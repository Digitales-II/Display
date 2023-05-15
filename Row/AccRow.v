module AccRow (
  input i_clk,
  input addRow,
  output reg [4:0] rows
);

  reg [4:0] cont = 5'b00000;
  reg rst = 0;

  always @(posedge i_clk) begin
    if (rst == 1'b1) begin
      cont <= 5'b00000;
    end else begin
      if (addRow == 1'b1) begin
        cont <= cont + 1;
      end
    end
    
    rst <= (cont == 5'b10100) ? 1'b1 : 1'b0;
  end
  
  always @(negedge i_clk) begin
    if (rst == 1'b1) begin
      rows <= 5'b00000;
    end else begin
      rows <= cont;
    end
  end

endmodule