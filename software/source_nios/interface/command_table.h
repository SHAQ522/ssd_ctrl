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




/****�Ĵ�����ַ��Ӧ**********************************************************************************************************************/
#define CHANNEL_CHOOSE 52  //ͨ��ѡ��
#define WRRAM_FLAG 70  //RAM���±�־
#define FIXED_FLAG 71  //�̶�֡���±�־
#define HEAD_FLAG 72  //֡ͷ���±�־
#define FRAME_FLAG 73  //֡�������±�־
#define READY_FLAG 51  //֡����׼����־

#define FIXED_INIT_REG 58  //�̶�֡��������ֵ�Ĵ���
#define FIXED_STEP_REG 59  //�̶�֡����������ֵ�Ĵ���

#define HEAD_SYNC_LEN 60  //֡ͷͬ���ֳ���
#define HEAD_SYNC_DAT0 61  //֡ͷͬ����0-3�ֽڼĴ���
#define HEAD_SYNC_DAT1 62  //֡ͷͬ����4-7�ֽڼĴ���
#define HEAD_SYNC_DAT2 63  //֡ͷͬ����8-9�ֽڼĴ���

#define HEAD_CNTR_LEN 64  //֡���������ȼĴ���
#define HEAD_CNTR_INIT0 65  //֡��������ֵ0-3�ֽڼĴ���
#define HEAD_CNTR_INIT1 66  //֡��������ֵ4-5�ֽڼĴ���
#define HEAD_CNTR_STEP 67  //֡����������ֵ�Ĵ���

#define HEAD_RES_FLAG 68  //֡ͷ�����ֽڱ�־�Ĵ���
#define HEAD_RES_INIT 69  //֡ͷ�����ֽ����ݼĴ���

#define HEAD_LEN_REG 54  //֡ͷ�ܳ��ȼĴ���

#define FRAMEDAT_LEN_REG 53  //֡���������ȼĴ���
#define TRACE_LEN_REG 55  //���̼Ĵ���
#define RETRACE_LEN_REG 56  //��̼Ĵ���
#define SOURCE_CH_REG 57  //����Դѡ��Ĵ���

#define CHANNEL_SYNC_REG  74   //
#define CHANNEL_START_REG 75  //

#define RESET_DB_REG 76  //��λ�Ĵ���
//�Ѷ���//#define UART_DB_REG 77  //���ڼĴ���


#define SCR_CHOOSE 79  //��λ�Ĵ���
#define SCR_UPDATE_FLAG 78  //��λ�Ĵ���
#define UNSCR_LEN 80  //��λ�Ĵ���





/****��־λ�仯**********************************************************************************************************************/
#define FLAG_HIGH 1
#define FLAG_LOW  0

#define RESET_DB_1 55  //��λ�Ĵ�����Ч
#define RESET_DB_0 0  //��λ�Ĵ�����Ч

typedef struct 
{
    uint8 channel;//--------------ͨ����
    uint8 fixed_init;//--------------�̶�֡��ֵ
    uint8 fixed_step;//--------------�̶�֡����ֵ
}SetSource_para ;

typedef struct 
{
    uint8 channel;//--------------ͨ����
    uint8 sync_len;//--------------ͬ���ֳ���
    uint32 sync_db0;//--------------ͬ����0-3�ֽ�
    uint32 sync_db1;//--------------ͬ����4-7�ֽ�
    uint32 sync_db2;//--------------ͬ����8-9�ֽ�
    
     uint8 cntr_len;//--------------֡����������
    uint32 cntr_init0;//--------------֡��������ֵ0-3�ֽ�
    uint32 cntr_init1;//--------------֡��������ֵ4-5�ֽ�
     uint8 cntr_step;//--------------֡����������ֵ
     
     uint8 res_flag;//--------------�����ֽڱ�־
     uint8 res_init;//--------------�����ֽ�����
    
}SetHead_para ;

typedef struct 
{
    uint8 channel;//--------------ͨ����
    uint8 source;//--------------����Դѡ��00ֹͣ 01�̶�֡ 02ram 03ssd
    uint32 framedat_len;//--------------֡����������
    uint32 trace_len;//--------------���̳���
    uint32 retrace_len;//--------------��̳���
}SetFrame_para ;

typedef struct 
{   
    uint32 dat_len;//--------------�����ݳ���
    uint32 lba_begin;//--------------������ʼ��ַ
    uint32 lba_end;//------------------����������ַ
}RdSSD_para ;



typedef struct 
{   
    uint8 channel;//--------------ͨ����
    uint32 fre_db;//--------------Ƶ����
    uint32 fre_word;//------------------Ƶ����ʾֵ
}TeleFre_para ;

typedef struct 
{   
    uint8 channel;//--------------ͨ����
    uint8 scr_choose;//--------------�Ƿ�ѡ�����
    uint8 unscr_len;//------------------�����ų���
}Scr_para ;

#endif /*COMMAND_TABLE_H_*/
