//时钟降频  50m hz --> 1hz
module dicCLK(clk50,clk1);
    input clk50;
    output clk1;
    integer i;
    reg clk1;
    reg cs;
    always @ (posedge clk50)
    begin
        if (i<2500000) 
            i = i+1;
        else
        begin
            i = 0;
            clk1 = ~clk1;
        end
    end
endmodule

//led 数字显示
module displayLed(num, outcode);
    input wire[3:0] num;
    output reg[6:0] outcode;
    always @ (num)
    begin
        case(num)//1灭 0亮 
            4'b0000: outcode=7'b1111111;//0
            4'b0001: outcode=7'b1001111;//1
            4'b0010: outcode=7'b0010010;//2
            4'b0011: outcode=7'b0000110;//3
            4'b0100: outcode=7'b1001100;//4
            4'b0101: outcode=7'b1011011;//5
            4'b0110: outcode=7'b1011111;//6
            4'b0111: outcode=7'b1110000;//7
            4'b1000: outcode=7'b0000000;//8
            4'b1001: outcode=7'b1111011;//9
        endcase
    end
endmodule


//不可设时间时钟内核
module Clock(clk, reset, hour, min, sec);
    input clk,reset;
    output reg[5:0] min=0, sec=0, hour=0;

    //reset
    always @ (reset)
    begin
        hour = 0;
        min = 0;
        sec = 0;
    end

    //count
    always @ (clk)
    begin
        sec = sec + 1;
        if (sec == 60) begin
            sec = 0;
            min = min + 1;
        end

        if (min >= 60) begin
            min = 0;
            hour = hour + 1;
        end

        if (hour >= 24 ) begin
            hour = 0;
        end
    end
endmodule

//可设时间时钟内核
module can_set_Clock(clk, reset, hour_set, min_set, sec_set, hour, min, sec);
    input clk,reset;
    input wire[5:0] min_set, sec_set, hour_set;
    output reg[5:0] min=0, sec=0, hour=0;

    //reset
    always @ (reset)
    begin
        hour <= hour_set;
        min  <= min_set;
        sec  <= sec_set;
    end

    //count
    always @ (clk)
    begin
        sec = sec + 1;
        if (sec == 60) begin
            sec = 0;
            min = min + 1;
        end

        if (min >= 60) begin
            min = 0;
            hour = hour + 1;
        end

        if (hour >= 24 ) begin
            hour = 0;
        end
    end
endmodule

//5位 拆分 模块 num < 64
module Split(num, hight, low);
input [5:0] num;
output reg[3:0] hight, low;
always @(num)
begin
    hight = num / 10;
    low = num % 10;
end
endmodule


//实验1 三极管移动移动输出
module LEDmov(clk1hz, sw0, hex0, hex1, hex2);
    input clk1hz,sw0;
    parameter Value=56'b0001001_0110000_1110001_1110001_0000001_0000000_0000000_0000000;// HELLO___
    output reg[6:0] hex0,hex1,hex2;
    reg[55:0] m=Value;
    always @ (posedge clk1hz)
    begin
        if (sw0)
            m = {m,m[55:49]};
        else
            m = {m[6:0],m[55:7]};
        {hex0,hex1,hex2} = m[55:35];
    end
endmodule


// 实验 2 时钟
module Exp2_clock(reset, clk50, sw0, hourh, hourl, minh, minl, sech, secl);
input clk50, sw0, reset;
output wire[6:0]  hourh, hourl, minh, minl, sech, secl;
wire clk;
wire[5:0] min=0, sec=0, hour=0;
wire[3:0] hourh_code, hourl_code, minh_code,  minl_code, sech_code,  secl_code;


dicCLK dic1(clk50, clk);        // 时钟降频率
Clock clock(clk, reset, hour, min, sec);    // 时钟内核

Split sh(hour, hourh_code, hourl_code);
Split sm(min,  minh_code,  minl_code);
Split ss(sec,  sech_code,  secl_code);

displayLed dhh(hourh_code, hourh);
displayLed dhl(hourl_code, hourl);
displayLed dmh(minh_code,  minh);
displayLed dml(minl_code,  minl);
displayLed dsh(sech_code,  sech);
displayLed dsl(secl_code,  secl);

endmodule


//  实验3。 时钟扩展
//  端口： 重置，重置小时，重置分钟，重置秒，50mHz时钟信号，7段管输出（时分秒 高低位 ）
module Exp3_cantSetclock(reset, hour_re, min_re, sec_re, clk50, sw0, hourh, hourl, minh, minl, sech, secl);
input clk50, sw0, reset;
input wire[5:0] hour_re, min_re, sec_re;
output wire[6:0]  hourh, hourl, minh, minl, sech, secl;

wire clk;
wire[5:0] min=0, sec=0, hour=0;

wire[3:0] hourh_code, hourl_code, minh_code,  minl_code, sech_code,  secl_code;


dicCLK dic1(clk50, clk);        // 时钟降频率
can_set_Clock scl(clk, reset, hour_re, min_re, sec_re, hour, min, sec);    // 时钟内核

Split sh(hour, hourh_code, hourl_code);
Split sm(min,  minh_code,  minl_code);
Split ss(sec,  sech_code,  secl_code);

displayLed dhh(hourh_code, hourh);
displayLed dhl(hourl_code, hourl);
displayLed dmh(minh_code,  minh);
displayLed dml(minl_code,  minl);
displayLed dsh(sech_code,  sech);
displayLed dsl(secl_code,  secl);
endmodule
