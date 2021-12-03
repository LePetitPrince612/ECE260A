module adder_select_16_bit
(
    input  logic            [15:0]      a,
    input  logic            [15:0]      b,
    output logic                        cout,
    output logic            [15:0]      s
);

    logic                   [3:0]       cout_reg;

    adder_4_bit adder_4_bit_inst1
    (
        .a              (a[3:0]),
        .b              (b[3:0]),
        .cin            (1'b0),
        .cout           (cout_reg[0]),
        .s              (s[3:0])
    );

    genvar i;
    
    generate
        for (i=1; i<4; i++) begin : select_adder
            adder_select_4_bit adder_select_4_bit_inst
            (
                .a      (a[4*i +: 4]),
                .b      (b[4*i +: 4]),
                .sel    (cout_reg[i-1]),
                .cout   (cout_reg[i]),
                .s      (s[4*i +: 4])
            );
        end
    endgenerate
    
    assign cout = cout_reg[3];

endmodule
