/* DLL testbench */

`default_nettype none

`timescale 1 ns / 1 ps

`define FUNCTIONAL
`define UNIT_DELAY #1

`include "dll.v"
`include "/usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
`include "/usr/share/pdk/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"

module dll_tb;

    reg resetb;
    reg enable;
    reg osc;
    reg [4:0] fint;
    reg [2:0] ffrac;

    wire [1:0] clockp;
    wire [7:0] div;

    assign div = {fint, ffrac};

    initial begin
	$dumpfile("dll_tb.vcd");
	$dumpvars(0, dll_tb);

	osc <= 1'b0;
	resetb <= 1'b0;
	enable <= 1'b0;
	fint <= 7'd10;		// 100Mz / 10MHz = 10
	ffrac <= 3'b001;	// 1/8

	#300;
	resetb <= 1'b1;

	#300;
	enable <= 1'b1;

	#100000;
	$finish;
    end

    always #50 osc <= (osc === 1'b0);

    dll dut (
	.resetb(resetb),
	.enable(enable),
	.osc(osc),
	.clockp(clockp),
	.div(div),
	.dco(1'b0),
	.ext_trim(26'd0)
    );

endmodule;
