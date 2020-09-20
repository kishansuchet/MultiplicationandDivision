package FSMD
import chisel3._
class Reg(size :Int) extends Module{
  val io = IO(new Bundle{
    val input = Input(UInt(size.W))
    val output = Output(UInt(size.W))
    val en = Input(Bool())
  })
  val r = RegInit(0.U(size.W))
  if (io.en == true.B){//enable
    r := io.input
  }
  io.output := r
}
