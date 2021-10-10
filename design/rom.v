module rom(
    input wire i_clk,
    input [13:0] i_addr,
    output reg [0:0] o_data
);

reg rom[16383:0];

initial begin
    $readmemb("rom.mem", rom);
end

always @(posedge i_clk) begin
    o_data <= rom[i_addr];
end

endmodule
