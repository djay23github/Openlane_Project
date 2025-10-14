# RTL2GDSII Flow using Opensource Tools - Power Management Unit FSM Design 🧠⚙️

This repository documents my learning journey through open-source ASIC design tools and methodologies using the **Skywater 130nm PDK**.  

Each day covers hands-on activities, tool usage, and theoretical understanding of VLSI design concepts — from RTL simulation to synthesis, STA, SPICE analysis, and PnR automation.

The structure of this repository is inspired by the RTL Design and Synthesis Workshop Flow by Kunal Ghosh

---

## 🗓️ Day 1 – Learning Open-Source Tools

**Installed Tools:**
- iVerilog  
- GTKWave  
- Yosys  
- OpenSTA  
- ngspice  
- Magic
- PnR using the automated flow (https://github.com/The-OpenROAD-Project/OpenLane)  

**Design Used:**  
good_shift_reg.v from (https://github.com/kunalg123/sky130RTLDesignAndSynthesisWorkshop)

- Verilog simulation performed using **iVerilog**  
- `.vcd` file generated and visualized using **GTKWave**
- PDK used: **Skywater 130nm**

**Design Insight (Shift Register = D Flip-Flop):**
- If **data arrives early** w.r.t clock → No setup/hold violation (data stable)
- If **data arrives late** w.r.t clock → **Setup violation** → Output updates **after 2 cycles** instead of 1

---

## 🗓️ Day 2 – Understanding Liberty Files (.lib)

**Topics Covered:**
- Structure of Liberty files (.lib)
- PVT Corners
- Leakage power and area information
- Cell delay tables

**Hands-on:**
- Synthesizing modules using **hierarchical** and **flat** methods
- Practiced **bottom-up synthesis** for sub-modules to optimize overall design

---

## 🗓️ Day 3 – Logic Optimization Techniques

**Topics Learned:**
- Constant Propagation  
- State Reduction  
- Retiming  
- Logic Cloning  

**Constant Propagation:**  
`Y = ~(A.B + C)` → If `A = 0` (constant), then `Y = ~C` (acts as an inverter).

**Logic Optimization Example:**
`assign y = a ? (b ? c : (c ? a : 0)) : (!c);`
Simplified to 
`y = ac + a.c' = a(c + c') = a`

**State Optimization - reduction of unused states**
Cloning - cloning a signal for better timing results

**Commands used here in Yosys** - 
`opt_clean -purge`
Opt_check = Mux with select signal = a and input = 0 and b → AND gate
Opt_check2 = Mux with select signal = a and input = 1 and b → OR gate
Opt_check3 = Mux with 2 select signals but one of each input is 0 → 3-input AND gate
and so on...

---

## 🗓️ Day 4 – Gate Level Simulation
Understanding the Gate Level Simulation ( Post-synthesis simulation ) to verify the functionality and logical correctness of the circuit which should be same as the pre-synthesis model.

---

## Day 5 - Constructs and Looping Statements
Learning about different constructs and looping statements in the design - if-else, for , case, generate. Understanding the issues of improper coding styles.

---

## 🗓️ Day 6 - PMU FSM Design RTL Coding

---

### 🗓️ Day 7 - Timing Report Generation for Single Corner - PMU FSM

***OpenSTA tool*** - timing reports of the PMU FSM are generated for one corner: ***sky130_fd_sc_hd_tt_025C_1v80***

`P: TT, V: 1.8V, T: 25 degC`

pmu_constraints - consists of constraints used for the PMU FSM
pmu_fsm_sta -  tcl file used to generate the timing reports
Reports generated:
Power report
Setup/Hold timing report
Worst slack (min/max) report
Clock skew report
Max Tran/Max Cap violations report

---

### 🗓️ Day 8 - Use of Ngspice tool for SPICE Modeling 
Using ngspice tool, spice models of inverter VTC curve, inverter transient behaviour, NMOS I-V curves were simulated and analyzed


---

### 🗓️ Day 9 - Timing Report Generation for Multi Corner - PMU FSM 
***OpenSTA tool*** - timing reports for the PMU FSM were calculated at different PVT corners

change_process.py -  a python script to generate power and timing report summary of the different PVT corners
graph_analysis.py -  a python script to analyze the graphs for power and timing summary report ( setup and old) at the different PVT corners

---

# 🗓️ Day 10 - OpenLane Tool Flow Generation - RTL2GDSII

Completed the automated flow for PnR using Openlane tool for the PMU FSM Design and generated reports for analysis


