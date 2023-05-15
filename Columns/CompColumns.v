module CompColumns(i_clk,Columns, C);
  input wire i_clk;
  input wire [7:0]Columns;
  output reg C;
 
  always@(posedge i_clk) begin
    C = (Columns>=8'b01010000) ? 1'b1 : 1'b0;
  end
  
endmodule
