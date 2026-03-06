# fsm-secure-locked-alu-verilog
FSM Based Secure ALU with Key Sequence Unlock and Attempt Protection

This project implements a secured Arithmetic Logic Unit (ALU) protected using a Finite State Machine (FSM). The ALU remains locked until the correct key sequence is entered. This demonstrates a basic hardware security concept using Verilog.

## Unlock Mechanism

The FSM checks the following key sequence to unlock the ALU:

01 → 10 → 11

If the correct sequence is entered, the ALU becomes active. If a wrong key is entered, the FSM returns to the initial state. After three wrong attempts, the system permanently locks the ALU until reset.

## ALU Operations

| op | Operation |
|----|-----------|
| 00 | A + B |
| 01 | A - B |
| 10 | A & B |
| 11 | A \| B |

The design was simulated to verify FSM state transitions, unlock behaviour, ALU functionality, and permanent lock after multiple wrong attempts.

## Files

secure_alu.v – Verilog source code  
secure_alu_tb.v – Testbench  
waveform.png – Simulation waveform  
fsm_state_diagram.png – FSM state diagram  
block_diagram.png – System block diagram  
