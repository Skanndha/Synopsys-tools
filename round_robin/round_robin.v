module round_robin(
    input clk,
    input rst_n,
    input [3:0] in,
    output reg [3:0] out
);

    reg [2:0] present_state;
    reg [2:0] next_state;

    parameter [2:0] S_ideal = 3'b000;
    parameter [2:0] S_0 = 3'b001;
    parameter [2:0] S_1 = 3'b010;
    parameter [2:0] S_2 = 3'b011;
    parameter [2:0] S_3 = 3'b100;

  
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= S_ideal;
        else
            present_state <= next_state;
    end

    
    always @(*) begin
        case (present_state)
            S_ideal: begin
                if (in[0])
                    next_state = S_0;
                else if (in[1])
                    next_state = S_1;
                else if (in[2])
                    next_state = S_2;
                else if (in[3])
                    next_state = S_3;
                else
                    next_state = S_ideal;
            end

            S_0: begin
                if (in[1])
                    next_state = S_1;
                else if (in[2])
                    next_state = S_2;
                else if (in[3])
                    next_state = S_3;
                else if (in[0])
                    next_state = S_0;
                else
                    next_state = S_ideal;
            end

            S_1: begin
                if (in[2])
                    next_state = S_2;
                else if (in[3])
                    next_state = S_3;
                else if (in[0])
                    next_state = S_0;
                else if (in[1])
                    next_state = S_1;
                else
                    next_state = S_ideal;
            end

            S_2: begin
                if (in[3])
                    next_state = S_3;
                else if (in[0])
                    next_state = S_0;
                else if (in[1])
                    next_state = S_1;
                else if (in[2])
                    next_state = S_2;
                else
                    next_state = S_ideal;
            end

            S_3: begin
                if (in[0])
                    next_state = S_0;
                else if (in[1])
                    next_state = S_1;
                else if (in[2])
                    next_state = S_2;
                else if (in[3])
                    next_state = S_3;
                else
                    next_state = S_ideal;
            end

            default: begin
                if (in[0])
                    next_state = S_0;
                else if (in[1])
                    next_state = S_1;
                else if (in[2])
                    next_state = S_2;
                else if (in[3])
                    next_state = S_3;
                else
                    next_state = S_ideal;
            end
        endcase
    end

    always @(*) begin
        case (present_state)
            S_0: out = 4'b0001;
            S_1: out = 4'b0010;
            S_2: out = 4'b0100;
            S_3: out = 4'b1000;
            default: out = 4'b0000;
        endcase
    end

endmodule
