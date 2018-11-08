`timescale 1ps/1ps
module DE1_SoC(CLOCK_50, LEDR, SW, HEX0, KEY);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [6:0] HEX0;
	output logic [9:0] LEDR;
	
	
	logic reset, start;
	
	assign start = SW[9];
	
	D_FF key(.clk(CLOCK_50), .d(~KEY[0]), .q(reset));
	//assign reset = ~KEY[0];
	logic done, LoadA, Result_add, Result_0, A__0, ShiftA;
	logic [7:0] Input_A, A;
	logic [3:0] result;
	
	assign Input_A = SW[7:0];
	
	controller task1(.CLOCK_50, .reset, .done, .LoadA, .Result_0, .Result_add, .ShiftA, .A, .A__0, .start);
	
	datapath task11(.CLOCK_50, .reset, .A, .Result_add, .Result_0, .ShiftA, .LoadA, .A__0, .Input_A,  .result);
	
	seg_7 count(.bcd(result), .leds(HEX0));
	
	assign LEDR[9] = done;
	
endmodule

module controller(CLOCK_50, reset, done, LoadA, Result_0, Result_add, ShiftA, A, A__0, start);
	input logic CLOCK_50, reset, start;
	input logic A__0;
	input logic [7:0] A;
	output logic done, Result_0, Result_add, ShiftA, LoadA;


	logic [1:0] ps, ns;
	parameter [1:0] s1 = 2'b00, s2 = 2'b01, s3 = 2'b10;
	
	assign LoadA = (ps == s1 | reset == 1'b1);
	
	always_comb begin
		done = 1'b0;
		Result_0 = 1'b0;
		Result_add = 1'b0;
		ShiftA = 1'b0;
		case(ps)
			s1: begin
				Result_0 = 1'b1;
				if(!start) begin
					ns = s1;
				end
				else begin
					ns = s2;
				end
			end
			s2: begin
				ShiftA = 1'b1;
				if(A == 0) begin
					ns = s3;
				end
				else begin
					ns = s2;
					if(!A__0) begin
						Result_add = 1'b1;
					end
					else begin
						Result_add = 1'b0;
					end
				end
			end
			s3: begin
				done = 1'b1;
				if(start) begin
					ns = s3;
				end 
				else begin
					ns = s1;
				end
			end
			default: begin
				ns = 2'bxx;
			end
		endcase
	end
	
	always_ff @(posedge CLOCK_50) begin
		if(reset) begin	
			ps <= s1;
		end
		else begin
			ps <= ns;
		end
	end
	
endmodule


module datapath(CLOCK_50, reset, A, Result_add, Result_0, ShiftA, LoadA, A__0, Input_A,  result);
	input logic CLOCK_50, reset;
	input logic Result_add, Result_0, ShiftA, LoadA;
	input logic [7:0] Input_A;
	output logic [7:0] A;
	output logic [3:0] result;
	output logic A__0;
	
	always_ff @(posedge CLOCK_50) begin
		if(reset) begin
			result <= 4'b0;
		end
		else if(Result_0) begin
			result <= 4'b0;
		end
		else if(Result_add) begin
			result <= result + 4'b0001;
		end
	end
	
	shiftvalue shift(.CLOCK_50(CLOCK_50), .LoadA(LoadA), .ShiftA(ShiftA), .Input_A(Input_A), .A(A));
	assign A__0 = ~|A;
endmodule

module shiftvalue(CLOCK_50, LoadA, ShiftA, Input_A, A);
	input logic [7:0] Input_A;
	input logic CLOCK_50;
	input logic LoadA, ShiftA;
	output logic [7:0] A;
	
	
	always_ff @(posedge CLOCK_50) begin
		if(LoadA) begin
			A <= Input_A;
		end
		else if(ShiftA) begin
			A <= A >> 1;
		end
	end
endmodule

module DE1_SoC_testbench();
	logic clk;
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [6:0] HEX0;
	logic [9:0] LEDR;	
	
	DE1_SoC dut(.CLOCK_50(clk), .LEDR, .SW, .HEX0, .KEY);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	integer i;
	
	initial begin
		KEY[0] <= 0;							@(posedge clk);
		KEY[0] <= 1;		SW[9] <= 1; SW[7:0] <= 8'b00000001;		@(posedge clk);
		@(posedge clk);
		 
		for(i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		
		KEY[0] <= 0;							@(posedge clk);
		KEY[0] <= 1;		SW[9] <= 1; SW[7:0] <= 8'b00001111;		@(posedge clk);
		@(posedge clk);
		 
		for(i = 0; i < 100; i++) begin
			@(posedge clk);
		end
		KEY[0] <= 0;							@(posedge clk);
		KEY[0] <= 1;		SW[9] <= 1; SW[7:0] <= 8'b11111111;		@(posedge clk);
		@(posedge clk);
		 
		for(i = 0; i < 100; i++) begin
			@(posedge clk);
		end
				
				
		$stop;
	end
endmodule

