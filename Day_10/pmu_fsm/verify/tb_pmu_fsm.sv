// =======================================================================
//  PMU FSM Testbench - Enhanced Debugging
// =======================================================================
`timescale 1ns/1ps

module tb_pmu_fsm;
    reg clk;
    reg reset_n;

    // DUT inputs
    reg req_idle, req_sleep, req_off, wake_up;
    reg pwr_stable, clk_stable, retention_ready;

    // DUT outputs
    wire clk_gate_en, pwr_gate_en, reset_ctrl, retention_en;
    wire retention_save, retention_restore;
    wire [1:0] dvfs_ctrl, pwr_state;
    wire seq_busy, error;
    wire [2:0] curr_state;

    integer test_count, error_count;

    // Instantiate DUT
    pmu_fsm dut(
        .clk(clk),
        .reset_n(reset_n),
        .req_idle(req_idle), 
        .req_sleep(req_sleep), 
        .req_off(req_off), 
        .wake_up(wake_up),
        .pwr_stable(pwr_stable),
        .clk_stable(clk_stable),
        .retention_ready(retention_ready),
        .clk_gate_en(clk_gate_en),
        .pwr_gate_en(pwr_gate_en),
        .retention_en(retention_en),
        .retention_save(retention_save),
        .retention_restore(retention_restore),
        .dvfs_ctrl(dvfs_ctrl),
        .reset_ctrl(reset_ctrl), 
        .pwr_state(pwr_state),
        .seq_busy(seq_busy),
        .error(error)
    );

    assign curr_state = dut.curr_state;

    // Clock generation
    always #5 clk = ~clk;

    // Helper function to get state name
    function [80:0] get_state_name;
        input [2:0] state;
        case (state)
            3'b000: get_state_name = "ACTIVE";
            3'b001: get_state_name = "IDLE";
            3'b010: get_state_name = "SLEEP";
            3'b011: get_state_name = "OFF";
            3'b100: get_state_name = "SLEEP_ENT";
            3'b101: get_state_name = "OFF_ENT";
            3'b110: get_state_name = "WAKE_UP";
            default: get_state_name = "UNKNOWN";
        endcase
    endfunction

    // Reset task
    task reset_system;
        begin
            $display("[TASK] Applying reset...");
            reset_n = 0;
            req_idle = 0;
            req_sleep = 0;
            req_off = 0;
            wake_up = 0;
            pwr_stable = 1;
            clk_stable = 1;
            retention_ready = 1;
            repeat(5) @(posedge clk);
            reset_n = 1;
            repeat(2) @(posedge clk);
            $display("[TASK] Reset released. Current state: %s", get_state_name(curr_state));
        end
    endtask

    // Wait cycles with debug info
    task wait_cycles;
        input integer cycles;
        integer i;
        begin
            for (i = 0; i < cycles; i = i + 1) begin
                @(posedge clk);
                $display("  [Cycle %0d] State: %s, sync: idle=%b sleep=%b off=%b wake=%b", 
                         i, get_state_name(curr_state), 
                         dut.req_idle_sync, dut.req_sleep_sync, 
                         dut.req_off_sync, dut.wake_up_sync);
            end
        end
    endtask

    // State check task
    task check_state;
        input [2:0] expected_state;
        input [80:0] state_name;
        begin
            if (curr_state !== expected_state) begin
                $display("ERROR: Expected %s (0x%0h), got %s (0x%0h)", 
                        state_name, expected_state, get_state_name(curr_state), curr_state);
                error_count = error_count + 1;
            end else begin
                $display("PASS:  %s", state_name);
            end
            test_count = test_count + 1;
        end
    endtask

    // =======================================================================
    // Specific Debug Tests
    // =======================================================================

    task test_active_to_idle_debug;
        begin
            $display("\nDEBUG TEST: ACTIVE -> IDLE");
            reset_system();
            
            $display("Setting req_idle=1");
            req_idle = 1;
            
            // Wait for synchronization and state transition
            wait_cycles(4);
            
            req_idle = 0;
            check_state(3'b001, "IDLE");
            
            if (clk_gate_en !== 1'b1) begin
                $display("ERROR: clk_gate_en should be 1 in IDLE, got %b", clk_gate_en);
                error_count = error_count + 1;
            end else begin
                $display("PASS: clk_gate_en = 1 in IDLE");
            end
        end
    endtask

    task test_active_to_sleep_ent_debug;
        begin
            $display("\nDEBUG TEST: ACTIVE -> SLEEP_ENT");
            reset_system();
            
            $display("Setting req_sleep=1");
            req_sleep = 1;
            
            // Wait for synchronization and state transition
            wait_cycles(4);
            
            req_sleep = 0;
            check_state(3'b100, "SLEEP_ENT");
            
            if (seq_busy !== 1'b1) begin
                $display("ERROR: seq_busy should be 1 in SLEEP_ENT, got %b", seq_busy);
                error_count = error_count + 1;
            end else begin
                $display("PASS: seq_busy = 1 in SLEEP_ENT");
            end
            
            // Continue sequence
            $display("Continuing SLEEP_ENT sequence...");
            retention_ready = 1;
            wait_cycles(5);
            check_state(3'b010, "SLEEP");
        end
    endtask

    // =======================================================================
    // Main Test Sequence
    // =======================================================================

    initial begin
        // Initialize
        clk = 0;
        test_count = 0;
        error_count = 0;
        
        $display("Starting PMU FSM Debug Test");
        $display("===========================");
        
        // Run specific debug tests
        test_active_to_idle_debug();
        test_active_to_sleep_ent_debug();
        
        // Summary
        $display("\n=== TEST SUMMARY ===");
        $display("Tests run: %0d", test_count);
        $display("Errors:    %0d", error_count);
        
        if (error_count == 0) begin
            $display("*** ALL TESTS PASSED ***");
        end else begin
            $display("*** TESTS FAILED ***");
        end
        
        $finish;
    end

    // VCD dump for detailed debugging
    initial begin
        $dumpfile("pmu_fsm_debug.vcd");
        $dumpvars(0, tb_pmu_fsm);
    end

    // Timeout
    initial begin
        #50000;
        $display("Timeout: Simulation too long");
        $finish;
    end

endmodule
