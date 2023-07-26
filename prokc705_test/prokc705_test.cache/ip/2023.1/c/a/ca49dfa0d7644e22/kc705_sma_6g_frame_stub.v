// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Fri Jun 16 15:18:33 2023
// Host        : tristar running 64-bit Ubuntu 20.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ kc705_sma_6g_frame_stub.v
// Design      : kc705_sma_6g_frame
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "aurora_64b66b_v12_0_13, Coregen v14.3_ip3, Number of lanes = 1, Line rate is double7.8125Gbps, Reference Clock is double156.25MHz, Interface is Framing, Flow Control is Immediate_NFC and is operating in DUPLEX configuration" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(s_axi_tx_tdata, s_axi_tx_tlast, 
  s_axi_tx_tkeep, s_axi_tx_tvalid, s_axi_tx_tready, m_axi_rx_tdata, m_axi_rx_tlast, 
  m_axi_rx_tkeep, m_axi_rx_tvalid, s_axi_nfc_tvalid, s_axi_nfc_tdata, s_axi_nfc_tready, rxp, 
  rxn, txp, txn, refclk1_in, hard_err, soft_err, channel_up, lane_up, user_clk_out, 
  mmcm_not_locked_out, sync_clk_out, reset_pb, gt_rxcdrovrden_in, power_down, loopback, 
  pma_init, gt_pll_lock, drp_clk_in, drpaddr_in, drpdi_in, drpdo_out, drprdy_out, drpen_in, 
  drpwe_in, qpll_drpaddr_in, qpll_drpdi_in, qpll_drpdo_out, qpll_drprdy_out, qpll_drpen_in, 
  qpll_drpwe_in, init_clk, link_reset_out, gt_qpllclk_quad3_out, gt_qpllrefclk_quad3_out, 
  gt_qpllrefclklost_out, gt_qplllock_out, sys_reset_out, gt_reset_out, tx_out_clk)
/* synthesis syn_black_box black_box_pad_pin="s_axi_tx_tdata[0:63],s_axi_tx_tlast,s_axi_tx_tkeep[0:7],s_axi_tx_tvalid,s_axi_tx_tready,m_axi_rx_tdata[0:63],m_axi_rx_tlast,m_axi_rx_tkeep[0:7],m_axi_rx_tvalid,s_axi_nfc_tvalid,s_axi_nfc_tdata[0:15],s_axi_nfc_tready,rxp[0:0],rxn[0:0],txp[0:0],txn[0:0],hard_err,soft_err,channel_up,lane_up[0:0],mmcm_not_locked_out,reset_pb,gt_rxcdrovrden_in,power_down,loopback[2:0],pma_init,gt_pll_lock,drpaddr_in[8:0],drpdi_in[15:0],drpdo_out[15:0],drprdy_out,drpen_in,drpwe_in,qpll_drpaddr_in[7:0],qpll_drpdi_in[15:0],qpll_drpdo_out[15:0],qpll_drprdy_out,qpll_drpen_in,qpll_drpwe_in,init_clk,link_reset_out,gt_qpllrefclk_quad3_out,gt_qpllrefclklost_out,gt_qplllock_out,sys_reset_out,gt_reset_out,tx_out_clk" */
/* synthesis syn_force_seq_prim="refclk1_in" */
/* synthesis syn_force_seq_prim="user_clk_out" */
/* synthesis syn_force_seq_prim="sync_clk_out" */
/* synthesis syn_force_seq_prim="drp_clk_in" */
/* synthesis syn_force_seq_prim="gt_qpllclk_quad3_out" */;
  input [0:63]s_axi_tx_tdata;
  input s_axi_tx_tlast;
  input [0:7]s_axi_tx_tkeep;
  input s_axi_tx_tvalid;
  output s_axi_tx_tready;
  output [0:63]m_axi_rx_tdata;
  output m_axi_rx_tlast;
  output [0:7]m_axi_rx_tkeep;
  output m_axi_rx_tvalid;
  input s_axi_nfc_tvalid;
  input [0:15]s_axi_nfc_tdata;
  output s_axi_nfc_tready;
  input [0:0]rxp;
  input [0:0]rxn;
  output [0:0]txp;
  output [0:0]txn;
  input refclk1_in /* synthesis syn_isclock = 1 */;
  output hard_err;
  output soft_err;
  output channel_up;
  output [0:0]lane_up;
  output user_clk_out /* synthesis syn_isclock = 1 */;
  output mmcm_not_locked_out;
  output sync_clk_out /* synthesis syn_isclock = 1 */;
  input reset_pb;
  input gt_rxcdrovrden_in;
  input power_down;
  input [2:0]loopback;
  input pma_init;
  output gt_pll_lock;
  input drp_clk_in /* synthesis syn_isclock = 1 */;
  input [8:0]drpaddr_in;
  input [15:0]drpdi_in;
  output [15:0]drpdo_out;
  output drprdy_out;
  input drpen_in;
  input drpwe_in;
  input [7:0]qpll_drpaddr_in;
  input [15:0]qpll_drpdi_in;
  output [15:0]qpll_drpdo_out;
  output qpll_drprdy_out;
  input qpll_drpen_in;
  input qpll_drpwe_in;
  input init_clk;
  output link_reset_out;
  output gt_qpllclk_quad3_out /* synthesis syn_isclock = 1 */;
  output gt_qpllrefclk_quad3_out;
  output gt_qpllrefclklost_out;
  output gt_qplllock_out;
  output sys_reset_out;
  output gt_reset_out;
  output tx_out_clk;
endmodule
