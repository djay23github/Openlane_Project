// ===================================================================
//  Power Management Unit ( with Sleep and OFF sequencing )
//  Author: Dhananjay Joshi
//  Description:
//  Simple FSM to implement a PMU block
//  handles power up, active and power down sequences
// ===================================================================

module pmu_fsm (
    input wire clk,
    input wire reset_n,

    // PMU Requests
    input wire req_idle, 
    input wire req_sleep, 
    input wire req_off, 
    input wire wake_up,

    // Status Inputs
    input wire pwr_stable,
    input wire clk_stable,
    input wire retention_ready,

    // Control outputs
    output reg clk_gate_en,
    output reg pwr_gate_en,
    output reg retention_en,
    output reg retention_save,
    output reg retention_restore,
    output reg [1:0] dvfs_ctrl,
    output reg reset_ctrl,
    output reg [1:0] pwr_state,
    output reg seq_busy,
    output reg error
);

// ===================================================================
// State Encoding - Binary for simplicity, easy to debug
// ===================================================================
localparam [2:0] ACTIVE    = 3'b000,
                 IDLE      = 3'b001,
                 SLEEP     = 3'b010,
                 OFF       = 3'b011,
                 SLEEP_ENT = 3'b100,
                 OFF_ENT   = 3'b101,
                 WAKE_UP   = 3'b110;

reg [2:0] curr_state, next_state;

// ===================================================================
// Sequential Elements
// ===================================================================
reg [7:0] seq_timer;

// Input synchronization (2-stage for simplicity)
reg [3:0] sync_stage1, sync_stage2;
wire req_idle_sync, req_sleep_sync, req_off_sync, wake_up_sync;

assign {req_idle_sync, req_sleep_sync, req_off_sync, wake_up_sync} = sync_stage2;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        sync_stage1 <= 4'b0;
        sync_stage2 <= 4'b0;
    end else begin
        sync_stage1 <= {req_idle, req_sleep, req_off, wake_up};
        sync_stage2 <= sync_stage1;
    end
end

// ===================================================================
// State Machine 
// ===================================================================

// State register
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin 
        curr_state <= ACTIVE;
        seq_timer <= 8'h00;
    end else begin 
        curr_state <= next_state;
        
        // Timer control
        if (curr_state != next_state) begin
            seq_timer <= 8'h00;
        end else if (seq_busy) begin
            seq_timer <= seq_timer + 1'b1;
        end
    end
end

// Next state logic
always @(*) begin
    // Default values
    next_state = curr_state;
    seq_busy = 1'b0;
    error = 1'b0;

    case (curr_state)
        ACTIVE: begin
            // Check synchronized requests
            if (wake_up_sync) begin
                next_state = ACTIVE; // Stay in ACTIVE on wake_up
            end else if (req_off_sync) begin
                next_state = OFF_ENT;
            end else if (req_sleep_sync) begin
                next_state = SLEEP_ENT;
            end else if (req_idle_sync) begin
                next_state = IDLE;
            end
        end

        IDLE: begin
            if (wake_up_sync) begin
                next_state = ACTIVE;
            end else if (req_off_sync) begin
                next_state = OFF_ENT;
            end else if (req_sleep_sync) begin
                next_state = SLEEP_ENT;
            end
        end

        SLEEP: begin
            if (wake_up_sync) begin
                next_state = WAKE_UP;
            end else if (req_off_sync) begin
                next_state = OFF_ENT;
            end
        end

        OFF: begin
            if (wake_up_sync) begin
                next_state = WAKE_UP;
            end
        end

        SLEEP_ENT: begin
            seq_busy = 1'b1;
            if (seq_timer >= 8'h03) begin // Increased to 3 cycles
                if (retention_ready) begin
                    next_state = SLEEP;
                end else if (seq_timer >= 8'h0F) begin // Shorter timeout
                    next_state = ACTIVE;
                    error = 1'b1;
                end
            end
        end

        OFF_ENT: begin
            seq_busy = 1'b1;
            if (seq_timer >= 8'h05) begin
                next_state = OFF;
            end
        end

        WAKE_UP: begin
            seq_busy = 1'b1;
            if (seq_timer >= 8'h03 && pwr_stable && clk_stable) begin
                if (retention_ready) begin
                    next_state = ACTIVE;
                end else if (seq_timer >= 8'h0F) begin
                    next_state = ACTIVE;
                    error = 1'b1;
                end
            end
        end

        default: begin
            next_state = ACTIVE;
        end
    endcase
end

// ===================================================================
// Output Generation
// ===================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        clk_gate_en <= 1'b0;
        pwr_gate_en <= 1'b0;
        retention_en <= 1'b0;
        retention_save <= 1'b0;
        retention_restore <= 1'b0;
        dvfs_ctrl <= 2'b11;
        reset_ctrl <= 1'b0;
        pwr_state <= 2'b00;
    end else begin
        // Default outputs (ACTIVE state)
        clk_gate_en <= 1'b0;
        pwr_gate_en <= 1'b0;
        retention_en <= 1'b0;
        retention_save <= 1'b0;
        retention_restore <= 1'b0;
        dvfs_ctrl <= 2'b11;
        reset_ctrl <= 1'b0;
        pwr_state <= 2'b00;

        case (curr_state)
            ACTIVE: begin
                pwr_state <= 2'b00;
                // All outputs already at default (active)
            end

            IDLE: begin
                pwr_state <= 2'b01;
                clk_gate_en <= 1'b1;
            end

            SLEEP: begin
                pwr_state <= 2'b10;
                clk_gate_en <= 1'b1;
                pwr_gate_en <= 1'b1;
                retention_en <= 1'b1;
                dvfs_ctrl <= 2'b01;
            end

            OFF: begin
                pwr_state <= 2'b11;
                clk_gate_en <= 1'b1;
                pwr_gate_en <= 1'b1;
                reset_ctrl <= 1'b1;
            end

            SLEEP_ENT: begin
                pwr_state <= 2'b10;
                retention_save <= (seq_timer < 8'h02);
                retention_en <= 1'b1;
            end

            OFF_ENT: begin
                pwr_state <= 2'b11;
                if (seq_timer < 8'h02) begin
                    retention_save <= 1'b1;
                end
            end

            WAKE_UP: begin
                pwr_state <= 2'b00;
                if (seq_timer >= 8'h01 && seq_timer < 8'h03) begin
                    retention_restore <= 1'b1;
                    retention_en <= 1'b1;
                end
                reset_ctrl <= (seq_timer < 8'h01);
            end

            default: begin
                pwr_state <= 2'b00;
            end
        endcase
    end
end

endmodule