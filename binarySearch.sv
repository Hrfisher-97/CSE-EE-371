`timescale 1ps/1ps
module binarySearch (L, found, done, index, clk, reset);
	input logic clk, reset;
	input logic [7:0] L;
	output logic [5:0] index;
	output logic found;
	
	output logic done;
	
	logic [7:0] tempArrData, arrData;
	logic [5:0] tempIndex;
	logic [4:0] high, low, counter;
	logic lessThan, greaterThan, memReady, update;
	
	assign length = high - low + 1'b1;
	
	ram32x8 A (.address(index[4:0]), .clock(clk), .data(L), .wren(1'b0), .q(arrData));

	assign found = (L == arrData);
	assign index = (low + high)>>1;
	
	always_ff @(posedge clk) begin
		tempIndex <= index;
		if (reset) begin
			high <= 5'b11111;
			low <= 0;
			done <= 0;
			update <= 1;
		end else begin
			if (tempIndex == index)
				update <= 0;
			else
				update <= 1;
			if(~done) begin
				if (found | (high==low))
					done <= 1;
				else if (update) begin
					if (L < arrData) begin
						high <= index - 1'b1;
					end else if (L > arrData) begin
						low <= index + 1'b1;
					end
				end
			end
		end
	end
	
endmodule 

module binarySearch_testbench();
	logic clk, reset, found, done;
	logic [5:0] index;
	logic [7:0] L;
	
	parameter CLOCK_PERIOD = 100;
	
	binarySearch dut (.L, .found, .done, .index, .clk, .reset);
	
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
		reset <= 1; L <= 120; @(posedge clk); // exists in a nontrivial index of array
		@(posedge clk);
		reset <= 0; @(posedge clk);
		while (~done) begin
			@(posedge clk);
		end
		$stop;
	end
	
endmodule  
