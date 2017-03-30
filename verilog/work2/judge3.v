//三位投票器模块
module judge3(in1,in2,in3,out);
    input in1,in2,in3;
    output out;
    reg out;
    reg[2:0] temp;
    always@(in1,in2,in3)
    begin
        temp = in1 + in2 + in3;
        if(temp > 2'b01) out=1;
        else out=0;
    end
endmodule
