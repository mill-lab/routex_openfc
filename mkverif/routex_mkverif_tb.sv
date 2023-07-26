`timescale 1ns/1ps
module routex_mkverif_test();
   parameter STEP = 10;
   parameter NumPorts = 4;
   reg	     RST, CLK;

   reg [NumPorts-1:0][7:0][63:0] DEST;
   reg [NumPorts-1:0]		 GO, BP;
   reg [NumPorts-1:0][63:0]	 LEN;
   
   reg [63:0]			 CNT;
   
   mkverif # (.NumPorts(NumPorts)) uut
     (.RST(RST),
      .CLK(CLK),
      .DEST(DEST),
      .GO(GO),
      .LEN(LEN),
      .BP(BP),
      .FALSE()
      );
   
   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("ASM");

      RST <= 1;
      DEST <= 0;
      GO <= 0;
      LEN <= 0;
      BP <= 0;

      #(12.1*STEP)
      RST <= 0;
      
      #(3000*STEP)
      $finish;
   end // initial begin

   always @ (posedge CLK) begin
      if (RST) begin
	 CNT <= 0;
      end else begin 
	 CNT <= CNT + 1;
	 case (CNT)
	   100: begin
	      DEST[0][0] <= {8'h01, 56'h4};
	      LEN[0] <= 500;
	      GO[0] <= 1;
	      
	      DEST[1][0] <= {8'h01, 56'h4};
	      LEN[1] <= 500;
	      GO[1] <= 1;
	      	      
	      DEST[2][0] <= {8'h01, 56'h4};
	      LEN[2] <= 500;
	      GO[2] <= 1;
	      
	      DEST[3][0] <= {8'h01, 56'h4};
	      LEN[3] <= 500;
	      GO[3] <= 1;
	   end // case: 101

	   101: begin
	      GO <= 0;
	   end
	   
	   600: begin
	      DEST[0][0] <= {8'h01, 56'h4};
	      LEN[0] <= 300;
	      GO[0] <= 1;
	      
	      // DEST[1][0] <= {8'h01, 56'h4};
	      // LEN[1] <= 300;
	      // GO[1] <= 1;
	      	      
	      // DEST[2][0] <= {8'h01, 56'h4};
	      // LEN[2] <= 300;
	      // GO[2] <= 1;
	      
	      // DEST[3][0] <= {8'h01, 56'h4};
	      // LEN[3] <= 300;
	      // GO[3] <= 1;
	   end
	   
	   601: begin
	      GO <= 0;
	   end

	   900: begin
	      DEST[0][0] <= {8'h01, 56'h4};
	      LEN[0] <= 100;
	      GO[0] <= 1;
	      
	      // DEST[1][0] <= {8'h01, 56'h4};
	      // LEN[1] <= 100;
	      // GO[1] <= 1;
	      	      
	      // DEST[2][0] <= {8'h01, 56'h4};
	      // LEN[2] <= 100;
	      // GO[2] <= 1;
	      
	      // DEST[3][0] <= {8'h01, 56'h4};
	      // LEN[3] <= 100;
	      // GO[3] <= 1;
	   end
	   
	   901: begin
	      GO <= 0;
	   end

	   // 1000: begin
	   //    DEST[0][0] <= {8'h01, 56'h4};
	   //    LEN[0] <= 100;
	   //    GO[0] <= 1;
	      
	   //    DEST[1][0] <= {8'h01, 56'h4};
	   //    LEN[1] <= 100;
	   //    GO[1] <= 1;
	      
	   //    DEST[2][0] <= {8'h01, 56'h4};
	   //    LEN[2] <= 100;
	   //    GO[2] <= 1;
	      
	   //    DEST[3][0] <= {8'h01, 56'h4};
	   //    LEN[3] <= 100;
	   //    GO[3] <= 1;
	   // end
	   
	   1001: begin
	      GO <= 0;
	   end
	   
	   440: begin
	      BP <= 4'b1111;
	   end

	   1100: begin
	      BP <= 0;
	   end

	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule
