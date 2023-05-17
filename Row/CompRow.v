module CompRow(i_clk,rows, C);
  input wire i_clk;
  input wire [4:0]rows;
  output reg C;
 
  always@(posedge i_clk) begin
    C = (rows>=5'b10011) ? 1'b1 : 1'b0;
  end
  
endmodule
