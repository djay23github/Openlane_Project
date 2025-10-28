###############################################################################
# Created by write_sdc
# Tue Oct 14 03:02:12 2025
###############################################################################
current_design pmu_fsm
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.0000 [get_ports {clk}]
set_clock_uncertainty -setup 0.3000 clk
set_clock_uncertainty -hold 0.1000 clk
set_propagated_clock [get_clocks {clk}]
set_clock_latency -source 0.5000 [get_clocks {clk}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {clk_stable}]
set_input_delay 3.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {clk_stable}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {pwr_stable}]
set_input_delay 3.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {pwr_stable}]
set_input_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {req_idle}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {req_idle}]
set_input_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {req_off}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {req_off}]
set_input_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {req_sleep}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {req_sleep}]
set_input_delay 1.0000 -clock [get_clocks {clk}] -min -add_delay [get_ports {retention_ready}]
set_input_delay 3.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {retention_ready}]
set_input_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {wake_up}]
set_input_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {wake_up}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {clk_gate_en}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {clk_gate_en}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dvfs_ctrl[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dvfs_ctrl[0]}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {dvfs_ctrl[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {dvfs_ctrl[1]}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {error}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {error}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {pwr_gate_en}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {pwr_gate_en}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {pwr_state[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {pwr_state[0]}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {pwr_state[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {pwr_state[1]}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {reset_ctrl}]
set_output_delay 2.5000 -clock [get_clocks {clk}] -max -add_delay [get_ports {reset_ctrl}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {retention_en}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {retention_en}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {retention_restore}]
set_output_delay 2.5000 -clock [get_clocks {clk}] -max -add_delay [get_ports {retention_restore}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {retention_save}]
set_output_delay 2.5000 -clock [get_clocks {clk}] -max -add_delay [get_ports {retention_save}]
set_output_delay 0.5000 -clock [get_clocks {clk}] -min -add_delay [get_ports {seq_busy}]
set_output_delay 2.0000 -clock [get_clocks {clk}] -max -add_delay [get_ports {seq_busy}]
set_false_path\
    -from [get_ports {reset_n}]\
    -to [list [get_cells {_239_}]\
           [get_cells {_240_}]\
           [get_cells {_241_}]\
           [get_cells {_242_}]\
           [get_cells {_243_}]\
           [get_cells {_244_}]\
           [get_cells {_245_}]\
           [get_cells {_246_}]\
           [get_cells {_247_}]\
           [get_cells {_248_}]\
           [get_cells {_249_}]\
           [get_cells {_250_}]\
           [get_cells {_251_}]\
           [get_cells {_252_}]\
           [get_cells {_253_}]\
           [get_cells {_254_}]\
           [get_cells {_255_}]\
           [get_cells {_256_}]\
           [get_cells {_257_}]\
           [get_cells {_258_}]\
           [get_cells {_259_}]\
           [get_cells {_260_}]\
           [get_cells {_261_}]\
           [get_cells {_262_}]\
           [get_cells {_263_}]\
           [get_cells {_264_}]\
           [get_cells {_265_}]\
           [get_cells {_266_}]]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0500 [get_ports {clk_gate_en}]
set_load -pin_load 0.0200 [get_ports {error}]
set_load -pin_load 0.0500 [get_ports {pwr_gate_en}]
set_load -pin_load 0.0300 [get_ports {reset_ctrl}]
set_load -pin_load 0.0500 [get_ports {retention_en}]
set_load -pin_load 0.0300 [get_ports {retention_restore}]
set_load -pin_load 0.0300 [get_ports {retention_save}]
set_load -pin_load 0.0200 [get_ports {seq_busy}]
set_load -pin_load 0.0200 [get_ports {dvfs_ctrl[1]}]
set_load -pin_load 0.0200 [get_ports {dvfs_ctrl[0]}]
set_load -pin_load 0.0200 [get_ports {pwr_state[1]}]
set_load -pin_load 0.0200 [get_ports {pwr_state[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk_stable}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {pwr_stable}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {req_idle}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {req_off}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {req_sleep}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {reset_n}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {retention_ready}]
set_driving_cell -lib_cell sky130_fd_sc_hd__buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {wake_up}]
set_case_analysis 0 [get_ports {reset_n}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.5000 [current_design]
