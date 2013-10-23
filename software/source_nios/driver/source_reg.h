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
    uint8 channel;//--------------通道号
    uint32 neg_length;//----------逆程长度
    uint32 data_length;//---------正程长度
    uint32 out_en;//--------------输出使能极性
    uint32 frame_count;//---------帧数
    uint32 flag_mode;//-----------使能模式
    uint32 data_mode;//-----------数据位宽
    uint32 syn_mode;//------------同步模式
    uint32 syn_key;//-------------同步信号
}Source_para ;
Source_para Source_paraA;



typedef struct 
{
    uint32 lba_begin;//-----------硬盘起始扇区
    uint32 lba_end;//-------------硬盘终止扇区
    uint32 write_lba_begin;//-----写硬盘起始扇区
    uint32 write_lba_end;//-------写硬盘终止扇区
}Disk_Para ;

Disk_Para Disk_ParaGlobal;

typedef struct 
{
    uint8 channel;//--------------通道号
    float fre_set;//-----------时钟频率
    float pho_set;//-----------时钟相位
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

//读寄存器地址
#define COMMAND_FIFO_USEDW   0  //-------------------命令FIFO个数
#define COMMAND_FIFO_DATA    1  //-------------------命令FIFO数据
#define SYSTEM_STATE         2  //-------------------系统状态
#define GIGE_COUNT           3  //-------------------烧写数据状态
#define SDRAM_WR_DONE        4  //-------------------SDRAM写结束

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

#define UART_DB_REG 77  //串口寄存器

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

//写寄存器地址
/****MAC控制********************************************************************************************************************/
#define MAC_RESET          1 //------------MAC IP core 复位，NIOS地址为1
#define PACKET_SIZE        2 //------------UDP数据一包的长度，NIOS地址为80
#define START_SEND         3 //------------UDP数据发送信号，持续1个回合，NIOS地址为81
/****通道控制********************************************************************************************************************/
#define SRC_MODE_FRAME     4//-------------通道选择 模式1 固定帧格式
#define SRC_MODE_RAM       5//-------------通道选择 模式2 1KB文件数据
#define SRC_MODE_IDE       6//-------------通道选择 模式3 硬盘数据
#define SRC_CHANNEL_PARA   7//-------------通道选择 参数
#define SRC_BEGIN_SEND     10//------------开始/停止发送
#define SRC_SEND_RESET     11//------------复位/置位发送模块
#define SRC_DATA_LENGTH    12//------------输出正程长度---预留30个通道位置
#define SRC_BLANK_LENGTH   13//------------输出逆程长度---预留30个通道位置
#define SRC_OUT_EN         14//------------输出使能极性---预留30个通道位置
#define SRC_MODE           15//------------输出方式---预留30个通道位置 （0）固定帧格式  （1）1KB文件数据  （2）硬盘数据
#define SRC_DATA_MODE      16//------------发送数据宽度
#define SRC_FLAG_MODE      17//------------使能模式 FLAG CT 无使能
#define SRC_SYN_MODE       18//------------同步模式 自同步、外同步

#define SRC_BEGIN_SET      20//------------开始/停止设置数据

#define SRC_SYN_KEY        21//-----------同步信号

/****相位调整********************************************************************************************************************/
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
/****固定帧格式********************************************************************************************************************/
#define LOAD_HEAD      200
#define LOAD_FLAG      201
#define LOAD_LENGTH    202
#define LOAD_SCRAMBLE  203

/****时钟控制********************************************************************************************************************/
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

/****硬盘数据**********************************************************************************************************************/
#define LBA_BEGIN           250 //------------------硬盘起始扇区：32bit
#define LBA_END             251 //------------------硬盘终止扇区：32bit
#define IDE_WR              252 //------------------硬盘开始写/停止写：1bit
#define IDE_RD              253 //------------------硬盘开始读/停止读：1bit
#define IDE_OPEN            254 //------------------硬盘开始/关闭数据源：1bit
#define IDE_RESET           255 //------------------硬盘开始/关闭数据源：1bit
#define SDRAM_RESET         257 //------------------复位/置位发送模块：1bit

#define WRADDR_BEGIN        260 //-------------------SDRAM写起始地址：16bit
#define WRADDR_END          261 //-------------------SDRAM写终止地址：16bit
#define RDADDR_BEGIN        262 //-------------------SDRAM读起始地址：16bit
#define RDADDR_END          263 //-------------------SDRAM读终止地址：16bit
#define SDRAM_WR            264 //-------------------SDRAM读起始地址：16bit
#define SDRAM_RD            265 //-------------------SDRAM读终止地址：16bit
#define FRAME_LENGTH        266 //-------------------一帧图像大小：32bit
#define SDRAM_LENGTH        267 //-------------------SDRAM数据大小：32bit

/****函数**********************************************************************************************************************
void init_system();
void init_channel();
void init_net();
void init_clock();

extern char str_temp[1024];
extern void log_printf(char *str_in,uint8 channel);//把日志打印到jtag_uart上、上位机上

extern float freq_set;//-------------时钟频率
extern float phoffset_set;//---------时钟相位
extern void set_clock(U8 channel,float freq,float phoffset);
*******************************************************************************************************************************/

#endif /*SOURCE_REG_H_*/
