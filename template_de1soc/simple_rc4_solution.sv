module ksa_solution(input logic CLOCK_50,
			input logic [3:0] KEY,
			input logic [3:0] SW,
			output logic [9:0] LEDR,
			output logic [6:0] HEX0,
			output logic [6:0] HEX1,
			output logic [6:0] HEX2,
			output logic [6:0] HEX3,
			output logic [6:0] HEX4,
			output logic [6:0] HEX5
			);	//Top-level Module

	//Task 1 variable declaration
	logic reset;
	logic start;
	logic [7:0] s_address_1;
	logic [7:0] s_data_1;
	logic s_wren_1;
	logic task_1_done;

	assign reset = KEY[3];
	assign start = KEY[0];

	task_1 inst_task_1 (
		.clk(CLOCK_50),
		.reset(reset),
		.start(start),
		.s_address(s_address_1),
		.s_data(s_data_1),
		.s_wren(s_wren_1),
		.done(task_1_done)
	); //Instantiate Task 1 Module
	
	logic [23:0] secret_key;

// 7-Segment Display
	logic [7:0] Seven_Seg_Val[5:0];
	logic [3:0] Seven_Seg_Data[5:0];       
	logic [23:0] actual_7seg_output;
	reg [23:0] regd_actual_7seg_output;   

	assign actual_7seg_output =  secret_key;

	always @(posedge CLOCK_50)
	begin
	    regd_actual_7seg_output <= actual_7seg_output;
	end

	assign Seven_Seg_Data[0] = regd_actual_7seg_output[3:0];
	assign Seven_Seg_Data[1] = regd_actual_7seg_output[7:4];
	assign Seven_Seg_Data[2] = regd_actual_7seg_output[11:8];
	assign Seven_Seg_Data[3] = regd_actual_7seg_output[15:12];
	assign Seven_Seg_Data[4] = regd_actual_7seg_output[19:16];
	assign Seven_Seg_Data[5] = regd_actual_7seg_output[23:20];
	
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst0(.ssOut(Seven_Seg_Val[0]), .nIn(Seven_Seg_Data[0]));
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst1(.ssOut(Seven_Seg_Val[1]), .nIn(Seven_Seg_Data[1]));
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst2(.ssOut(Seven_Seg_Val[2]), .nIn(Seven_Seg_Data[2]));
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst3(.ssOut(Seven_Seg_Val[3]), .nIn(Seven_Seg_Data[3]));
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst4(.ssOut(Seven_Seg_Val[4]), .nIn(Seven_Seg_Data[4]));
	SevenSegmentDisplayDecoder SevenSegmentDisplayDecoder_inst5(.ssOut(Seven_Seg_Val[5]), .nIn(Seven_Seg_Data[5]));
	
	assign HEX0 = Seven_Seg_Val[0];
	assign HEX1 = Seven_Seg_Val[1];
	assign HEX2 = Seven_Seg_Val[2];
	assign HEX3 = Seven_Seg_Val[3];
	assign HEX4 = Seven_Seg_Val[4];
	assign HEX5 = Seven_Seg_Val[5];
endmodule