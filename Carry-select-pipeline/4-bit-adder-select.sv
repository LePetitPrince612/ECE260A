module adder_select_4_bit
(
    input  logic        [3:0]   a_in,
    input  logic        [3:0]   b_in,
    input  logic                sel_in,
    output logic                c_out,
    output logic        [3:0]   s_out
);

    logic               [3:0]   sum1_logic, sum2_logic;
    logic                       cout1_logic, cout2_logic;

    adder_4_bit adder_4_bit_inst1(
        .a_in       (a_in),
        .b_in       (b_in),
        .c_in       (1'b0),
        .c_out      (cout1_logic),
        .s_out      (sum1_logic)
    );

    adder_4_bit adder_4_bit_inst2(
        .a_in      (a_in),
        .b_in      (b_in),
        .c_in      (1'b1),
        .c_out     (cout2_logic),
        .s_out     (sum2_logic)
    );

    assign c_out    = sel_in? cout2_logic : cout1_logic;
    assign s_out    = sel_in? sum2_logic : sum1_logic;

endmodule
