`timescale 1ns/1ps
module routex_mux4_test();
   parameter STEP = 10;
   parameter Numports = 4, PortNo = 1;
   
   reg RST, CLK;

   reg [Numports-1:0][7:0][63:0] D;
   reg [Numports-1:0][7:0]	 DEST;
   reg [Numports-1:0]		 DEST_VALID, D_HDR_VALID, D_PLD_VALID;
   reg [Numports-1:0]		 D_SOF, D_EOF;
   
   reg [63:0]			 CNT;

   routex_mux # (.PortNo(1) ) uut
     (.RST(RST),
      .CLK(CLK),
      .D(D),
      .DEST(DEST),
      .DEST_VALID(DEST_VALID),
      .D_HDR_VALID(D_HDR_VALID),
      .D_PLD_VALID(D_PLD_VALID),
      .D_SOF(D_SOF),
      .D_EOF(D_EOF),
      .Q_BP(4'b0),
      .D_BP(),
      .COLLISION(),
      .Q(),
      .Q_HDR_VALID(),
      .Q_PLD_VALID(),
      .Q_SOF(),
      .Q_EOF());

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;
      DEST <= 0;
      DEST_VALID <= 0;
      D_HDR_VALID <= 0;
      D_PLD_VALID <= 0;
      D_SOF <= 0;
      D_EOF <= 0;

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
	   1: begin // Collision 2data test IN
	      DEST[0] <= 1;
	      DEST[1] <= 1;
	      DEST_VALID[0] <= 1;
	      DEST_VALID[1] <= 1;
	      D_SOF[0] <= 1;
	      D_SOF[1] <= 1; end
	   2: begin
	      D[0][0] <= {8'h2, 56'h0};
	      D[0][1] <= {8'h2, 56'h0};
	      D[0][2] <= {8'h2, 56'h0};
	      D[0][3] <= {8'h1, 56'h1};
	      D[0][4] <= {8'h1, 56'h2};
	      D[0][5] <= {8'h1, 56'h3};
	      D[0][6] <= {8'h1, 56'h4};
	      D[0][7] <= {8'h1, 56'h5};
	      
	      D[1][0] <= {8'h2, 56'h0};
	      D[1][1] <= {8'h2, 56'h0};
	      D[1][2] <= {8'h2, 56'h0};
	      D[1][3] <= {8'h1, 56'h1};
	      D[1][4] <= {8'h1, 56'h0};
	      D[1][5] <= {8'h1, 56'h0};
	      D[1][6] <= {8'h1, 56'h0};
	      D[1][7] <= 10;
	      
	      D_HDR_VALID[0] <= 1;
	      D_HDR_VALID[1] <= 1;
	      D_SOF <= 0; end
	   3: begin
	      D[0][0] <= {8'h1, 56'h6};
	      D[0][1] <= {8'h1, 56'h7};
	      D[0][2] <= {8'h1, 56'h8};
	      D[0][3] <= {8'h1, 56'h10};
	      D[0][4] <= {8'h1, 56'h11};
	      D[0][5] <= {8'h1, 56'h12};
	      D[0][6] <= {8'h1, 56'h13};
	      D[0][7] <= 10;
	      
	      D_HDR_VALID[1] <= 0;
	      DEST_VALID[1] <= 0;
	      D_SOF <= 0; end
	   4: begin
	      D[0][0] <= 64'h1;
	      D[0][1] <= 64'h2;
	      D[0][2] <= 64'h3;
	      D[0][3] <= 64'h4;
	      D[0][4] <= 64'h5;
	      D[0][5] <= 64'h6;
	      D[0][6] <= 64'h7;
	      D[0][7] <= 64'h8;
	      
	      D_HDR_VALID[0] <= 0;
	      D_PLD_VALID[0] <= 1; end
	   5: begin
	      D[0][0] <= 64'h9;
	      D[0][1] <= 64'h10;
	      D_EOF <= 1; end
	   6: begin
	      DEST_VALID <= 0;
	      D_PLD_VALID <= 0;
	      D_EOF <= 0; end
	   7:;
	   8:;
	   9:;
	   10:;
	   11:;
	   12:;
	   13:;
	   14:;
	   15: begin
	      DEST[1] <= 1;
	      DEST_VALID[1] <= 1;
	      D_SOF[1] <= 1; end
	   16: begin
	      D[1][0] <= {8'h2, 56'h0};
	      D[1][1] <= {8'h2, 56'h0};
	      D[1][2] <= {8'h2, 56'h0};
	      D[1][3] <= {8'h1, 56'h1};
	      D[1][4] <= {8'h1, 56'h0};
	      D[1][5] <= {8'h1, 56'h0};
	      D[1][6] <= {8'h1, 56'h0};
	      D[1][7] <= 10;
	      D_HDR_VALID[1] <= 1;
	      D_SOF <= 0; end
	   17: begin
	      D[1][0] <= 64'h1;
	      D[1][1] <= 64'h2;
	      D[1][2] <= 64'h3;
	      D[1][3] <= 64'h4;
	      D[1][4] <= 64'h5;
	      D[1][5] <= 64'h6;
	      D[1][6] <= 64'h7;
	      D[1][7] <= 64'h8;
	      D_HDR_VALID[1] <= 0;
	      D_PLD_VALID[1] <= 1; end
	   18: begin
	      D[1][0] <= 64'h9;
	      D[1][1] <= 64'h10;
	      D_EOF[1] <= 1; end
	   19: begin
	      DEST_VALID <= 0;
	      D_PLD_VALID <= 0;
	      D_EOF <= 0; end
	   /* 
	   1: begin //Normal test IN
	      DEST[0] <= 1;
	      DEST_VALID[0] <= 1;
	      D_SOF[0] <= 1; end
	   2: begin
	      D[0][0] <= {8'h2, 56'h0};
	      D[0][1] <= {8'h2, 56'h0};
	      D[0][2] <= {8'h2, 56'h0};
	      D[0][3] <= {8'h1, 56'h1};
	      D[0][4] <= {8'h1, 56'h0};
	      D[0][5] <= {8'h1, 56'h0};
	      D[0][6] <= {8'h1, 56'h0};
	      D[0][7] <= 10;
	      D_HDR_VALID[0] <= 1;
	      D_SOF <= 0; end
	   3: begin
	      D[0][0] <= 64'h1;
	      D[0][1] <= 64'h2;
	      D[0][2] <= 64'h3;
	      D[0][3] <= 64'h4;
	      D[0][4] <= 64'h5;
	      D[0][5] <= 64'h6;
	      D[0][6] <= 64'h7;
	      D[0][7] <= 64'h8;
	      DEST_VALID[1] <= 0;
	      D_HDR_VALID[0] <= 0;
	      D_PLD_VALID <= 1; end
	   4: begin
	      D[0][0] <= 64'h9;
	      D[0][1] <= 64'h10;
	      D_EOF <= 1; end
	   5: begin
	      DEST_VALID <= 0;
	      D_PLD_VALID <= 0;
	      D_EOF <= 0; end
	    */
	 endcase // case (CNT)
      end // else: !if(RST)
   end // always @ (posedge CLK)
endmodule // routex_mux4_test
