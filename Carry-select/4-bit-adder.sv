module adder_4_bit
(   input  logic        [3:0]   a,
    input  logic        [3:0]   b,
    input  logic                cin,
    output logic                cout,
    output logic        [3:0]   s
);

    logic               [3:0]   cout_reg;
    
    assign cout             = cout_reg[3];

    always_comb begin
        for (int i=0; i<4; i++) begin
            {cout_reg[i], s[i]} = (i==0)? a[i] + b[i] + cin : a[i] + b[i] + cout_reg[i-1];
        end
    end

endmodule
