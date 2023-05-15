module FrecuencyDivider(
  input wire clk,
  input rst,
  output reg o_clk
);

  parameter f = 25000000;  // Frecuencia de entrada en Hz
  parameter f_out = 1000;     // Frecuencia de salida deseada en Hz
  reg [31:0] count;
  reg toggle;

  always @(posedge clk or posedge rst) begin
    if (rst) 
        count <= 0;
    else begin
        if (count >= f / f_out - 1) begin
            count <= 0;
            toggle <= ~toggle;
        end else begin
            count <= count + 1;
        end
    end
  end

  always @(posedge clk) begin
    if (count == f / (2 * f_out) - 1) begin
      o_clk <= toggle;
    end
  end

endmodule