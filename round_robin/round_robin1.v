module round_robin(
    input clk,
    input rst_n,
    input [3:0] in,
    output reg [3:0] out
);

    reg [2:0] present_state;
    reg [2:0] next_state;

    parameter [2:0] S_ideal = 3'b000;
    parameter [2:0] S_0     = 3'b001;
    parameter [2:0] S_1     = 3'b010;
    parameter [2:0] S_2     = 3'b011;
    parameter [2:0] S_3     = 3'b100;

    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            present_state <= S_ideal;
        else
            present_state <= next_state;
    end

    
    always @(*) begin
        if (present_state == S_ideal) begin
           
            casez (in)
                4'b1???: next_state = S_0;
                4'b01??: next_state = S_1;
                4'b001?: next_state = S_2;
                4'b0001: next_state = S_3;
                default: next_state = S_ideal;
            endcase
        end else begin
           
            case (present_state)
                S_0: next_state = (in[1] ? S_1 : (in[2] ? S_2 : (in[3] ? S_3 : (in[0] ? S_0 : S_ideal))));
                S_1: next_state = (in[2] ? S_2 : (in[3] ? S_3 : (in[0] ? S_0 : (in[1] ? S_1 : S_ideal))));
                S_2: next_state = (in[3] ? S_3 : (in[0] ? S_0 : (in[1] ? S_1 : (in[2] ? S_2 : S_ideal))));
                S_3: next_state = (in[0] ? S_0 : (in[1] ? S_1 : (in[2] ? S_2 : (in[3] ? S_3 : S_ideal))));
                default: next_state = S_ideal;
            endcase
        end
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
