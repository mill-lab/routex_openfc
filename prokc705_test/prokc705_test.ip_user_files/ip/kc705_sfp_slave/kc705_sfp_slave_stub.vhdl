-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
-- Date        : Fri Jun 16 15:18:35 2023
-- Host        : tristar running 64-bit Ubuntu 20.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/lab/mill/kc705/prokc705_test/prokc705_test.gen/sources_1/ip/kc705_sfp_slave/kc705_sfp_slave_stub.vhdl
-- Design      : kc705_sfp_slave
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7k325tffg900-2
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kc705_sfp_slave is
  Port ( 
    s_axi_tx_tdata : in STD_LOGIC_VECTOR ( 0 to 63 );
    s_axi_tx_tlast : in STD_LOGIC;
    s_axi_tx_tkeep : in STD_LOGIC_VECTOR ( 0 to 7 );
    s_axi_tx_tvalid : in STD_LOGIC;
    s_axi_tx_tready : out STD_LOGIC;
    m_axi_rx_tdata : out STD_LOGIC_VECTOR ( 0 to 63 );
    m_axi_rx_tlast : out STD_LOGIC;
    m_axi_rx_tkeep : out STD_LOGIC_VECTOR ( 0 to 7 );
    m_axi_rx_tvalid : out STD_LOGIC;
    s_axi_nfc_tvalid : in STD_LOGIC;
    s_axi_nfc_tdata : in STD_LOGIC_VECTOR ( 0 to 15 );
    s_axi_nfc_tready : out STD_LOGIC;
    rxp : in STD_LOGIC_VECTOR ( 0 to 0 );
    rxn : in STD_LOGIC_VECTOR ( 0 to 0 );
    txp : out STD_LOGIC_VECTOR ( 0 to 0 );
    txn : out STD_LOGIC_VECTOR ( 0 to 0 );
    refclk1_in : in STD_LOGIC;
    hard_err : out STD_LOGIC;
    soft_err : out STD_LOGIC;
    channel_up : out STD_LOGIC;
    lane_up : out STD_LOGIC_VECTOR ( 0 to 0 );
    mmcm_not_locked : in STD_LOGIC;
    user_clk : in STD_LOGIC;
    sync_clk : in STD_LOGIC;
    reset_pb : in STD_LOGIC;
    gt_rxcdrovrden_in : in STD_LOGIC;
    power_down : in STD_LOGIC;
    loopback : in STD_LOGIC_VECTOR ( 2 downto 0 );
    pma_init : in STD_LOGIC;
    gt_pll_lock : out STD_LOGIC;
    drp_clk_in : in STD_LOGIC;
    gt_qpllclk_quad3_in : in STD_LOGIC;
    gt_qpllrefclk_quad3_in : in STD_LOGIC;
    gt_to_common_qpllreset_out : out STD_LOGIC;
    gt_qpllrefclklost_in : in STD_LOGIC;
    gt_qplllock_in : in STD_LOGIC;
    drpaddr_in : in STD_LOGIC_VECTOR ( 8 downto 0 );
    drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    drprdy_out : out STD_LOGIC;
    drpen_in : in STD_LOGIC;
    drpwe_in : in STD_LOGIC;
    qpll_drpaddr_in : in STD_LOGIC_VECTOR ( 7 downto 0 );
    qpll_drpdi_in : in STD_LOGIC_VECTOR ( 15 downto 0 );
    qpll_drpdo_out : out STD_LOGIC_VECTOR ( 15 downto 0 );
    qpll_drprdy_out : out STD_LOGIC;
    qpll_drpen_in : in STD_LOGIC;
    qpll_drpwe_in : in STD_LOGIC;
    init_clk : in STD_LOGIC;
    link_reset_out : out STD_LOGIC;
    sys_reset_out : out STD_LOGIC;
    tx_out_clk : out STD_LOGIC
  );

end kc705_sfp_slave;

architecture stub of kc705_sfp_slave is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "s_axi_tx_tdata[0:63],s_axi_tx_tlast,s_axi_tx_tkeep[0:7],s_axi_tx_tvalid,s_axi_tx_tready,m_axi_rx_tdata[0:63],m_axi_rx_tlast,m_axi_rx_tkeep[0:7],m_axi_rx_tvalid,s_axi_nfc_tvalid,s_axi_nfc_tdata[0:15],s_axi_nfc_tready,rxp[0:0],rxn[0:0],txp[0:0],txn[0:0],refclk1_in,hard_err,soft_err,channel_up,lane_up[0:0],mmcm_not_locked,user_clk,sync_clk,reset_pb,gt_rxcdrovrden_in,power_down,loopback[2:0],pma_init,gt_pll_lock,drp_clk_in,gt_qpllclk_quad3_in,gt_qpllrefclk_quad3_in,gt_to_common_qpllreset_out,gt_qpllrefclklost_in,gt_qplllock_in,drpaddr_in[8:0],drpdi_in[15:0],drpdo_out[15:0],drprdy_out,drpen_in,drpwe_in,qpll_drpaddr_in[7:0],qpll_drpdi_in[15:0],qpll_drpdo_out[15:0],qpll_drprdy_out,qpll_drpen_in,qpll_drpwe_in,init_clk,link_reset_out,sys_reset_out,tx_out_clk";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "aurora_64b66b_v12_0_13, Coregen v14.3_ip3, Number of lanes = 1, Line rate is double7.8125Gbps, Reference Clock is double156.25MHz, Interface is Framing, Flow Control is Immediate_NFC and is operating in DUPLEX configuration";
begin
end;
