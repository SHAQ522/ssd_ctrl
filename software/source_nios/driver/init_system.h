#ifndef INIT_SYSTEM_H_
#define INIT_SYSTEM_H_

#include "source_reg.h"

/****函数**********************************************************************************************************************
void init_system();
void init_channel();

void init_clock();

extern char str_temp[1024];
extern void log_printf(char *str_in,uint8 channel);//把日志打印到jtag_uart上、上位机上

extern float freq_set;//-------------时钟频率
extern float phoffset_set;//---------时钟相位
extern void set_clock(U8 channel,float freq,float phoffset);
*******************************************************************************************************************************/
void init_net();
void init_mysystem();
void init_clock();
void show_initing();
void show_init_end();

#endif /*INIT_SYSTEM_H_*/
