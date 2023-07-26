`timescale 1ns/1ps
module routex_rx_buf_test();
   parameter STEP = 10;
   parameter Numports = 4;

   reg RST, CLK;

   reg [7:0][63:0] D;
   reg		   D_VALID;
   reg		   COLLISION;
   
   reg [63:0]	   CNT;
   
   routex_rx_buf  uut (.RST(RST),
		       .CLK(CLK),
		       .D(D),
		       .D_VALID(D_VALID),
		       .Q_BP(4'b0),
		       .COLLISION(COLLISION),
		       .D_BP(),
		       .Q(),
		       .Q_VALID());

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;
      D_VALID <= 0;
      COLLISION <= 0;

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
	   101: begin
	      D[0] <= {8'h2, 56'h0};
	      D[1] <= {8'h2, 56'h0};
	      D[2] <= {8'h2, 56'h0};
	      D[3] <= {8'h1, 56'h1};
	      D[4] <= {8'h1, 56'h0};
	      D[5] <= {8'h1, 56'h0};
	      D[6] <= {8'h1, 56'h0};
	      D[7] <= 10;

	      D_VALID <= 1; end
	   102: begin
	      D[0] <= 64'h1;
	      D[1] <= 64'h2;
	      D[2] <= 64'h3;
	      D[3] <= 64'h4;
	      D[4] <= 64'h5;
	      D[5] <= 64'h6;
	      D[6] <= 64'h7;
	      D[7] <= 64'h8; end
	   103: begin
	      D[0] <= 64'h9;
	      D[1] <= 64'h10; end
	   104: begin
	      D_VALID <= 0; end
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule // router_rx_buf_test

