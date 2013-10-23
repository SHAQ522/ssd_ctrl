#ifndef COMMAND_TABLE_H_
#define COMMAND_TABLE_H_

#define COMMAND_SYNC_CODE 0xEB91

#define START_PROGRAM_DISK 0x01
#define STOP_PROGRAM_DISK 0x02

#define START_PROGRAM_RAM 0x03
#define SET_FIXED_DAT 0x04

#define SET_CLK_DATA 0x05

#define SET_HEAD_DATA 0x06

#define SET_FRAME_PARA 0x07
#define SET_FRAME_READY 0x08

#define SET_CHANNEL_START 0x09
#define SET_SSD_SDRAM 0x0A
#define START_SSD_SDRAM 0x0B
#define STOP_SSD_SDRAM 0x0C
#define SET_FRAME_SCRPARA 0x0D


#define MEASURE_CLK 0x10
#define SYS_RESET_FLAG 0xff
#define HEART_BEAT_FLAG 0xaa




/****寄存器地址对应**********************************************************************************************************************/
#define CHANNEL_CHOOSE 52  //通道选择
#define WRRAM_FLAG 70  //RAM更新标志
#define FIXED_FLAG 71  //固定帧更新标志
#define HEAD_FLAG 72  //帧头更新标志
#define FRAME_FLAG 73  //帧参数更新标志
#define READY_FLAG 51  //帧数据准备标志

#define FIXED_INIT_REG 58  //固定帧计数器初值寄存器
#define FIXED_STEP_REG 59  //固定帧计数器步进值寄存器

#define HEAD_SYNC_LEN 60  //帧头同步字长度
#define HEAD_SYNC_DAT0 61  //帧头同步字0-3字节寄存器
#define HEAD_SYNC_DAT1 62  //帧头同步字4-7字节寄存器
#define HEAD_SYNC_DAT2 63  //帧头同步字8-9字节寄存器

#define HEAD_CNTR_LEN 64  //帧计数器长度寄存器
#define HEAD_CNTR_INIT0 65  //帧计数器初值0-3字节寄存器
#define HEAD_CNTR_INIT1 66  //帧计数器初值4-5字节寄存器
#define HEAD_CNTR_STEP 67  //帧计数器步进值寄存器

#define HEAD_RES_FLAG 68  //帧头备用字节标志寄存器
#define HEAD_RES_INIT 69  //帧头备用字节内容寄存器

#define HEAD_LEN_REG 54  //帧头总长度寄存器

#define FRAMEDAT_LEN_REG 53  //帧数据区长度寄存器
#define TRACE_LEN_REG 55  //正程寄存器
#define RETRACE_LEN_REG 56  //逆程寄存器
#define SOURCE_CH_REG 57  //数据源选择寄存器

#define CHANNEL_SYNC_REG  74   //
#define CHANNEL_START_REG 75  //

#define RESET_DB_REG 76  //复位寄存器
//已定义//#define UART_DB_REG 77  //串口寄存器


#define SCR_CHOOSE 79  //复位寄存器
#define SCR_UPDATE_FLAG 78  //复位寄存器
#define UNSCR_LEN 80  //复位寄存器





/****标志位变化**********************************************************************************************************************/
#define FLAG_HIGH 1
#define FLAG_LOW  0

#define RESET_DB_1 55  //复位寄存器有效
#define RESET_DB_0 0  //复位寄存器无效

typedef struct 
{
    uint8 channel;//--------------通道号
    uint8 fixed_init;//--------------固定帧初值
    uint8 fixed_step;//--------------固定帧步进值
}SetSource_para ;

typedef struct 
{
    uint8 channel;//--------------通道号
    uint8 sync_len;//--------------同步字长度
    uint32 sync_db0;//--------------同步字0-3字节
    uint32 sync_db1;//--------------同步字4-7字节
    uint32 sync_db2;//--------------同步字8-9字节
    
     uint8 cntr_len;//--------------帧计数器长度
    uint32 cntr_init0;//--------------帧计数器初值0-3字节
    uint32 cntr_init1;//--------------帧计数器初值4-5字节
     uint8 cntr_step;//--------------帧计数器步进值
     
     uint8 res_flag;//--------------备用字节标志
     uint8 res_init;//--------------备用字节内容
    
}SetHead_para ;

typedef struct 
{
    uint8 channel;//--------------通道号
    uint8 source;//--------------数据源选择00停止 01固定帧 02ram 03ssd
    uint32 framedat_len;//--------------帧数据区长度
    uint32 trace_len;//--------------正程长度
    uint32 retrace_len;//--------------逆程长度
}SetFrame_para ;

typedef struct 
{   
    uint32 dat_len;//--------------总数据长度
    uint32 lba_begin;//--------------扇区起始地址
    uint32 lba_end;//------------------扇区结束地址
}RdSSD_para ;



typedef struct 
{   
    uint8 channel;//--------------通道号
    uint32 fre_db;//--------------频率字
    uint32 fre_word;//------------------频率显示值
}TeleFre_para ;

typedef struct 
{   
    uint8 channel;//--------------通道号
    uint8 scr_choose;//--------------是否选择加扰
    uint8 unscr_len;//------------------不加扰长度
}Scr_para ;

#endif /*COMMAND_TABLE_H_*/
