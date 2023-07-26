`timescale 1ns/1ps
module routex_core_test();
   parameter STEP = 10;
   parameter Numports = 4;

   reg RST, CLK;

   reg [Numports-1:0][7:0][63:0] D;
   reg [Numports-1:0]		 D_VALID;
   
   reg [63:0]			 CNT;
   
   routex_core #(.PassThrough(4'b0)) uut (.RST(RST),
					  .CLK(CLK),
					  .D(D),
					  .D_VALID(D_VALID),
					  .Q_BP(4'b0),
					  .D_BP(),
					  .COLLISION(),
					  .PT(),
					  .PT_VALID(),
					  .Q(),
					  .Q_VALID(),
					  .Q_SOF());

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;

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
	      D[0][0] <= {8'h2, 56'h0};
	      D[0][1] <= {8'h2, 56'h0};
	      D[0][2] <= {8'h2, 56'h0};
	      D[0][3] <= {8'h1, 56'h4};
	      D[0][4] <= {8'h1, 56'h0};
	      D[0][5] <= {8'h1, 56'h0};
	      D[0][6] <= {8'h1, 56'h0};
	      D[0][7] <= 10;
	      
	      D[1][0] <= {8'h2, 56'h0};
	      D[1][1] <= {8'h2, 56'h0};
	      D[1][2] <= {8'h2, 56'h0};
	      D[1][3] <= {8'h1, 56'h4};
	      D[1][4] <= {8'h1, 56'h1};
	      D[1][5] <= {8'h1, 56'h1};
	      D[1][6] <= {8'h1, 56'h1};
	      D[1][7] <= 10;
	      
	      D_VALID[0] <= 1;
	      D_VALID[1] <= 1; end
	   2: begin
	      D[0][0] <= 64'h1;
	      D[0][1] <= 64'h2;
	      D[0][2] <= 64'h3;
	      D[0][3] <= 64'h4;
	      D[0][4] <= 64'h5;
	      D[0][5] <= 64'h6;
	      D[0][6] <= 64'h7;
	      D[0][7] <= 64'h8;

	      D[1][0] <= 64'h10;
	      D[1][1] <= 64'h20;
	      D[1][2] <= 64'h30;
	      D[1][3] <= 64'h40;
	      D[1][4] <= 64'h50;
	      D[1][5] <= 64'h60;
	      D[1][6] <= 64'h70;
	      D[1][7] <= 64'h80; end
	   3: begin
	      D[0][0] <= 64'h9;
	      D[0][1] <= 64'h10;
	      
	      D[1][0] <= 64'h90;
	      D[1][1] <= 64'h100; end
	   4: begin
	      D_VALID[0] <= 0;
	      D_VALID[1] <= 0; end
	   5: ;
	   6: ;
	   7: ;
	   8: ;
	   9: ;
	   10:;
	   11:;
	   12:;
	   13:;
	   14:;
	   15:;
	   16:;
	   17:;
	   18:;
	   19:;
	   20:;
	   21:;
	   22:;
	   23: D_VALID[1] <= 1;
	   24: begin
	      D[1][0] <= {8'h2, 56'h0};
	      D[1][1] <= {8'h2, 56'h0};
	      D[1][2] <= {8'h2, 56'h0};
	      D[1][3] <= {8'h1, 56'h4};
	      D[1][4] <= {8'h1, 56'h1};
	      D[1][5] <= {8'h1, 56'h1};
	      D[1][6] <= {8'h1, 56'h1};
	      D[1][7] <= 10; end
	   25: begin
	      D[1][0] <= 64'h10;
	      D[1][1] <= 64'h20;
	      D[1][2] <= 64'h30;
	      D[1][3] <= 64'h40;
	      D[1][4] <= 64'h50;
	      D[1][5] <= 64'h60;
	      D[1][6] <= 64'h70;
	      D[1][7] <= 64'h80; end
	   26: begin
	      D[1][0] <= 64'h90;
	      D[1][1] <= 64'h100; end
	   27: D_VALID[1] <= 0;
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule // router_core_test
