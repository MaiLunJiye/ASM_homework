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

initial
begin
$dumpfile("test.vcd");
$dumpvars(0,test);
end

endmodule
