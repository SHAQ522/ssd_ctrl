#ifndef SOURCE_REG_H_
#define SOURCE_REG_H_

#define uint8 alt_u8
#define uint16 alt_u16
#define uint32 alt_u32
#define uint64 alt_u64

//#include "system.h"
//#include "stdio.h"
//#include "alt_types.h"
//#include "io.h"
//#include "sys/alt_irq.h"
//#include "utilities.h"
//#include "unistd.h"
//#include "UDPCore.h"
//#include "altera_avalon_pio_regs.h"
//#include "math.h"
//#include "init_system.h"

#include "system.h"
#include "sys/alt_sys_init.h"
#include "stdio.h"
#include "alt_types.h"
#include "io.h"
#include "sys/alt_irq.h"
#include "utilities.h"
#include "unistd.h"
#include "UDPCore.h"
#include "altera_avalon_pio_regs.h"
#include "math.h"
#include "init_system.h"
#include "string.h"
#include "stdlib.h"

//#include "clock.h"
//#include "si5338.h" 


typedef struct 
{
    uint8 channel;//--------------ͨ����
    uint32 neg_length;//----------��̳���
    uint32 data_length;//---------���̳���
    uint32 out_en;//--------------���ʹ�ܼ���
    uint32 frame_count;//---------֡��
    uint32 flag_mode;//-----------ʹ��ģʽ
    uint32 data_mode;//-----------����λ��
    uint32 syn_mode;//------------ͬ��ģʽ
    uint32 syn_key;//-------------ͬ���ź�
}Source_para ;
Source_para Source_paraA;



typedef struct 
{
    uint32 lba_begin;//-----------Ӳ����ʼ����
    uint32 lba_end;//-------------Ӳ����ֹ����
    uint32 write_lba_begin;//-----дӲ����ʼ����
    uint32 write_lba_end;//-------дӲ����ֹ����
}Disk_Para ;

Disk_Para Disk_ParaGlobal;

typedef struct 
{
    uint8 channel;//--------------ͨ����
    float fre_set;//-----------ʱ��Ƶ��
    float pho_set;//-----------ʱ����λ
}Clk_Para ;

Clk_Para Clk_ParaGlobal;

#define CHNUM        15
#define CHOFFSET     1

#define CH0        0 
#define CH1        1
#define CH2        2
#define CH3        3
#define CH4        4
#define CH5        5
#define CH6        6
#define CH7        7
#define CH8        8 
#define CH9        9
#define CH10       10
#define CH11       11
#define CH12       12
#define CH13       13
#define CH14       14
#define CH15       15

#define true    1 
#define false   0
#define on      1 
#define off     0
#define HIGH    1 
#define LOW     0

#define framemode 0
#define rammode 1
#define idemode 2

#define invalid_channel 255

//���Ĵ�����ַ
#define COMMAND_FIFO_USEDW   0  //-------------------����FIFO����
#define COMMAND_FIFO_DATA    1  //-------------------����FIFO����
#define SYSTEM_STATE         2  //-------------------ϵͳ״̬
#define GIGE_COUNT           3  //-------------------��д����״̬
#define SDRAM_WR_DONE        4  //-------------------SDRAMд����

#define SIGNAL_TELE_CH        10 
#define RAM_TELE_CH        11 
#define UART_FIFO_NUM        12 

#define FREQ_TELE_CH0        50 
#define FREQ_TELE_CH1        51 
#define FREQ_TELE_CH2        52 
#define FREQ_TELE_CH3        53 
#define FREQ_TELE_CH4        54 
#define FREQ_TELE_CH5        55 
#define FREQ_TELE_CH6        56 
#define FREQ_TELE_CH7        57 
#define FREQ_TELE_CH8        58 
#define FREQ_TELE_CH9        59
#define FREQ_TELE_CH10        60 
#define FREQ_TELE_CH11        61 

#define UART_DB_REG 77  //���ڼĴ���

#define PHASE_TELE_CH0        100 
#define PHASE_TELE_CH1        101 
#define PHASE_TELE_CH2        102 
#define PHASE_TELE_CH3        103 
#define PHASE_TELE_CH4        104 
#define PHASE_TELE_CH5        105 
#define PHASE_TELE_CH6        106 
#define PHASE_TELE_CH7        107 
#define PHASE_TELE_CH8        108 
#define PHASE_TELE_CH9        109 

