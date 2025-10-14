# # ===================================================================
# # Timing Analysis for PMU FSM - Skywater 130nm
# # Optimized for the PMU FSM design
# # ===================================================================

set libname "sky130_fd_sc_hd__tt_025C_1v80.lib"

# Currently only using the TT operating condition
read_liberty ../libs/$libname

# Read the verilog netlist file
read_verilog ../Day_6/rtl/pmu_fsm_icarus_synth.v

# Link the design
link_design pmu_fsm

# Read Constraints
read_sdc pmu_constraints.sdc

# Report the timing
report_checks -path_delay min_max -fields {nets cap slew input_pins} -format full_clock_expanded > pmu_fsm.timing.rpt

# # Report worst slack
# report_worst_slack -max > reports/pmu_fsm.worst_slack.max.rpt
# report_worst_slack -min > reports/pmu_fsm.worst_slack.min.rpt

# # Report clock skew
# report_clock_skew > reports/pmu_fsm.skew.rpt

# # Check for violations
# report_checks -unconstrained -fields  {slew cap input_pins} > reports/pmu_fsm.violations.rpt

# # Report max tran/max cap violations
# report_check_types -violators > reports/pmu_fsm.viol.rpt

# # Report power
# report_power > reports/pmu_fsm.power.rpt