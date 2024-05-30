/* DCO testbench */

`default_nettype none

`timescale 1 ns / 1 ps

`define FUNCTIONAL
`define UNIT_DELAY #1

`include "dll.v"
`include "/usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
`include "/usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

module dco_tb;

    reg resetb;
    reg enable;
    reg [25:0] ext_trim;

    wire [1:0] clockp;

    initial begin
	$dumpfile("dco_tb.vcd");
	$dumpvars(0, dco_tb);

	resetb <= 1'b0;
	enable <= 1'b0;
	ext_trim <= 26'h0000000;

	#300;
	resetb <= 1'b1;

	#300;
	enable <= 1'b1;

	#5000;
	ext_trim <= 26'h3ffffff;
	#5000;
	$finish;
    end

    dll dut (
	.resetb(resetb),
	.enable(enable),
	.osc(1'b0),
	.clockp(clockp),
	.div(7'd0),
	.dco(1'b1),
	.ext_trim(ext_trim)
    );

endmodule;
