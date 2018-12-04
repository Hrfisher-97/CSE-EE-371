module part1 (CLOCK_50, CLOCK2_50, SW, KEY, GPIO_0, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, PS2_CLK, PS2_DAT,
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT);

	input CLOCK_50, CLOCK2_50;
	input [3:0] KEY;
	input [9:0] SW;
	// I2C Audio/Video config interface
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	inout PS2_CLK, PS2_DAT;
	// Audio CODEC
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	output AUD_DACDAT;
	output [35:0] GPIO;
	
	// Local wires.
	wire read_ready, write_ready, read, write, writeMem, readMem;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right, writedata_left_temp, writedata_right_temp;
	wire reset = ~KEY[0];
	wire reverse = SW[0];
	
	assign GPIO_0[0] = read;
	assign GPIO_0[1] = write;

	/////////////////////////////////
	// Your code goes here 
	/////////////////////////////////
	
	//assign writedata_left = readdata_left;
	//assign writedata_right = readdata_right;
	assign read = read_ready;
	assign write = write_ready;
	
	//avgfilter avgL (.clk(CLOCK_50), .in(readdata_left), .read_ready(read_ready), .write_ready(write_ready), .out(writedata_left_temp));
	//avgfilter avgR (.clk(CLOCK_50), .in(readdata_right), .read_ready(read_ready), .write_ready(write_ready), .out(writedata_right_temp));
	
//	parameter UPPER_BITS = 1; // get from VGA monitor
//	wire mouse_start;
//	reg button_left, button_right, button_middle;
//	reg [UPPER_BITS-1:0] x, y;
//	
//	ps2 mouse (.reset(reset), .start(mouse_start), .CLOCK_50(CLOCK_50), .PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), .button_left(button_left), .button_right(button_right), .button_middle(button_middle), .bin_x(x), .bin_y(y));
	
	part3 p3L (.clk(CLOCK_50), .reset(reset), .in(readdata_left), .read_ready(read), .write_ready(write), .out(writedata_left_temp));
	part3 p3R (.clk(CLOCK_50), .reset(reset), .in(readdata_right), .read_ready(read), .write_ready(write), .out(writedata_right_temp));
	
	trackMemSignals tracker (.signalIn(~KEY[3]), .clk(CLOCK_50), .reset(SW[9]), .write(writeMem), .read(readMem));
	
	audioLooper loopLeft (.in(writedata_left_temp), .clk(CLOCK_50), .reset(SW[9]), .write(writeMem), .read(readMem), .reverse(reverse), .out(writedata_left));
	audioLooper loopRight (.in(writedata_right_temp), .clk(CLOCK_50), .reset(SW[9]), .write(writeMem), .read(readMem), .reverse(reverse), .out(writedata_right));
	
/////////////////////////////////////////////////////////////////////////////////
// Audio CODEC interface. 
//
// The interface consists of the following wires:
// read_ready, write_ready - CODEC ready for read/write operation 
// readdata_left, readdata_right - left and right channel data from the CODEC
// read - send data from the CODEC (both channels)
// writedata_left, writedata_right - left and right channel data to the CODEC
// write - send data to the CODEC (both channels)
// AUD_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio CODEC
// I2C_* - should connect to top-level entity I/O of the same name.
//         These signals go directly to the Audio/Video Config module
/////////////////////////////////////////////////////////////////////////////////
	clock_generator my_clock_gen(
		// inputs
		CLOCK2_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule





