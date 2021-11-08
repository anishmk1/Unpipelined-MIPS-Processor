module control(
    input [15:0] instr,
    input [4:0] opcode,
    output [1:0] RegDest,
    output [3:0] alu_op,
    output MemToReg,
    output MemRead,
    output MemWrite
);
    // Control unit
    
    wire [1:0] funct;
    reg [3:0] alu_op_reg;

    // funct bits generated from either instr or opcode depending on instr type
    assign funct = (opcode == 5'b11001) ? instr[1:0] : opcode[1:0];    
    
    assign MemToReg = 1'b0;
    assign MemRead = 1'b0;
    assign MemWrite = 1'b0;

    assign RegDest = (opcode[4:3] == 2'b01 || opcode[4:3] == 2'b10) ? 0 :   // i type instr
                    (opcode[4:3] == 2'b11) ? 2 : 3;                         // r-type instr  

    assign alu_op = alu_op_reg;

    // generate alu op signal
    always @(*) begin
        if (opcode == 5'b11001 || opcode[4:3] == 2'b01) begin       // R type instr || i type 
            case (funct)               // decode using function bits
                2'b00: 
                    alu_op_reg = 4'd0;     // addition op
                2'b01:
                    alu_op_reg = 4'd1;     // subtraction op
                2'b10:
                    alu_op_reg = 4'd2;     // XOR op
                2'b11:
                    alu_op_reg = 4'd12;     // ANDN op
            endcase
        end
    end
endmodule  