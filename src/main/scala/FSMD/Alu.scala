package FSMD
import chisel3._
import chisel3.util._

class Alu(size: Int) extends Module{
  val io= IO(new Bundle{
  val alu_a = Input(UInt(size.W))
  val alu_b = Input(UInt(size.W))
  val op=Input(Bool()) //0 for *;1 for /
  val aluoutput = Output(UInt(size.W))
})
  io.aluoutput := 0.U //multiplication
  switch(io.op){
    is(false.B){
      io.aluoutput := io.alu_a + io.alu_b
    }
    is(true.B){ //division
      io.aluoutput := io.alu_a - io.alu_b
    }
  }
}
