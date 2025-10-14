# # ===================================================================
# # Constraints for PMU FSM - Skywater 130nm
# # Optimized for the PMU FSM design
# # ===================================================================



# Clock Constraints - 100MHz clock ( very basic and conservative design)
create_clock -name clk -period 10 [get_ports clk]

set_clock_latency -source 0.5 [get_clocks clk]
set_clock_latency 0.8 [get_clocks clk]

set_clock_uncertainty -setup 0.3 [get_clocks clk]
set_clock_uncertainty -hold 0.1 [get_clocks clk]

# Input Constraints
set_input_delay -clock clk -max 2.0 [get_ports "req_idle req_sleep req_off wake_up"]
set_input_delay -clock clk -min 0.5 [get_ports "req_idle req_sleep req_off wake_up"]

set_input_delay -clock clk -max 3.0 [get_ports "pwr_stable clk_stable retention_ready"]
set_input_delay -clock clk -min 1.0 [get_ports "pwr_stable clk_stable retention_ready"]


# Output Constraints
set_output_delay -clock clk -max 2.0 [get_ports "clk_gate_en pwr_gate_en retention_en"]
set_output_delay -clock clk -min 0.5 [get_ports "clk_gate_en pwr_gate_en retention_en"]

set_output_delay -clock clk -max 2.5 [get_ports "retention_save retention_restore reset_ctrl"]
set_output_delay -clock clk -min 0.5 [get_ports "retention_save retention_restore reset_ctrl"]

set_output_delay -clock clk -max 2.0 [get_ports "dvfs_ctrl pwr_state"]
set_output_delay -clock clk -min 0.5 [get_ports "dvfs_ctrl pwr_state"]

set_output_delay -clock clk -max 2.0 [get_ports "seq_busy error"]
set_output_delay -clock clk -min 0.5 [get_ports "seq_busy error"]

# False paths
set_false_path -from [get_ports "reset_n"] -to [all_registers]

# Case Analysis 
set_case_analysis 0 [get_ports reset_n]

# Load Constraints
set_load 0.05 [get_ports "clk_gate_en pwr_gate_en retention_en"]
set_load 0.03 [get_ports "retention_save retention_restore reset_ctrl"]
set_load 0.02 [get_ports "dvfs_ctrl pwr_state seq_busy error"]

# Driving Cells for inputs
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 [all_inputs]

# Max Transition
set_max_transition 0.5 [current_design]
