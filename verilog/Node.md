# 命令步骤

```shell
iverilog -o 输出文件 代码文件和测试文件
vvp -n 上面的输出文件 -lxt2
cp   vvp的输出文件.vcd     改名为.lxt
gtkwave     改名后的文件
```

# 例子代码

```verilog
// 模块
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
```

```verilog
//测试代码
module test();
reg tin1,tin2,tin3;
wire tout;
judge3 F1( .in1(tin1), .in2(tin2), .in3(tin3), .out(tout));

initial
begin: ONLY_ONE
    reg [3:0] Pal;
    for(Pal=0; Pal<8; Pal=Pal+1)
    begin
        {tin1,tin2,tin3} = Pal;
        #5 $display("in1, in2, in3 = %b%b%b",tin1, tin2, tin3,
            ":::out = %d",tout);
    end
end

//下面这部很重要
initial
begin
$dumpfile("test.vcd");
$dumpvars(0,test);
end
endmodule
```
