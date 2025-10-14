// =======================================================================
//  PMU FSM Verification Testbench
// =======================================================================
`timescale 1ns/1ps

module tb_pmu_fsm;
    logic clk;
    logic reset_n;

    // DUT inputs
    logic req_idle, req_sleep, req_off, wake_up;
    logic pwr_stable, clk_stable, retention_ready;

    // DUT outputs
    logic clk_gate_en, pwr_gate_en, reset_ctrl, retention_en;
    logic retention_save, retention_restore;
    logic [1:0] dvfs_ctrl, pwr_state;
    logic seq_busy, error;


    // Testbench control bits
    bit test_pass = 1;
    int test_case_count = 0;
    int error_count = 0;
    // int check_count = 0;

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

always #5 clk = ~clk;

// =======================================================================
// Coverage Collection for the testbench
// =======================================================================

// `ifdef COVERAGE
// covergroup pmu_cov @(posedge clk);
//     option.per_instance = 1;

//     // State coverage
//     state_cp: coverpoint dut.curr_state {
//         bins active = {dut.ACTIVE};
//         bins idle = {dut.IDLE};
//         bins sleep = {dut.SLEEP};
//         bins off = {dut.OFF};
//         bins sleep_ent = {dut.SLEEP_ENT};
//         bins off_ent = {dut.OFF_ENT};
//         bins wake_up = {dut.WAKE_UP};
//     }

//     // Transition Coverage
//     trans_cp : coverpoint dut.curr_state {
//         bins transitions[] = (
//             dut.ACTIVE => dut.IDLE,
//             dut.ACTIVE => dut.SLEEP_ENT,
//             dut.ACTIVE => dut.OFF_ENT,
//             dut.IDLE => dut.ACTIVE,
//             dut.IDLE => dut.SLEEP_ENT,
//             dut.IDLE => dut.OFF_ENT,
//             dut.SLEEP => dut.OFF_ENT,
//             dut.SLEEP => dut.WAKE_UP,
//             dut.OFF => dut.WAKE_UP,
//             dut.SLEEP_ENT => dut.SLEEP,
//             dut.SLEEP_ENT => dut.ACTIVE, // error case
//             dut.OFF_ENT => dut.OFF,
//             dut.WAKE_UP => dut.ACTIVE
//         );
//     }

//     // Request Coverage
//     req_cp : coverpoint {req_idle, req_sleep, req_off, wake_up} {
//         bins single_req[] = {
//             4'b1000, 4'b0100, 4'b0010, 4'b0001 // Single Requests
//         };
//         bins multi_req = {[4'b0011:4'b1111]}; // Multiple Requests
//         bins no_req = {4'b0000};
//     }

//     // Output Coverage
//     output_cp :  coverpoint {clk_gate_en, pwr_gate_en, retention_en, reset_ctrl} {
//         bins power_states[] = {
//           4'b0000, // ACTIVE
//           4'b1000, // IDLE
//           4'b1101, // SLEEP
//           4'b1110, // OFF (with reset)
//           4'b0010, // Retention Active
//           4'b0001, // Reset Active
//         };
//     }

//     // Cross coverage - with requests in each state
//     state_req_cross: cross state_cp, req_cp;

//     // Sequence coverage
//     seq_cp : coverpoint seq_busy {
//         bins idle = {0};
//         bins busy = {1};
//     }

// endgroup
// `endif COVERAGE

// Instantiating the coverage group
// pmu_cov pcov;

// =======================================================================
// Scoreboard for checking the behaviour of RTL
// =======================================================================

