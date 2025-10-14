// ===================================================================
//  Power Management Unit ( Simple FSM )
//  Author: Dhananjay Joshi
//  Description:
//  Simple FSM to implement a PMU block -
//  handles power up, active and power down sequences
// ===================================================================


module pmu_fsm (
    input wire clk,
    input wire reset_n,

    // PMU Requests
    input logic req_idle, 
    input logic req_sleep, 
    input logic req_off, 
    input logic wake_up,

    // Status Inputs
    input logic pwr_stable, // Power supply stable
    input logic clk_stable, // Clock is stable
    input logic retention_ready, // Retention complete

    // Control outputs
    output reg clk_gate_en,
    output reg pwr_gate_en,
    output reg retention_en,
    output reg retention_save,
    output reg retention_restore, // retention save state and restore state
    output reg [1:0] dvfs_ctrl,
    output reg reset_ctrl,
    output reg [1:0] pwr_state, // current power state to monitor
    output reg seq_busy, // sequence is busy
    output reg error // error detected
);


// State Encodings ( 3 bits, 7 States) - Power Mode Indication
typedef enum logic [2:0] { 
    ACTIVE  =   3'b000, // Full power, max performance
    IDLE    =   3'b001, // Clock gated , Power ON
    SLEEP   =   3'b010, // Power gated, Retention , low performance
    OFF     =   3'b011, // Full power down
    SLEEP_ENT  =    3'b100, // Sleep entry sequence
    OFF_ENT =   3'b101, // OFF entry sequence
    WAKE_UP =   3'b110 // Wake up sequence

 } pwr_mode_t; 
                

pwr_mode_t curr_state, next_state;

// Sequence timer - for realistic sequencing
reg [7:0] seq_timer;
// reg [7:0] seq_timeout;

// Request Synchronizer ( for async requests (CDC issue can be solved))
logic req_idle_sync, req_sleep_sync, req_off_sync, wake_up_sync;
logic req_idle_meta, req_sleep_meta, req_off_meta, wake_up_meta; // metastable state

// Synchronizing async requests
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        {req_idle_meta, req_idle_sync} <= 2'b00;
        {req_sleep_meta, req_sleep_sync} <= 2'b00;
        {req_off_meta, req_off_sync} <= 2'b00;
        {wake_up_meta, wake_up_sync} <= 2'b00;
    end else begin
        // First stage of synchronization
        req_idle_meta <= req_idle;
        req_sleep_meta <= req_sleep;
        req_off_meta <= req_off;
        wake_up_meta <= wake_up;

        // Second stage of synchronization
        req_idle_sync <= req_idle_meta;
        req_sleep_sync <= req_sleep_meta;
        req_off_sync <= req_off_meta;
        wake_up_sync <= wake_up_meta;
    end
end

// Request Priority Encoder --> highest to lowest wake_up > off > sleep > idle
logic [2:0] req_priority;
always_comb begin 
    if(wake_up_sync) req_priority   =   3'b100;
    else if(req_off_sync) req_priority  =   3'b011;
    else if(req_sleep_sync) req_priority    =   3'b010;
    else if(req_idle_sync) req_priority =   3'b001;
    else req_priority = 3'b000;
end

// State Registers
always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin 
        curr_state <= ACTIVE;
        seq_timer <= 8'h00;
    end else begin 
        curr_state <= next_state;

        // Sequence Timer Control
        if(curr_state != next_state) begin
            seq_timer <= 8'h00; // Reset the timer
        end else if (seq_busy) begin
            seq_timer <= seq_timer + 1'b1;
        end
    end
end

// Next State Logic with Sequencing

