`timescale 1ns/1ps
`default_nettype none

module router_sink
  ( input wire CLK, RST,

    // Router ports
    input wire [63:0] D,
    input wire        D_VALID,

    output reg [7:0]  DEST,
    output wire       DEST_VALID,
  
    output reg        SOF, EOF,
    output reg [63:0] FRAME,
    output reg        HEADER_VALID,
    output reg        PAYLOAD_VALID
    );

   // Receiver state machine
   reg [2:0]          STAT, STAT_R; // idle (dest), header, payload
   reg [31:0]         D_TOGO;
   
   always @ (posedge CLK) begin
      STAT_R <= STAT;
      
      if (RST) begin
         STAT <= 3'b001;
         SOF <= 0;
         EOF <= 0;
         D_TOGO <= 0;
      end else begin
         case (STAT)
           3'b001: begin
              EOF <= 0;
              PAYLOAD_VALID <= 0;
              
              if (D_VALID) begin
                 STAT <= 3'b010;
                 DEST <= D[7:0];
                 SOF <= 1;
              end end

           3'b010: begin
              SOF <= 0;
              
              if (D_VALID & (D[63:56] != 8'h01)) begin
                 D_TOGO <= D[31:0];
                 STAT <= 3'b100;
              end

              HEADER_VALID <= (D_VALID & (D[63:56] == 8'h01));
              PAYLOAD_VALID <= (D_VALID & (D[63:56] == 8'h00));
              FRAME <= D;
           end

           3'b100: begin
              if (D_VALID) begin
                 D_TOGO <= D_TOGO -1;
                 if (D_TOGO == 1) begin
                    STAT <= 3'b001;
                    EOF <= 1;
                 end
              end 

              PAYLOAD_VALID <= D_VALID;
              FRAME <= D;
           end
           
           default: begin
              STAT <= 3'b001; end
         endcase
      end
   end

   assign DEST_VALID = |STAT[2:1] | STAT_R[2];
   
endmodule

`default_nettype wire
