module hexdisp(
    input i_clk,
    input [3:0] i_bin_num,
    output [6:0] o_hex_gfedcba);

  reg [6:0] r_hex_encoding = 7'h00;

always @ ( posedge i_clk )
  begin
    case (i_bin_num)
        4'b0000 :
          r_hex_encoding <= 7'h3F;
        4'b0001 :
          r_hex_encoding <= 7'h06;
        4'b0010 :
          r_hex_encoding <= 7'h5B;
        4'b0011 :
          r_hex_encoding <= 7'h4F;
        4'b0100 :
          r_hex_encoding <= 7'h66;
        4'b0101 :
          r_hex_encoding <= 7'h6D;
        4'b0110 :
          r_hex_encoding <= 7'h7D;
        4'b0111 :
          r_hex_encoding <= 7'h07;
        4'b1000 :
          r_hex_encoding <= 7'h7F;
        4'b1001 :
          r_hex_encoding <= 7'h6F;
        4'b1010 :
          r_hex_encoding <= 7'h77;
        4'b1011 :
          r_hex_encoding <= 7'h7C;
        4'b1100 :
          r_hex_encoding <= 7'h39;
        4'b1101 :
          r_hex_encoding <= 7'h5E;
        4'b1110 :
          r_hex_encoding <= 7'h79;
        4'b1111 :
          r_hex_encoding <= 7'h71;
      endcase
  end

assign o_hex_gfedcba[6:0] = r_hex_encoding[6:0];


endmodule
