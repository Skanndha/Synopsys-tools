
module round_robintb();
  reg clk;
  reg rst_n;
  reg [3:0] in;
  wire [3:0] out;
  
  
  round_robin DUT(clk, rst_n, in, out);
  

  always #5 clk = ~clk;
  

  
  initial begin
    clk = 0;
    rst_n = 1;
    in = 4'b0;
    
    #10 rst_n = 0;
    
    #5 rst_n = 1;
    
   #10 in = 4'b1000;    
    
   #10 in = 4'b1010;
    
   #10 in = 4'b0010;
    
    #10 in = 4'b0110;
    
    #10 in = 4'b1110;
    
    #10 in = 4'b1111;
    
   #10 in = 4'b0100;
    
    #10 in = 4'b0010;
    
    #5 rst_n = 0;
    
    #100 $finish;
  end
  
   initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
endmodule
    
    
  
