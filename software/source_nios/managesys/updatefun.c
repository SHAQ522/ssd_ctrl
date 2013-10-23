#include "updatefun.h"
#include "sysmanage.h"

#include "sysdriver\myepcs.h"

char str_temp1[INFO_SYS_LENGTH];

alt_u32 epcs_startaddr;
alt_u32 epcs_endaddr;
alt_u32 epcs_length;

alt_u32 block_size;
alt_u32 block_num;

alt_u8 epcs_rec_workstate;
alt_u8 epcs_burn_workstate;

alt_u32 buff_offset;

alt_u8 rec_sum;

#define FAIL 0
#define SUCCESS 1


#define EPCS_BUFF_SIZE 16384//65536/4
#define EPCS_BUFF_ONE 1024
#define EPCS_UNIT_SIZE 4

alt_u32 epcs_wraddr;
alt_u32* dat_buf;
extern uint8 sys_command[32];
/*****************************************************************************************/
/********************************配置文件数据缓存********************************************/
alt_u32 config_len;
alt_u32 lentemp;
alt_u32* config_buff;
alt_u8 config_sum;
alt_u32 config_offset;
alt_u8 config_workstate;
/*****************************************************************************************/
/********************************配置信息上传***********************************************/
alt_u32 info_len[1];
alt_u8* info_buff;
/*****************************************************************************************/
/********************************声明内部函数***********************************************/
alt_u32 CheckUpateDat(void);
alt_u32 GetUpdateDat(void);
void log_sysprintf(char *str_in);
void cmd_sysupload(char *str_in);
void ClrEPCSFifo();
/*****************************************************************************************/
/********************************从外部取数据***********************************************/
alt_u32 CheckUpateDat(void)
{
    alt_u32 temp_data;
    temp_data=IORD(EXPORT_BASE,EPCS_USEDW_REG);
        return temp_data;
} 
alt_u32 GetUpdateDat(void)
{
    alt_u32 temp_data;
    temp_data=IORD(EXPORT_BASE,EPCS_DAT_REG);
        return temp_data;
}
/*****************************************************************************************/
/****************************初始化********************************************************/
void InitUpdateCon()
{
    epcs_rec_workstate = 0;
    epcs_burn_workstate = 0;
    config_workstate = 0;
    buff_offset = 0;
    rec_sum = 0;
    ClrEPCSFifo();
    block_size = GetEPCSBlockSize();
    block_num = GetEPCSBlockNum();  
    InitEPCS();  
    dat_buf = NULL;
}
void ReserveUpdate(void)
{
                           
}
/*****************************************************************************************/
/****************************接收命令******************************************************/
void StartUpdate(void)
{
        
    epcs_startaddr=((uint32)(sys_command[2])*256*256*256)+((uint32)(sys_command[3])*256*256)
                    +((uint32)(sys_command[4])*256)+((uint32)(sys_command[5])*1);
    epcs_endaddr =((uint32)(sys_command[6])*256*256*256)+((uint32)(sys_command[7])*256*256)
                    +((uint32)(sys_command[8])*256)+((uint32)(sys_command[9])*1);
    epcs_length = epcs_endaddr - epcs_startaddr;
    
    rec_sum = sys_command[10];
        
    epcs_wraddr = epcs_startaddr;
    
    dat_buf = (alt_u32 *)malloc(epcs_length);//
    
    ClrEPCSFifo();
    SendUpdateReq(); 
    buff_offset = 0;  
    epcs_rec_workstate = 1;
    epcs_burn_workstate = 0;
    
    
    ShowRecStart(epcs_length,rec_sum);
    
}
/*****************************************************************************************/
/****************************接收数据******************************************************/
void Rec1Packet(void)
{
    int i;
    
    while (CheckUpateDat()<EPCS_BUFF_ONE);
    
    usleep(10);
    for(i=0;i<EPCS_BUFF_ONE;i++)
    {
        dat_buf[i+buff_offset]=GetUpdateDat();
    }
      
    buff_offset = buff_offset + EPCS_BUFF_ONE;          
}
void CheckRecState(void)
{
    alt_u8 check_temp;
    if ((buff_offset>=(epcs_length/EPCS_UNIT_SIZE))&&epcs_rec_workstate==1)
    {
        epcs_rec_workstate = 0;
        check_temp = CheckEPCSSum();
        ShowRecOver(check_temp);
        if(rec_sum == check_temp)
        {
            epcs_burn_workstate = 1;
            epcs_wraddr = 0;
            ShowRecSuccess();
        }
        else
        {
            ShowRecFail();
            epcs_burn_workstate = 0;
            epcs_wraddr = 0;
            ShowUpdateOver(FAIL);
        }
        
    }
    else if(epcs_rec_workstate==1)
    {
        SendUpdateReq();
    }
}
void Rec2EPCS(void)
{
    Rec1Packet();
       
    CheckRecState();   
}
/*****************************************************************************************/
/****************************下载程序******************************************************/
void Write2EPCS(void)
{
    WritEPCS1Block();
    epcs_wraddr = epcs_wraddr + EPCS_BUFF_SIZE*EPCS_UNIT_SIZE;
    CheckWritEPCS();
}
void WritEPCS1Block(void)
{
    //EraseEPCS(epcs_wraddr,EPCS_BUFF_SIZE*EPCS_UNIT_SIZE);
    //usleep(10);
    WriteEPCS(epcs_wraddr,dat_buf+epcs_wraddr/EPCS_UNIT_SIZE,EPCS_BUFF_SIZE*EPCS_UNIT_SIZE);
}
void CheckWritEPCS(void)
{
    if (epcs_wraddr>=epcs_length)
    {
        ShowUpdateOver(SUCCESS);
        epcs_wraddr = 0;
        epcs_burn_workstate = 0;
    }
    else
    {
        ShowBurnStatus();
    }
}
/*****************************************************************************************/
/****************************请求数据******************************************************/
void SendUpdateReq(void)//再发送1k数据
{     
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = 0x80;  
     //log_printf(str_temp1); 
     usleep(100);
     cmd_sysupload(str_temp1); 
     usleep(50);       
}
/*****************************************************************************************/
/****************************返回信息******************************************************/
void SendUpdateInfo(void)//命令接收返回值
{     
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = sys_command[1]; 
     str_temp1[2] = sys_command[2]; 
     str_temp1[3] = sys_command[3]; 
     str_temp1[4] = sys_command[4]; 
     str_temp1[5] = sys_command[5]; 
     str_temp1[6] = sys_command[6]; 
     str_temp1[7] = sys_command[7]; 
     str_temp1[8] = sys_command[8]; 
     str_temp1[9] = sys_command[9]; 
     str_temp1[10] = sys_command[10]; 
     log_sysprintf(str_temp1);      
}
void ShowUpdateOver(alt_u8 id)//表示更新完毕
{     
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = 0x81;
     str_temp1[2] = id;  
     log_sysprintf(str_temp1); 
     usleep(50);
     cmd_sysupload(str_temp1); 
     usleep(50);  
     //dat_buf = (alt_u32 *)malloc(epcs_length);//    
     free(dat_buf);   
}