//д�Ĵ�����ַ
/****MAC����********************************************************************************************************************/
#define MAC_RESET          1 //------------MAC IP core ��λ��NIOS��ַΪ1
#define PACKET_SIZE        2 //------------UDP����һ���ĳ��ȣ�NIOS��ַΪ80
#define START_SEND         3 //------------UDP���ݷ����źţ�����1���غϣ�NIOS��ַΪ81
/****ͨ������********************************************************************************************************************/
#define SRC_MODE_FRAME     4//-------------ͨ��ѡ�� ģʽ1 �̶�֡��ʽ
#define SRC_MODE_RAM       5//-------------ͨ��ѡ�� ģʽ2 1KB�ļ�����
#define SRC_MODE_IDE       6//-------------ͨ��ѡ�� ģʽ3 Ӳ������
#define SRC_CHANNEL_PARA   7//-------------ͨ��ѡ�� ����
#define SRC_BEGIN_SEND     10//------------��ʼ/ֹͣ����
#define SRC_SEND_RESET     11//------------��λ/��λ����ģ��
#define SRC_DATA_LENGTH    12//------------������̳���---Ԥ��30��ͨ��λ��
#define SRC_BLANK_LENGTH   13//------------�����̳���---Ԥ��30��ͨ��λ��
#define SRC_OUT_EN         14//------------���ʹ�ܼ���---Ԥ��30��ͨ��λ��
#define SRC_MODE           15//------------�����ʽ---Ԥ��30��ͨ��λ�� ��0���̶�֡��ʽ  ��1��1KB�ļ�����  ��2��Ӳ������
#define SRC_DATA_MODE      16//------------�������ݿ��
#define SRC_FLAG_MODE      17//------------ʹ��ģʽ FLAG CT ��ʹ��
#define SRC_SYN_MODE       18//------------ͬ��ģʽ ��ͬ������ͬ��

#define SRC_BEGIN_SET      20//------------��ʼ/ֹͣ��������

#define SRC_SYN_KEY        21//-----------ͬ���ź�

/****��λ����********************************************************************************************************************/
#define PLL_CONFIG_START1   30
#define PLL_CONFIG_START2   31
#define PLL_CONFIG_START3   32
#define PLL_CONFIG_START4   33
#define PLL_CONFIG_START5   34
#define PLL_CONFIG_START6   35
#define PLL_CONFIG_START7   36
#define PLL_CONFIG_START8   37

#define PLL_CONFIG_PHASETAP          40
#define PLL_CONFIG_M_SET             41
#define PLL_CONFIG_C0_HIGH_SET       42
#define PLL_CONFIG_C0_LOW_SET        43
#define PLL_CONFIG_CHARGE_PUMP       44
#define PLL_CONFIG_LOWPASS_FILTER_R  45
#define PLL_CONFIG_LOWPASS_FILTER_C  46
#define PLL_CONFIG_N                 47
#define PLL_CONFIG_PHASE_POSEDGE     48
/****�̶�֡��ʽ********************************************************************************************************************/
#define LOAD_HEAD      200
#define LOAD_FLAG      201
#define LOAD_LENGTH    202
#define LOAD_SCRAMBLE  203

/****ʱ�ӿ���********************************************************************************************************************/
#define CLK_SEL_CH0           280 
#define CLK_SEL_CH1           281 
#define CLK_SEL_CH2           282 
#define CLK_SEL_CH3           283 
#define CLK_SEL_CH4           284
#define CLK_SEL_CH5           285 
#define CLK_SEL_CH6           286 
#define CLK_SEL_CH7           287 
#define CLK_SEL_CH8           288
#define CLK_SEL_CH9           289 
#define CLK_SEL_CH10          290 
#define CLK_SEL_CH11          291

/****Ӳ������**********************************************************************************************************************/
#define LBA_BEGIN           250 //------------------Ӳ����ʼ������32bit
#define LBA_END             251 //------------------Ӳ����ֹ������32bit
#define IDE_WR              252 //------------------Ӳ�̿�ʼд/ֹͣд��1bit
#define IDE_RD              253 //------------------Ӳ�̿�ʼ��/ֹͣ����1bit
#define IDE_OPEN            254 //------------------Ӳ�̿�ʼ/�ر�����Դ��1bit
#define IDE_RESET           255 //------------------Ӳ�̿�ʼ/�ر�����Դ��1bit
#define SDRAM_RESET         257 //------------------��λ/��λ����ģ�飺1bit

#define WRADDR_BEGIN        260 //-------------------SDRAMд��ʼ��ַ��16bit
#define WRADDR_END          261 //-------------------SDRAMд��ֹ��ַ��16bit
#define RDADDR_BEGIN        262 //-------------------SDRAM����ʼ��ַ��16bit
#define RDADDR_END          263 //-------------------SDRAM����ֹ��ַ��16bit
#define SDRAM_WR            264 //-------------------SDRAM����ʼ��ַ��16bit
#define SDRAM_RD            265 //-------------------SDRAM����ֹ��ַ��16bit
#define FRAME_LENGTH        266 //-------------------һ֡ͼ���С��32bit
#define SDRAM_LENGTH        267 //-------------------SDRAM���ݴ�С��32bit

/****����**********************************************************************************************************************
void init_system();
void init_channel();
void init_net();
void init_clock();

extern char str_temp[1024];
extern void log_printf(char *str_in,uint8 channel);//����־��ӡ��jtag_uart�ϡ���λ����

extern float freq_set;//-------------ʱ��Ƶ��
extern float phoffset_set;//---------ʱ����λ
extern void set_clock(U8 channel,float freq,float phoffset);
*******************************************************************************************************************************/

#endif /*SOURCE_REG_H_*/
