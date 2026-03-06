module secure_alu(input clk, input reset, input [1:0] key, input [7:0] A, input [7:0] B, input [1:0] op, output reg [7:0] result);
reg unlocked;
reg permanently_locked;
reg [1:0] state;
reg [1:0] wrong_attempts;
parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;
always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        unlocked <= 0;
        wrong_attempts <= 0;
        permanently_locked <= 0;
    end
    else if(!permanently_locked)
    begin
      case(state)
        S0:
        begin
            if(key == 2'b01)
                state <= S1;
            else if(key != 2'b00)
            begin
                wrong_attempts <= wrong_attempts + 1;
                state <= S0;
            end
        end
        S1:
        begin
            if(key == 2'b10)
                state <= S2;
            else
            begin
                wrong_attempts <= wrong_attempts + 1;
                state <= S0;
            end
        end
        S2:
        begin
            if(key == 2'b11)
            begin
                state <= S3;
                unlocked <= 1;
            end
            else
            begin
                wrong_attempts <= wrong_attempts + 1;
                state <= S0;
            end
        end
        S3:
            unlocked <= 1;
      endcase
        if(wrong_attempts == 3)
            permanently_locked <= 1;
    end
end
always @(*)
begin
    if(unlocked && !permanently_locked)
    begin
        case(op)
        2'b00: result = A + B;
        2'b01: result = A - B;
        2'b10: result = A & B;
        2'b11: result = A | B;
        endcase
    end
    else
        result = 8'b00000000;
end

endmodule
