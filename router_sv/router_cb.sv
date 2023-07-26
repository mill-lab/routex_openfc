`timescale 1ns/1ps
`default_nettype none
module router_cb # ( parameter NumPorts = 4 )
   ( input wire CLK, RST,

     input wire [NumPorts-1:0][63:0]  D,
     input wire [NumPorts-1:0][7:0]   DEST,
     input wire [NumPorts-1:0] 	      DEST_VALID, D_HDR_VALID, D_PLD_VALID, 
     input wire [NumPorts-1:0] 	      D_SOF, D_EOF,
     output wire [NumPorts-1:0]       D_BP, COLLISION,
   
     output wire [NumPorts-1:0][63:0] Q,
     output wire [NumPorts-1:0]       Q_HDR_VALID, Q_PLD_VALID, Q_SOF, Q_EOF,
     input wire [NumPorts-1:0] 	      Q_BP
     );

   wire [NumPorts-1:0][NumPorts-1:0]  D_BPi, COLi;
   
   genvar                          i;
   generate
      for (i=0; i<NumPorts; i=i+1) begin : mux_gen

         router_mux4 # ( .NumPorts(NumPorts), .PortNo(i+1) ) rm
             ( .CLK(CLK), .RST(RST),
               .D(D), 
               .DEST       (DEST),        .DEST_VALID (DEST_VALID),
               .D_HDR_VALID(D_HDR_VALID), .D_PLD_VALID(D_PLD_VALID),
               .D_SOF      (D_SOF),       .D_EOF      (D_EOF),
               .D_BP       (D_BPi[i]),
               .COLLISION  (COLi [i]),

               .Q          (Q          [i]),
               .Q_HDR_VALID(Q_HDR_VALID[i]),
               .Q_PLD_VALID(Q_PLD_VALID[i]),
               .Q_SOF      (Q_SOF      [i]),
               .Q_EOF      (Q_EOF      [i]),
               .Q_BP       (Q_BP       [i])
               );

      end
   endgenerate

   // OR'ing all D_BPi[] 
   //    assign D_BP = D_BPi[0] | D_BPi[1] | D_BPi[2] | D_BPi[3]; 

   channel_or # ( .Width(NumPorts), .NumCh(NumPorts) ) d_bp_or
     ( .D(D_BPi), .Q(D_BP) );


   channel_or # ( .Width(NumPorts), .NumCh(NumPorts) ) col_or
     ( .D(COLi), .Q(COLLISION) );
   
endmodule // router_cb


module channel_or # ( parameter Width=64, NumCh=4 )
   ( input wire [Width-1:0][NumCh-1:0] D,
     output wire [Width-1:0] Q );

   wire [Width-1:0][NumCh-1:0] TEMP;

   assign TEMP[0] = D[0];

   generate
      genvar                   i;
      for (i=1; i<NumCh; i=i+1) begin : or_gen
         assign TEMP[i] = D[i] | TEMP[i-1];
      end
   endgenerate

   assign Q = TEMP[NumCh-1];
   
endmodule // channel_or

`default_nettype wire
