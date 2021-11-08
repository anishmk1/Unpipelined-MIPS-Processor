module execute(
    input [15:0] data1,
    input [15:0] data2,
    output [15:0] alu_result,
    output zero,
    input [3:0] op
);
    wire [15:0] set_out, shifter_out, andn_out, slb_out, btr_out;
    
    assign alu_result = (op == 4'd0) ? data1 + data2 :    // add operation
                        (op == 4'd1) ? data2 - data1 :    // subtract operation
                        (op == 4'd2) ? data1 ^ data2 :    // XOR operation
                        (op == 4'd3) ? data1 & data2 :    // AND
                        (op[3:2] == 2'b01) ? set_out :    // set operation
                        (op[3:2] == 2'b10) ? shifter_out: // shift operation
                        (op == 4'd12) ? andn_out :        // ANDN op
                        (op == 4'd13) ? slb_out :         // shift left byte (SLB) op
                        (op == 4'd14) ? btr_out :         // BTR
                        0;          


    // instance shifter

    // set op stuff

    // andn stuff

    // slb stuff

    // btr stuff


endmodule