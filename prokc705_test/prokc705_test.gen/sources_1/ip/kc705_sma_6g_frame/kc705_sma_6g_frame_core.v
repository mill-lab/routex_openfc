 ///////////////////////////////////////////////////////////////////////////////
 //
 // Project:  Aurora 64B/66B
 // Company:  Xilinx
 //
 //
 //
 // (c) Copyright 2008 - 2009 Xilinx, Inc. All rights reserved.
 //
 // This file contains confidential and proprietary information
 // of Xilinx, Inc. and is protected under U.S. and
 // international copyright and other intellectual property
 // laws.
 //
 // DISCLAIMER
 // This disclaimer is not a license and does not grant any
 // rights to the materials distributed herewith. Except as
 // otherwise provided in a valid license issued to you by
 // Xilinx, and to the maximum extent permitted by applicable
 // law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
 // WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
 // AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
 // BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
 // INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
 // (2) Xilinx shall not be liable (whether in contract or tort,
 // including negligence, or under any other theory of
 // liability) for any loss or damage of any kind or nature
 // related to, arising under or in connection with these
 // materials, including for any direct, or any indirect,
 // special, incidental, or consequential loss or damage
 // (including loss of data, profits, goodwill, or any type of
 // loss or damage suffered as a result of any action brought
 // by a third party) even if such damage or loss was
 // reasonably foreseeable or Xilinx had been advised of the
 // possibility of the same.
 //
 // CRITICAL APPLICATIONS
 // Xilinx products are not designed or intended to be fail-
 // safe, or for use in any application requiring fail-safe
 // performance, such as life-support or safety devices or
 // systems, Class III medical devices, nuclear facilities,
 // applications related to the deployment of airbags, or any
 // other applications that could lead to death, personal
 // injury, or severe property or environmental damage
 // (individually and collectively, "Critical
 // Applications"). Customer assumes the sole risk and
 // liability of any use of Xilinx products in Critical
 // Applications, subject only to applicable laws and
 // regulations governing limitations on product liability.
 //
 // THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
 // PART OF THIS FILE AT ALL TIMES.

 //
 ///////////////////////////////////////////////////////////////////////////////
 //
 //  kc705_sma_6g_frame
 //
 //
 //
 //  Description: This is the top level interface module
 //
 //
 ///////////////////////////////////////////////////////////////////////////////

 // aurora core  file

 `timescale 1 ns / 10 ps

   (* core_generation_info = "kc705_sma_6g_frame,aurora_64b66b_v12_0_13,{c_aurora_lanes=1,c_column_used=left,c_gt_clock_1=GTXQ2,c_gt_clock_2=None,c_gt_loc_1=X,c_gt_loc_10=X,c_gt_loc_11=X,c_gt_loc_12=X,c_gt_loc_13=X,c_gt_loc_14=X,c_gt_loc_15=X,c_gt_loc_16=X,c_gt_loc_17=X,c_gt_loc_18=X,c_gt_loc_19=X,c_gt_loc_2=X,c_gt_loc_20=X,c_gt_loc_21=X,c_gt_loc_22=X,c_gt_loc_23=X,c_gt_loc_24=X,c_gt_loc_25=X,c_gt_loc_26=X,c_gt_loc_27=X,c_gt_loc_28=X,c_gt_loc_29=X,c_gt_loc_3=X,c_gt_loc_30=X,c_gt_loc_31=X,c_gt_loc_32=X,c_gt_loc_33=X,c_gt_loc_34=X,c_gt_loc_35=X,c_gt_loc_36=X,c_gt_loc_37=X,c_gt_loc_38=X,c_gt_loc_39=X,c_gt_loc_4=X,c_gt_loc_40=X,c_gt_loc_41=X,c_gt_loc_42=X,c_gt_loc_43=X,c_gt_loc_44=X,c_gt_loc_45=X,c_gt_loc_46=X,c_gt_loc_47=X,c_gt_loc_48=X,c_gt_loc_5=X,c_gt_loc_6=X,c_gt_loc_7=X,c_gt_loc_8=X,c_gt_loc_9=1,c_lane_width=4,c_line_rate=7.8125,c_gt_type=gtx,c_qpll=true,c_nfc=true,c_nfc_mode=IMM,c_refclk_frequency=156.25,c_simplex=false,c_simplex_mode=TX,c_stream=false,c_ufc=false,c_user_k=false,flow_mode=Immediate_NFC,interface_mode=Framing,dataflow_config=Duplex}" *)
(* DowngradeIPIdentifiedWarnings="yes" *)
 module kc705_sma_6g_frame_core #
 (

      parameter     STABLE_CLOCK_PERIOD = 20,            //Period of the stable clock driving this state-machine, unit is [ns]
      parameter   SIM_GTXRESET_SPEEDUP=   "TRUE",      // Set to 1 to speed up sim reset
 
      parameter CC_FREQ_FACTOR = 5'd24, // Its highly RECOMMENDED that this value be NOT changed.
                                        // Changing it to a value greater than 24 may result in soft errors.  
                                        // User may reduce to a value lower than 24 if channel needs to be 
                                        // established in noisy environment
                                        // Min value is 4.  
                                        // The current GAP in between two consecutive DO_CC posedge events is 4992 user_clk cycles.
 
     parameter   EXAMPLE_SIMULATION =   0      
      //pragma translate_off
        | 1
      //pragma translate_on
 )
 (
     // AXI TX Interface
     s_axi_tx_tdata,
     s_axi_tx_tvalid,
     s_axi_tx_tready,
     s_axi_tx_tkeep,
     s_axi_tx_tlast,
 
     // AXI RX Interface
     m_axi_rx_tdata,
     m_axi_rx_tvalid,
     m_axi_rx_tkeep,
     m_axi_rx_tlast,
 
     // Native Flow Control interface
     s_axi_nfc_tvalid,
     s_axi_nfc_tdata,
     s_axi_nfc_tready,
     
 
 
 
 

     // GTX Serial I/O
     rxp,
     rxn,
     txp,
     txn,

    // GTX Reference Clock Interface
     gt_refclk1,

     // Error Detection Interface
     hard_err,
     soft_err,

     // Status
     channel_up,
     lane_up,
     // System Interface
     mmcm_not_locked,
     user_clk,
     sync_clk,
     sysreset_to_core,
     gt_rxcdrovrden_in,
     power_down,
     loopback,
     pma_init,
     rst_drp_strt,
//---{

// I am in AURORA TOP file in 7 series port instance
    gt_qpllclk_quad3_in,
    gt_qpllrefclk_quad3_in,

    gt_to_common_qpllreset_out,
    gt_qplllock_in,//
    gt_qpllrefclklost_in,
    

//---}
     drp_clk_in,
 
    // GT DRP Ports
       drpaddr_in,
       drpdi_in,
       drpdo_out,
       drprdy_out,
       drpen_in,
       drpwe_in,



    init_clk,
    link_reset_out,



       gt_pll_lock,
       sys_reset_out,



       tx_out_clk
 );


 localparam INTER_CB_GAP = 5'd9;
 localparam BACKWARD_COMP_MODE1 = 1'b0; //disable check for interCB gap
 localparam BACKWARD_COMP_MODE2 = 1'b0; //reduce RXCDR lock time, Block Sync SH max count, disable CDR FSM in wrapper
 localparam BACKWARD_COMP_MODE3 = 1'b0; //clear hot-plug counter with any valid btf detected

 `define DLY #1

 //***********************************Port Declarations*******************************

     // TX AXI Interface
       input  [0:63]     s_axi_tx_tdata; 
       input  [0:7]      s_axi_tx_tkeep; 
       input             s_axi_tx_tlast;
       input             s_axi_tx_tvalid;
       output            s_axi_tx_tready;

     // RX AXI Interface
       output [0:63]     m_axi_rx_tdata; 
       output [0:7]      m_axi_rx_tkeep; 

       output             m_axi_rx_tlast; 
       output             m_axi_rx_tvalid;

     // Native Flow Control interface
       input              s_axi_nfc_tvalid;
       input   [0:15]     s_axi_nfc_tdata; 
       output             s_axi_nfc_tready;





     // GTX Serial I/O
       input             rxp;
       input             rxn;

       output             txp;
       output             txn;

     // GTX Reference Clock Interface
       input              gt_refclk1;

     // Error Detection Interface
       output            hard_err;
       output            soft_err;

     // Status
       output             channel_up;
       output             lane_up;

     // System Interface
       input               mmcm_not_locked;
       input               user_clk;
       input               sync_clk;
       input               sysreset_to_core;
       input               gt_rxcdrovrden_in;
       input               power_down;
       input    [2:0]      loopback;
       input               pma_init;
       input               rst_drp_strt;
       output              sys_reset_out;
