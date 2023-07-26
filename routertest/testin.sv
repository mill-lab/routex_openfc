`default_nettype none
module testin
  (input wire CLK, RST,
   output wire [3:0][63:0] D,
   output wire [3:0] 	   D_VALID,
   output wire [3:0] 	   D_BP);

   reg [3:0][63:0] Din;
   // reg [3:0] D_VALID;

   reg [3:0] 	   STAT;
   wire [3:0] 	   STAT_NEXT = {STAT[2:0], STAT[3]};

   always @ (posedge CLK) begin
      if (RST) begin
	 Din <= 0;
	 D_VALID = 0;
	 STAT <= 'b0001;
      end else begin
	 case (STAT)
	   'b0001: begin
	      Din[0] <= 'h36af;
	      Din[1] <= 'h0;
	      Din[2] <= ;
	      Din[3] <= 1;
	      STAT <= STAT_NEXT;
	   end

	   'b0010: begin
	      Din[0] <= 'h36af;
	      Din[1] <= 'h0;
	      Din[2] <= ;
	      Din[3] <= 6;
	      STAT <= STAT_NEXT;
	   end

	   'b0100: begin
	      Din[0] <= 'h36af;
	      Din[1] <= 'h0;
	      Din[2] <= ;
	      Din[3] <= 'd1;
	      STAT <= STAT_NEXT;
	   end

	   'b1000: begin
	      Din[0] <= 'h36af;
	      Din[1] <= 'h0;
	      Din[2] <= ;
	      Din[3] <= ;
	      STAT <= STAT_NEXT;
	   end
	   default: STAT <= 1;
	 endcase // case (STAT)
      end // else: !if(RST)
   end // always @ (posedge CLK)

   assign D = Din;
   
   assign D_BP = 0;
endmodule	 
`default_nettype wire
