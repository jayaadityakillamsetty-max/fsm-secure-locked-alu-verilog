`timescale 1ns/1ps
module secure_alu_tb;
reg clk;
reg reset;
reg [1:0] key;
reg [7:0] A;
reg [7:0] B;
reg [1:0] op;
wire [7:0] result;
secure_alu uut(
    .clk(clk),
    .reset(reset),
    .key(key),
    .A(A),
    .B(B),
    .op(op),
    .result(result)
);
always #5 clk = ~clk;
initial
begin
clk = 0;
reset = 1;
key = 2'b00;
A = 8'd10;
B = 8'd4;
#10 reset = 0;
// case 1 wrong attempts
#10 key = 2'b10;
#10 key = 2'b11;
#10 key = 2'b10;
// case 2 correct sequence 
#10 key = 2'b01;
#10 key = 2'b10;
#10 key = 2'b11;
#10 op = 2'b00;
#50 $finish;
end
endmodule
