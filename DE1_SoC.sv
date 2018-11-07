`timescale 1ps/1ps
module DE1_SoC(CLOCK_50, LEDR, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	
	
	logic reset, start;
	
	assign start = SW[9];
	assign reset = ~KEY[0];
	logic done, LoadA, Result_add, Result_0, A__0, ShiftA, s;
	logic [7:0] in, A;
	logic [3:0] result;
	
	controller task1(.CLOCK_50, .reset, .in, .done, .LoadA, .Result_0, .Result_add, .ShiftA, .A, .A__0, .s);
	
	datapath task11(.CLOCK_50, .reset, .A, .Result_add, .Result_0, .ShiftA, .LoadA, .A__0, .in,  .result);
	
endmodule

module controller(CLOCK_50, reset, in, done, LoadA, Result_0, Result_add, ShiftA, A, A__0, s);
	input logic CLOCK_50, reset, s;
	input logic LoadA, A__0;
	input logic [7:0] A, in;
	output logic done, Result_0, Result_add, ShiftA;


	logic [1:0] ps, ns;
	parameter [1:0] s1 = 2'b00, s2 = 2'b01, s3 = 2'b10;
	
	always_comb begin
		done = 1'b0;
		Result_0 = 1'b0;
		Result_add = 1'b0;
		ShiftA = 1'b0;
		case(ps)
			s1: begin
				Result_0 = 1'b1;
				if(!s) begin
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
				if(s) begin
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


module datapath(CLOCK_50, reset, A, Result_add, Result_0, ShiftA, LoadA, A__0, in,  result);
	input logic CLOCK_50, reset;
	input logic Result_add, Result_0, ShiftA, LoadA, A__0;
	input logic [7:0] in, A;
	output logic [3:0] result;
	
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
		
	shiftvalue(.CLOCK_50(CLOCK_50), .reset(reset), .LoadA(LoadA), .ShiftA(ShiftA), .in(in), .A(A));
	assign A__0 = ~|A;
	end
endmodule

module shiftvalue(CLOCK_50, reset, LoadA, ShiftA, in, A);
	input logic CLOCK_50, reset;
	input logic ShiftA;
	input logic [7:0] in;
	output logic [7:0] A;
	
	always_ff @(posedge clk) begin
		if(reset) begin
			A <= 8'b0;
		end 
		else if(ShiftA) begin
			A <= in << 1;
		end
	end
endmodule
