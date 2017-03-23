// 8路输入译码为 3位 二进制数字 外加flag 输出
module codeshow(in0,in1,in2,in3,in4,in5,in6,in7,out,flag);
    input in0,in1,in2,in3,in4,in5,in6,in7;
    output reg[2:0] out;
    output reg flag;

    always@(in0,in1,in2,in3,in4,in5,in6,in7)
    begin
        flag = 1'b1;
        out = 3'b000;
        
        if(in7) out=3'b111;
        else if(in6) out=3'b110;
        else if(in5) out=3'b101;
        else if(in4) out=3'b100;
        else if(in3) out=3'b011;
        else if(in2) out=3'b010;
        else if(in1) out=3'b001;
        else if(in0) out=3'b000;
        else flag = 1'b0;
    end
endmodule
