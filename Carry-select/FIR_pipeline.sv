module FIR_pipeline
(
    input  logic                clk,
    input  logic                reset,
    input  logic        [15:0]  a,
    output logic        [17:0]  s
);

    logic               [15:0]  a1, a2, a3, a4   = 16'b0;

    always_ff @(posedge clk) begin
        if (reset) begin
            a1          <=  0;
            a2          <=  0;
            a3          <=  0;
            a4          <=  0;
        end
        else begin
            a1          <=  a;
            a2          <=  a1;
            a3          <=  a2;
            a4          <=  a3;
        end
    end

    logic               [16:0]  sum1, sum2;
    logic               [16:0]  sum1_reg, sum2_reg;

    adder_select_16_bit adder_select_16_bit_inst1(
        .a              (a1),
        .b              (a2),
        .s              (sum1[15:0]),
        .cout           (sum1[16])
    );

    adder_select_16_bit adder_select_16_bit_inst2(
        .a              (a3),
        .b              (a4),
        .s              (sum2[15:0]),
        .cout           (sum2[16])
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            sum1_reg    <=  0;
            sum2_reg    <=  0;
        end
        else begin
            sum1_reg    <=  sum1;
            sum2_reg    <=  sum2;
        end
    end

    logic               [17:0]  s_l_logic;

    adder_select_17_bit adder_select_17_bit_inst1(
        .a              (sum1_reg),
        .b              (sum2_reg),
        .s              (s_l_logic[16:0]),
        .cout           (s_l_logic[17])
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            s           <= 0;
        end 
        else begin
            s           <= s_l_logic;
        end 
    end

endmodule
