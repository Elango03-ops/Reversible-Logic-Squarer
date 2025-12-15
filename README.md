# Reversible 4-bit Squarer

This repository implements a **reversible 4-bit squarer** using reversible logic gates.
The design emphasizes structured arithmetic construction and **explicit garbage-output management**,
which are central concerns in reversible and low-energy computing.

---

## Why Reversible Logic?

Conventional (irreversible) logic circuits lose information during computation.
According to **Landauer’s principle**, every bit of lost information results in energy dissipation.

Reversible logic avoids this by enforcing a **one-to-one mapping** between inputs and outputs.
No information is destroyed; instead, additional outputs (called *garbage outputs*) may be generated
to preserve reversibility.

This project demonstrates these concepts using a concrete arithmetic block: a 4-bit squarer.

---

## Problem Statement

Compute: Y = A × A 

where `A` is a 4-bit input and `Y` is an 8-bit output, using **only reversible logic constructs**.

---

## Design Architecture

The squarer is built in three logical stages:

### 1. Partial Product Generation
- Partial products are generated using reversible gates.
- Each operation preserves input information.
- Additional outputs are produced as garbage to maintain reversibility.

### 2. Reversible Summation Network
- Partial products are summed column-wise following binary arithmetic rules.
- Reversible Half Adders and Full Adders are used instead of conventional adders.
- Carry propagation is handled without information loss.

### 3. Garbage Output Management
- Intermediate signals not required for the final output are treated as garbage.
- The design keeps garbage outputs explicit and structured for clarity and analysis.

---

## Reversible Building Blocks Used

- **Peres Gate**
- **HNG Gate**
- **Reversible Half Adder**
- **Reversible Full Adder**

These gates enable arithmetic operations while maintaining reversibility.

---

## Folder Structure


---

## Simulation and Verification

- Tool: **AMD Vivado**
- Simulation type: Behavioral simulation
- The testbench verifies correct squaring behavior for valid 4-bit input values.

---

## Scope and Limitations

- This implementation is limited to **4-bit inputs**.
- The focus is on **functional correctness and reversibility**, not physical synthesis.
- No power, area, or timing optimizations are claimed.

---

## Possible Extensions

- Scaling the design to 8-bit inputs
- Applying uncomputation techniques to further reduce garbage outputs
- Comparative analysis of garbage count with other reversible squarer architectures

