# Dual-Port RAM in Verilog

An 8-bit wide, 16-depth synchronous dual-port RAM module implemented in Verilog. Includes conflict resolution and verification testbench using Icarus Verilog and GTKWave.

## 🔧 Features
- Simultaneous read/write ports (Port A and Port B)
- Write-write conflict resolution (Port A priority)
- Read-before-write conflict handling
- Testbench simulation with Icarus Verilog

## 📂 File Structure
- `Design.v` – Verilog design for the dual-port RAM
- `Test_bench.v` – Verilog testbench with stimulus and monitoring
- `dump.vcd` – GTKWave-readable waveform output (optional, local use)

## ▶️ Simulation
```bash
iverilog -o Output_tb.vvp Test_bench.v Design.v
vvp Output_tb.vvp
gtkwave dump.vcd

