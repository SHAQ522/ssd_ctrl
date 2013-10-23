
#include "..\driver\source_reg.h"
#include "..\driver\command_driver.h"
#include "command_process.h"
#include "command_table.h"
#include "send_updatedata.h"

extern SetSource_para SetSource_paraA;
extern SetHead_para  SetHead_paraA;
extern SetFrame_para SetFrame_paraA;
extern uint32     my_channel;
extern Scr_para Scr_paraA;
/***********************************************************************************************************/
void turnon_write_ramdata(void)//开始烧写数据  
{    
    IOWR(EXPORT_BASE,CHANNEL_CHOOSE,SetSource_paraA.channel);
    
    IOWR(EXPORT_BASE,WRRAM_FLAG,FLAG_LOW);    
    IOWR(EXPORT_BASE,WRRAM_FLAG,FLAG_HIGH);
    usleep(1);
    IOWR(EXPORT_BASE,WRRAM_FLAG,FLAG_LOW); 
    
    usleep(100);
    //check_ramstate();   
}
void set_fixeddata(void)
{
     IOWR(EXPORT_BASE,CHANNEL_CHOOSE,SetSource_paraA.channel);
     
     IOWR(EXPORT_BASE,FIXED_INIT_REG,SetSource_paraA.fixed_init);
     IOWR(EXPORT_BASE,FIXED_STEP_REG,SetSource_paraA.fixed_step);
     
     IOWR(EXPORT_BASE,FIXED_FLAG,FLAG_LOW);  
     IOWR(EXPORT_BASE,FIXED_FLAG,FLAG_HIGH);
     usleep(1);
     IOWR(EXPORT_BASE,FIXED_FLAG,FLAG_LOW);  
}

void set_headdata(void)
{
     uint8 temp;
     IOWR(EXPORT_BASE,CHANNEL_CHOOSE,SetHead_paraA.channel);
     
    IOWR(EXPORT_BASE,HEAD_SYNC_LEN,SetHead_paraA.sync_len);
    IOWR(EXPORT_BASE,HEAD_SYNC_DAT0,SetHead_paraA.sync_db0);
    IOWR(EXPORT_BASE,HEAD_SYNC_DAT1,SetHead_paraA.sync_db1);
    IOWR(EXPORT_BASE,HEAD_SYNC_DAT2,SetHead_paraA.sync_db2);
    IOWR(EXPORT_BASE,HEAD_CNTR_LEN,SetHead_paraA.cntr_len);
    IOWR(EXPORT_BASE,HEAD_CNTR_INIT0,SetHead_paraA.cntr_init0);
    IOWR(EXPORT_BASE,HEAD_CNTR_INIT1,SetHead_paraA.cntr_init1);
    IOWR(EXPORT_BASE,HEAD_CNTR_STEP,SetHead_paraA.cntr_step);
    IOWR(EXPORT_BASE,HEAD_RES_FLAG,SetHead_paraA.res_flag);
    IOWR(EXPORT_BASE,HEAD_RES_INIT,SetHead_paraA.res_init);
    
    temp = SetHead_paraA.res_flag + SetHead_paraA.sync_len + SetHead_paraA.cntr_len;
    IOWR(EXPORT_BASE,HEAD_LEN_REG,temp);
     
     IOWR(EXPORT_BASE,HEAD_FLAG,FLAG_LOW);  
     IOWR(EXPORT_BASE,HEAD_FLAG,FLAG_HIGH);
     usleep(1);
     IOWR(EXPORT_BASE,HEAD_FLAG,FLAG_LOW);  
}
void set_framepara(void)
{
    IOWR(EXPORT_BASE,CHANNEL_CHOOSE,SetFrame_paraA.channel);
    
    IOWR(EXPORT_BASE,FRAMEDAT_LEN_REG,SetFrame_paraA.framedat_len);
    IOWR(EXPORT_BASE,TRACE_LEN_REG,SetFrame_paraA.trace_len);
    IOWR(EXPORT_BASE,RETRACE_LEN_REG,SetFrame_paraA.retrace_len);
    IOWR(EXPORT_BASE,SOURCE_CH_REG,SetFrame_paraA.source);
    
    IOWR(EXPORT_BASE,FRAME_FLAG,FLAG_LOW);  
    IOWR(EXPORT_BASE,FRAME_FLAG,FLAG_HIGH);
    usleep(1);
    IOWR(EXPORT_BASE,FRAME_FLAG,FLAG_LOW); 
}
void set_frameready(void)
{
    //IOWR(EXPORT_BASE,CHANNEL_CHOOSE,SetSource_paraA.channel);
      
    IOWR(EXPORT_BASE,READY_FLAG,FLAG_LOW);    
    IOWR(EXPORT_BASE,READY_FLAG,FLAG_HIGH);
    usleep(1);
    IOWR(EXPORT_BASE,READY_FLAG,FLAG_LOW);   
}
void set_channelstart(void)
{
    IOWR(EXPORT_BASE,CHANNEL_SYNC_REG,my_channel);
    
    IOWR(EXPORT_BASE,CHANNEL_START_REG,FLAG_LOW);    
    IOWR(EXPORT_BASE,CHANNEL_START_REG,FLAG_HIGH);
    usleep(1);
    IOWR(EXPORT_BASE,CHANNEL_START_REG,FLAG_LOW);
    
    usleep(100);
    
    //check_channelstate();
    
}
uint32 check_channelstate(void)
{
    uint32 temp0,temp1;
    
    temp1 = IORD(EXPORT_BASE,SIGNAL_TELE_CH);
    usleep(10000);
    temp0 = IORD(EXPORT_BASE,SIGNAL_TELE_CH);
    
    while (temp0 != temp1)
    {
        temp1 = IORD(EXPORT_BASE,SIGNAL_TELE_CH);
        usleep(10000);
        temp0 = IORD(EXPORT_BASE,SIGNAL_TELE_CH); 
        usleep(10000);   
    }
//    if(temp0!=0)
//        printf("有通道在发送，发送同步字为：%8x\n",temp0);
    return temp0;
       
}
#define max_cnt 10000
#define fail_writeram 1
#define success_writeram 0
int check_ramstate(void)
{
    uint32 temp1;
    uint32 cnt=0;
    uint32 fail_flag = 0;
    temp1 = IORD(EXPORT_BASE,RAM_TELE_CH);
    switch(SetSource_paraA.channel)
    {
       case CH0:
            while(((temp1&0x00000001)==0)&&(fail_flag != fail_writeram))
            {
                temp1 = IORD(EXPORT_BASE,RAM_TELE_CH);
                usleep(10000);
                cnt++;
                if (cnt>max_cnt)
                {
                    fail_flag = fail_writeram;
                }
            }    
            // printf("通道%dRAM烧写成功\n",CH0);    
       break;  
       default:
       break;      
    }
    return fail_flag;
}
void set_scr(void)
{
     IOWR(EXPORT_BASE,CHANNEL_CHOOSE,Scr_paraA.channel);
    
    IOWR(EXPORT_BASE,SCR_CHOOSE,Scr_paraA.scr_choose);
    IOWR(EXPORT_BASE,UNSCR_LEN,Scr_paraA.unscr_len);
    
    
    IOWR(EXPORT_BASE,SCR_UPDATE_FLAG,FLAG_LOW);    
    IOWR(EXPORT_BASE,SCR_UPDATE_FLAG,FLAG_HIGH);
    usleep(1);
    IOWR(EXPORT_BASE,SCR_UPDATE_FLAG,FLAG_LOW);
}
