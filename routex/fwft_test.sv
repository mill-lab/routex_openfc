`timescale 1ns/1ps
module fwft_test();
   parameter STEP = 10;
   reg RST, CLK;
   
   reg [7:0][63:0] D;
   reg		   D_VALID;
   wire		   D_BP;
   
   wire [7:0][63:0] FIFO_Q;
   reg		    RD_EN;
   wire		    FIFO_VALID;
   
   reg [63:0]  CNT;

   xpm_fifo_test fifo 
     ( .CLK(CLK), .RST(RST), 
       .D(D), .D_VALID(D_VALID), .D_BP(D_BP), 
       .FIFO_Q(FIFO_Q), .FIFO_VALID(FIFO_VALID), .RD_EN(RD_EN)
       );
   
   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("ASM");

      RST <= 1;
      D_VALID <= 0;
      RD_EN <= 0;

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
	      
	      D_VALID <= 1;
	      RD_EN <= 1; end
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
	   // 5: begin
	   //    D <= 2; end
	   // 6: begin
	   //    D <= 3; end
	   // 7: begin
	   //    D <= 4; end
	   // 8: begin 
	   //    D <= 5; end
	   // 9: begin 
	   //    D <= 6;
	   //    RD_EN <= 0; end
	   // 10: begin 
	   //    D <= 7; end
	   // 11: begin 
	   //    D <= 8; end
	   // 12: begin 
	   //    D <= 9; end
	   // 13: begin 
	   //    D <= 10; end
	   // 14: begin 
	   //    D_VALID <= 0; end
	   // 15: begin
	   //    D_VALID[0] <= 1;
	   //    D_VALID[1] <= 1;
	   //    D[0] <= {8'h1, 56'h1};
	   //    D[1] <= {8'h1, 56'h1}; end
	   // 16: begin
	   //    D[0] <= {8'h1, 56'h2};
	   //    D[1] <= {8'h1, 56'h2}; end
	   // 17: begin
	   //    D[0] <= 10;
	   //    D[1] <= 10; end
	   // 18: begin
	   //    D[0] <= 16*1;
	   //    D[1] <= 16*16*1; end
	   // 19: begin
	   //    D[0] <= 16*2;
	   //    D[1] <= 16*16*2; end
	   // 20: begin
	   //    D[0] <= 16*3;
	   //    D[1] <= 16*16*3; end
	   // 21: begin
	   //    D[0] <= 16*4;
	   //    D[1] <= 16*16*4; end
	   // 22: begin 
	   //    D[0] <= 16*5;
	   //    D[1] <= 16*16*5; end
	   // 23: begin 
	   //    D[0] <= 16*6;
	   //    D[1] <= 16*16*6; end
	   // 24: begin 
	   //    D[0] <= 16*7;
	   //    D[1] <= 16*16*7; end
	   // 25: begin 
	   //    D[0] <= 16*8;
	   //    D[1] <= 16*16*8; end
	   // 26: begin 
	   //    D[0] <= 16*9;
	   //    D[1] <= 16*16*9; end
	   // 27: begin 
	   //    D[0] <= 16*10;
	   //    D[1] <= 16*16*10; end
	   // 28: begin 
	   //    D_VALID[0] <= 0;
	   //    D_VALID[1] <= 0; end
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule
