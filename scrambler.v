//-----------------------------------------------------------------------------
// ³ÂêØ 2012.11.28
//-----------------------------------------------------------------------------
// scrambler module for data[15:0],   lfsr[90:0]=1+x^84+x^85+x^86+x^88+x^89+x^91;
//----------------------------------------------------------------------------- 
module scrambler(
  input [15:0] data_in,
  input scram_en,
  input scram_rst,
  output reg [15:0] data_out,
  input rst,
  input clk);

  reg [90:0] lfsr_q,lfsr_c;
  reg [15:0] data_c;

  always @(*) begin
    lfsr_c[0]  = lfsr_q[0] ^ lfsr_q[5] ^ lfsr_q[6] ^ lfsr_q[75] ^ lfsr_q[77] ^ lfsr_q[80] ^ lfsr_q[78] ^ lfsr_q[79]^ lfsr_q[81] ^ lfsr_q[88]  ^ lfsr_q[85] ^ lfsr_q[86] ^ lfsr_q[87] ^ lfsr_q[90]; //-16 lfsr_q[-14] ^ lfsr_q[-13] ^ lfsr_q[-11] ^ lfsr_q[-10]  ^ lfsr_q[-9]  ^ lfsr_q[75]
    lfsr_c[1]  = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[3]  ^ lfsr_q[5]  ^ lfsr_q[76] ^ lfsr_q[78] ^ lfsr_q[81] ^ lfsr_q[79]^ lfsr_q[80]^  lfsr_q[82] ^ lfsr_q[88] ^ lfsr_q[86] ^ lfsr_q[87] ^ lfsr_q[89] ;//-15 lfsr_q[-13] ^ lfsr_q[-12] ^ lfsr_q[-10] ^ lfsr_q[-9]  ^ lfsr_q[-8]  ^ lfsr_q[76] 
    lfsr_c[2]  = lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[3] ^ lfsr_q[4]  ^ lfsr_q[6]  ^ lfsr_q[77] ^ lfsr_q[83] ^ lfsr_q[79] ^ lfsr_q[80] ^ lfsr_q[81] ^ lfsr_q[82] ^ lfsr_q[88] ^ lfsr_q[87]  ^ lfsr_q[89]   ^ lfsr_q[90] ;    //-14 lfsr_q[-12] ^ lfsr_q[-11] ^ lfsr_q[-9] ^ lfsr_q[-8]  ^ lfsr_q[-7]  ^ lfsr_q[77]
    lfsr_c[3]  = lfsr_q[0] ^ lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[78] ^ lfsr_q[84] ^ lfsr_q[80] ^ lfsr_q[81] ^ lfsr_q[82] ^ lfsr_q[83] ^ lfsr_q[88] ^ lfsr_q[89] ^ lfsr_q[90] ;  //-13 lfsr_q[-11] ^ lfsr_q[-10] ^ lfsr_q[-8] ^ lfsr_q[-7]  ^ lfsr_q[-6]  ^ lfsr_q[78]   
    lfsr_c[4]  = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[3]  ^ lfsr_q[6]  ^ lfsr_q[79] ^ lfsr_q[85] ^ lfsr_q[81] ^ lfsr_q[82] ^ lfsr_q[83] ^ lfsr_q[84] ^ lfsr_q[89] ^ lfsr_q[90]   ;//-12 lfsr_q[-10] ^ lfsr_q[-9] ^ lfsr_q[-7] ^ lfsr_q[-6]  ^ lfsr_q[-5]  ^ lfsr_q[79]
    lfsr_c[5]  = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[4] ^ lfsr_q[5]  ^ lfsr_q[6]  ^ lfsr_q[80] ^ lfsr_q[86] ^ lfsr_q[82] ^ lfsr_q[83] ^ lfsr_q[84] ^ lfsr_q[85] ^ lfsr_q[90];//-11 lfsr_q[-9] ^ lfsr_q[-8] ^ lfsr_q[-6] ^ lfsr_q[-5]  ^ lfsr_q[-4]  ^ lfsr_q[80]
    lfsr_c[6]  = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[81] ^ lfsr_q[87] ^ lfsr_q[83] ^ lfsr_q[84] ^ lfsr_q[85] ^ lfsr_q[86];  //-10 lfsr_q[-8] ^ lfsr_q[-7] ^ lfsr_q[-5] ^ lfsr_q[-4]  ^ lfsr_q[-3]  ^ lfsr_q[81]
    lfsr_c[7]  = lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[4] ^ lfsr_q[82] ^ lfsr_q[88] ^ lfsr_q[84] ^ lfsr_q[85] ^ lfsr_q[86] ^ lfsr_q[87] ;//-9 lfsr_q[-7] ^ lfsr_q[-6] ^ lfsr_q[-4] ^ lfsr_q[-3]  ^ lfsr_q[-2]  ^ lfsr_q[82]
    lfsr_c[8]  = lfsr_q[2] ^ lfsr_q[3] ^ lfsr_q[5] ^ lfsr_q[83] ^ lfsr_q[88] ^ lfsr_q[85] ^ lfsr_q[86] ^ lfsr_q[87] ^ lfsr_q[89];//-8 lfsr_q[-6] ^ lfsr_q[-5] ^ lfsr_q[-3] ^ lfsr_q[-2]  ^ lfsr_q[-1]  ^ lfsr_q[83] 
    lfsr_c[9]  = lfsr_q[3] ^ lfsr_q[4] ^ lfsr_q[6] ^ lfsr_q[84] ^ lfsr_q[88] ^ lfsr_q[86] ^ lfsr_q[87] ^ lfsr_q[89] ^ lfsr_q[90]; //-7 lfsr_q[-5] ^ lfsr_q[-4] ^ lfsr_q[-2] ^ lfsr_q[-1]  ^ lfsr_q[0]  ^ lfsr_q[84] 
    lfsr_c[10] = lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[3] ^ lfsr_q[4]  ^ lfsr_q[6]  ^ lfsr_q[85] ^ lfsr_q[88] ^ lfsr_q[87] ^ lfsr_q[89] ^ lfsr_q[90]; //-6 lfsr_q[-4] ^ lfsr_q[-3] ^ lfsr_q[-1] ^ lfsr_q[0]  ^ lfsr_q[1]  ^ lfsr_q[85]   
    lfsr_c[11] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[4]  ^ lfsr_q[6]  ^ lfsr_q[86] ^ lfsr_q[88] ^ lfsr_q[89] ^ lfsr_q[90]; //-5 lfsr_q[-3] ^ lfsr_q[-2] ^ lfsr_q[0] ^ lfsr_q[1]  ^ lfsr_q[2]  ^ lfsr_q[86]  
    lfsr_c[12] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[6] ^ lfsr_q[87] ^ lfsr_q[89] ^ lfsr_q[90];                //-4 lfsr_q[-2] ^ lfsr_q[-1] ^ lfsr_q[1] ^ lfsr_q[2]  ^ lfsr_q[3]  ^ lfsr_q[87]
    lfsr_c[13] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[5]  ^ lfsr_q[6]  ^ lfsr_q[88]  ^ lfsr_q[90];  //-3 lfsr_q[-1] ^ lfsr_q[0] ^ lfsr_q[2] ^ lfsr_q[3]  ^ lfsr_q[4]  ^ lfsr_q[88]
    lfsr_c[14] = lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[4]  ^ lfsr_q[5]  ^ lfsr_q[89];  //-2  lfsr_q[0] ^ lfsr_q[1] ^ lfsr_q[3] ^ lfsr_q[4]  ^ lfsr_q[5]  ^ lfsr_q[89]
    lfsr_c[15] = lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[4] ^ lfsr_q[5]  ^ lfsr_q[6]  ^ lfsr_q[90];  //-1  lfsr_q[1] ^ lfsr_q[2] ^ lfsr_q[4] ^ lfsr_q[5]  ^ lfsr_q[6]  ^ lfsr_q[90]    
    lfsr_c[16] = lfsr_q[0];
    lfsr_c[17] = lfsr_q[1];
    lfsr_c[18] = lfsr_q[2];
    lfsr_c[19] = lfsr_q[3];
    lfsr_c[20] = lfsr_q[4];
    lfsr_c[21] = lfsr_q[5];
    lfsr_c[22] = lfsr_q[6];
    lfsr_c[23] = lfsr_q[7];
    lfsr_c[24] = lfsr_q[8];
    lfsr_c[25] = lfsr_q[9];
    lfsr_c[26] = lfsr_q[10];
    lfsr_c[27] = lfsr_q[11];
    lfsr_c[28] = lfsr_q[12];
    lfsr_c[29] = lfsr_q[13];
    lfsr_c[30] = lfsr_q[14];
    lfsr_c[31] = lfsr_q[15];
    lfsr_c[32] = lfsr_q[16];
    lfsr_c[33] = lfsr_q[17];
    lfsr_c[34] = lfsr_q[18];
    lfsr_c[35] = lfsr_q[19];
    lfsr_c[36] = lfsr_q[20];
    lfsr_c[37] = lfsr_q[21];
    lfsr_c[38] = lfsr_q[22];
    lfsr_c[39] = lfsr_q[23];
    lfsr_c[40] = lfsr_q[24];
    lfsr_c[41] = lfsr_q[25];
    lfsr_c[42] = lfsr_q[26];
    lfsr_c[43] = lfsr_q[27];
    lfsr_c[44] = lfsr_q[28];
    lfsr_c[45] = lfsr_q[29];
    lfsr_c[46] = lfsr_q[30];
    lfsr_c[47] = lfsr_q[31];
    lfsr_c[48] = lfsr_q[32];
    lfsr_c[49] = lfsr_q[33];
    lfsr_c[50] = lfsr_q[34];
    lfsr_c[51] = lfsr_q[35];
    lfsr_c[52] = lfsr_q[36];
    lfsr_c[53] = lfsr_q[37];
    lfsr_c[54] = lfsr_q[38];
    lfsr_c[55] = lfsr_q[39];
    lfsr_c[56] = lfsr_q[40];
    lfsr_c[57] = lfsr_q[41];
    lfsr_c[58] = lfsr_q[42];
    lfsr_c[59] = lfsr_q[43];
    lfsr_c[60] = lfsr_q[44];
    lfsr_c[61] = lfsr_q[45];
    lfsr_c[62] = lfsr_q[46];
    lfsr_c[63] = lfsr_q[47];
    lfsr_c[64] = lfsr_q[48];
    lfsr_c[65] = lfsr_q[49];
    lfsr_c[66] = lfsr_q[50];
    lfsr_c[67] = lfsr_q[51];
    lfsr_c[68] = lfsr_q[52];
    lfsr_c[69] = lfsr_q[53];
    lfsr_c[70] = lfsr_q[54];
    lfsr_c[71] = lfsr_q[55];
    lfsr_c[72] = lfsr_q[56];
    lfsr_c[73] = lfsr_q[57];
    lfsr_c[74] = lfsr_q[58];
    lfsr_c[75] = lfsr_q[59];
    lfsr_c[76] = lfsr_q[60];
    lfsr_c[77] = lfsr_q[61];
    lfsr_c[78] = lfsr_q[62];
    lfsr_c[79] = lfsr_q[63];
    lfsr_c[80] = lfsr_q[64];
    lfsr_c[81] = lfsr_q[65];
    lfsr_c[82] = lfsr_q[66];
    lfsr_c[83] = lfsr_q[67];
    lfsr_c[84] = lfsr_q[68];
    lfsr_c[85] = lfsr_q[69];
    lfsr_c[86] = lfsr_q[70];
    lfsr_c[87] = lfsr_q[71];
    lfsr_c[88] = lfsr_q[72];
    lfsr_c[89] = lfsr_q[73];
    lfsr_c[90] = lfsr_q[74];

    data_c[0] = data_in[0] ^ lfsr_q[75];
    data_c[1] = data_in[1] ^ lfsr_q[76];
    data_c[2] = data_in[2] ^ lfsr_q[77]; 
    data_c[3] = data_in[3] ^ lfsr_q[78]; 
    data_c[4] = data_in[4] ^ lfsr_q[79]; 
    data_c[5] = data_in[5] ^ lfsr_q[80]; 
    data_c[6] = data_in[6] ^ lfsr_q[81] ;
    data_c[7] = data_in[7] ^ lfsr_q[82] ;    
    data_c[8] = data_in[8] ^ lfsr_q[83];
    data_c[9] = data_in[9] ^ lfsr_q[84];
    data_c[10] = data_in[10] ^ lfsr_q[85]; 
    data_c[11] = data_in[11] ^ lfsr_q[86]; 
    data_c[12] = data_in[12] ^ lfsr_q[87]; 
    data_c[13] = data_in[13] ^ lfsr_q[88]; 
    data_c[14] = data_in[14] ^ lfsr_q[89] ;
    data_c[15] = data_in[15] ^ lfsr_q[90] ;
  end // always

  always @(posedge clk, posedge rst) begin
    if(rst) begin
      lfsr_q <= {91{1'b1}};
      data_out <= {16{1'b0}};
    end
    else begin
      lfsr_q <= scram_rst ? {91{1'b1}} : scram_en ? lfsr_c : lfsr_q;
      data_out <= scram_en ? data_c : data_out;
    end
  end // always
endmodule // scrambler
