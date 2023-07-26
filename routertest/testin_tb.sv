`timescale 1ns/1ps
module testin_test();
   parameter STEP = 10;
   reg RST, CLK;

   reg [3:0][63:0] D;
   reg [3:0]	   D_VALID;
   reg [3:0]	   Q_BP;
   
   reg [63:0]	   CNT;

   router #(.PassThrough(4'b0)) uut (.RST(RST),
				     .CLK(CLK),
				     .D      (D),    // I [3:0][63:0]
				     .D_VALID(D_VALID),       // I [3:0]
				     .D_BP   (),     // O [3:0]
				     .Q       (ROUTER_Q), // O [3:0][63:0]
				     .Q_VALID(),  // O [3:0]
				     .Q_BP   (Q_BP),  // I [3:0]
				     .Q_SOF   ());  // Not connected

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;
      D_VALID <= 0;
      Q_BP <= 0;

      #(12.1*STEP)
      RST <= 0;
      
      #(1000*STEP)
      $finish;
   end // initial begin

   always @ (posedge CLK) begin
      if (RST) begin
	 CNT <= 0;
      end else begin 
	 CNT <= CNT + 1;
	 case (CNT)
	   1: begin
	      D_VALID[0] <= 1;
	      D[0] <= {8'h1, 56'h1}; end
	   2: begin D[0] <= {8'h1, 56'h2}; end
	   3: begin D[0] <= 10; end
	   4: begin D[0] <= 1; end
	   5: begin D[0] <= 2; end
	   6: begin D[0] <= 3; end
	   7: begin D[0] <= 4; end
	   8: begin 
	      D[0] <= 5;
	      Q_BP <= 1; end
	   9: begin D[0] <= 6; end
	   10: begin D[0] <= 7; end
	   11: begin D[0] <= 8; end
	   12: begin D[0] <= 9; end
	   13: begin D[0] <= 10; end
	   14: begin 
	      D_VALID[0] <= 0; end
	   100: Q_BP <= 0;
	   //15: begin
	   //    D_VALID[0] <= 1;
	   //    D[0] <= {8'h1, 56'h2}; end
	   // 16: begin D[0] <= {8'h1, 56'h3}; end
	   // 17: begin D[0] <= 10; end
	   // 18: begin D[0] <= 'h10; end
	   // 19: begin D[0] <= 'h20; end
	   // 20: begin D[0] <= 'h30; end
	   // 21: begin D[0] <= 'h40; end
	   // 22: begin D[0] <= 'h50; end
	   // 23: begin D[0] <= 'h60; end
	   // 24: begin D[0] <= 'h70; end
	   // 25: begin D[0] <= 'h80; end
	   // 26: begin D[0] <= 'h1234; end
	   // 27: begin D[0] <= 'habcd; end
	   // 28: begin D_VALID[0] <= 0; end
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule
