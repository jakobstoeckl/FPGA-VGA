//`include "text_ram.v"
`include "pll.v"
`include "vga.v"
`include "debounce.v"
module top(
    input  CLK,
    input P13,
    input [7:0] P,
    output P23,
    output P22,
    output P10,
    output P11,
    output P12);

wire w_clk;
wire gcb_clk;

wire w_valid_area;
wire w_px;

reg [11:0] addr_counter = 12'b000000000000;
reg  r_button = 1'b0;
wire w_button;

reg [7:0] r_i_data = 8'b0;
reg r_write_flag = 1'b0;
reg r_corruption_flag = 1'b0;
wire w_h_sync;
wire w_invert_h_sync;
assign w_invert_h_sync = ~w_h_sync;
pll inst_pll(
    .clock_in(CLK),
    .clock_out(w_clk));

SB_GB clk_buffer(
  .USER_SIGNAL_TO_GLOBAL_BUFFER(w_clk),
  .GLOBAL_BUFFER_OUTPUT(gcb_clk));

debounce deb(
    .i_clk(gcb_clk),
    .i_Switch(P13),
    .o_Switch(w_button)
    );

always @(posedge gcb_clk)
    begin
      r_button <= w_button;
      if (w_button == 1'b1 && r_button == 1'b0)
        begin
          r_i_data <= P;
          if(w_invert_h_sync == 1'b0)
            begin
              r_write_flag <= 1'b1;
              if(addr_counter == 12'b100101100000)
                begin
                  addr_counter <= 12'b000000000000;
                end
              else
                begin
                  addr_counter <= addr_counter + 1;
                end
            end
          else
            begin
              r_corruption_flag <= 1'b1;
              r_write_flag <= 1'b0;
            end
      end
      if(r_corruption_flag == 1'b1 && w_invert_h_sync == 1'b0)
        begin
          r_corruption_flag <= 1'b0;
          r_write_flag <= 1'b1;
          if(addr_counter == 12'b100101100000)
            begin
              addr_counter <= 12'b000000000000;
            end
          else
            begin
              addr_counter <= addr_counter + 1;
            end
        end
    end

vga vga_inst(
    .i_clk(gcb_clk),
    .i_addr(addr_counter),
    .i_din(r_i_data),
    .i_we(r_write_flag),
    .o_h_sync(w_h_sync),
    .o_v_sync(P23),
    .o_valid_area(w_valid_area),
    .o_px(w_px));

assign P22  = w_h_sync;
assign P12  = (w_valid_area) ? w_px : 1'b0;
assign P11  = (w_valid_area) ? w_px : 1'b0;
assign P10  = (w_valid_area) ? w_px : 1'b0;

endmodule
