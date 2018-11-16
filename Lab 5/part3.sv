module part3 #(parameter logN = 8) (clk, in, reset, read_ready, write_ready, out);
	input logic clk, reset, read_ready, write_ready;
	input logic [23:0] in;
	output logic [23:0] out;
	
	logic signed [23:0] signed_in, fractioned_in, fifo_out, negative_fifo_out, first_sum, next_sum, accumulator_q;
	 
	assign signed_in = in;
	
	// divide input by N
	always_comb begin
		if (signed_in[23])
			fractioned_in = signed_in >>> logN;
		else
			fractioned_in = signed_in >> logN;
	end
	
	logic empty, full;
	
	// reversed write and read signals because we are "reading" from the microphone and "writing" to the speaker
	//fifo #(logN) fifoBuff (.clk, .reset, .in(fractioned_in), .read_ready(write_ready), .write_ready(read_ready), .out(fifo_out), .empty, .full);

	// class example
	fifo_buffer #(.ADDR_WIDTH(logN)) fifoBuff (.clk, .reset, .rd(write_ready), .wr(read_ready), .empty, .full, .w_data(fractioned_in), .r_data(fifo_out));
	
	assign negative_fifo_out = ~(fifo_out) + 1'b1;
	
	assign next_sum = first_sum + accumulator_q;

	logic write_ready_next, empty_next; // takes 1 clock cycle to read from buffer after signal goes true
	
	//assign first_sum = fractioned_in + negative_fifo_out;
	
	always_comb begin
		if (write_ready_next & ~empty_next)
			first_sum = fractioned_in + negative_fifo_out;
		else
			first_sum = fractioned_in; // no output from FIFO, so just in/N signal
	end
	
	always_ff @(posedge clk) begin
		write_ready_next <= write_ready;
		empty_next <= empty;
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
	
	part3 #(3) dut (.in, .clk, .reset, .read_ready, .write_ready, .out);
	
	parameter CLOCK_PERIOD = 100;
	
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end
	
	/* Things we know work:
		starting with write_ready 1 and read_ready 0
		starting with write_ready 0 and read_ready 1
	*/
	
	initial begin
		reset <= 1; in <= 24'd64; write_ready <= 0; read_ready <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		@(posedge clk);
		//reset <= 1; in <= 24'd32; read_ready <= 1; write_ready <= 0; @(posedge clk);
		//reset <= 0; in <= 24'd16; @(posedge clk);
		in <= 24'd0; @(posedge clk);
		in <= 24'b111111111111111111111000; @(posedge clk); // -16?
		in <= 24'b111111111111111111110000; @(posedge clk); // -32?
		in <= 24'd8; @(posedge clk);
		write_ready <= 1; @(posedge clk);
		for (int i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		read_ready <= 0; @(posedge clk);
		for (int i = 0; i < 10; i++) begin
			@(posedge clk);
		end
		reset <= 1; write_ready <= 0; read_ready <= 0; @(posedge clk);
		reset <= 0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		reset <= 1; write_ready <= 1; read_ready <= 1; @(posedge clk);
		reset <= 0; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule

// class example, checking against my implementation
module fifo_cntrl #(parameter ADDR_WIDTH=3)
	(input logic clk, reset,
	input logic rd, wr,
	output logic empty, full,
	output logic [ADDR_WIDTH-1:0] w_addr, r_addr);

	logic [ADDR_WIDTH-1:0] w_ptr_logic, w_ptr_next, w_ptr_succ;
	logic [ADDR_WIDTH-1:0] r_ptr_logic, r_ptr_next, r_ptr_succ;
	logic full_logic, empty_logic, full_next, empty_next;
	
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			w_ptr_logic <= 0;
			r_ptr_logic <= 0;
			full_logic <= 1'b0;
			empty_logic <= 1'b1;
		end else begin
			w_ptr_logic <= w_ptr_next;
			r_ptr_logic <= r_ptr_next;
			full_logic <= full_next;
			empty_logic <= empty_next;
		end
	end
	
	always_comb begin
		w_ptr_succ = w_ptr_logic + 1;
		r_ptr_succ = r_ptr_logic + 1;
		w_ptr_next = w_ptr_logic;
		r_ptr_next = r_ptr_logic;
		full_next = full_logic;
		empty_next = empty_logic;
		unique case ({wr, rd})
			2'b01: // read
				if (~empty_logic) begin
					r_ptr_next = r_ptr_succ;
					full_next = 1'b0;
					if (r_ptr_succ == w_ptr_logic)
						empty_next = 1'b1;
				end
			2'b10: // write
				if (~full_logic) begin
					w_ptr_next = w_ptr_succ;
					empty_next = 1'b0;
					if (w_ptr_succ==r_ptr_logic)
						full_next = 1'b1;
				end
			2'b11: // read and write
				begin
					w_ptr_next = w_ptr_succ;
					r_ptr_next = r_ptr_succ;
				end
			default: ; // 2'b00
		endcase
	end
	
	assign w_addr = w_ptr_logic;
	assign r_addr = r_ptr_logic;
	assign full = full_logic;
	assign empty = empty_logic;	
endmodule 

// class example, checking against my implementation
module fifo_buffer #(parameter DATA_WIDTH=24, ADDR_WIDTH=3)
	(input logic clk, reset,
	input logic rd, wr,
	input logic [DATA_WIDTH-1:0] w_data,
	output logic empty, full,
	output logic [DATA_WIDTH-1:0] r_data);
	
	logic [ADDR_WIDTH-1:0] w_addr, r_addr;
	logic wr_en, full_tmp;
	
	assign wr_en = wr & ~full_tmp;
	assign full = full_tmp;
	
	fifo_cntrl #(.ADDR_WIDTH(ADDR_WIDTH)) c_unit (.*, .full(full_tmp));
	
	logic [DATA_WIDTH-1:0] fifo_reg [0:2**ADDR_WIDTH-1];
	
	always_ff @(posedge clk) begin
		if (wr_en)
			fifo_reg[w_addr] <= w_data;
	end
	
	assign r_data = fifo_reg[r_addr];
endmodule 

module fifo #(parameter ADDR_WIDTH=3) (clk, reset, in, read_ready, write_ready, out, empty, full);
	input logic [23:0] in;
	input logic read_ready, write_ready, clk, reset;
	output logic [23:0] out;
	output logic empty, full;
	
	logic [23:0] fifo [0:2**ADDR_WIDTH-1];
	
	logic [ADDR_WIDTH-1:0] w_addr, r_addr, w_addr_next, r_addr_next;
	
	logic full_next, empty_next;
	
	logic wr_en, rd_en;
	
	//probably backwards
	assign wr_en = write_ready & ~full;
	assign rd_en = read_ready & ~empty;
	
	always_comb begin
		if (w_addr == 2**ADDR_WIDTH-1)
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
	logic clk, reset, read_ready, write_ready, empty, empty1, full, full1;
	logic [23:0] in, out, out1;
	
	fifo dut (.in, .clk, .reset, .write_ready, .read_ready, .out, .empty, .full);
	fifo_buffer class_dut (.clk, .reset, .rd(read_ready), .wr(write_ready), .w_data(in), .r_data(out1), .empty(empty1), .full(full1));
	
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
