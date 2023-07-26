`timescale 1ns/1ps
`default_nettype none
module router_mux4 # (parameter NumPorts = 4, PortNo = 1) // 4 to 1 switch
   ( input wire CLK, RST,

     input wire [NumPorts-1:0][63:0] D,
     input wire [NumPorts-1:0][7:0]  DEST,
     input wire [NumPorts-1:0] 	     DEST_VALID, D_HDR_VALID, D_PLD_VALID,
     input wire [NumPorts-1:0] 	     D_SOF, D_EOF,
     output wire [NumPorts-1:0]      D_BP, COLLISION,

     output wire [63:0] 	     Q,
     output wire 		     Q_HDR_VALID, Q_PLD_VALID, Q_SOF, Q_EOF,
     input wire 		     Q_BP
     );

   // SOF detection
   
   wire [NumPorts-1:0] 		     SOF_DETECT;
   reg [NumPorts-1:0] 		     SOF_DETECTr;
   
   assign SOF_DETECT[3] = D_SOF[3] & (DEST[3] == PortNo);
   assign SOF_DETECT[2] = D_SOF[2] & (DEST[2] == PortNo);
   assign SOF_DETECT[1] = D_SOF[1] & (DEST[1] == PortNo);
   assign SOF_DETECT[0] = D_SOF[0] & (DEST[0] == PortNo);

   // Source switching on SOF_DETECT and corresponding EOF
   
   reg [NumPorts-1:0] 		     SRC_PORT;
   always @ (posedge CLK) begin
      if (RST) begin
         SRC_PORT <= 0;
	 SOF_DETECTr <= 0;
      end else begin
	 SOF_DETECTr <= SOF_DETECT;
         if (SRC_PORT==0) begin
            casex (SOF_DETECT)
              4'bxxx1: SRC_PORT <= 4'b0001;
              4'bxx10: SRC_PORT <= 4'b0010;
              4'bx100: SRC_PORT <= 4'b0100;
              4'b1000: SRC_PORT <= 4'b1000;
              default: SRC_PORT <= 0;
            endcase // casex (SOF_DETECT)
         end else begin
            if (SRC_PORT & D_EOF) SRC_PORT <= 0;
         end
      end
   end // always @ (posedge CLK)
   
   // - - - - - - - - - - - - - - - - - - - -
   // Collision detection

   reg [NumPorts-1:0] CD;
   wire               EOF_DETECT = |(SRC_PORT & D_EOF);

   /*
   always @ (posedge CLK) begin
      if (RST) begin
         CD <= 0;
      end else begin
         CD <= (SRC_PORT==0) ? (SOF_DETECT & ~SRC_PORTi) :  // may be slow...
               (EOF_DETECT ? 0 :  // end of session
                CD | SOF_DETECT); // secondary collision 
      end
   end
    */

   reg [2:0]          EOF_CNT;
   wire               EOF_CNT_FULL = &EOF_CNT;
   
   always @ (posedge CLK) begin
      if (RST) begin
         CD <= 0;
         EOF_CNT <= 0;
      end else begin
         if (EOF_DETECT) EOF_CNT <= 1;
         else EOF_CNT <= (EOF_CNT != 0) ? EOF_CNT+1 : 0;

         if (CD==0) begin
            CD <= (SOF_DETECTr & ~SRC_PORT);
         end else begin
            CD <= EOF_CNT_FULL ? 0 : // end of session
                  CD | SOF_DETECT; // secondary collision
         end
      end
   end
    

   assign COLLISION = CD;

   // - - - - - - - - - - - - - - - - - - - - 
   // registered output

   reg [63:0] Qi;
   reg        Q_HDR_VALIDi, Q_PLD_VALIDi, Q_SOFi, Q_EOFi;
   reg [3:0]  D_BPi;

   always @ (posedge CLK) begin
      Q_SOFi <= (SRC_PORT==0) & (|SOF_DETECT);
      Q_EOFi <= |(D_EOF & SRC_PORT);
      Q_HDR_VALIDi <= |(D_HDR_VALID & SRC_PORT);
      Q_PLD_VALIDi <= |(D_PLD_VALID & SRC_PORT);

      Qi <= SRC_PORT[3] ? D[3] :
            SRC_PORT[2] ? D[2] :
            SRC_PORT[1] ? D[1] :
            SRC_PORT[0] ? D[0] : 64'h0;

      D_BPi <= Q_BP ? SRC_PORT : 0;
   end
   
   assign Q     = Qi;
   assign Q_HDR_VALID = Q_HDR_VALIDi;
   assign Q_PLD_VALID = Q_PLD_VALIDi;
   assign Q_SOF = Q_SOFi;
   assign Q_EOF = Q_EOFi;
   assign D_BP  = D_BPi;
   
endmodule // router_mux4
`default_nettype wire
