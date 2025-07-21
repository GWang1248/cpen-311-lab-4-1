module task_1 (
    input logic clk,				//System Clock
	input logic reset,				//Reset Input (KEY[3])
	input logic start,				//Start Input (KEY[0])
	output logic [7:0] s_address,	//Address of bus to store into s_memory
	output logic [7:0] s_data,		//Data of bus to store into s_memory
	output logic s_wren,			//Indication signal of whether s allowed to be written or no
	output logic done,				//Indication that task 1 is done
);
endmodule