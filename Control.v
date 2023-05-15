module Control(
    input wire i_clk,

    //signal de control y banderas
    input wire compColumns,
    output reg addColumns,
    output reg rstColumns,


    output reg o_clk_enable,
    output reg o_latch,
    output reg o_blank,
 
    output reg [1:0] o_data_r,
    output reg [1:0] o_data_g,
    output reg [1:0] o_data_b,

    output reg [4:0] o_row_select
);

initial begin
  addColumns = 0;
  rstColumns = 0;
end
 

localparam
        s_DataUpdate = 0,
        s_BlanckSet = 1,
        s_LatchSet = 2,
        s_IncrementRow= 3,
        s_LatchClear = 4,
        s_BlankClear = 5;

reg [2:0] state=s_DataUpdate;

assign  o_data_r = {1'b1, 1'b0};
assign  o_data_g = {1'b1, 1'b1};
assign  o_data_b = {1'b0, 1'b1};                 

reg [7:0] pixels_to_shift=0;
always @(posedge i_clk) begin
    case (state)
        s_DataUpdate: begin 
            if (compColumns) 
                state <= s_BlanckSet;
            else begin
                rstColumns <=0;
                addColumns <=1;
                o_clk_enable <=0;
            end 
        end
        s_BlanckSet: begin
            o_blank <= 1; 
            rstColumns <= 1; 
            addColumns <=0;
            o_clk_enable <=1;
            state <= s_LatchSet;
        end
            
        s_LatchSet: begin
            o_latch  <= 1; 
            state <= s_IncrementRow;
        end  

        s_IncrementRow: begin
            o_row_select <= o_row_select + 1;
            state <= s_LatchClear;
        end
 
        s_LatchClear: begin
            o_latch  <= 0; 
            state <= s_BlankClear;
        end
        s_BlankClear:begin 
            o_blank <= 0; 
            state <= s_DataUpdate;
            rstColumns <= 1; 
        end
        default:
            state <= s_DataUpdate;
        
    endcase

end

endmodule