module counter(
	input i_clk,
	input i_rst,
	output [3:0]o_count
);

reg q2, q1, q0;
 
  always@(negedge i_clk)
begin

	if(i_rst)
		q0<=0;
	else 
		q0<= ~(q0);
end 

  always@(negedge q0)
begin
	if(i_rst)
		q1<=0;
	else 
		q1<=~(q1);
end


  always@(negedge q1)
begin
	if(i_rst)
		q2<=0;
	else 
		q2<=~(q2);
end

assign o_count = {q2,q1,q0};
endmodule 