//---{


    input                     gt_qpllclk_quad3_in;
    input                     gt_qpllrefclk_quad3_in;

    output                    gt_to_common_qpllreset_out;
    input                     gt_qplllock_in;//
    input                     gt_qpllrefclklost_in;//
//---}
       input    drp_clk_in;
    //---------------------- GT DRP Ports ----------------------
       output  [15:0]  drpdo_out;
       output          drprdy_out;
       input   [8:0]   drpaddr_in;
       input   [15:0]  drpdi_in;
       input           drpen_in;
       input           drpwe_in;

       output              gt_pll_lock;
       output              tx_out_clk;





       input              init_clk;
       output             link_reset_out;

 //*********************************Wire Declarations**********************************

       wire                drp_clk;
       wire                reset_neg_pma_init;
       reg                 rst_drp=1'b1;
       reg                 pma_init_r;

       wire    [0:63]     tx_d_i2;
       wire               tx_src_rdy_n_i2;
       wire               tx_dst_rdy_n_i2;
       wire    [0:2]      tx_rem_i2;
       wire    [0:2]      tx_rem_i3;
       wire               tx_sof_n_i2;
       wire               tx_eof_n_i2;
       wire    [0:63]     rx_d_i2;
       wire               rx_src_rdy_n_i2;
       wire    [0:2]      rx_rem_i2;
       wire    [0:2]      rx_rem_i3;
       wire               rx_sof_n_i2;
       wire               rx_eof_n_i2;

       wire    [0:63]     tx_d_i;
       wire               tx_src_rdy_n_i;
       wire               tx_dst_rdy_n_i;


       wire    [0:2]      tx_rem_i;
       wire               tx_sof_n_i;
       wire               tx_eof_n_i;
       wire    [0:15]     nfc_data_i;
       wire               nfc_src_rdy_n_i;
       wire               nfc_dst_rdy_n_i;

       wire    [0:63]     rx_d_i;
       wire               rx_src_rdy_n_i;

       wire    [0:2]      rx_rem_i;
       wire               rx_sof_n_i;
       wire               rx_eof_n_i;


       wire               ch_bond_done_i;
       wire               en_chan_sync_i;
       wire               chan_bond_reset_i;
       wire    [0:63]     tx_data_i;
       wire    [0:63]     rx_data_i;
       wire    [0:63]     tx_pe_data_i;
       wire               tx_pe_data_v_i;
       wire    [0:63]     rx_pe_data_i;
       wire               rx_pe_data_v_i;
       wire               channel_up_rx_if;
       wire               channel_up_tx_if;
       wire                system_reset_c;
       wire               tx_buf_err_i;
       wire               rx_lossofsync_i;
       wire               check_polarity_i;
       wire               rx_neg_i;
       wire               rx_polarity_i;
       wire               tx_header_1_i;
       wire               tx_header_0_i;
       wire               gt_pll_lock_i;
       wire               gt_pll_lock_ii;
       wire               tx_reset_i;
       wire               hard_err_i;
       wire               soft_err_i;
       wire               lane_up_i;
       wire               raw_tx_out_clk_i;
       wire               reset_lanes_i;
       wire               rx_buf_err_i;
       wire               rx_header_1_i;
       wire               rx_header_0_i;
       wire               rx_reset_i;
       wire               gen_na_idles_i;

       wire               gen_sep_i;
       wire               gen_sep7_i;



       wire               gen_snf_i;
       wire               gen_xoff_i;
       wire               gen_ch_bond_i;
       wire               got_na_idles_i;
       wire               got_idles_i;
       wire               got_cc_i;
       wire               rxdatavalid_to_ll_i;
       wire               remote_ready_i;
       wire               got_cb_i;
       wire               gen_cc_i;

       wire    [0:2]      sep_nb_i;
       wire               rx_sep_i;
       wire               rx_sep7_i;
       wire    [0:2]      rx_sep_nb_i;

       wire    [0:7]      fc_nb_i;
       wire    [0:7]      rx_fc_nb_i;

       wire               tx_wait_i;
       wire               decrement_nfc_i;
       wire               rx_snf_i;

       wire               rx_xoff_i;


     //Datavalid signal is routed to Local Link
       wire               rxdatavalid_i;
       wire               rxdatavalid_to_lanes_i;
       wire               txdatavalid_i;
       wire               txdatavalid_to_ll_i;
       wire               txdatavalid_symgen_i;
       wire               txclk_locked_c;

       wire               drp_clk_i;
       wire    [8:0] drpaddr_in_i;
       wire    [15:0]     drpdi_in_i;
       wire    [15:0]     drpdo_out_i;
       wire               drprdy_out_i;
       wire               drpen_in_i;
       wire               drpwe_in_i;


       wire               do_cc_i;
       wire               link_reset_i;
       wire               reset;
       wire               mmcm_not_locked_i;

       reg                soft_err;
       wire               sysreset_to_core_sync;
       wire               pma_init_sync;



 //*********************************Main Body of Code**********************************
     assign reset = sys_reset_out;


     // Connect top level logic
     assign channel_up  =   channel_up_rx_if;
     assign txclk_locked_c = !mmcm_not_locked ;

     always @(posedge user_clk)
       if(reset)
           soft_err  <= `DLY 1'b0;
       else
           soft_err  <= `DLY (|soft_err_i) & channel_up_tx_if;


     // Connect the TXOUTCLK of lane 0 to TX_OUT_CLK
 
       assign  tx_out_clk  =   raw_tx_out_clk_i;
 
 
 
       assign  gt_pll_lock =   gt_pll_lock_i;
       assign  rxdatavalid_to_lanes_i = |rxdatavalid_i;


       assign sysreset_to_core_sync = sysreset_to_core;

       assign pma_init_sync = pma_init;

    wire fsm_resetdone;
    // RESET_LOGIC instance
    kc705_sma_6g_frame_RESET_LOGIC core_reset_logic_i
    (
        .RESET                  (sysreset_to_core_sync),
        .USER_CLK               (user_clk),
        .INIT_CLK               (init_clk),
        .FSM_RESETDONE          (fsm_resetdone),
        .POWER_DOWN             (power_down),
        .LINK_RESET_IN          (link_reset_i),
        .SYSTEM_RESET           (sys_reset_out)
    );

 
      assign link_reset_out   =  link_reset_i;
 

     //_________________________Instantiate Lane 0______________________________

      assign         lane_up =   lane_up_i;

