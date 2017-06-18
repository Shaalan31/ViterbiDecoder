module VertibiTB();
reg [1:0]Signal;
reg clk;
wire [7:0]DataOut;

VertibiDecoder TestBenchProj(Signal,clk,DataOut);

initial begin 
	
	#100    //First input
	clk=0; Signal=2; 
	#100
	clk=1;
	#100
	clk=0; Signal=0; 
	#100
	clk=1;
	#100
	clk=0; Signal=3; 
	#100
	clk=1;
	#100
	clk=0; Signal=0; 
	#100
	clk=1;
	#100
	clk=0; Signal=2; 
	#100
	clk=1;
	#100
	clk=0; Signal=2; 
	#100
	clk=1;
	
	#100
	clk=0; Signal=1; 
	#100
	clk=1;
	#100
	clk=0; Signal=3; 
	#100
	clk=1;
	
	#100
	clk=0; //Signal=3; 
	#100
	clk=1;
	
	
	#100
	clk=0;
	#100
	clk=1;
	
	// #100    //First input
	// clk=0; Signal=0; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=1; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=3; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=0; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=1; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=1; 
	// #100
	// clk=1;
	// #100
	// clk=0; Signal=3; 
	// #100
	// clk=1;
	
	// #100
	// clk=0; //Signal=0; 
	// #100
	// clk=1;
	// #100
	// clk=0;
	// #100
	// clk=1;
	// #100
	// clk=0;
end
 

endmodule