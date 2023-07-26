`timescale 1ns/1ps
`default_nettype none
module xpm_fifo_test
    ( input wire CLK, RST,
      
      input wire	      D_VALID,
      input wire [7:0][63:0]  D,
      output wire	      D_BP,
      
      output wire [7:0][63:0] FIFO_Q,
      input wire	      RD_EN,
      output wire	      FIFO_VALID
      );
   
   // xpm_fifo_sync: Synchronous FIFO
   // Xilinx Parameterized Macro, version 2022.2
   
   xpm_fifo_sync #(
   .CASCADE_HEIGHT(0),        // DECIMAL
   .DOUT_RESET_VALUE("0"),    // String
   .ECC_MODE("no_ecc"),       // String
   .FIFO_MEMORY_TYPE("auto"), // String
   .FIFO_READ_LATENCY(0),     // DECIMAL
   .FIFO_WRITE_DEPTH(512),    // DECIMAL
   .FULL_RESET_VALUE(0),      // DECIMAL
   .PROG_EMPTY_THRESH(10),    // DECIMAL
   .PROG_FULL_THRESH(400),    // DECIMAL
   .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
   .READ_DATA_WIDTH(512),     // DECIMAL
   .READ_MODE("fwft"),        // String
   .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES("1002"), // String
   .WAKEUP_TIME(0),           // DECIMAL
   .WRITE_DATA_WIDTH(512),    // DECIMAL
   .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
  )
   xpm_fifo_sync_inst (.data_valid(FIFO_VALID),       // 1-bit output: Read Data Valid: When asserted, this signal indicates
                                                      // that valid data is available on the output bus (dout).
      
		       .dout(FIFO_Q),                 // READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven
                                                      // when reading the FIFO.
      
		       .prog_full(D_BP),              // 1-bit output: Programmable Full: This signal is asserted when the
                                                      // number of words in the FIFO is greater than or equal to the
                                                      // programmable full threshold value. It is de-asserted when the number of
                                                      // words in the FIFO is less than the programmable full threshold value.

		       .din(D),                       // WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when
                                                      // writing the FIFO.

		       .rd_en(RD_EN),                 // 1-bit input: Read Enable: If the FIFO is not empty, asserting this
                                                      // signal causes data (on dout) to be read from the FIFO. Must be held
                                                      // active-low when rd_rst_busy is active high.
      
		       .rst(RST),                     // 1-bit input: Reset: Must be synchronous to wr_clk. The clock(s) can be
                                                      // unstable at the time of applying reset, but reset must be released only
                                                      // after the clock(s) is/are stable.

		       .wr_clk(CLK),                  // 1-bit input: Write clock: Used for write operation. wr_clk must be a
                                                      // free running clock.

		       .wr_en(D_VALID)                // 1-bit input: Write Enable: If the FIFO is not full, asserting this
                                                      // signal causes data (on din) to be written to the FIFO Must be held
                                                      // active-low when rst or wr_rst_busy or rd_rst_busy is active high

		       );	
			   
endmodule
`default_nettype wire
