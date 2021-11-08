module writeback (
    input [15:0] mem_out,
    input [15:0] alu_out,
    input MemToReg,
    output [15:0] writedata
);
    assign writedata = (MemToReg) ? mem_out : alu_out;

endmodule