 module proc(clk, rst, err);
    input clk;
    input rst;
    output err;

    wire [2:0] read1regsel, read2regsel, writeregsel;
    wire [15:0] instr, writedata, read1data, read2data, PC, PC_nxt;
    wire write;

    // instantiate fetch block and register file
    fetch ifetch(.clk(clk), .rst(rst), .err(err), .instr(instr), .PC(PC), .PC_nxt(PC_nxt));
    rf irf(.clk(clk), .rst(rst), .read1regsel(read1regsel), 
        .read2regsel(read2regsel), .writeregsel(writeregsel), .writedata(writedata), 
        .write(write), .read1data(read1data), .read2data(read2data), .err(err));

    wire [4:0] opcode;
    wire halt;
    wire [15:0] intermediate;

    assign PC_nxt = PC + 2;

    // decode instruction
    assign opcode = instr[15:11];
    assign intermediate = {{10{instr[4]}}, instr[4:0]};   // sign extend intermediate
    assign read1regsel = instr[10:8];
    assign read2regsel = instr[7:5];

    assign writeregsel = (opcode == 5'b01000) ? instr[7:5] : instr[4:2];
    assign write = (opcode == 5'b01000 | opcode == 5'b11011) ? 1'b1: 1'b0;
    assign halt = (opcode == 5'b00000) ? 1'b1 : 1'b0;

    assign writedata = (opcode == 5'b01000) ? read1data + intermediate :    // ADDI op
                        (opcode == 5'b11011) ? read1data ^ read2data :      // XOR op
                        0;
endmodule
