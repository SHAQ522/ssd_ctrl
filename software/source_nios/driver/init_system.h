#ifndef INIT_SYSTEM_H_
#define INIT_SYSTEM_H_

#include "source_reg.h"

/****����**********************************************************************************************************************
void init_system();
void init_channel();

void init_clock();

extern char str_temp[1024];
extern void log_printf(char *str_in,uint8 channel);//����־��ӡ��jtag_uart�ϡ���λ����

extern float freq_set;//-------------ʱ��Ƶ��
extern float phoffset_set;//---------ʱ����λ
extern void set_clock(U8 channel,float freq,float phoffset);
*******************************************************************************************************************************/
void init_net();
void init_mysystem();
void init_clock();
void show_initing();
void show_init_end();

#endif /*INIT_SYSTEM_H_*/
