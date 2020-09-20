package FSMD
import chisel3._

class FSM(size :Int) extends Module{
  val io = IO(new Bundle{
    val a = Input(UInt(size.W))
    val b = Input(UInt(size.W))
    val op : Bool= Input(Bool()) //0 for * ; 1 for /
    val aluop = Output(Bool())
    val aluoutput: UInt = Input(UInt(size.W))
    val alu_a = Output(UInt(size.W)) //input 1 to alu
    val alu_b = Output(UInt(size.W)) // input 2 to alu
    val count :UInt= Output(UInt(size.W))
    val count_in = Input(UInt(size.W))
    val en0 = Output(Bool())
    val en1 = Output(Bool())
    val sel = Output(Bool())
    //val reset = Output(Bool())
})
  //multiplication
  io.aluop := 0.B
  io.count:=0.B
  io.en0 := 0.B
  io.en1:=0.B
  io.alu_a := 0.U
  io.alu_b := 0.U
  io.sel := false.B
  if(io.op == 0){
    when (io.count_in < io.b){
      io.alu_a := io.a
      io.en1 := true.B
      io.en0 := true.B
      io.alu_b:=0.U
      io.aluop:=false.B
      io.sel:=true.B
      io.count:= io.count_in + 1.U
    }
    if(io.count_in == io.b){
      io.alu_a := io.a
      io.en0 := true.B
      io.en1 := false.B
      io.alu_b:=0.U
      io.aluop:=false.B
      io.sel:=true.B
      io.count:= 0.U(size.W)
    }
  }
  else{
    when(io.aluoutput>io.a){
      io.alu_a := io.aluoutput
      io.alu_b := io.b
      io.aluop := true.B
      io.sel := false.B
      io.count := io.count_in + 1.U
      io.en1:=true.B
      io.en0:=true.B
    }
    when(io.aluoutput<io.a){
      io.alu_a := io.aluoutput
      io.alu_b :=0.U
      io.en0:=false.B
      io.en1:=false.B
      io.count := 0.U
      io.aluop := true.B
      io.sel := true.B
    }
  }
}
