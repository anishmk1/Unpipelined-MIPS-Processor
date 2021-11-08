module memory(
    input [15:0] addr,
    input MemWrite,
    input MemRead,
    input [15:0] writeData,
    output [15:0] mem_out
);
    wire memReadorWrite;

    assign memReadorWrite = memRead | memWrite;

    memory2c imem(.data_out(mem_out), .data_in(writeData), .addr(addr), .enable(memReadorWrite), .wr(MemWrite), .createdump(1'b0), .clk(clk), .rst(rst));

endmodule