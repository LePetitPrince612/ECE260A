module adder_select_17_bit
(
    input  logic                clk,
    input  logic                reset,
    input  logic        [16:0]  a_in,
    input  logic        [16:0]  b_in,
    output logic        [17:0]  s_out
);

    logic                       c_out_logic;

    adder_select_16_bit adder_select_16_bit_inst
    (
        .clk                    (clk),
        .reset                  (reset),
        .a_in                   (a_in[15:0]),
        .b_in                   (b_in[15:0]),
        .s_out                  ({c_out_logic, s_out[15:0]})
    );
    
    logic                       a_in_16_p_1_logic, a_in_16_p_2_logic, a_in_16_p_3_logic;
    logic                       b_in_16_p_1_logic, b_in_16_p_2_logic, b_in_16_p_3_logic;
    
    always_ff @(posedge clk) begin
        if (reset) begin
            a_in_16_p_1_logic       <= 0;
            b_in_16_p_1_logic       <= 0;
        end
        else begin
            a_in_16_p_1_logic       <= a_in[16];
            b_in_16_p_1_logic       <= b_in[16];
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            a_in_16_p_2_logic       <= 0;
            b_in_16_p_2_logic       <= 0;
        end
        else begin
            a_in_16_p_2_logic       <= a_in_16_p_1_logic;
            b_in_16_p_2_logic       <= b_in_16_p_1_logic;
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            a_in_16_p_3_logic       <= 0;
            b_in_16_p_3_logic       <= 0;
        end
        else begin
            a_in_16_p_3_logic       <= a_in_16_p_2_logic;
            b_in_16_p_3_logic       <= b_in_16_p_2_logic;
        end
    end

    assign {s_out[17], s_out[16]}   = a_in_16_p_3_logic + b_in_16_p_3_logic + c_out_logic;

endmodule
