// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
// Date        : Sun Apr  4 23:50:29 2021
// Host        : w10-620 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/justi/OneDrive/Documents/ES-lab4/ES-lab4.srcs/sources_1/ip/picture/picture_stub.v
// Design      : picture
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_1,Vivado 2018.2" *)
module picture(clka, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[17:0],douta[7:0]" */;
  input clka;
  input [17:0]addra;
  output [7:0]douta;
endmodule
