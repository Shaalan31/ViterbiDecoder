module VertibiDecoder#(parameter Z =8)(input [1:0]Signal, input clk , output  [Z-1:0]GoOut);
localparam N = Z+1;
reg [N-1:0]Error [7:0][N-1:0];
reg [3:0]State [7:0][1:0];
reg [1:0]BinaryOut [7:0][1:0];
reg [3:0]History [7:0][N-1:0];
reg [N-1:0]k;
reg [N-1:0]w;
reg [N-1:0]t;


reg [2:0] StateMinError;
reg [3:0] FirstError;
reg [3:0] i;
reg [2:0] StateBacktracking[N-1:0];
reg [2:0] StateBT;
reg [N-1:0] j;
reg [N-1:0] s;
reg [N-1:0]DecodedSymbol;

reg [1:0]temp1;
reg [1:0]temp2;

initial 
	begin
		//Initialzing the State table
		State[0][0]=0;
		State[0][1]=4;
		State[1][0]=0;
		State[1][1]=4;
		
		State[2][0]=1;
		State[2][1]=5;
		State[3][0]=1;
		State[3][1]=5;
		
		State[4][0]=2;
		State[4][1]=6;
		State[5][0]=2;
		State[5][1]=6;
		
		State[6][0]=3;
		State[6][1]=7;
		State[7][0]=3;
		State[7][1]=7;
		
		
		//Initialzing the BinaryOut table
		BinaryOut[0][0]=0;
		BinaryOut[0][1]=3;
		BinaryOut[1][0]=3;
		BinaryOut[1][1]=0;
		
		BinaryOut[2][0]=2;
		BinaryOut[2][1]=1;
		BinaryOut[3][0]=1;
		BinaryOut[3][1]=2;
		
		BinaryOut[4][0]=3;
		BinaryOut[4][1]=0;
		BinaryOut[5][0]=0;
		BinaryOut[5][1]=3;
		
		BinaryOut[6][0]=1;
		BinaryOut[6][1]=2;
		BinaryOut[7][0]=2;
		BinaryOut[7][1]=1;
		
		StateMinError=0;
		StateBT=0;
		StateBacktracking[0]=0;
		StateBacktracking[1]=0;
		StateBacktracking[2]=0;
		StateBacktracking[3]=0;
		StateBacktracking[4]=0;
		StateBacktracking[5]=0;
		StateBacktracking[6]=0;
		StateBacktracking[7]=0;
		

		t = 0;
		// genvar i;
		// genvar j;
		// generate 
			for(k=0;k<8;k=k+1)
				begin
				for(w=0;w<=N;w=w+1)
					begin
					History[k][w]=8;	
					Error[k][w]=2*N;
					end
				end
		//endgenerate
		
		History[0][0]=0;
		Error[0][0]=0;
		
		//DecodedSymbol=0;
	end
	always@(posedge clk)begin
		for(k=0;k<=8;k=k+1)
			//Start with the zero
		begin
			temp1 = BinaryOut[k][0];
			temp2 = BinaryOut[k][1];
				if(History[k][t]!=8   && ((Error[k][t] +( temp1[0] ^ Signal[0]) + (temp1[1] ^ Signal[1])) < Error[State[k][0]][t+1]))
				begin
					
					History[State[k][0]][t+1] = k;
					Error[State[k][0]][t+1] = Error[k][t] +( temp1[0] ^ Signal[0]) + (temp1[1] ^ Signal[1]);
				end
			//Ending with the one
				if(History[k][t]!=8 && ((Error[k][t] + (temp2[0] ^ Signal[0]) +  (temp2[1] ^ Signal[1])) < Error[State[k][1]][t+1]))
				begin
					History[State[k][1]][t+1] = k;
					Error[State[k][1]][t+1] = Error[k][t] + (temp2[0] ^ Signal[0]) + (temp2[1] ^ Signal[1]);
				end
		end
		
		
		
		
		if(t==(N-1))begin
			//7etet khairy w mayy
			FirstError=Error[0][N-1];
					//1st Loop To Find State With Min Error
					for (i=1;i<8;i=i+1) begin
						if(Error[i][N-1]<FirstError)
						begin
							FirstError=Error[i][N-1];
							StateMinError=i;
						end
					end

					//Needed Initializations
					StateBT=StateMinError;
					StateBacktracking[N-1]=StateMinError;

					//2nd Loop For BackTracking
					for (j=N-2;j>0;j=j-1)begin
						StateBacktracking[j]=History[StateBT][j+1];
						StateBT=StateBacktracking[j];
					end
					StateBacktracking[0]=History[StateBT][1];
						//StateBT=StateBacktracking[j];

					for (s=0;s<N;s=s+1)begin
						if (StateBacktracking[s]<4)begin
							DecodedSymbol[s]=0;
						end
						else begin
							DecodedSymbol[s]=1;
						end
					end
			t=-1;
			for(k=0;k<8;k=k+1)
				begin
				for(w=0;w<=N;w=w+1)
					begin
					History[k][w]=8;	
					Error[k][w]=2*N;
					end
				end
			History[0][0]=0;
			Error[0][0]=0;
			StateMinError=0;
			StateBT=0;
			StateBacktracking[0]=0;
			StateBacktracking[1]=0;
			StateBacktracking[2]=0;
			StateBacktracking[3]=0;
			StateBacktracking[4]=0;
			StateBacktracking[5]=0;
			StateBacktracking[6]=0;
			StateBacktracking[7]=0;
			//FirstError=Error[0][N-1];
			end
		t=t+1;
		end

	

assign GoOut=DecodedSymbol[Z:1];
	
	

endmodule




