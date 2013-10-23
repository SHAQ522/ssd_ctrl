#ifndef CLOCK_H_
#define CLOCK_H_

#endif /*CLOCK_H_*/
/*
*********************************************************************************************************
*                                              VARIABLES
*********************************************************************************************************
*/
//#include "si5338.h" 
//float freq_set;//-------------时钟频率
//float phoffset_set;//---------时钟相位

/*
*********************************************************************************************************
*                                         FUNCTION PROTOTYPES
*********************************************************************************************************
*/
void set_clock(U8 channel,float freq,float phoffset);
void updatafreq(U8 channel,float freq,float phoffset);
void pll_config(U8 channel,float freq,float phoffset);

extern void initsi5338();
extern void setfrequence(U8 site,float freq_s);




