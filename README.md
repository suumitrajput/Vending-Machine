# 🥤 Vending Machine Controller using Mealy FSM

![Verilog](https://img.shields.io/badge/Language-Verilog-blue)
![FSM](https://img.shields.io/badge/Design-Mealy%20FSM-green)
![RTL](https://img.shields.io/badge/Level-RTL%20Design-orange)

---

## 📌 Project Overview

This project implements a **₹20 Vending Machine Controller** using a **Mealy Finite State Machine (FSM)** in Verilog HDL.

The vending machine accepts ₹5 coins and dispenses the product when the total inserted amount reaches **₹20**.

Since this design uses a **Mealy FSM**, the output depends on both the **current state** and the **current input**.

---

# 💰 Product Price

## ₹20

The FSM tracks the following accumulated amounts:

| State | State Encoding | Amount |
|:-----:|:--------------:|:------:|
| S0 | 00 | ₹0 |
| S1 | 01 | ₹5 |
| S2 | 10 | ₹10 |
| S3 | 11 | ₹15 |

When the machine is in **S3 (₹15)** and receives another ₹5 coin:

```text
Total Amount = ₹20
DISPENSE = 1
```

The FSM then returns to the initial state **S0**.

---

# 🧠 FSM Type

This project uses a **Mealy Finite State Machine**.

In a Mealy FSM:

```text
Output = f(Current State, Input)
```

The output depends on:

- Current State
- Current Input

The dispense signal is generated when:

```text
Current State = S3
Input = ₹5
Output = 1
```

---

# 🔄 FSM State Diagram

The following diagram represents the complete state transition logic of the ₹20 Vending Machine.

<p align="center">
  <img src="fsm_diagram.png" alt="Vending Machine Mealy FSM State Diagram" width="700">
</p>

---

# 📊 State Transition Table

| Current State | Input | Next State | Output |
|:-------------:|:-----:|:----------:|:------:|
| S0 (₹0) | ₹0 | S0 | 0 |
| S0 (₹0) | ₹5 | S1 | 0 |
| S1 (₹5) | ₹0 | S1 | 0 |
| S1 (₹5) | ₹5 | S2 | 0 |
| S2 (₹10) | ₹0 | S2 | 0 |
| S2 (₹10) | ₹5 | S3 | 0 |
| S3 (₹15) | ₹0 | S3 | 0 |
| S3 (₹15) | ₹5 | S0 | 1 |

---

# 🏗️ FSM Flow

```text
      ┌─────────┐
      │   S0    │
      │  ₹0     │
      └────┬────┘
           │ ₹5
           ▼
      ┌─────────┐
      │   S1    │
      │  ₹5     │
      └────┬────┘
           │ ₹5
           ▼
      ┌─────────┐
      │   S2    │
      │  ₹10    │
      └────┬────┘
           │ ₹5
           ▼
      ┌─────────┐
      │   S3    │
      │  ₹15    │
      └────┬────┘
           │ ₹5
           │ DISPENSE = 1
           ▼
      ┌─────────┐
      │   S0    │
      │  ₹0     │
      └─────────┘
```

---

# ⚙️ Working Principle

## 1️⃣ Reset

Initially, the vending machine enters the S0 state.

```text
State = S0
Amount = ₹0
Dispense = 0
```

---

## 2️⃣ First ₹5 Coin

When the first ₹5 coin is inserted:

```text
S0 → S1

Amount = ₹5
```

---

## 3️⃣ Second ₹5 Coin

When another ₹5 coin is inserted:

```text
S1 → S2

Amount = ₹10
```

---

## 4️⃣ Third ₹5 Coin

When another ₹5 coin is inserted:

```text
S2 → S3

Amount = ₹15
```

---

## 5️⃣ Fourth ₹5 Coin

When the FSM is in S3 and another ₹5 coin is inserted:

```text
Current State = S3

Current Amount = ₹15

Input = ₹5

Total Amount = ₹20

DISPENSE = 1
```

After dispensing the product:

```text
S3 → S0
```

The machine is ready for the next transaction.

---

# 📥 Inputs and Outputs

| Signal | Type | Description |
|--------|------|-------------|
| `clk` | Input | System Clock |
| `rst` | Input | Reset Signal |
| `in` | Input | Coin Input |
| `out` | Output | Product Dispense Signal |
| `c` | Output | Current State |

---

# 🧪 Simulation

The Verilog testbench verifies the following functionality:

- ✅ Reset functionality
- ✅ FSM state transitions
- ✅ ₹5 coin insertion
- ✅ Amount accumulation
- ✅ ₹20 detection
- ✅ Product dispensing
- ✅ Mealy FSM output behavior

---

# ⏱️ Expected Simulation Flow

```text
RESET
  │
  ▼
S0 (₹0)
  │
  │ ₹5
  ▼
S1 (₹5)
  │
  │ ₹5
  ▼
S2 (₹10)
  │
  │ ₹5
  ▼
S3 (₹15)
  │
  │ ₹5
  ▼
DISPENSE = 1
  │
  ▼
S0 (₹0)
```

---

# 📂 Project Structure

```text
Vending-Machine-Mealy-FSM/
│
├── vending_machine.v
│       └── Main RTL Design
│
├── vending_machine_tb.v
│       └── Verilog Testbench
│
├── fsm_diagram.png
│       └── FSM State Diagram
│
├── waveform.png
│       └── Simulation Waveform
│
└── README.md
        └── Project Documentation
```

---

# 🛠️ Technologies Used

- Verilog HDL
- RTL Design
- Mealy FSM
- Digital Logic Design
- Finite State Machine
- Verilog Testbench

---

# 🎯 Key Concepts Demonstrated

- Finite State Machine Design
- Mealy FSM Architecture
- State Encoding
- Sequential Logic
- Combinational Logic
- Next State Logic
- Output Logic
- Clock and Reset Handling
- RTL Design
- Functional Simulation

---

# 🚀 Future Improvements

- Support for multiple coin denominations
- ₹1, ₹2, ₹5 and ₹10 coin support
- Change return functionality
- Multiple product selection
- LCD Display Interface
- FPGA Implementation
- SystemVerilog Testbench
- SystemVerilog Assertions (SVA)
- Formal Verification

---

# 👨‍💻 Author

**Sumit Singh**

Electronics Engineering | RTL Design | Verilog HDL | Digital Design

---

⭐ If you found this project useful, consider giving the repository a star!
