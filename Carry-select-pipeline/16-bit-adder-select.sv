module adder_select_16_bit
(
    input  logic                        clk,
    input  logic                        reset,
    input  logic            [15:0]      a_in,
    input  logic            [15:0]      b_in,
    output logic            [16:0]      s_out
);

    logic                               c_out_p1_in_logic;
    logic                   [3:0]       s_out_p1_in_logic;

    adder_4_bit adder_4_bit_inst1
    (
        .a_in               (a_in[3:0]),
        .b_in               (b_in[3:0]),
        .c_in               (1'b0),
        .c_out              (c_out_p1_in_logic),
        .s_out              (s_out_p1_in_logic)
    );

    logic                               c_out_p1_out_logic;
    logic                   [3:0]       s_out_p1_out_logic;
    logic                   [11:0]      a_in_p1_out_logic; 
    logic                   [11:0]      b_in_p1_out_logic;

    always_ff @(posedge clk) begin
        if(reset) begin
            {c_out_p1_out_logic, s_out_p1_out_logic, a_in_p1_out_logic, b_in_p1_out_logic}      <= 0;
        end
        else begin
            {c_out_p1_out_logic, s_out_p1_out_logic, a_in_p1_out_logic, b_in_p1_out_logic}      <= {c_out_p1_in_logic, s_out_p1_in_logic, a_in[15:4], b_in[15:4]};
        end
    end

    logic                               c_out_p2_in_logic;
    logic                   [3:0]       s_out_p2_in_logic;

    adder_select_4_bit adder_select_4_bit_inst1
    (
        .a_in               (a_in_p1_out_logic[3:0]),
        .b_in               (b_in_p1_out_logic[3:0]),
        .sel_in             (c_out_p1_out_logic),
        .c_out              (c_out_p2_in_logic),
        .s_out              (s_out_p2_in_logic)
    );

    logic                               c_out_p2_out_logic;
    logic                   [7:0]       s_out_p2_out_logic;
    logic                   [7:0]       a_in_p2_out_logic; 
    logic                   [7:0]       b_in_p2_out_logic;

    always_ff @(posedge clk) begin
        if(reset) begin
            {c_out_p2_out_logic, s_out_p2_out_logic, a_in_p2_out_logic, b_in_p2_out_logic}      <= 0;
        end
        else begin
            {c_out_p2_out_logic, s_out_p2_out_logic, a_in_p2_out_logic, b_in_p2_out_logic}      <= {c_out_p2_in_logic, {s_out_p2_in_logic, s_out_p1_out_logic}, a_in_p1_out_logic[11:4], b_in_p1_out_logic[11:4]};
        end
    end

    logic                               c_out_p3_in_logic;
    logic                   [3:0]       s_out_p3_in_logic;

    adder_select_4_bit adder_select_4_bit_inst2
    (
        .a_in               (a_in_p2_out_logic[3:0]),
        .b_in               (b_in_p2_out_logic[3:0]),
        .sel_in             (c_out_p2_out_logic),
        .c_out              (c_out_p3_in_logic),
        .s_out              (s_out_p3_in_logic)
    );

    logic                               c_out_p3_out_logic;
    logic                   [11:0]      s_out_p3_out_logic;
    logic                   [3:0]       a_in_p3_out_logic; 
    logic                   [3:0]       b_in_p3_out_logic;

    always_ff @(posedge clk) begin
        if(reset) begin
            {c_out_p3_out_logic, s_out_p3_out_logic, a_in_p3_out_logic, b_in_p3_out_logic}      <= 0;
        end
        else begin
            {c_out_p3_out_logic, s_out_p3_out_logic, a_in_p3_out_logic, b_in_p3_out_logic}      <= {c_out_p3_in_logic, {s_out_p3_in_logic, s_out_p2_out_logic}, a_in_p2_out_logic[7:4], b_in_p2_out_logic[7:4]};
        end
    end   

    adder_select_4_bit adder_select_4_bit_inst3
    (
        .a_in               (a_in_p3_out_logic),
        .b_in               (b_in_p3_out_logic),
        .sel_in             (c_out_p3_out_logic),
        .c_out              (s_out[16]),
        .s_out              (s_out[15:12])
    );

    assign                  s_out[11:0]     = s_out_p3_out_logic;

endmodule
