module FIR_pipeline
(
    input  logic                clk,
    input  logic                reset,
    input  logic        [15:0]  a,
    output logic        [17:0]  s
);

    logic               [15:0]  a1_logic, a2_logic, a3_logic, a4_logic   = 16'b0;

    always_ff @(posedge clk) begin
        if (reset) begin
            a1_logic            <=  0;
            a2_logic            <=  0;
            a3_logic            <=  0;
            a4_logic            <=  0;
        end
        else begin
            a1_logic            <=  a;
            a2_logic            <=  a1_logic;
            a3_logic            <=  a2_logic;
            a4_logic            <=  a3_logic;
        end
    end

    logic               [16:0]  s_out1_p_in_logic;
    logic               [16:0]  s_out2_p_in_logic;

    logic               [16:0]  s_out1_p_out_logic;
    logic               [16:0]  s_out2_p_out_logic;

    adder_select_16_bit adder_select_16_bit_inst1(
        .clk             (clk),
        .reset           (reset),
        .a_in            (a1_logic),
        .b_in            (a2_logic),
        .s_out           (s_out1_p_in_logic)
    );

    adder_select_16_bit adder_select_16_bit_inst2(
        .clk             (clk),
        .reset           (reset),
        .a_in            (a3_logic),
        .b_in            (a4_logic),
        .s_out           (s_out2_p_in_logic)
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            s_out1_p_out_logic  <=  0;
            s_out2_p_out_logic  <=  0;
        end
        else begin
            s_out1_p_out_logic  <=  s_out1_p_in_logic;
            s_out2_p_out_logic  <=  s_out2_p_in_logic;
        end
    end

    logic               [17:0]  s_l_logic;

    adder_select_17_bit adder_select_17_bit_inst1(
        .clk            (clk),
        .reset          (reset),
        .a_in           (s_out1_p_out_logic),
        .b_in           (s_out2_p_out_logic),
        .s_out          (s_l_logic)
    );

    always_ff @(posedge clk) begin
        if (reset) begin
            s                   <= 0;
        end
        else begin
            s                   <= s_l_logic;
        end          
    end

endmodule
