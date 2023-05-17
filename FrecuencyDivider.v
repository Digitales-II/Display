module FrecuencyDivider(
  input wire clk,
  input rst,
  output reg o_clk
);

  parameter f = 25000000;  // Frecuencia de entrada en Hz
  parameter f_out = 12500000;     // Frecuencia de salida deseada en Hz
  parameter max_cunt =f/(2*f_out);
  reg [31:0] count;
  reg toggle;

  always @(posedge clk or posedge rst) begin
    if (rst) 
        count <= 0;
    else begin
        if (count >= max_cunt - 1) begin
            count <= 0;
            toggle <= ~toggle;
        end else begin
            count <= count + 1;
        end
    end
  end
  always @(posedge clk) begin
    o_clk <= toggle;
  end

endmodule