module Control(
    input wire i_clk,

    //signal de control y banderas
    input wire compColumns,
    input wire compRows,
    output reg addColumns,
    output reg addRow,
    output reg rstColumns,


    output reg o_clk_enable,
    output reg o_latch,
    output reg o_blank,
 
    output reg [1:0] o_data_r,
    output reg [1:0] o_data_g,
    output reg [1:0] o_data_b,

    
);

initial begin
  addColumns = 0;
  rstColumns = 0;
  addRow = 0;
end
 

localparam
        s_DataUpdate = 0,
        s_BlanckSet = 1,
        s_LatchSet = 2,
        s_IncrementRow= 3,
        s_LatchClear = 4,
        s_BlankClear = 5;

reg [2:0] state=s_DataUpdate;

/*assign  o_data_r = {1'b1, 1'b0};
assign  o_data_g = {1'b0, 1'b1};
assign  o_data_b = {1'b1, 1'b1}; */
reg [4:0] red_register   = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
reg [4:0] green_register = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
reg [4:0] blue_register  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0}; 


reg [4:0] red_register2   = {1'b0, 1'b0, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1};
reg [4:0] green_register2 = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0};
reg [4:0] blue_register2  = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0}; 

reg [7:0] pixels_to_shift=0;
reg [3:0] counter = 0;
always @(posedge i_clk) begin
    case (state)
        s_DataUpdate: begin 
            if (compColumns) 
                state <= s_BlanckSet;
            else begin
                o_data_r <= {red_register2[counter], red_register[counter]};
                o_data_g <= {green_register2[counter], green_register[counter]};
                o_data_b <= {blue_register2[counter], blue_register[counter]};
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
            addRow <=1;
            state <= s_LatchClear;
        end
 
        s_LatchClear: begin
            addRow <=0;
            o_latch  <= 0; 
            state <= s_BlankClear;
        end
        s_BlankClear:begin 
            o_blank <= 0; 
            rstColumns <= 1; 
            state <= s_DataUpdate;
            if (compRows == 1) begin
                if (counter >=6)
                    counter <= 0;
                else
                    counter <= counter + 1;
            end
            
        end
        default:
            state <= s_DataUpdate;
        
    endcase

end

endmodule