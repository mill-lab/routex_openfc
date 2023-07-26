`timescale 1ns/1ps
`default_nettype none
module router # ( parameter NumPorts = 4, PassThrough=4'b0011 )
   ( input wire CLK, RST,

     input wire [NumPorts-1:0][63:0]  D,
     input wire [NumPorts-1:0] 	      D_VALID,
     output wire [NumPorts-1:0]       D_BP,

     output wire [NumPorts-1:0][63:0] Q,
     output wire [NumPorts-1:0]       Q_VALID,
     input wire [NumPorts-1:0] 	      Q_BP,
     output wire [NumPorts-1:0]       Q_SOF   // used to generate PE_RST
     );

   // RX buffer to router core
   wire [NumPorts-1:0][63:0]          Di;
   wire [NumPorts-1:0] 		      D_VALIDi, D_BPi, COLi;
   
   // Passthrough signals
   wire [NumPorts-1:0][63:0] 	      PT;
   wire [NumPorts-1:0] 		      PT_VALID;
   
   generate
      genvar                       i;

      for (i=0; i<NumPorts; i=i+1) begin : rxbuf_gen
         wire [63:0] BUF_D  = PT_VALID[i] ? PT[i] : D[i];
         wire        BUF_DV = D_VALID[i] | PT_VALID[i];

         router_rx_buf rxbuf
             ( .CLK(CLK), .RST(RST),

               .D_VALID(BUF_DV),                     // I
               .D_BP   (D_BP   [i]),                 // O
               .D      (BUF_D),    // I

               .Q_VALID(D_VALIDi[i]),                // O
               .Q_BP   (D_BPi   [i]),                // I
               .Q      (Di      [i]),   // O
               .COLLISION(COLi  [i])                 // I
               );
      end
   endgenerate
   
   router_core # (.NumPorts(NumPorts), .PassThrough(PassThrough) ) rc
     ( .CLK(CLK), .RST(RST),
      
       .D      (Di),         // I
       .D_VALID(D_VALIDi),   // I
       .D_BP   (D_BPi),      // O
       .COLLISION(COLi),     // O
       
       .PT       (PT), // O
       .PT_VALID (PT_VALID), // O
       
       .Q      (Q),          // O
       .Q_VALID(Q_VALID),    // O
       .Q_BP   (Q_BP),       // I
       .Q_SOF  (Q_SOF)       // O
      );
   

endmodule // router
`default_nettype wire
