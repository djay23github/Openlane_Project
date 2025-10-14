# # ===================================================================
# # Timing Analysis for PMU FSM - Skywater 130nm
# # Optimized for the PMU FSM design
# # ===================================================================

set lib_name "sky130_fd_sc_hd__tt_100C_1v80.lib"
set file_dir "TT"
set design_name "pmu_fsm"

# Currently only using the TT operating condition
read_liberty ../libs/$lib_name

# Read the verilog netlist file
read_verilog ../Day_6/rtl/pmu_fsm_icarus_synth.v

# Link the design
link_design $design_name

# Read Constraints
read_sdc pmu_constraints.sdc

# Report the timing
report_checks -path_delay min_max -fields {cap slew input_pins} -digits {5} -format full_clock_expanded > reports/$file_dir/$design_name.timing.$lib_name.rpt

# Report TNS and WNS
report_tns  > reports/$file_dir/$design_name.tns.$lib_name.rpt
report_wns  > reports/$file_dir/$design_name.wns.$lib_name.rpt

# Report power
report_power > reports/$file_dir/$design_name.power.$lib_name.rpt