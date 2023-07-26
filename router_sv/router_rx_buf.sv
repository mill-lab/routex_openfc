`timescale 1ns/1ps
`default_nettype none
module router_rx_buf
  ( input wire CLK, RST,

    input wire         D_VALID,
    input wire [63:0]  D,
    output wire        D_BP,

    output wire        Q_VALID,
    output wire [63:0] Q,
    input wire         Q_BP,
    input wire         COLLISION
   );

   wire [63:0]         FIFO_Q;
   wire                RD_EN;
   wire                FIFO_VALID;
   
   fwft_64x512_afull fwft 
     ( .clk(CLK), .srst(RST), 
       .din (D), .wr_en(D_VALID), .prog_full(D_BP), 
       .dout(FIFO_Q), .valid(FIFO_VALID), .rd_en(RD_EN)
        );


   // EOF detector
   reg [31:0]          Q_TOGO, Q_TOGO_R;
   wire                EOF = (Q_VALID & Q_TOGO==1);
   
   always @ (posedge CLK) begin
      if (RST | COLLISION) begin
         Q_TOGO <= 0;
      end else begin
         if (Q_VALID) begin
            if (Q_TOGO==0) begin
               Q_TOGO   <=  (Q[63:56]!=8'h01) ? Q[31:0] : 0;
            end else begin
               Q_TOGO <= Q_TOGO - 1;
            end
         end
      end
   end

   // Write to Backup

   reg                 COLLISION_R;
   reg [63:0]          BUP [0:15];
   reg [3:0]           BUP_WA, BUP_WA_R; // address for 16 words
   reg                 RE_TX;
   
   always @ (posedge CLK) begin
      COLLISION_R <= COLLISION;
      
      if (RST) begin
         BUP_WA <= 0;
         BUP_WA_R <= 8'hff;
         RE_TX  <= 0;
      end else begin
         if (EOF) begin
            BUP_WA <= 0;
            BUP_WA_R <= 8'hff;
            RE_TX  <= 0;
         end else begin
            if (COLLISION)  RE_TX <= 1;

//          if (~COLLISION & Q_VALID & ~RE_TX) begin
            if (~COLLISION_R & COLLISION) begin
               BUP_WA_R <= BUP_WA;
               BUP_WA <= 0;
            end else         if (~COLLISION & Q_VALID & ~&BUP_WA) begin
               BUP_WA <= BUP_WA+1;
               BUP[BUP_WA] <= Q;
            end
         end
      end
   end

   // Read from Backup

   reg [3:0] BUP_RA;
   
   always @ (posedge CLK) begin
      if (RST) begin
         BUP_RA <= 0;
      end else begin
         if (COLLISION | EOF)
           BUP_RA <= 0;
         else begin
            if (RE_TX) begin
               if(~Q_BP & (BUP_RA != BUP_WA_R)) BUP_RA <= BUP_RA+1;
            end
         end
      end
   end

   wire RE_TX_DONE = RE_TX & (BUP_WA_R==BUP_RA);
   
   assign RD_EN = ~Q_BP & ~COLLISION & (RE_TX ? RE_TX_DONE : 1);

   assign Q = (RE_TX & ~RE_TX_DONE) ? BUP[BUP_RA]  : FIFO_Q;
   assign Q_VALID = RD_EN & FIFO_VALID | (RE_TX & ~COLLISION & ~Q_BP & BUP_WA_R!=BUP_RA) ;

endmodule
`default_nettype wire
