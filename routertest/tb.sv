`timescale 1ns/1ps
module router_test();
   parameter STEP = 10;
   reg RST, CLK;


   defparam uut.NumPorts = 4;
   defparam uut.PassThrough=4'b0011;

   wire [3:0][63:0] ROUTER_D, ROUTER_Q;
   
   router uut (.RST(RST),
	       .CLK(CLK),
	       .D      (ROUTER_D),    // I [3:0][63:0]
	       .D_VALID(),       // I [3:0]
	       .D_BP   (),     // O [3:0]
	       .Q       (ROUTER_Q), // O [3:0][63:0]
	       .Q_VALID(),  // O [3:0]
	       .Q_BP   (4'b0),  // I [3:0]
	       .Q_SOF   ());  // Not connected


   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;

      #(2.1*STEP)
      RST <= 0;

      #(1000*STEP)
      $finish;
   end // initial begin
endmodule
