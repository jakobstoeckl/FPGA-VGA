`include "hvgenerator.v"
`include "ram.v"
`include "rom.v"
module vga(
  input  wire i_clk,
  input  wire [11:0] i_addr,
  input  wire [7:0] i_din,
  input  wire i_we,
  output wire o_h_sync,
  output wire o_v_sync,
  output wire o_valid_area,
  output wire o_px);

wire w_h_sync;
assign o_h_sync = w_h_sync;
wire [10:0] w_h_counter;
wire [9:0]  w_v_counter;
wire [13:0]  w_rom_addr;

wire w_px;

wire [10:3] column;  //80
wire [9:4]  row;  //30
reg [2:0]  rom_x;  //80
reg [3:0]  rom_y;  //30

wire [11:0]  text_addr;
wire [7:0]   text_char;

assign column = w_h_counter[10:3]; // column = r_h_counter / 8
assign    row = w_v_counter[9:4];  // row    = r_v_counter / 16
assign text_addr = column + (row * 80);

wire [11:0] ram_addr;
assign ram_addr = (w_h_counter < 640) ? text_addr : i_addr;

wire we2;
assign we2 = ~w_h_sync;

//wire w_h_sync_original;
//wire w_v_sync_original;
//wire w_valid_area;
//
//reg hsync_delayed1;
//reg hsync_delayed2;
//reg hsync_delayed3;
//
//reg vsync_delayed1;
//reg vsync_delayed2;
//reg vsync_delayed3;
//
//reg inDisplayAreaDelayed1;
//reg inDisplayAreaDelayed2;
//
//always@(posedge i_clk)
//begin
//	hsync_delayed1 <= w_h_sync_original;
//	hsync_delayed2 <= hsync_delayed1;
//	hsync_delayed3 <= hsync_delayed2;
//
//	vsync_delayed1 <= w_v_sync_original;
//	vsync_delayed2 <= vsync_delayed1;
//	vsync_delayed3 <= vsync_delayed2;
//
//	inDisplayAreaDelayed1 <= w_valid_area;
//	inDisplayAreaDelayed2 <= inDisplayAreaDelayed1;
//end
//
//assign o_h_sync = hsync_delayed2;
//assign o_v_sync = vsync_delayed2;
//assign o_valid_area = inDisplayAreaDelayed1;


hvgenerator inst_hvgenerator(
    .i_clk(i_clk),
    .o_h_sync(w_h_sync),
    .o_v_sync(o_v_sync),
    .r_h_counter(w_h_counter),
    .r_v_counter(w_v_counter),
    .o_valid_area(o_valid_area));

ram ram_inst(
    .i_clk(i_clk),
    .i_we1(i_we),
    .i_we2(we2),
    .i_addr(ram_addr),
    .i_din(i_din),
    .o_dout(text_char)
    );

always @ ( posedge i_clk )
begin
  rom_x <= w_h_counter[2:0];
  rom_y <= w_v_counter[3:0];
end

assign w_rom_addr = (text_char << 7) + (rom_y << 3) + rom_x;

rom rom_inst(
  .i_clk(i_clk),
  .i_addr(w_rom_addr),
  .o_data(w_px)
  );

assign o_px = (w_v_counter < 480 && w_h_counter < 640) ? w_px : 1'b0;
endmodule
