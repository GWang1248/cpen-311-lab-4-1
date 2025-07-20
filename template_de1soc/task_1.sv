module task_1 (
    input logic clk,                   // System Clock CLK_50
    input logic rst,                   // System Reset KEY(3)
    input logic start,                 // System Start KEY(0) High Means Activated
    output logic [7:0]  s_address,     // address bus into s_memory
    output logic [7:0]  s_data,        // data bus into s_memory
    output logic        s_wren,        // write enable for s_memory
    output logic        done           // asserted when init (0–255) is done
)

    //FSM States Define: IDLE, WRITE, DONE
    typedef enum logic [1:0] { 
        IDLE,
        WRITE,
        DONE
     } state_machine;

     state_machine  state, next_state;
     logic [7:0]    count;            // 8-bit Counter, contorl both address and value

    //Set Reset condition, e.g. Reset State
    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            count <= 8'b0;
        end
        else begin
            state <= next_state;
            if (state == WRITE && count != 8'hFF)
                count <= count + 1;
        end
    end
endmodule