always_comb begin
    next_state = curr_state;
    seq_busy = 1'b0;
    error = 1'b0;

    case (curr_state)
        ACTIVE  : begin
            if(req_priority != 3'b000) begin
                case (req_priority)
                    3'b001 : next_state = IDLE;
                    3'b010 : next_state = SLEEP_ENT;
                    3'b011 : next_state = OFF_ENT;
                    3'b100 : next_state = WAKE_UP;    
                endcase
            end
        end 

        IDLE    : begin
            case (req_priority)
                3'b010  :   next_state = SLEEP_ENT;
                3'b011  :   next_state = OFF_ENT;
                3'b100  :   next_state = WAKE_UP; 
                default :   next_state = IDLE; 
            endcase
        end

        SLEEP   : begin
            case (req_priority)
                3'b011  :   next_state = OFF_ENT;
                3'b100  :   next_state = WAKE_UP; 
                default :   next_state = SLEEP; 
            endcase 
        end

        OFF     : begin
            if(req_priority == 3'b100) begin
                next_state = WAKE_UP;
            end
        end

        // Sleep entry sequence
        SLEEP_ENT   : begin
            seq_busy = 1'b1;
            if(seq_timer >= 8'h02) begin
                if(retention_ready) begin
                    next_state = SLEEP;
                end else if(seq_timer >= 8'hFF) begin
                    next_state = ACTIVE;
                    error = 1'b1;
                end
            end
        end

        // OFF state entry sequence
        OFF_ENT : begin
            seq_busy  = 1'b1;
            if(seq_timer >= 8'h05) begin
                next_state = OFF;
            end
        end

        WAKE_UP :  begin
            seq_busy = 1'b1;
            if(seq_timer >= 8'h03 && pwr_stable && clk_stable) begin
                if(retention_ready) begin
                    next_state = ACTIVE;
                end else if(seq_timer >= 8'hFF) begin
                    next_state = ACTIVE;
                    error = 1'b1;
                end
            end
        end

        default :   begin
            next_state = ACTIVE;
        end 
    endcase
end


// Output logic with registered outputs

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        clk_gate_en <= 1'b0;
        pwr_gate_en <= 1'b0;
        retention_en <= 1'b0;
        retention_save <= 1'b0;
        retention_restore <= 1'b0;
        dvfs_ctrl <= 2'b11;
        reset_ctrl <= 1'b0;
        pwr_state <= 2'b00;

    end else begin
        clk_gate_en <= 1'b0;
        pwr_gate_en <= 1'b0;
        retention_en <= 1'b0;
        retention_save <= 1'b0;
        retention_restore <= 1'b0;
        dvfs_ctrl <= 2'b11;
        reset_ctrl <= 1'b0;
        pwr_state <= 2'b00;

        case (curr_state)
            ACTIVE  : begin
                pwr_state <= 2'b00;
                // Everything is default - ACTIVE MODE 
            end

            IDLE    : begin
                pwr_state <= 2'b01;
                clk_gate_en <= 1'b1;
            end 

            SLEEP   : begin
                pwr_state <= 2'b10;
                clk_gate_en <= 1'b1;
                pwr_gate_en <= 1'b1;
                retention_en <= 1'b1;
                dvfs_ctrl <= 2'b01; // Low performance
            end

            OFF     : begin
                pwr_state <= 2'b11;
                clk_gate_en <= 1'b1;
                pwr_gate_en <= 1'b1;
                reset_ctrl <= 1'b1;
            end

            SLEEP_ENT   : begin
                pwr_state <= 2'b10;
                retention_save <= (seq_timer < 8'h02); // Save data during first cycle
                retention_en <= 1'b1;
            end

            OFF_ENT     : begin
                pwr_state <= 2'b11;
                if(seq_timer < 8'h02) begin
                    retention_save <= 1'b1; // Save data and the state of retention before power-off
                end
            end

            WAKE_UP     : begin
                pwr_state <= 2'b00;
                if (seq_timer >= 8'h01 && seq_timer < 8'h03) begin
                    retention_restore <= 1'b1;
                    retention_en <= 1'b1;
                end
                reset_ctrl <= (seq_timer < 8'h01); // Assert reset initially
            end

            default: begin
                pwr_state <= 2'b00;
            end

        endcase
    end
end

// SystemVerilog Assertions for Design Validation

// `ifdef SIMULATION
// // Checking for illegal state transitions
// property no_direct_to_off;
//     @(posedge clk) (curr_state inside {ACTIVE, IDLE}) |-> (next_state != OFF);
// endproperty

// property sequence_timeout;
//     @(posedge clk) (seq_busy && seq_timer == 8'hFF) |=> !seq_busy;
// endproperty

// property wake_up_priority;
//     @(posedge clk) (wake_up_sync && curr_state inside {IDLE, SLEEP, OFF}) |=> (next_state inside {ACTIVE, WAKE_UP});
// endproperty
// `endif

endmodule