kc705_sma_6g_frame_AURORA_LANE aurora_lane_0_i
     (
         // TX LL
           .TX_PE_DATA(tx_pe_data_i[0:63]),
           .TX_PE_DATA_V(tx_pe_data_v_i),
           .GEN_SEP7(gen_sep7_i),
           .GEN_SEP(gen_sep_i),
           .SEP_NB(sep_nb_i[0:2]),

           .GEN_SNF(gen_snf_i),
           .GEN_XOFF(gen_xoff_i),
           .FC_NB(fc_nb_i),


           .CHANNEL_UP(channel_up_tx_if),
           .GEN_CC(gen_cc_i),

         // RX LL
           .RX_PE_DATA(rx_pe_data_i[0:63]),
           .RX_PE_DATA_V(rx_pe_data_v_i),
           .RX_SEP7(rx_sep7_i),
           .RX_SEP(rx_sep_i),
           .RX_SEP_NB(rx_sep_nb_i[0:2]),

           .RX_FC_NB(rx_fc_nb_i[0:7]),
           .RX_SNF(rx_snf_i),
           .RX_XOFF(rx_xoff_i),



         // GTX Interface
           .RX_DATA(rx_data_i[0:63]),
           .RX_HEADER_1(rx_header_1_i),
           .RX_HEADER_0(rx_header_0_i),
           .TX_BUF_ERR(|tx_buf_err_i),
           .RX_BUF_ERR(|rx_buf_err_i),
           .CHECK_POLARITY(check_polarity_i),
           .RX_NEG(rx_neg_i),
           .RX_POLARITY(rx_polarity_i),
           .RX_RESET(rx_reset_i),
           .TX_HEADER_1(tx_header_1_i),
           .TX_HEADER_0(tx_header_0_i),
           .TX_DATA(tx_data_i[0:63]),
           .TX_RESET(tx_reset_i),
           .RX_LOSSOFSYNC(rx_lossofsync_i),

         // Global Logic Interface
           .GEN_NA_IDLE(gen_na_idles_i),
           .GEN_CH_BOND(gen_ch_bond_i),
           .LANE_UP(lane_up_i),
           .HARD_ERR(hard_err_i),
           .SOFT_ERR(soft_err_i),
           .GOT_NA_IDLE(got_na_idles_i),
           .RXDATAVALID_TO_LL(rxdatavalid_to_ll_i),
           .GOT_CC(got_cc_i),
           .REMOTE_READY(remote_ready_i),
           .GOT_CB(got_cb_i),
           .GOT_IDLE(got_idles_i),

         // System Interface
           .USER_CLK(user_clk),
           .RESET_LANES(reset_lanes_i),
           .GTXRESET_IN(pma_init_sync),
           .RESET(reset),
           .TXDATAVALID_SYMGEN_IN(txdatavalid_symgen_i),
           .RXDATAVALID_IN(rxdatavalid_to_lanes_i)
     );



     //_________________________Instantiate GTX Wrapper ______________________________

