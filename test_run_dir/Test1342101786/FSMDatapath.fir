;buildInfoPackage: chisel3, version: 3.3.2, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit FSMDatapath : 
  module FSM : 
    input clock : Clock
    input reset : Reset
    output io : {flip a : UInt<16>, flip b : UInt<16>, flip op : UInt<1>, aluop : UInt<1>, flip aluoutput : UInt<16>, alu_a : UInt<16>, alu_b : UInt<16>, count : UInt<16>, flip count_in : UInt<16>, en0 : UInt<1>, en1 : UInt<1>, sel : UInt<1>}
    
    io.aluop <= UInt<1>("h00") @[FSM.scala 21:12]
    io.count <= UInt<1>("h00") @[FSM.scala 22:11]
    io.en0 <= UInt<1>("h00") @[FSM.scala 23:10]
    io.en1 <= UInt<1>("h00") @[FSM.scala 24:9]
    io.alu_a <= UInt<1>("h00") @[FSM.scala 25:12]
    io.alu_b <= UInt<1>("h00") @[FSM.scala 26:12]
    io.sel <= UInt<1>("h00") @[FSM.scala 27:10]
    node _T = gt(io.aluoutput, io.b) @[FSM.scala 49:22]
    when _T : @[FSM.scala 49:28]
      io.alu_a <= io.aluoutput @[FSM.scala 50:16]
      io.alu_b <= io.b @[FSM.scala 51:16]
      io.aluop <= UInt<1>("h01") @[FSM.scala 52:16]
      io.sel <= UInt<1>("h00") @[FSM.scala 53:14]
      node _T_1 = add(io.count_in, UInt<1>("h01")) @[FSM.scala 54:31]
      node _T_2 = tail(_T_1, 1) @[FSM.scala 54:31]
      io.count <= _T_2 @[FSM.scala 54:16]
      io.en1 <= UInt<1>("h01") @[FSM.scala 55:13]
      io.en0 <= UInt<1>("h01") @[FSM.scala 56:13]
      skip @[FSM.scala 49:28]
    node _T_3 = lt(io.aluoutput, io.b) @[FSM.scala 58:22]
    when _T_3 : @[FSM.scala 58:28]
      io.alu_a <= io.aluoutput @[FSM.scala 59:16]
      io.alu_b <= UInt<1>("h00") @[FSM.scala 60:16]
      io.en0 <= UInt<1>("h00") @[FSM.scala 61:13]
      io.en1 <= UInt<1>("h00") @[FSM.scala 62:13]
      io.count <= UInt<1>("h00") @[FSM.scala 63:16]
      io.aluop <= UInt<1>("h01") @[FSM.scala 64:16]
      io.sel <= UInt<1>("h01") @[FSM.scala 65:14]
      skip @[FSM.scala 58:28]
    
  module Reg : 
    input clock : Clock
    input reset : Reset
    output io : {flip input : UInt<16>, output : UInt<16>, flip en : UInt<1>}
    
    reg r : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[Reg.scala 9:18]
    io.output <= r @[Reg.scala 13:13]
    
  module Reg_1 : 
    input clock : Clock
    input reset : Reset
    output io : {flip input : UInt<16>, output : UInt<16>, flip en : UInt<1>}
    
    reg r : UInt<16>, clock with : (reset => (reset, UInt<16>("h00"))) @[Reg.scala 9:18]
    io.output <= r @[Reg.scala 13:13]
    
  module Alu : 
    input clock : Clock
    input reset : Reset
    output io : {flip alu_a : UInt<16>, flip alu_b : UInt<16>, flip op : UInt<1>, aluoutput : UInt<16>}
    
    io.aluoutput <= UInt<1>("h00") @[Alu.scala 12:16]
    node _T = eq(UInt<1>("h00"), io.op) @[Conditional.scala 37:30]
    when _T : @[Conditional.scala 40:58]
      node _T_1 = add(io.alu_a, io.alu_b) @[Alu.scala 15:32]
      node _T_2 = tail(_T_1, 1) @[Alu.scala 15:32]
      io.aluoutput <= _T_2 @[Alu.scala 15:20]
      skip @[Conditional.scala 40:58]
    else : @[Conditional.scala 39:67]
      node _T_3 = eq(UInt<1>("h01"), io.op) @[Conditional.scala 37:30]
      when _T_3 : @[Conditional.scala 39:67]
        node _T_4 = sub(io.alu_a, io.alu_b) @[Alu.scala 18:32]
        node _T_5 = tail(_T_4, 1) @[Alu.scala 18:32]
        io.aluoutput <= _T_5 @[Alu.scala 18:20]
        skip @[Conditional.scala 39:67]
    
  module FSMDatapath : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip a : UInt<16>, flip b : UInt<16>, flip op : UInt<1>, output1 : UInt<16>, output2 : UInt<16>}
    
    io.output2 <= UInt<1>("h00") @[FSMDatapath.scala 14:14]
    io.output1 <= UInt<1>("h00") @[FSMDatapath.scala 15:14]
    inst FSM of FSM @[FSMDatapath.scala 16:19]
    FSM.clock <= clock
    FSM.reset <= reset
    inst Reg1 of Reg @[FSMDatapath.scala 17:20]
    Reg1.clock <= clock
    Reg1.reset <= reset
    inst Reg2 of Reg_1 @[FSMDatapath.scala 18:20]
    Reg2.clock <= clock
    Reg2.reset <= reset
    inst Alu of Alu @[FSMDatapath.scala 19:19]
    Alu.clock <= clock
    Alu.reset <= reset
    FSM.io.a <= io.a @[FSMDatapath.scala 20:12]
    FSM.io.b <= io.b @[FSMDatapath.scala 21:12]
    FSM.io.op <= io.op @[FSMDatapath.scala 22:13]
    FSM.io.aluoutput <= Alu.io.aluoutput @[FSMDatapath.scala 23:20]
    FSM.io.count_in <= FSM.io.count @[FSMDatapath.scala 24:19]
    Alu.io.alu_a <= FSM.io.alu_a @[FSMDatapath.scala 25:16]
    node _T = mux(FSM.io.sel, Alu.io.aluoutput, FSM.io.alu_b) @[FSMDatapath.scala 26:22]
    Alu.io.alu_b <= _T @[FSMDatapath.scala 26:16]
    Reg1.io.en <= FSM.io.en0 @[FSMDatapath.scala 27:14]
    Reg2.io.en <= FSM.io.en1 @[FSMDatapath.scala 28:14]
    Alu.io.op <= FSM.io.aluop @[FSMDatapath.scala 29:12]
    Reg2.io.input <= FSM.io.count @[FSMDatapath.scala 30:17]
    Reg1.io.input <= Alu.io.aluoutput @[FSMDatapath.scala 31:17]
    io.output1 <= Reg1.io.output @[FSMDatapath.scala 32:14]
    io.output2 <= Reg2.io.output @[FSMDatapath.scala 33:14]
    
