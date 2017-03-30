module test();
reg tin0,tin1,tin2,tin3,tin4,tin5,tin6,tin7;
wire tflag;
wire [2:0] tout;
codeshow F1(
    .in0(tin0),
    .in1(tin1),
    .in2(tin2),
    .in3(tin3),
    .in4(tin4),
    .in5(tin5),
    .in6(tin6),
    .in7(tin7),
    .out(tout),
    .flag(tflag)
);

initial
begin: ONLY_ONE
    reg [7:0] Pal;
    for(Pal=0; Pal<8'b11111111; Pal=Pal+1)
    begin
        {tin7,tin6,tin5,tin4,tin3,tin2,tin1,tin0} = Pal;
        #1 $display("in1-8 = %b%b%b%b%d%b%b%b",tin0,tin1,tin2,tin3,tin5,tin6,tin7,
            ":::out=%d,flag=%d",tout,tflag);
    end
end

initial
begin
$dumpfile("test.lxt");
$dumpvars(0,test);
end

endmodule