kc705_sma_6g_frame_WRAPPER  #
     (
        .INTER_CB_GAP                           (INTER_CB_GAP),
        .BACKWARD_COMP_MODE1                    (BACKWARD_COMP_MODE1),
        .BACKWARD_COMP_MODE2                    (BACKWARD_COMP_MODE2),
        .BACKWARD_COMP_MODE3                    (BACKWARD_COMP_MODE3),
        .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),           // Period of the stable clock driving this state-machine, unit is [ns]
        .SIM_GTXRESET_SPEEDUP                   (SIM_GTXRESET_SPEEDUP),
        .EXAMPLE_SIMULATION                     (EXAMPLE_SIMULATION)
     )
kc705_sma_6g_frame_wrapper_i
     (




         // Aurora Lane Interface
           .CHECK_POLARITY_IN    (check_polarity_i),
           .RX_NEG_OUT           (rx_neg_i),
           .RXPOLARITY_IN        (rx_polarity_i),
           .RXRESET_IN           (rx_reset_i),
           .TXDATA_IN          (tx_data_i[0:63]),
           .TXRESET_IN           (tx_reset_i),
           .RXDATA_OUT           (rx_data_i[0:63]),
           .RXBUFERR_OUT         (rx_buf_err_i),
           .TXBUFERR_OUT         (tx_buf_err_i),

         // Global Logic Interface
           .CHBONDDONE_OUT       (ch_bond_done_i),
           .ENCHANSYNC_IN        (en_chan_sync_i),
         // Serial IO
           .RX1N_IN              (rxn),
           .RX1P_IN              (rxp),
           .TX1N_OUT             (txn),
           .TX1P_OUT             (txp),
           //-----------
           // Clocks and Clock Status
           .TXUSRCLK_IN                            (sync_clk),
           .TXUSRCLK2_IN                           (user_clk),
           .RXLOSSOFSYNC_OUT     (rx_lossofsync_i),
           .TXOUTCLK1_OUT        (raw_tx_out_clk_i),
           //-----------
           .PLLLKDET_OUT         (gt_pll_lock_i),
           //-----------
           // System Interface
           .GTXRESET_IN                            (pma_init_sync),
           //-----------
           .CHAN_BOND_RESET                        (chan_bond_reset_i),
           .LOOPBACK_IN                            (loopback),
           .CHANNEL_UP_RX_IF(channel_up_rx_if),
           .CHANNEL_UP_TX_IF(channel_up_tx_if),
           .POWERDOWN_IN                           (power_down),
           .REFCLK1_IN                             (gt_refclk1),

//---{

       .gt_qpllclk_quad3_in        (gt_qpllclk_quad3_in        ),
       .gt_qpllrefclk_quad3_in     (gt_qpllrefclk_quad3_in     ),

       .gt_to_common_qpllreset_out  (gt_to_common_qpllreset_out  ),
       .gt_qplllock_in       (gt_qplllock_in       ),
       .gt_qpllrefclklost_in (gt_qpllrefclklost_in ),
//---}
           .TXHEADER_IN({tx_header_1_i,tx_header_0_i}),
           .RXHEADER_OUT({rx_header_1_i,rx_header_0_i}),
           .RESET(reset),
           .GT_RXCDROVRDEN_IN(gt_rxcdrovrden_in),
           .FSM_RESETDONE(fsm_resetdone),
           .RXDATAVALID_OUT(rxdatavalid_i),
           .TXDATAVALID_OUT(txdatavalid_i),
           .TXCLK_LOCK(txclk_locked_c),

    //---------------------- GT DRP Ports ----------------------
	   .DRP_CLK_IN(drp_clk_in),
           .DRPADDR_IN(drpaddr_in),
	   .DRPDI_IN(drpdi_in),
           .DRPDO_OUT(drpdo_out),
           .DRPRDY_OUT(drprdy_out),
           .DRPEN_IN(drpen_in),
           .DRPWE_IN(drpwe_in),


         .INIT_CLK                      (init_clk),
         .LINK_RESET_OUT                (link_reset_i),


         .TXDATAVALID_SYMGEN_OUT        (txdatavalid_symgen_i),
           //-----------
           .RXUSRCLK2_IN                           (user_clk)
     );

     assign mmcm_not_locked_i = mmcm_not_locked;



     //__________Instantiate Global Logic to combine Lanes into a Channel______

