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
[`good_shift_reg.v`](https://github.com/kunalg123/sky130RTLDesignWorkshop) from *Kunal Ghosh’s sky130RTLDesignWorkshop repository*

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

### 🧩 Examples

**Constant Propagation:**  
`Y = ~(A.B + C)` → If `A = 0` (constant), then `Y = ~C` (acts as an inverter).

**Logic Optimization Example:**
```verilog```
assign y = a ? (b ? c : (c ? a : 0)) : (!c);
Simplified to 
y = ac + a.c' = a(c + c') = a
