# Lab 3: Design and Verification Examples

You will design and verify small examples in pairs of two.

## ALU with an Accumulator

 * Design engineer: Martin
 * Verification engineer: Hans, Kishan, Niels, Victor

### Specification

The design is an ALU with following operations: nop, +, -, &, |, ^, b, >>

The result of the ALU is stored in the accumulator (a register).
The accumulator has an enable input.

One input to the ALU is the accumulator, the other input is the component input.

The bit width of the design is configurable

The interface is:

```scala
abstract class AluAccu(size: Int) extends Module {
  val io = IO(new Bundle {
    val op = Input(UInt(3.W))
    val din = Input(UInt(size.W))
    val ena = Input(Bool())
    val accu = Output(UInt(size.W))
  })
}
}
```

### Test plan

 * Test that the accumulator is 0 after the reset
 * Test all ALU functions
 * Use edge cases as inputs, such as 0, -1, max. positive, min. negative
   * Compare use all combinations of edge cases with all operations
 * Use random inputs
 * Test that enable works
 * Test different bit width, at least 16 and 32 bits


## Design 1

 * Design engineer: Kishan
 * Verification engineer: Niels

### Specification

### Test plan

## Design 2 - Register file

 * Design engineer: Victor
 * Verification engineer: Hans

### Specification
  Configurationale bit width.
  The register file has synchronous read/write.
  
  Interface:
  ```scala
  abstract class RegFile(addrWidth: Int, dataWidth: Int) extends Module {
  val io = IO(new Bundle {
    val regWrite = Input(Bool())
    val registerRs1 = Input(UInt(addrWidth.W))
    val data1 = Output(UInt(dataWidth.W))
    val registerRs2 = Input(UInt(addrWidth.W))
    val data2 = Output(UInt(dataWidth.W))
    val registerRd = Input(UInt(addrWidth.W))
    val writeData = Input(UInt(dataWidth.W))
  })
}
```

### Test plan
 * Test writing to location zero doesn't change the register file
 * Test reading and writing from all other register locations
 * Test reading from the port being currently written to

## Design 3

 * Design engineer: Niels
 * Verification engineer: Victor

### Specification

### Test plan

## Design 4

 * Design engineer: Hans
 * Verification engineer: Kishan

### Specification

### Test plan






