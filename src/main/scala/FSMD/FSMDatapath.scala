package FSMD
import chisel3._
import chisel3.util._

// a/b or a*b format
case class FSMDatapath(size: Int) extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(size.W))
    val b = Input(UInt(size.W))
    val op = Input(Bool()) // 0 for multiplication ;1 for division
    val output1 = Output(UInt(size.W))//product;remainder
    val output2 = Output(UInt(size.W))//b;quotient
  })
  io.output2 := 0.U
  io.output1 := 0.U
  val FSM = Module(new FSM(size))
  val Reg1 = Module(new Reg(size))
  val Reg2 = Module(new Reg(size))
  val Alu = Module(new Alu(size))
  FSM.io.a := io.a
  FSM.io.b := io.b
  FSM.io.op := io.op
  FSM.io.aluoutput := Alu.io.aluoutput
  FSM.io.count_in := FSM.io.count
  Alu.io.alu_a := FSM.io.alu_a
  Alu.io.alu_b := Mux(FSM.io.sel, Alu.io.aluoutput,FSM.io.alu_b)//FSM.io.alu_b
  Reg1.io.en := FSM.io.en0
  Reg2.io.en := FSM.io.en1
  Alu.io.op:=FSM.io.aluop
  Reg2.io.input := FSM.io.count
  Reg1.io.input := Alu.io.aluoutput
  io.output1 := Reg1.io.output
  io.output2 := Reg2.io.output
}
//object DatapathMain extends App {
//  println("Generating the Processor hardware")
//  chisel3.Driver.execute(Array("--target-dir", "generated"), () => new FSMD.Datapath(16))
//}