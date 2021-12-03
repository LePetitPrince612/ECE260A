module adder_4_bit
(
    input  logic        [3:0]   a_in,
    input  logic        [3:0]   b_in,
    input  logic                c_in,
    output logic                c_out,
    output logic        [3:0]   s_out
);

    logic               [3:0]   c_out_logic;
    
    assign c_out                        =   c_out_logic[3];

    always_comb begin
        for (int i=0; i<4; i++) begin
            {c_out_logic[i], s_out[i]}  =   (i==0)? a_in[i] + b_in[i] + c_in : a_in[i] + b_in[i] + c_out_logic[i-1];
        end
    end

endmodule
