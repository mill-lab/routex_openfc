// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2023 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: xilinx.com:ip:aurora_64b66b:12.0
// IP Revision: 13

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
kc705_sma_6g_frame your_instance_name (
  .rxp(rxp),                                          // input wire [0 : 0] rxp
  .rxn(rxn),                                          // input wire [0 : 0] rxn
  .refclk1_in(refclk1_in),                            // input wire refclk1_in
  .reset_pb(reset_pb),                                // input wire reset_pb
  .power_down(power_down),                            // input wire power_down
  .pma_init(pma_init),                                // input wire pma_init
  .loopback(loopback),                                // input wire [2 : 0] loopback
  .txp(txp),                                          // output wire [0 : 0] txp
  .txn(txn),                                          // output wire [0 : 0] txn
  .hard_err(hard_err),                                // output wire hard_err
  .soft_err(soft_err),                                // output wire soft_err
  .channel_up(channel_up),                            // output wire channel_up
  .lane_up(lane_up),                                  // output wire [0 : 0] lane_up
  .tx_out_clk(tx_out_clk),                            // output wire tx_out_clk
  .drp_clk_in(drp_clk_in),                            // input wire drp_clk_in
  .gt_pll_lock(gt_pll_lock),                          // output wire gt_pll_lock
  .s_axi_tx_tdata(s_axi_tx_tdata),                    // input wire [0 : 63] s_axi_tx_tdata
  .s_axi_tx_tkeep(s_axi_tx_tkeep),                    // input wire [0 : 7] s_axi_tx_tkeep
  .s_axi_tx_tlast(s_axi_tx_tlast),                    // input wire s_axi_tx_tlast
  .s_axi_tx_tvalid(s_axi_tx_tvalid),                  // input wire s_axi_tx_tvalid
  .s_axi_tx_tready(s_axi_tx_tready),                  // output wire s_axi_tx_tready
  .s_axi_nfc_tvalid(s_axi_nfc_tvalid),                // input wire s_axi_nfc_tvalid
  .s_axi_nfc_tdata(s_axi_nfc_tdata),                  // input wire [0 : 15] s_axi_nfc_tdata
  .s_axi_nfc_tready(s_axi_nfc_tready),                // output wire s_axi_nfc_tready
  .m_axi_rx_tdata(m_axi_rx_tdata),                    // output wire [0 : 63] m_axi_rx_tdata
  .m_axi_rx_tkeep(m_axi_rx_tkeep),                    // output wire [0 : 7] m_axi_rx_tkeep
  .m_axi_rx_tlast(m_axi_rx_tlast),                    // output wire m_axi_rx_tlast
  .m_axi_rx_tvalid(m_axi_rx_tvalid),                  // output wire m_axi_rx_tvalid
  .mmcm_not_locked_out(mmcm_not_locked_out),          // output wire mmcm_not_locked_out
  .drpaddr_in(drpaddr_in),                            // input wire [8 : 0] drpaddr_in
  .drpdi_in(drpdi_in),                                // input wire [15 : 0] drpdi_in
  .qpll_drpaddr_in(qpll_drpaddr_in),                  // input wire [7 : 0] qpll_drpaddr_in
  .qpll_drpdi_in(qpll_drpdi_in),                      // input wire [15 : 0] qpll_drpdi_in
  .drprdy_out(drprdy_out),                            // output wire drprdy_out
  .drpen_in(drpen_in),                                // input wire drpen_in
  .drpwe_in(drpwe_in),                                // input wire drpwe_in
  .qpll_drprdy_out(qpll_drprdy_out),                  // output wire qpll_drprdy_out
  .qpll_drpen_in(qpll_drpen_in),                      // input wire qpll_drpen_in
  .qpll_drpwe_in(qpll_drpwe_in),                      // input wire qpll_drpwe_in
  .drpdo_out(drpdo_out),                              // output wire [15 : 0] drpdo_out
  .qpll_drpdo_out(qpll_drpdo_out),                    // output wire [15 : 0] qpll_drpdo_out
  .init_clk(init_clk),                                // input wire init_clk
  .link_reset_out(link_reset_out),                    // output wire link_reset_out
  .user_clk_out(user_clk_out),                        // output wire user_clk_out
  .sync_clk_out(sync_clk_out),                        // output wire sync_clk_out
  .gt_qpllclk_quad3_out(gt_qpllclk_quad3_out),        // output wire gt_qpllclk_quad3_out
  .gt_qpllrefclk_quad3_out(gt_qpllrefclk_quad3_out),  // output wire gt_qpllrefclk_quad3_out
  .gt_qpllrefclklost_out(gt_qpllrefclklost_out),      // output wire gt_qpllrefclklost_out
  .gt_qplllock_out(gt_qplllock_out),                  // output wire gt_qplllock_out
  .gt_rxcdrovrden_in(gt_rxcdrovrden_in),              // input wire gt_rxcdrovrden_in
  .sys_reset_out(sys_reset_out),                      // output wire sys_reset_out
  .gt_reset_out(gt_reset_out)                        // output wire gt_reset_out
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file kc705_sma_6g_frame.v when simulating
// the core, kc705_sma_6g_frame. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

