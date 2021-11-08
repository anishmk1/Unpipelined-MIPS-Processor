module decode(
    input clk,
    input rst,
    output err,
    input [15:0] instr,
    output [4:0] opcode,
    output [15:0] reg1data,
    output [15:0] reg2data,
    input [15:0] writedata,
    input [1:0] RegDest,     // control sig
);
    // contains register file. Takes in instruction as input and outputs register values
    // control signals for register file??

    wire [4:0] opcode;
    wire halt, beqz;
    wire [15:0] intermediate;
    wire [2:0] writeregsel;

    // instruction decode
    assign opcode = instr[15:11];
    assign intermediate = {{10{instr[4]}}, instr[4:0]};   // sign extend intermediate
    assign read1regsel = instr[10:8];
    assign read2regsel = instr[7:5];
    assign writeregsel = (ReDgest == 2'd0) ? instr[7:5] : 
                        (RegDest == 2'd1) ? instr[10:8] : 
                        (RegDest == 2'd2) ? instr[4:2] :
                        3'd7;       // write to register 7 if JAL instr
    assign write = (opcode == 5'b01000 | opcode == 5'b11011) ? 1'b1: 1'b0;
    assign halt = (opcode == 5'b00000) ? 1'b1 : 1'b0;


    // register file
    rf regFile0(.clk(clk), .rst(rst), .read1regsel(read1regsel), 
        .read2regsel(read2regsel), .writeregsel(writeregsel), .writedata(writedata), 
        .write(write), .read1data(reg1data), .read2data(reg2data), .err(err));


endmodule