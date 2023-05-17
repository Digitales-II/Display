module Display(
    input i_clk,

    output reg o_clk,
    output reg o_latch,
    output reg o_blank,
 
    output reg [1:0] o_data_r,
    output reg [1:0] o_data_g,
    output reg [1:0] o_data_b,

    output reg [4:0] o_row_select,
    output reg led
);
wire [7:0]w_columns;
wire [4:0]w_rows;
wire w_addColumns;
wire w_rstColumns;
wire w_compColumns;
wire w_compRows;
wire w_addRow;
wire w_o_clk;
wire w_o_clk_enable;

FrecuencyDivider dF(.clk(i_clk),.o_clk(w_o_clk),.rst(w_o_clk_enable));
Control control (.i_clk(i_clk),.o_clk_enable(w_o_clk_enable),.o_latch(o_latch),.o_blank(o_blank),.o_data_r(o_data_r),.o_data_g(o_data_g),.o_data_b(o_data_b),.addRow(w_addRow),.compColumns(w_compColumns),.compRows(w_compRows),.rstColumns(w_rstColumns),.addColumns(w_addColumns));
AccColumns accColumns(.o_clk(w_o_clk),.addColumns(w_addColumns),.rstColumns(w_rstColumns),.columns(w_columns));
CompColumns compColumns (.i_clk(i_clk),.Columns(w_columns),.C(w_compColumns));
AccRow accRows(.i_clk(i_clk),.addRow(w_addRow),.rows(w_rows));
CompRow compRows(.i_clk(i_clk),.rows(w_rows),.C(w_compRows));
assign o_clk= w_o_clk;
assign o_row_select= w_rows;
assign led=w_o_clk;
endmodule
