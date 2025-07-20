module ksa_init(input logic start, clk, reset_n,
							input logic [7:0] q,
							output logic [7:0] data, address,
							output logic finish, wren); //task 1
	
	//state = {wren, finish}
	parameter idle = 2'b00;
	parameter writing = 2'b10;
	parameter done = 2'b01;
	
	logic [1:0] state /*synthesis keep*/;

	assign finish = state[0];
	assign wren = state[1];
	
	always_ff @(posedge clk, negedge reset_n)
		if(!reset_n) state <= idle;
		else
			case(state)
				idle: 	if (start) begin
								state <= writing;
								data <= 0;
								address <= 0;
							end
							else begin	
									state <= idle;
									data <= 0;
									address <= 0;
							end
				writing: if (address >= 8'd255) begin	
								state <= done;
								data <= 0;
								address <= 0;
							end
							else begin
								state <= writing;
								data <= address + 1'b1;
								address <= address + 1'b1;
							end
				done: 	begin
								state <= idle;
								data <= 0;
								address <= 0;
							end
				default: begin 
								state <= idle;
								data <= 0;
								address <= 0;
							end
			endcase
endmodule