kc705_sma_6g_frame_GLOBAL_LOGIC #
     (
        .INTER_CB_GAP(INTER_CB_GAP)
     )   global_logic_i
     (
         //GTX Interface
         .CH_BOND_DONE(ch_bond_done_i),
         .EN_CHAN_SYNC(en_chan_sync_i),
         .CHAN_BOND_RESET(chan_bond_reset_i),

         // Aurora Lane Interface
         .LANE_UP(lane_up_i),
         .HARD_ERR(hard_err_i),
         .GEN_NA_IDLES(gen_na_idles_i),
         .GEN_CH_BOND(gen_ch_bond_i),
         .RESET_LANES(reset_lanes_i),
         .GOT_NA_IDLES(got_na_idles_i),
         .GOT_CCS(got_cc_i),
         .REMOTE_READY(remote_ready_i),
         .GOT_CBS(got_cb_i),
         .GOT_IDLES(got_idles_i),

         // System Interface
         .USER_CLK(user_clk),
         .RESET(reset),
         .CHANNEL_UP_RX_IF(channel_up_rx_if),
         .CHANNEL_UP_TX_IF(channel_up_tx_if),
         .CHANNEL_HARD_ERR(hard_err),
         .TXDATAVALID_IN(txdatavalid_i)
     );

     //_____________________________ TX AXI SHIM _______________________________
     // Converts input AXI4-Stream signals to LocalLink

