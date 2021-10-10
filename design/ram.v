`default_nettype none
module ram (
            input wire i_clk,
            input wire i_we1,
            input wire i_we2,
            input [11:0] i_addr,
            input wire [7:0] i_din,
            output [7:0] o_dout);


reg [7:0] mem [4095:0];

initial begin
  $readmemh("ram.mem", mem);
end

always @(posedge i_clk)
begin
if(i_we1 & i_we2)
  begin
    mem[i_addr] <= i_din;
  end
  else
  o_dout <= mem[i_addr];
// Output register controlled by clock.
end
endmodule
