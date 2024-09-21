module countertb();

reg i_clk, i_rst;
  wire [3:0]o_count;

  counter dut1(i_clk, i_rst, o_count);


initial 

begin

i_clk=0;
i_rst=1;

#10 i_rst=0;


end 


always #5 i_clk = ~i_clk;

initial
begin

$dumpfile("dump.vcd");
$dumpvars();
#500 $finish;
end  
endmodule 
