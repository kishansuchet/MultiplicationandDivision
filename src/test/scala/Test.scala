import java.math.BigInteger

import org.scalatest._
import chisel3._
import chisel3.fromBigIntToLiteral
import chisel3.util._
import chisel3.iotesters._
import scala.util.Random.nextInt
import scala.math.BigInt
import scala.math.Numeric.BigIntIsIntegral.abs

class Test(dut: FSMD.FSMDatapath) extends PeekPokeTester(dut) {
  poke(dut.io.a,2.U)
  poke(dut.io.b,2.U)
  poke(dut.io.op,false.B)
//  println("product is:")
//  println("number x: ")
  step(1)
  println("product is: "+peek(dut.io.output1).toString)
  println("number x: "+peek(dut.io.output2).toString)
  step(1)
  println("product is: "+peek(dut.io.output1).toString)
  println("number x: "+peek(dut.io.output2).toString)
  step(1)
  println("product is: "+peek(dut.io.output1).toString)
  println("number x: "+peek(dut.io.output2).toString)
  step(1)
  println("product is: "+peek(dut.io.output1).toString)
  println("number x: "+peek(dut.io.output2).toString)
}
object Test extends App {
  chisel3.iotesters.Driver (() => new FSMD.FSMDatapath(16)) { c =>
    new Test (c)
  }
}