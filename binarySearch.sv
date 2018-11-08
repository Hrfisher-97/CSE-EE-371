`timescale 1ps/1ps
module binarySearch (L, found, done, index, clk, reset);
	input logic clk, reset;
	input logic [7:0] L;
	//input logic [DATA_WIDTH-1:0] A [0:2**ADDR_WIDTH-1];
	output logic [5:0] index;
	output logic found;
	
	output logic done;
	
	logic [5:0] length;
	logic [4:0] high;
	logic [4:0] low;
	
	assign length = high - low + 1'b1;
	
	logic [7:0] arrData;
	
	ram32x8 A (.address(index), .clock(clk), .data(L), .wren(1'b0), .q(arrData));
	
	logic [4:0] tempIndex;
	
	logic [4:0] counter;
	
	// need to fix timing issues, see waveform
	// likely source is q from ram instantiation taking an extra clock cycle to update its value
	always_ff @(posedge clk) begin
		if (reset) begin
			counter <= 5'b01010;
			high <= 5'b11111;
			low <= 0;
			done <= 0;
			index <= 6'd15; // assumes array size always 32
		end else if(~done) begin
			if (found | counter == 0)//length == 6'd1)
				done <= 1;
			else begin
				counter <= counter - 1'b1;
				if (L < arrData) begin
					high <= index;
				end else if (L > arrData) begin
					low <= index + 1;
				end
				index <= (low + high)>>1;
			end
		end
	end
	
	assign found = (L == arrData);
	
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
		while (! (found | done)) begin
			@(posedge clk);
		end
		reset <= 1; L <= 255; @(posedge clk); // exists in array
		reset <= 0; @(posedge clk);
		while (! (found | done)) begin
			@(posedge clk);
		end
		reset <= 1; L <= 60; @(posedge clk); // doesn't exist in array
		reset <= 0; @(posedge clk);
		while (! (found | done)) begin
			@(posedge clk);
		end
		$stop;
	end
	
endmodule 
