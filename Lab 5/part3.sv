module part3 #(parameter logN = 3) (clk, in, reset, read_ready, write_ready, out);
	input logic clk, reset, read_ready, write_ready;
	input logic [23:0] in;
	output logic [23:0] out;
	
	logic signed [23:0] signed_in, fractioned_in, fifo_out, negative_fifo_out, first_sum, next_sum, accumulator_q;
	 
	assign signed_in = in;
	
	// divide input by N
	always_comb begin
		if (signed_in[23])
			fractioned_in = signed_in >>> logN; // did not work for negative 8
		else
			fractioned_in = signed_in >> logN;
	end
	
	// reversed write and read signals because we are "reading" from the microphone and "writing" to the speaker
	fifo #(logN) fifoBuff (.clk, .reset, .in(fractioned_in), .read_ready(write_ready), .write_ready(read_ready), .out(fifo_out));

	assign negative_fifo_out = ~(fifo_out) + 1'b1; // check this works
	
	assign first_sum = negative_fifo_out + fractioned_in;
	assign next_sum = first_sum + accumulator_q;
	
	always_ff @(posedge clk) begin
		if (reset)
			accumulator_q <= 0;
		else
			accumulator_q <= next_sum;
	end
	
	assign out = next_sum;
endmodule

module part3_testbench();
	logic clk, reset, read_ready, write_ready;
	logic [23:0] in, out;
	
	part3 dut (.in, .clk, .reset, .read_ready, .write_ready, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; in <= 24'd32; read_ready <= 1; write_ready <= 0; @(posedge clk);
		reset <= 0; in <= 24'd16; @(posedge clk);
		in <= 24'd0; @(posedge clk);
		in <= 24'b111111111111111111111000; @(posedge clk); // -16?
		in <= 24'b111111111111111111110000; @(posedge clk); // -32?
		in <= 24'd8; @(posedge clk);
		write_ready <= 1; @(posedge clk);
		for (int i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule

module fifo #(parameter ADDR_WIDTH=3) (clk, reset, in, read_ready, write_ready, out);
	input logic [23:0] in;
	input logic read_ready, write_ready, clk, reset;
	output logic [23:0] out;
	
	logic [23:0] fifo [0:2**ADDR_WIDTH-1];
	
	logic [ADDR_WIDTH-1:0] w_addr, r_addr, w_addr_next, r_addr_next;
	
	logic empty, full, full_next, empty_next;
	
	logic wr_en, rd_en;
	
	//probably backwards
	assign wr_en = write_ready & ~full;
	assign rd_en = read_ready & ~empty;
	
	always_comb begin
		if (w_addr == 2*ADDR_WIDTH-1)
			w_addr_next = 0;
		else
			w_addr_next = w_addr + 1;
		if (r_addr == 2**ADDR_WIDTH-1)
			r_addr_next = 0;
		else
			r_addr_next = r_addr + 1;
		if (full)
			full_next = ~rd_en;
		else
			full_next = wr_en & (w_addr_next == r_addr);
		if (empty)
			empty_next = ~wr_en;
		else
			empty_next = rd_en & (r_addr_next == w_addr);
	end

	always_ff @(posedge clk) begin
		if(reset) begin
			w_addr <= 0;
			r_addr <= 0;
			empty <= 1;
			full <= 0;
		end else begin
			empty <= empty_next;
			full <= full_next;
			if (wr_en) begin
				fifo[w_addr] <= in;
				w_addr <= w_addr_next;
			end
			if (rd_en) begin
				out <= fifo[r_addr];
				r_addr <= r_addr_next;
			end
		end 
	end
endmodule

module fifo_testbench();
	logic clk, reset, read_ready, write_ready;
	logic [23:0] in, out;
	
	fifo dut (.in, .clk, .reset, .write_ready, .read_ready, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	initial begin
		reset <= 1; in <= 24'd1; write_ready<=1; read_ready <= 0; @(posedge clk);
		reset <= 0;
		for (int i = 0; i < 10; i++) begin
			in <= in + 1; @(posedge clk);
		end
		read_ready <= 1; @(posedge clk);
		for (int i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		$stop;
	end
endmodule
