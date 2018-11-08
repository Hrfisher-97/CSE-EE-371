module D_FF(clk, d, q);
	input logic clk, d;
	output logic q;
	
	logic temp;
	
	always_ff @(posedge clk) begin
		temp <= d;
		q <= temp;
	end
endmodule
