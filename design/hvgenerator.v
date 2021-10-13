module hvgenerator
(
  input   wire      i_clk,
  output  wire      o_h_sync,
  output  wire      o_v_sync,
  output  reg [10:0] r_h_counter,
  output  reg [9:0] r_v_counter,
  output  wire      o_valid_area,
);

reg r_h_sync, r_v_sync = 1'b0;
reg r_valid_area  = 1'b0;

parameter max_h = 640 + 16 + 64 + 120;
parameter max_v = 480 +  1 +  3 +  16;


always @ ( posedge i_clk )
  begin
    if (r_h_counter == max_h)
      begin
        r_h_counter <= 1'b0;
      end
    else
      begin
        r_h_counter <= r_h_counter + 1;
      end
  end


always @ ( posedge i_clk )
  begin
    if (r_h_counter == max_h)
      begin
        if (r_v_counter == max_v)
            r_v_counter <= 1'b0;
        else
            r_v_counter <= r_v_counter + 1;
      end
  end

always @(posedge i_clk)
  begin
    r_h_sync <= ((r_h_counter > (640 + 16)) && (r_h_counter < (640 + 16 + 65)));   // active for 64 clocks
    r_v_sync <= ((r_v_counter > (480 +  1)) && (r_v_counter < (480 +  1 +  4)));   // active for  3 clocks
  end

always @( posedge i_clk )
begin
if (r_h_counter > 0 && r_h_counter < 640 && r_v_counter < 480)
  begin
      r_valid_area <= 1'b1;
  end
  else
  begin
      r_valid_area <= 1'b0;
  end
end



assign o_valid_area = r_valid_area;
assign o_h_sync = ~r_h_sync;
assign o_v_sync = ~r_v_sync;

endmodule
