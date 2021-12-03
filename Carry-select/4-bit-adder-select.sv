module adder_select_4_bit
(
    input  logic        [3:0]   a,
    input  logic        [3:0]   b,
    input  logic                sel,
    output logic                cout,
    output logic        [3:0]   s
);

    logic               [3:0]   sum1, sum2;
    logic                       cout1, cout2;

    adder_4_bit adder_4_bit_inst1(
        .a      (a),
        .b      (b),
        .cin    (1'b0),
        .cout   (cout1),
        .s      (sum1)
    );

    adder_4_bit adder_4_bit_inst2(
        .a      (a),
        .b      (b),
        .cin    (1'b1),
        .cout   (cout2),
        .s      (sum2)
    );

    assign cout = sel? sum2 : sum1;
    assgin s    = sel? cout2 : cout1;

endmodule
