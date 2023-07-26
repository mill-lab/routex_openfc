`timescale 1ns/1ps
module cmux_test();
   parameter STEP = 10;
   parameter Numports = 4, PortNo = 1;
   
   reg RST, CLK;

   reg [Numports-1:0][7:0][63:0] D;
   reg [Numports-1:0]		 SRC_PORT;
   
   reg [63:0]			 CNT;

   channel_mux uut
     (.D(D),
      .SEL(SRC_PORT),
      .Q());

   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("SA");

      RST <= 1;
      D <= 0;
      SRC_PORT <= 0;
      
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
	      D[0][3] <= {8'h1, 56'h1};
	      D[0][4] <= {8'h1, 56'h0};
	      D[0][5] <= {8'h1, 56'h0};
	      D[0][6] <= {8'h1, 56'h0};
	      D[0][7] <= 10;
	      
	      D[1][0] <= {8'h2, 56'h0};
	      D[1][1] <= {8'h2, 56'h0};
	      D[1][2] <= {8'h2, 56'h0};
	      D[1][3] <= {8'h1, 56'h1};
	      D[1][4] <= {8'h1, 56'h0};
	      D[1][5] <= {8'h1, 56'h0};
	      D[1][6] <= {8'h1, 56'h0};
	      D[1][7] <= 10; 
	      SRC_PORT <= 1; end
	 endcase // case (CNT)
      end // else: !if(RST)
   end // always @ (posedge CLK)
endmodule // routex_mux4_test
