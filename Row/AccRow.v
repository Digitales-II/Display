module AccRow (
  input i_clk,
  input addRow,
  output reg [4:0] rows
);


  reg rst = 0;

  always @(posedge i_clk or posedge rst) begin
    if (rst)
      rows <= 5'b00000;
    else if (addRow)
      rows  <= rows  + 1;
  end
  always@(posedge i_clk) begin
    rst = (rows>=5'b10100) ? 1'b1 : 1'b0;
  end
  
endmodule