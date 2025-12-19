# Reversible 4-bit and 8-bit Squarer

This repository contains a reversible 4-bit and 8-bit squarer implemented using reversible logic gates in Verilog. The design follows the architecture proposed in recent reversible squarer literature and is targeted for FPGA implementation using Xilinx Vivado. [file:268]

The focus is on:
- Lower **quantum cost** and total reversible logic implementation cost (TRLIC).
- Reduced **garbage outputs** and ancilla inputs.
- Structuring the squarer into clear partial-product and summation stages for reuse and scaling. [file:268]

---

## Motivation and background

In conventional (irreversible) logic, information loss at each computation step leads to energy dissipation, as captured by Landauer’s principle. Reversible logic enforces a one‑to‑one mapping between inputs and outputs, which can theoretically enable computations with much lower energy loss. [file:268]

For arithmetic circuits such as squarers and multipliers, key optimization goals are:
- Minimizing delay through shorter logic depth.
- Minimizing quantum cost, gate count, garbage outputs, and constant inputs. [file:268]

This project adapts those ideas into a clean, open Verilog implementation suitable for learning, experimentation, and extension.

---

## Problem statement

- Input:
  - 4-bit input \(A[3:0]\) and 8-bit input \(A[7:0]\) (for the respective designs).
- Output:
  - 8-bit result \(Y[7:0] = A[3:0] \times A[3:0]\) for the 4‑bit squarer.
  - 16-bit result \(Y[15:0] = A[7:0] \times A[7:0]\) for the 8‑bit squarer.

Both designs are constructed using reversible gates and reversible adders, preserving information while computing the arithmetic square.

---

## Repository structure

- `src/gates/`  
  Primitive reversible building blocks:
  - `peres_gate.v` – Peres gate.
  - `hng_gate.v` – HNG full-adder style gate.
  - `rev_half_adder.v`, `rev_full_adder.v` – Reversible half and full adders built from the above gates.

- `src/squarer_4bit/`  
  4‑bit squarer datapath:
  - `partial_products_4bit.v` – Generates reversible partial products.
  - `summation_network_4bit.v` – Structured reversible adder tree.
  - `squarer_4bit.v` – Top-level 4‑bit squarer connecting the blocks.

- `src/squarer_8bit/`  
  8‑bit squarer datapath:
  - `partial_products_8bit.v` – Reversible partial-products generator for 8‑bit input.
  - `summation_network_8bit.v` – Summation network scaled to 16‑bit output.
  - `squarer_8bit.v` – Top-level 8‑bit squarer reusing the same design philosophy.

- `tb/`  
  Testbenches:
  - `tb_squarer_4bit.v` – Testbench for the 4‑bit squarer.
  - `tb_squarer_8bit.v` – Testbench for the 8‑bit squarer.

---

## How to run the design

1. **Open in Vivado**
   - Create or open a Vivado project.
   - Add all Verilog files from `src/` and the desired testbench from `tb/`.
   - Set `squarer_4bit.v` or `squarer_8bit.v` as the top module.

2. **Run simulation**
   - Use `tb_squarer_4bit.v` to verify the 4‑bit design.
   - Use `tb_squarer_8bit.v` to verify the 8‑bit design.
   - Inspect waveforms to confirm correct squares for representative input patterns.

3. **Synthesis and implementation (optional)**
   - Target an Artix‑7 board (e.g., Nexys A7) or any supported FPGA.
   - Run synthesis, implementation, and timing analysis to compare resource usage and delay with non‑reversible baselines. [file:268]

---

## Possible extensions

- Compare delay, LUT count, and power against a standard (irreversible) squarer implemented with conventional adders.
- Experiment with alternative reversible full‑adder designs and observe changes in quantum cost and garbage outputs. [file:268]
- Extend the architecture to wider word lengths (16‑bit, 32‑bit) and study scalability.

---

## Citation

If you use this repository in academic work, you may cite the underlying reversible squarer paper that inspired the architecture. [file:268]
