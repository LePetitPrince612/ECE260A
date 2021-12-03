module adder_select_17_bit
(
    input  logic        [16:0]  a,
    input  logic        [16:0]  b,
    output logic                cout,
    output logic        [16:0]  s
);

    logic                       cout_reg;

    adder_select_16_bit adder_select_16_bit_inst
    (
        .a      (a[15:0]),
        .b      (b[15:0]),
        .cout   (cout_reg),
        .s      (s[15:0])
    );

    assign {cout, s[16]} = a[16] + b[16] + cout_reg;

endmodule