class PMUScoreBoard;

    bit [2:0] expected_state;
    bit expected_clk_gate, expected_pwr_gate, expected_retention;
    bit [1:0] expected_dvfs;
    bit expected_reset;
    int check_count = 0;
    int error_count = 0;

    function void check_state(  string test_name, 
                                bit [2:0] curr_state,
                                bit clk_gate_en, 
                                bit pwr_gate_en,
                                bit retention_en, 
                                bit [1:0] dvfs_ctrl,
                                bit reset_ctrl);
    
        bit local_error = 0;
        string state_name;

        case (curr_state)
            dut.ACTIVE  :   begin
                state_name = "ACTIVE";
                if(clk_gate_en !== 0) begin
                    $error("%s: ACTIVE state - clk_gate_en should be 0, got %b", test_name, clk_gate_en);
                    local_error = 1;
                end
                if(pwr_gate_en !== 0) begin
                    $error("%s: ACTIVE state - pwr_gate_en should be 0, got %b", test_name, pwr_gate_en);
                    local_error = 1;
                end
                if(dvfs_ctrl !== 2'b11) begin
                    $error("%s: ACTIVE state - dvfs_ctrl should be 2'b11, got %b", test_name, dvfs_ctrl);
                    local_error = 1;
                end
            end

            dut.IDLE  :   begin
                state_name = "IDLE";
                if(clk_gate_en == 0) begin
                    $error("%s: IDLE state - clk_gate_en should be 1, got %b", test_name, clk_gate_en);
                    local_error = 1;
                end
            end
            dut.SLEEP  :   begin
                state_name = "SLEEP";
                if(clk_gate_en == 0) begin
                    $error("%s: SLEEP state - clk_gate_en should be 1, got %b", test_name, clk_gate_en);
                    local_error = 1;
                end
                if(pwr_gate_en == 0) begin
                    $error("%s: SLEEP state - pwr_gate_en should be 1, got %b", test_name, pwr_gate_en);
                    local_error = 1;
                end
                if(retention_en == 0) begin
                    $error("%s: SLEEP state - retention_en should be 1, got %b", test_name, retention_en);
                    local_error = 1;
                end
                if(dvfs_ctrl !== 2'b01) begin
                    $error("%s: SLEEP state - dvfs_ctrl should be 2'b01, got %b", test_name, dvfs_ctrl);
                    local_error = 1;
                end
            end
            dut.OFF  :   begin
                state_name = "OFF";
                if(clk_gate_en == 0) begin
                    $error("%s: OFF state - clk_gate_en should be 1, got %b", test_name, clk_gate_en);
                    local_error = 1;
                end
                if(pwr_gate_en == 0) begin
                    $error("%s: OFF state - pwr_gate_en should be 1, got %b", test_name, pwr_gate_en);
                    local_error = 1;
                end
                if(reset_ctrl == 0) begin
                    $error("%s: OFF state - reset_ctrl should be 1, got %b", test_name, reset_ctrl);
                    local_error = 1;
                end
            end
            dut.WAKE_UP  :   begin
                state_name = "WAKE_UP";
                if(retention_en == 0) begin
                    $error("%s: WAKE_UP state - retention_enable should be 1, got %b", test_name, retention_en);
                    local_error = 1;
                end
            end 
            
        endcase

        check_count = check_count + 1;
        if(local_error) error_count = error_count + 1; 
    endfunction 


    function void report();
        $display("Scoreboard: %0d checks, %0d errors", check_count, error_count);
    endfunction

endclass


PMUScoreBoard scb;


// =======================================================================
// Monitor for automatic checking
// =======================================================================
always @(posedge clk ) begin
    if(reset_n) begin
        scb.check_state("Auto Check", dut.curr_state, clk_gate_en, pwr_gate_en, retention_en, dvfs_ctrl, reset_ctrl);
        // pcov.sample();
    end
end

// =======================================================================
// Task to Apply RESET
// =======================================================================

task apply_reset();
    $display("Applying reset...");
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
    $display("Reset released");
endtask 

// =======================================================================
// Task to Wait for Cycles
// =======================================================================

task wait_cycles(int cycles);
        repeat(cycles) @(posedge clk);
endtask


// =======================================================================
// Task to Check States
// =======================================================================

task check_state(bit [2:0] expected_state, string state_name);
        if(dut.curr_state !== expected_state) begin
            $error("Expected state %s (0x%0h), got 0x%0h", 
                   state_name, expected_state, dut.curr_state);
            error_count++;
        end else begin
            $display("Correctly in state: %s", state_name);
        end
endtask


// =======================================================================
// Task 1: Power on Reset
// =======================================================================

task test_power_on_reset;
    $display("\n=== Test 1: Power On Reset ===");
    test_case_count++;
    apply_reset();
    check_state(dut.ACTIVE, "ACTIVE");
    if(clk_gate_en !== 0 || pwr_gate_en !== 0 || reset_ctrl !== 0) begin
        $error("Reset state outputs are incorrect");
        error_count++;
    end
endtask 

// =======================================================================
// Task 2: Active to Idle
// =======================================================================

task test_active_to_idle();
        $display("\n=== Test 2: ACTIVE -> IDLE ===");
        test_case_count++;
        apply_reset();
        
        // Request IDLE
        req_idle = 1;
        wait_cycles(2);
        req_idle = 0;
        
        check_state(dut.IDLE, "IDLE");
        if(clk_gate_en !== 1) begin
            $error("IDLE state - clk_gate_en should be 1");
            error_count++;
        end
endtask


// =======================================================================
// Task 3: Idle to Active
// =======================================================================

task test_idle_to_active();
        $display("\n=== Test 3: IDLE -> ACTIVE ===");
        test_case_count++;
        apply_reset();
        
        // Go to IDLE first
        req_idle = 1;
        wait_cycles(2);
        req_idle = 0;
        check_state(dut.IDLE, "IDLE");
        
        // Wake up
        wake_up = 1;
        wait_cycles(2);
        wake_up = 0;
        
        check_state(dut.ACTIVE, "ACTIVE");
        if(clk_gate_en !== 0) begin
            $error("ACTIVE state - clk_gate_en should be 0");
            error_count++;
        end
endtask


// =======================================================================
// Task 4: Active to Sleep
// =======================================================================

task test_active_to_sleep_sequence();
    $display("\n=== Test 4: ACTIVE -> SLEEP Sequence ===");
    test_case_count++;
    apply_reset();
    
    // Request SLEEP
    req_sleep = 1;
    wait_cycles(1);
    req_sleep = 0;
    
    // Should enter SLEEP_ENT sequence
    check_state(dut.SLEEP_ENT, "SLEEP_ENT");
    if(!seq_busy) begin
        $error("SLEEP_ENT should have seq_busy=1");
        error_count++;
    end
    
    // Wait for retention save
    retention_ready = 0;
    wait_cycles(3);
    retention_ready = 1;
    wait_cycles(1);
    
    // Should now be in SLEEP
    check_state(dut.SLEEP, "SLEEP");
    if(clk_gate_en !== 1 || pwr_gate_en !== 1 || retention_en !== 1) begin
        $error("SLEEP state outputs incorrect");
        error_count++;
    end
endtask

// =======================================================================
// Task 5: Sleep to OFF Sequence
// =======================================================================

task test_sleep_to_off_sequence();
    $display("\n=== Test 5: SLEEP -> OFF Sequence ===");
    test_case_count++;
    apply_reset();
    
    // Go to SLEEP first
    req_sleep = 1;
    wait_cycles(1);
    req_sleep = 0;
    retention_ready = 1;
    wait_cycles(10); // Wait for SLEEP entry
    
    // Request OFF
    req_off = 1;
    wait_cycles(1);
    req_off = 0;
    
    check_state(dut.OFF_ENT, "OFF_ENT");
    
    // Wait for OFF sequence
    wait_cycles(10);
    check_state(dut.OFF, "OFF");
    
    if(reset_ctrl !== 1) begin
        $error("OFF state - reset_ctrl should be 1");
        error_count++;
    end
endtask

// =======================================================================
// Task 6: OFF to WAKEUP
// =======================================================================

task test_off_to_active_wakeup();
    $display("\n=== Test 6: OFF -> ACTIVE Wake-up ===");
    test_case_count++;
    apply_reset();
    
    // Go to OFF first (quick path for test)
    force dut.curr_state = dut.OFF;
    wait_cycles(1);
    
    // Trigger wake-up
    wake_up = 1;
    wait_cycles(1);
    wake_up = 0;
    
    check_state(dut.WAKE_UP, "WAKE_UP");
    
    // Simulate power sequencing
    pwr_stable = 0;
    clk_stable = 0;
    wait_cycles(2);
    pwr_stable = 1;
    clk_stable = 1;
    retention_ready = 1;
    wait_cycles(5);
    
    check_state(dut.ACTIVE, "ACTIVE");
    release dut.curr_state;
endtask


// =======================================================================
// Task 7: Checking the Priority of Requests
// =======================================================================

task test_request_priority();
    $display("\n=== Test 7: Request Priority ===");
    test_case_count++;
    apply_reset();
    
    // Test wake_up has highest priority
    req_idle = 1;
    req_sleep = 1;
    req_off = 1;
    wake_up = 1;
    wait_cycles(2);
    
    // Should ignore other requests and stay in ACTIVE due to wake_up
    check_state(dut.ACTIVE, "ACTIVE");
    
    req_idle = 0;
    req_sleep = 0;
    req_off = 0;
    wake_up = 0;
endtask

// =======================================================================
// Task 8: Checking Timeout of Sequence
// =======================================================================

task test_sequence_timeout();
    $display("\n=== Test 8: Sequence Timeout ===");
    test_case_count++;
    apply_reset();
    
    // Trigger SLEEP entry but never set retention_ready
    req_sleep = 1;
    wait_cycles(1);
    req_sleep = 0;
    retention_ready = 0; // Never ready
    
    // Wait for timeout
    wait_cycles(300); // Should timeout before this
    
    if(error !== 1) begin
        $error("Timeout should trigger error signal");
        error_count++;
    end
    
    check_state(dut.ACTIVE, "ACTIVE after timeout");
    retention_ready = 1; // Restore
endtask

// =======================================================================
// Task 9: Testing Error Conditions
// =======================================================================

task test_error_conditions();
    $display("\n=== Test 9: Error Conditions ===");
    test_case_count++;
    apply_reset();
    
    // Test power failure during wake-up
    req_sleep = 1;
    wait_cycles(1);
    req_sleep = 0;
    retention_ready = 1;
    wait_cycles(10); // Reach SLEEP
    
    wake_up = 1;
    wait_cycles(1);
    wake_up = 0;
    
    // Simulate power failure
    pwr_stable = 0;
    wait_cycles(20);
    
    if(dut.curr_state != dut.WAKE_UP) begin
        $error("Should stay in WAKE_UP during power issues");
        error_count++;
    end
    pwr_stable = 1;
endtask


// =======================================================================
// MAIN VERIFICATION TEST SEQUENCE
// =======================================================================

initial begin
        scb = new();
        $display("Starting PMU FSM Verification");
        $display("=============================");
        
        clk = 0;
        apply_reset();
        
        // Run all test cases
        test_power_on_reset();
        test_active_to_idle();
        test_idle_to_active();
        test_active_to_sleep_sequence();
        test_sleep_to_off_sequence();
        test_off_to_active_wakeup();
        test_request_priority();
        test_sequence_timeout();
        test_error_conditions();
        
        // Final report
        $display("\n=== Verification Summary ===");
        $display("Test cases run: %0d", test_case_count);
        $display("Errors found: %0d", error_count);
        scb.report();
        
        // Coverage report
        // $display("\nCoverage Summary:");
        // $display("State coverage: %0.2f%%", pcov.state_cp.get_inst_coverage());
        // $display("Transition coverage: %0.2f%%", pcov.trans_cp.get_inst_coverage());
        // $display("Request coverage: %0.2f%%", pcov.req_cp.get_inst_coverage());
        
        if(error_count == 0) begin
            $display("*** TEST PASSED ***");
        end else begin
            $display("*** TEST FAILED ***");
            test_pass = 0;
        end
        
        $finish;
end

// =======================================================================
// WAVEFORM DUMPING FILE
// =======================================================================

initial begin
    $dumpfile("verify/pmu_fsm_verification.vcd");
    $dumpvars(0, tb_pmu_fsm);
end

// =======================================================================
// SAFE TIMEOUT
// =======================================================================

initial begin
    #1000000; // 1ms timeout
    $display("Test timeout - simulation took too long");
    $finish;
end

endmodule