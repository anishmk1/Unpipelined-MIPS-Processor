module fetch (clk, rst, err, instr, PC, PC_nxt);

	input clk;
	input rst;
	input [15:0] PC_nxt;
	output [15:0] PC;
	output err;
	output [15:0] instr;

	assign err = 1'b0;

	// PC register
	dff iPC_reg[15:0](.q(PC), .d(PC_nxt), .clk(clk), .rst(rst));

	// Fetch instruction
	memory2c imem(.data_out(instr), .data_in(16'h0000), .addr(PC), .enable(1'b1), .wr(1'b0), .createdump(1'b0), .clk(clk), .rst(rst));

endmodule