kc705_sma_6g_frame_AXI_TO_LL #
     (
        .DATA_WIDTH(64),
        .STRB_WIDTH(8),
        .USE_4_NFC (0),
        .REM_WIDTH (3)
     )

     axi_to_ll_data_i
     (
      .AXI4_S_IP_TX_TVALID(s_axi_tx_tvalid),
      .AXI4_S_IP_TX_TREADY(s_axi_tx_tready),
      .AXI4_S_IP_TX_TDATA(s_axi_tx_tdata),
      .AXI4_S_IP_TX_TKEEP(s_axi_tx_tkeep),
      .AXI4_S_IP_TX_TLAST(s_axi_tx_tlast),

      .LL_OP_DATA(tx_d_i),
      .LL_OP_SOF_N(tx_sof_n_i),
      .LL_OP_EOF_N(tx_eof_n_i),
      .LL_OP_REM(tx_rem_i),
      .LL_OP_SRC_RDY_N(tx_src_rdy_n_i),
      .LL_IP_DST_RDY_N(tx_dst_rdy_n_i),

      // System Interface
      .USER_CLK(user_clk),
      .CHANNEL_UP(channel_up_tx_if)
     );



kc705_sma_6g_frame_AXI_TO_LL #
     (
        .DATA_WIDTH(16),
        .STRB_WIDTH(8),
        .USE_4_NFC (1),
        .REM_WIDTH (3)
     )

     axi_to_ll_nfc_i
     (
      .AXI4_S_IP_TX_TVALID(s_axi_nfc_tvalid),
      .AXI4_S_IP_TX_TREADY(s_axi_nfc_tready),
      .AXI4_S_IP_TX_TDATA(s_axi_nfc_tdata),
      .AXI4_S_IP_TX_TKEEP(8'd0),
      .AXI4_S_IP_TX_TLAST(1'b0),

      .LL_OP_DATA(nfc_data_i),
      .LL_OP_SOF_N(),
      .LL_OP_EOF_N(),
      .LL_OP_REM(),
      .LL_OP_SRC_RDY_N(nfc_src_rdy_n_i),
      .LL_IP_DST_RDY_N(nfc_dst_rdy_n_i),

      // System Interface
      .USER_CLK(user_clk),
      .CHANNEL_UP(channel_up_tx_if)
      );



    // TX LOCALLINK
kc705_sma_6g_frame_TX_LL tx_ll_i
     (
         // LocalLink PDU Interface
         .TX_D(tx_d_i),
         .TX_SRC_RDY_N(tx_src_rdy_n_i),
         .TX_REM(tx_rem_i),
         .TX_SOF_N(tx_sof_n_i),
         .TX_EOF_N(tx_eof_n_i),
         .TX_DST_RDY_N(tx_dst_rdy_n_i),
         // NFC Interface
         .NFC_REQ_N(nfc_src_rdy_n_i),
         .NFC_PAUSE(nfc_data_i[8:15]),
         .NFC_XOFF(nfc_data_i[7]),
         .NFC_ACK_N(nfc_dst_rdy_n_i),

         // Clock Compenstaion Interface
         .DO_CC(do_cc_i),




         // Global Logic Interface
         .CHANNEL_UP(channel_up_tx_if),

         // Aurora Lane Interface
         .GEN_SEP(gen_sep_i),
         .GEN_SEP7(gen_sep7_i),
         .SEP_NB(sep_nb_i),
         .GEN_SNF(gen_snf_i),
         .GEN_XOFF(gen_xoff_i),
         .FC_NB(fc_nb_i),

         .TX_PE_DATA_V(tx_pe_data_v_i),
         .TX_PE_DATA(tx_pe_data_i),
         .GEN_CC(gen_cc_i),

         // RX_LL Interface
         .TX_WAIT(tx_wait_i),
         .DECREMENT_NFC(decrement_nfc_i),
         // System Interface
         .USER_CLK(user_clk),
         .TXDATAVALID_IN(txdatavalid_i),
         .RESET(reset_lanes_i)
    );

 //_____________________________ RX AXI SHIM _______________________________

kc705_sma_6g_frame_LL_TO_AXI #
     (
        .DATA_WIDTH(64),
        .STRB_WIDTH(8),
        .REM_WIDTH (3)
     )

     ll_to_axi_data_i
     (
      .LL_IP_DATA(rx_d_i),
      .LL_IP_SOF_N(rx_sof_n_i),
      .LL_IP_EOF_N(rx_eof_n_i),
      .LL_IP_REM(rx_rem_i),
      .LL_IP_SRC_RDY_N(rx_src_rdy_n_i),
      .LL_OP_DST_RDY_N(),

      .AXI4_S_OP_TVALID(m_axi_rx_tvalid),
      .AXI4_S_OP_TDATA(m_axi_rx_tdata),
      .AXI4_S_OP_TKEEP(m_axi_rx_tkeep),
      .AXI4_S_OP_TLAST(m_axi_rx_tlast),
      .AXI4_S_IP_TREADY(1'b0)

     );


     // RX LOCALLINK
kc705_sma_6g_frame_RX_LL rx_ll_i
    (
         // LocalLink RX Interface
         .RX_D(rx_d_i),
         .RX_SRC_RDY_N(rx_src_rdy_n_i),
         .RX_REM(rx_rem_i),
         .RX_SOF_N(rx_sof_n_i),
         .RX_EOF_N(rx_eof_n_i),
         // Aurora Lane Interface
         .RX_PE_DATA(rx_pe_data_i),
         .RX_PE_DATA_V(rx_pe_data_v_i),
         .RX_SEP(rx_sep_i),
         .RX_SEP7(rx_sep7_i),
         .RX_SEP_NB(rx_sep_nb_i),
         .RX_SNF(rx_snf_i),
         .RX_XOFF(rx_xoff_i),
         .RX_FC_NB(rx_fc_nb_i),



         .RXDATAVALID_TO_LL(rxdatavalid_to_ll_i),
           .RX_CC(got_cc_i),
         .RX_IDLE(got_idles_i),
         // Global Logic Interface
         .CHANNEL_UP(channel_up_rx_if),

         // TX_LL Interface
         .TX_WAIT(tx_wait_i),
         .DECREMENT_NFC(decrement_nfc_i),


         // System Interface
         .USER_CLK(user_clk),
         .RESET(reset_lanes_i)
    );


  
          assign drp_clk = drp_clk_in;

    always @(posedge init_clk)
    begin
        if (rst_drp_strt)
            rst_drp   <= `DLY 1'b1;
        else if (reset_neg_pma_init)
            rst_drp   <= `DLY 1'b0;
    end

    always @(posedge init_clk)
        pma_init_r    <= `DLY pma_init_sync;

    assign reset_neg_pma_init = (!pma_init_sync) & pma_init_r;


    // Standard CC Module
kc705_sma_6g_frame_STANDARD_CC_MODULE #
(
    .CC_FREQ_FACTOR (CC_FREQ_FACTOR)
)
 standard_cc_module_i
    (
         .DO_CC         (do_cc_i),
         .USER_CLK      (user_clk),
         .CHANNEL_UP    (channel_up_rx_if)
    );

 endmodule
