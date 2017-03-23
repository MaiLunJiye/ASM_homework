//8 路输入分离 10 进制
module eight_two_show( in1, in2, in3, in4, in5, in6, in7, in8,
                        out1,out2, out3);
input reg in1, in2, in3, in4, in5, in6, in7, in8;
output reg [3:0] out1,out2,out3;

always @ (in1, in2, in3, in4, in5, in6, in7, in8)
begin
    reg [7:0] inputsum = {in1, in2, in3, in4, in5, in6, in7, in8};
    out1 = inputsum % 10;
    inputsum = inputsum / 10;
    out2 = inputsum % 10;
    inputsum = inputsum / 10;
    out3 = inputsum % 10;
    inputsum = inputsum / 10;
end
endmodule
