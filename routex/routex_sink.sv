`timescale 1ns/1ps
`default_nettype none

module routex_sink
  ( input wire CLK, RST,

    // Router ports
    input wire [7:0][63:0] D,
    input wire		   D_VALID,

    output reg [7:0]	   DEST,
    output wire		   DEST_VALID,
  
    output reg		   SOF, EOF,
    output reg [7:0][63:0] FRAME,
    output reg		   HDR_VALID,
    output reg		   PLD_VALID
    );

   // Receiver state machine
   reg [2:0]		   STAT, STAT_R; // idle (dest), header, payload
   reg [31:0]		   D_TOGO;
   wire [7:0]		   HDR_FLG;
/*
   D[511:448] D[7][63:0]
   D[447:384] D[6][63:0]
   D[383:320] D[5][63:0]
   D[319:256] D[4][63:0]
   D[255:192] D[3][63:0]
   D[191:128] D[2][63:0]
   D[127: 64] D[1][63:0]
   D[ 63:  0] D[0][63:0]
*/
   assign HDR_FLG[7] = (D[7][63:56] == 8'h1); // D[511:504]
   assign HDR_FLG[6] = (D[6][63:56] == 8'h1); // D[447:440]
   assign HDR_FLG[5] = (D[5][63:56] == 8'h1); // D[383:376]
   assign HDR_FLG[4] = (D[4][63:56] == 8'h1); // D[319:312]
   assign HDR_FLG[3] = (D[3][63:56] == 8'h1); // D[255:248]
   assign HDR_FLG[2] = (D[2][63:56] == 8'h1); // D[191:184]
   assign HDR_FLG[1] = (D[1][63:56] == 8'h1); // D[127:120]
   assign HDR_FLG[0] = (D[0][63:56] == 8'h1); // D[ 63: 56]

   // generate
   //    genvar		   i;
   //    for (i=0; i<8; i=i+1) begin : HDR_FLG_gen
   // 	 assign HDR_FLG[i] = (D[i][63:56] == 1);
   //    end
   // endgenerate

   wire [7:0]		   DEST_FLG;

   router_ch_sel cs
     (.REQ(HDR_FLG), .SEL(DEST_FLG));
   
   always @ (posedge CLK) begin
      STAT_R <= STAT;
      
      if (RST) begin
         STAT <= 3'b001;
         SOF <= 0;
         EOF <= 0;
         D_TOGO <= 0;
      end else begin
         case (STAT)
           3'b001: begin // waiting destination
              EOF <= 0;
              PLD_VALID <= 0;
	      if (D_VALID & |DEST_FLG) begin
		 FRAME <= D;
                 DEST <= DEST_FLG[7] ? D[7] :
			 DEST_FLG[6] ? D[6] :
			 DEST_FLG[5] ? D[5] :
			 DEST_FLG[4] ? D[4] :
			 DEST_FLG[3] ? D[3] :
			 DEST_FLG[2] ? D[2] :
			 DEST_FLG[1] ? D[1] :
			 DEST_FLG[0] ? D[0] : 64'h0;
		 HDR_VALID <= D_VALID;
		 SOF <= 1;
		 if (D[7][63:56] != 0) STAT <= 3'b010; // waiting length
		 else if (D[7][63:56] == 0) begin // already D_TOGO available
		    D_TOGO <= D[7][31:0];
		    STAT <= 3'b100;
		 end
	      end
	   end

           3'b010: begin
	      SOF <= 0;
	      if (D_VALID & D[7][63:56] == 0) begin
                 D_TOGO <= D[7][31:0];
                 STAT <= 3'b100;
              end
	      FRAME <= D;
           end

           3'b100: begin
	      SOF <= 0;
	      HDR_VALID <= 0;
              if (D_VALID) begin
                 D_TOGO <= D_TOGO -8;
                 if (D_TOGO <= 8) begin
                    STAT <= 3'b001;
                    EOF <= 1;
                 end
              end 

              PLD_VALID <= D_VALID;
              FRAME <= D;
           end
           
           default: begin
              STAT <= 3'b001; end
         endcase
      end
   end

   assign DEST_VALID = |STAT[2:1] | STAT_R[2];
   
endmodule // routex_sink

// priprity circuit
module router_ch_sel # (parameter NumCh=8 )
   ( input wire [NumCh-1:0] REQ,
     output wire [NumCh-1:0] SEL );

   wire [NumCh-1:0][NumCh-1:0]    TEMP;
   assign TEMP[0] = REQ[0] ? 1 : 0;
   
   generate
      genvar            i;
      for (i=1; i<NumCh; i=i+1) begin : casex_gen
         assign TEMP[i] = (TEMP[i-1]!=0) ? TEMP[i-1] : (REQ[i] ? 1 << i : 0);
      end
   endgenerate

   assign SEL = TEMP[NumCh-1];
endmodule // channel_sel

`default_nettype wire
