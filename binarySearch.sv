`timescale 1ps/1ps
module DE1_SoC (CLOCK_50, SW, KEY, LEDR, HEX0, HEX1);
	input logic CLOCK_50;
	input logic [9:0] SW;
	input logic [3:0] KEY;
	
	output logic [9:0] LEDR;
	output logic [6:0] HEX0, HEX1;
	
	logic [4:0] L;
	logic done; // not used by this module
	
	binarySearch(.A(SW[7:0]), .found(LEDR[9]), .done, .L, .clk(CLOCK_50), .start(SW[9]), .reset(~KEY[0]));
	
	// add the hex display thingies
endmodule

// add the start logic
module binarySearch (A, found, done, L, clk, start, reset);
	input logic clk, start, reset;
	input logic [7:0] A;
	output logic [4:0] L;
	output logic found, done;
	
	logic [7:0] arrData;
	logic [5:0] index;
	logic [4:0] tempL, high, low;
	logic update;
	
	ram32x8 A (.address(L[4:0]), .clock(clk), .data(A), .wren(1'b0), .q(arrData));

	assign found = (L == arrData);
	assign index = (low + high)>>1;
	assign L = index[4:0];
	
	always_ff @(posedge clk) begin
		tempL <= L;
		if (reset) begin
			high <= 5'b11111;
			low <= 0;
			done <= 0;
			update <= 1;
		end else if(start) begin
			if (tempL == L)
				update <= 0;
			else
				update <= 1;
			if(~done) begin
				if (found | (high==low))
					done <= 1;
				else if (update) begin
					if (L < arrData) begin
						high <= L - 1'b1;
					end else if (L > arrData) begin
						low <= L + 1'b1;
					end
				end
			end
		end
	end
	
endmodule 

module binarySearch_testbench();
	logic clk, reset, found, done;
	logic [5:0] L;
	logic [7:0] L;
	
	parameter CLOCK_PERIOD = 100;
	
	binarySearch dut (.L, .found, .done, .L, .clk, .reset);
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; L <= 0; @(posedge clk); // exists in array
		@(posedge clk);
		reset <= 0; @(posedge clk); 
		while (~done) begin
			@(posedge clk);
		end
		reset <= 1; L <= 255; @(posedge clk); // exists in array
		reset <= 0; @(posedge clk);
		while (~done) begin
			@(posedge clk);
		end
		reset <= 1; L <= 60; @(posedge clk); // doesn't exist in array
		@(posedge clk);
		reset <= 0; @(posedge clk);
		while (~done) begin
			@(posedge clk);
		end
		reset <= 1; L <= 120; @(posedge clk); // exists in a nontrivial L of array
		@(posedge clk);
		reset <= 0; @(posedge clk);
		while (~done) begin
			@(posedge clk);
		end
		$stop;
	end
	
endmodule 
