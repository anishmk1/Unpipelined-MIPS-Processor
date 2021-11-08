/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   /* your code here */
   // submodule dataflow signals
   wire err_fetch, err_decode, err_mem;
   wire [4:0] opcode;
   wire [15:0] instr, PC, PC_nxt;
   wire [15:0] reg1data, reg2data, writedata, alu_result;

   assign err = err_fetch | err_decode | err_mem;

   // control signals
   wire [1:0] RegDest;
   wire [3:0] alu_op;
   wire MemToReg, MemRead, MemWrite;

   // control unit
   control ctrl0(.instr(instr), .opcode(opcode), .RegDest(RegDest), .alu_op(alu_op), .MemToReg(MemToReg), .MemRead(MemRead), .MemRead(MemRead));

   // fetch unit
   fetch fetch0(.clk(clk), .rst(rst), .err(err_fetch), .PC(PC), .PC_nxt(PC_nxt));

   // decode unit
   decode decode0(.clk(clk), .rst(rst), .err(err_decode), .instr(instr), .opcode(opcode), .reg1data(reg1data), .reg2data(reg2data), .writedata(writedata), .RegDest(RegDest));

   // execute unit
   execute execute0(.data1(reg1data), .data2(reg2data), .alu_result(alu_result), .zero(zero), .op(alu_op));
   
   // memory unit
   memory memory0(.addr(alu_result), .MemWrite(MemWrite), .MemRead(MemRead), .writeData(reg2data), .mem_out(mem_out));
   
   //writeback unit
   writeback writeback0(.mem_out(mem_out), .alu_out(alu_result), .MemToReg(MemToReg), .writedata(writedata));
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
