//共阴极7段管显示
module LED_GND_tb();
reg   [3:0] num;
wire  [6:0]outCode;
reg [3:0] count;
initial
 begin
    $dumpfile("LED_GND.vcd");
    $dumpvars(0, s);
    $monitor("innum=%d --> out=%d",num,outCode);

    for(count=0; count<4'b1111; count=count+1)
    begin
        #1 num = count;
    end

    #1 $finish;
 end
LED_GND s(num,outCode);
endmodule
