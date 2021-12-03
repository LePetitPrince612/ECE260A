// testbench for 4-tap, w-bit, unsigned averaging FIR filter
// ECE260A Lab 3 assignment   2019
// change parameter w to experiment wih wider operand vectors, such as 16 bits
module project_tb2_u;
  parameter           w = 16;
  logic               clk = 'b0,			          
                      reset = 'b1;	  // active high
  logic  [w-1:0] a; 	              // unsigned operands
  wire   [w+1:0] s;                   // sum output from DUT
  wire signed[w+2:0] dif1;   	      // diff. between theoretical and actual rums
  logic	 [w+1:0] s_b1;    	          // "golden" sum output
  logic  [w-1:0] ar, 				  // delays of input a -- parallels actual pipeline
                 br,				  //   in DUT
                 cr,
                 dr;	              // operand tapped delay line in testbench	

// device under test goes here
// choose "tree," "cascade," "CSA," or other topology
//  fir4rca_cas_u #(.w(w)) f1(.*);
  FIR_pipeline FIR_pipeline_inst
  (
      .clk(clk),
      .reset(reset),
      .a_in(a),
      .s_out(s)
  );

  always begin			           	  // tick ... tock 
    #5ns clk = 'b1;
	#5ns clk = 'b0;
  end

// series of 25 sets of random operands
  initial begin
    $display("a   s  s_b  diff");
    #10ns reset = '0;
	for(int i = 0; i < 25; i++) begin
	  a   = $random;// 2**(i/4);//$random;
	  #8ns $displayh(a,,,,,s,,,,s_b1,,,,dif1);
	  #2ns;
	end  
    #50ns $stop;
  end

  always @(posedge clk) 
    if(reset) begin :rst
	  ar  <= 'b0;
	  br  <= 'b0;
	  cr  <= 'b0;
	  dr  <= 'b0;
	  s_b1<= 'b0;
	end  :rst
	else begin :run
      ar  <= a;						  // match DUT's input pipe reg. delay
      br  <= ar;
      cr  <= br;
      dr  <= cr;
      s_b1 <= ar+br+cr+dr;			 // purely behavioral description of function
    end :run
    
  logic	 [w+1:0] s_b2, s_b3, s_b4, s_b5, s_b6, s_b7;  
    
  always @(posedge clk) 
    if(reset) begin
	  s_b2<= 'b0;
	end
	else begin
      s_b2 <= s_b1;			 // purely behavioral description of function
    end

  always @(posedge clk) 
    if(reset) begin
	  s_b3<= 'b0;
	end
	else begin
      s_b3 <= s_b2;			 // purely behavioral description of function
    end
    
  always @(posedge clk) 
    if(reset) begin
	  s_b4<= 'b0;
	end
	else begin
      s_b4 <= s_b3;			 // purely behavioral description of function
    end
    
  always @(posedge clk) 
    if(reset) begin
	  s_b5<= 'b0;
	end
	else begin
      s_b5 <= s_b4;			 // purely behavioral description of function
    end
    
  always @(posedge clk) 
    if(reset) begin
	  s_b6<= 'b0;
	end
	else begin
      s_b6 <= s_b5;			 // purely behavioral description of function
    end
    
  always @(posedge clk) 
    if(reset) begin
	  s_b7<= 'b0;
	end
	else begin
      s_b7 <= s_b6;			 // purely behavioral description of function
    end

  assign dif1 = s - s_b7;
endmodule