void ShowRecStart(alt_u32 len,alt_u8 sum)//显示接收数据开始
{
    memset(str_temp1, 0, INFO_SYS_LENGTH);
    str_temp1[0] = 0x12;
    str_temp1[1] = 0x82;
    str_temp1[5] = len%0x100;
    str_temp1[4] = len/0x100%0x100;
    str_temp1[3] = len/0x10000%0x100;
    str_temp1[2] = len/0x1000000;
    str_temp1[6] = sum;       
    log_sysprintf(str_temp1); 
    usleep(50);
}
void ShowRecOver(alt_u8 sum)//显示接收数据结束
{
    memset(str_temp1, 0, INFO_SYS_LENGTH);
    str_temp1[0] = 0x12;
    str_temp1[1] = 0x83;
    str_temp1[2] =sum;
    log_sysprintf(str_temp1); 
    usleep(50);
}
void ShowRecSuccess(void)//显示接收数据成功
{
    memset(str_temp1, 0, INFO_SYS_LENGTH);
    str_temp1[0] = 0x12;
    str_temp1[1] = 0x84;
    log_sysprintf(str_temp1); 
    usleep(50);
}
void ShowRecFail(void)//显示接收数据失败
{
    memset(str_temp1, 0, INFO_SYS_LENGTH);
    str_temp1[0] = 0x12;
    str_temp1[1] = 0x85;
    log_sysprintf(str_temp1); 
    usleep(50);
}
void ShowBurnStatus(void)
{
     memset(str_temp1, 0, INFO_SYS_LENGTH);
    str_temp1[0] = 0x12;
    str_temp1[1] = 0x86;
    str_temp1[2] = (epcs_wraddr/0x10000*100)/(epcs_length/0x10000);
    log_sysprintf(str_temp1); 
    usleep(50);
}
/*****************************************************************************************/
/****************************计算校验******************************************************/
alt_u8 CheckEPCSSum(void)
{
    alt_u32 i;
    alt_u32 temp = 0;
    alt_u8 temp0,temp1,temp2,temp3;
    alt_u8 res;
    for(i=0;i<(epcs_length/EPCS_UNIT_SIZE);i++)
    {
        temp ^= dat_buf[i];
    }
    temp0 = temp%0x100;
    temp1 = temp/0x100%0x100;
    temp2 = temp/0x10000%0x100;
    temp3 = temp/0x1000000;
    
    res = temp0^temp1^temp2^temp3;
    return res;
}
/*****************************************************************************************/
/****************************上传网络信息******************************************************/
void log_sysprintf(char *str_in)//通用上传底层接口函数
{
     char udp_temp[1024];
     memset(udp_temp, 0, 1024);
     udp_temp[0] = 0x03;
     udp_temp[1] = 0xcc;
     udp_temp[2] = 0xfa;
     udp_temp[3] = 0xff;
     udp_temp[4] = 0xff;
     udp_temp[5] = 0xfa;
     udp_temp[6] = 0xf3;
     udp_temp[7] = 0x00;
    // memset(udp_temp,0xff,8);
     memcpy(udp_temp+8, str_in, INFO_SYS_LENGTH);
     
     sendNet(udp_temp, 1024);      
}
void cmd_sysupload(char *str_in)//通用上传底层接口函数
{
     char udp_temp[1024];
     memset(udp_temp, 0, 1024);
     udp_temp[0] = 0x03;
     udp_temp[1] = 0xcc;
     udp_temp[2] = 0xfa;
     udp_temp[3] = 0xff;
     udp_temp[4] = 0xff;
     udp_temp[5] = 0xfa;
     udp_temp[6] = 0xf3;
     udp_temp[7] = 0x01;
    // memset(udp_temp,0xff,8);
     memcpy(udp_temp+8, str_in, INFO_SYS_LENGTH);
     
     sendNet(udp_temp, 1024);      
}
/*****************************************************************************************/
void ClrEPCSFifo()
{
    IOWR(EXPORT_BASE,EPCS_FIFO_CLR,0);
    IOWR(EXPORT_BASE,EPCS_FIFO_CLR,1);
    usleep(10);
    IOWR(EXPORT_BASE,EPCS_FIFO_CLR,0);
}
/*****************************************************************************************/
/****************************下载相关配置信息************************************************/
void SetVersionIp(void)
{
    WriteEPCS(CONFIG_INFO_BASE,sys_command+2,8);
}
void StartConfigFile(void)
{
    config_len=((uint32)(sys_command[2])*256*256*256)+((uint32)(sys_command[3])*256*256)
                    +((uint32)(sys_command[4])*256)+((uint32)(sys_command[5])*1);
    lentemp = (config_len+1024)/1024*1024;
    config_buff = malloc(lentemp+4);
    ClrEPCSFifo();
    config_sum  = sys_command[6];
    config_workstate = 1;  
    config_offset = 0; 
    config_buff[0] = config_len;
    SendConfigReq();
}
void SendConfigReq(void)//再发送1k数据
{     
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = 0x90;  
     //log_printf(str_temp1); 
     usleep(100);
     cmd_sysupload(str_temp1); 
     usleep(50);       
}
void RecConfig(void)
{
    Rec1Conpack();
    if(config_offset >= lentemp/4)
    {
        config_workstate = 0;
        
        if(CheckConfigSum()==config_sum)
        {
            WriteEPCS(CONFIG_INFO_BASE+0x10000,config_buff,config_len+4);
            ShowConfigDone(SUCCESS);
        }
        else
        {
            ShowConfigDone(FAIL);
        }
    }
    else
    {
        SendConfigReq();
    }
}
void Rec1Conpack(void)
{
    int i;
    
    while (CheckUpateDat()<(EPCS_BUFF_ONE/4));
    
    usleep(10);
    for(i=0;i<(EPCS_BUFF_ONE/4);i++)
    {
        config_buff[1+i+config_offset]=GetUpdateDat();
    }
      
    config_offset = config_offset + EPCS_BUFF_ONE/4;          
}
void ShowConfigDone(alt_u8 id)//表示更新完毕
{     
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = 0x91;
     str_temp1[2] = id;  
     log_sysprintf(str_temp1); 
     usleep(50); 
     
     free(config_buff);   
}
alt_u8 CheckConfigSum(void)
{
    alt_u32 i;
    alt_u32 temp = 0;
    alt_u8 temp0,temp1,temp2,temp3;
    alt_u8 res;
    for(i=1;i<(lentemp/EPCS_UNIT_SIZE);i++)
    {
        temp ^= config_buff[i];
    }
    temp0 = temp%0x100;
    temp1 = temp/0x100%0x100;
    temp2 = temp/0x10000%0x100;
    temp3 = temp/0x1000000;
    
    res = temp0^temp1^temp2^temp3;
    return res;
}
/***********************************************************************************************/
/****************************读取配置信息*********************************************************/
void StartBackXML(void)
{
    alt_u32 cnt;
    
    
    
    ReadEPCS(CONFIG_INFO_BASE+0x10000,info_len,4); 
    info_buff = malloc((info_len[0]+512)/512*512);
    SenBackLen();
    ReadEPCS(CONFIG_INFO_BASE+0x10004,info_buff,info_len[0]); 
       
    for(cnt=0;cnt<info_len[0];cnt+=512)
    {
        str_sysupload(info_buff+cnt);
    }
    
    free(info_buff);
    
}
void SenBackLen()
{
     memset(str_temp1, 0, INFO_SYS_LENGTH);
     str_temp1[0] = 0x12;
     str_temp1[1] = 0x94;
     str_temp1[2] = info_len[0]/0x1000000; 
     str_temp1[3] = info_len[0]/0x10000%0x100;  
     str_temp1[4] = info_len[0]/0x100%0x100;  
     str_temp1[5] = info_len[0]%0x100;   
     cmd_sysupload(str_temp1); 
     usleep(50); 
}
void str_sysupload(char *str_in)
{
     char udp_temp[1024];
     memset(udp_temp, 0, 1024);
     udp_temp[0] = 'X';
     udp_temp[1] = 'M';
     udp_temp[2] = 'L';
     udp_temp[3] = 'B';
    // memset(udp_temp,0xff,8);
     memcpy(udp_temp+4, str_in, 512);
     
     sendNet(udp_temp, 1024);      
}
/***********************************************************************************************/
