`timescale 1ns/1ps
module routex_sink_test();
   parameter STEP = 10;
   
   reg RST, CLK;

   reg [7:0][63:0] D;
   reg 		   D_VALID;

   reg [63:0]	   CNT;
   
   routex_sink uut
     (.RST(RST),
      .CLK(CLK),
      .D(D),
      .D_VALID(D_VALID),
      .DEST(),
      .DEST_VALID(),
      .SOF(),
      .EOF(),
      .FRAME(),
      .HDR_VALID(),
      .PLD_VALID());

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;
      D_VALID <= 0;

      #(12.1*STEP)
      RST <= 0;
      
      #(100*STEP)
      $finish;
   end // initial begin

   always @ (posedge CLK) begin
      if (RST) begin
	 CNT <= 0;
      end else begin
	 CNT <= CNT + 1;
	 case (CNT)
	   1: begin
	      D[0] <= {8'h2, 56'h1};
	      D[1] <= {8'h2, 56'h2};
	      D[2] <= {8'h2, 56'h3};
	      D[3] <= {8'h1, 56'h4};
	      D[4] <= {8'h1, 56'h5};
	      D[5] <= {8'h1, 56'h6};
	      D[6] <= {8'h1, 56'h7};
	      D[7] <= {8'h1, 56'h8};
	      D_VALID <= 1; end
	   2: begin
	      D[0] <= {8'h1, 56'h9};
	      D[1] <= {8'h1, 56'h10};
	      D[2] <= {8'h1, 56'h11};
	      D[3] <= {8'h1, 56'h12};
	      D[4] <= {8'h1, 56'h13};
	      D[5] <= {8'h1, 56'h14};
	      D[6] <= {8'h1, 56'h15};
	      D[7] <= {8'h1, 56'h16};
	      D_VALID <= 1; end
	   3: begin
	      D[0] <= {8'h1, 56'h17};
	      D[1] <= {8'h1, 56'h18};
	      D[2] <= {8'h1, 56'h19};
	      D[3] <= {8'h1, 56'h20};
	      D[4] <= {8'h1, 56'h21};
	      D[5] <= {8'h1, 56'h22};
	      D[6] <= {8'h1, 56'h23};
	      D[7] <= 27;
	      D_VALID <= 1; end
	   4: begin
	      D[0] <= 1;
	      D[1] <= 2;
	      D[2] <= 3;
	      D[3] <= 4;
	      D[4] <= 5;
	      D[5] <= 6;
	      D[6] <= 7;
	      D[7] <= 8; end
	   5: begin
	      D[0] <= 9;
	      D[1] <= 10;
	      D[2] <= 11;
	      D[3] <= 12;
	      D[4] <= 13;
	      D[5] <= 14;
	      D[6] <= 15;
	      D[7] <= 16; end
	   6: begin
	      D[0] <= 17;
	      D[1] <= 18;
	      D[2] <= 19;
	      D[3] <= 20;
	      D[4] <= 21;
	      D[5] <= 22;
	      D[6] <= 23;
	      D[7] <= 24; end
	   7: begin
	      D[0] <= 25;
	      D[1] <= 26;
	      D[2] <= 27; end
	   8: begin D_VALID <= 0; end

	   20: begin
	      D[0] <= {8'h2, 56'h1};
	      D[1] <= {8'h2, 56'h2};
	      D[2] <= {8'h2, 56'h3};
	      D[3] <= {8'h1, 56'h4};
	      D[4] <= {8'h1, 56'h5};
	      D[5] <= {8'h1, 56'h6};
	      D[6] <= {8'h1, 56'h7};
	      D[7] <= 10;
	      D_VALID <= 1; end
	   21: begin
	      D[0] <= 64'h1;
	      D[1] <= 64'h2;
	      D[2] <= 64'h3;
	      D[3] <= 64'h4;
	      D[4] <= 64'h5;
	      D[5] <= 64'h6;
	      D[6] <= 64'h7;
	      D[7] <= 64'h8; end
	   22: begin
	      D[0] <= 64'h9;
	      D[1] <= 64'h10; end
	   23: begin D_VALID <= 0; end
	 endcase // case (CNT)
      end // else: !if(RST)
   end // always @ (posedge CLK)
endmodule // routex_sink_test
