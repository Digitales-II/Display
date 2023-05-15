module AccColumns(
  input o_clk,
  input addColumns,
  input rstColumns,
  output reg [7:0] columns);

  always @(posedge o_clk or posedge rstColumns) begin
    if (rstColumns)
      columns <= 8'b00000000;
    else if (addColumns)
      columns <= columns + 1;
  end
endmodule
