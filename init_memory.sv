module ksa_init (
    input  logic        clk,           // system clock
    input  logic        reset,         // synchronous reset (active high)
    input  logic        start,         // pulses high to begin initialization
    output logic [7:0]  s_address,     // address bus into s_memory
    output logic [7:0]  s_data,        // data bus into s_memory
    output logic        s_wren,        // write enable for s_memory
    output logic        INIT_FINISHED  // asserted when init (0–255) is done
);

    // FSM states
    typedef enum logic [1:0] {
        IDLE,
        WRITING,
        DONE
    } state_t;

    state_t       state, next_state;
    logic [7:0]   count;

    // State register + counter
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 8'd0;
        end else begin
            state <= next_state;
            // increment counter only while writing, up to 0xFF
            if (state == WRITING && count != 8'hFF)
                count <= count + 1;
        end
    end

    // Next-state logic and outputs
    always_comb begin
        // defaults
        next_state    = state;
        s_address     = count;
        s_data        = count;
        s_wren        = 1'b0;
        INIT_FINISHED = 1'b0;

        case (state)
            IDLE: begin
                // wait for start pulse
                if (start)
                    next_state = WRITING;
            end

            WRITING: begin
                // write count → memory[count]
                s_wren = 1'b1;
                if (count == 8'hFF)
                    next_state = DONE;
            end

            DONE: begin
                // de-assert write, signal completion
                s_wren        = 1'b0;
                INIT_FINISHED = 1'b1;
            end
        endcase
    end

endmodule