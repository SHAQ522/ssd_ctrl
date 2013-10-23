
#include "..\driver\source_reg.h"
#include "sysmanage.h"
#include "updatefun.h"
#include "sysdriver\myepcs.h"



void (*pupdate_fun[MAXUPDATE])(void);  
const uint8 UpdateCmdNum = MAXUPDATE;

uint32 check_syscmd();
uint32 get_syscommand();

uint8 sys_command[32];

extern alt_u8 epcs_rec_workstate;
extern alt_u8 epcs_burn_workstate;
extern alt_u8 config_workstate;
void RegistUpdateFun(void);
void AnalyseUpdate(uint8 nID);



int checksys_command()
{
    uint32 gbit_data_to_process;
    uint32 i;
    uint32 temp_data;
    
    gbit_data_to_process = check_syscmd();//��ȡ�����������
    if(gbit_data_to_process < 16)
        return 0;
                
    usleep(1000);
    //��ȡ���ε�32�ֽ�����
    for(i=0;i<16;i++)
    {
        temp_data=get_syscommand();
        sys_command[i*2+1]=(uint8)(temp_data%256);
        sys_command[i*2]=(uint8)(temp_data/256);
        usleep(100);
    }


    if (sys_command[0]== 0x12)//�������ӿ�
    {
        //��������ӿ�
        AnalyseUpdate(sys_command[1]);
        
        return 1;
    }
    
    return -2;
}
void RegistUpdateFun(void)
{
    pupdate_fun[RESERVEUPDATE0] = &ReserveUpdate;
    pupdate_fun[STARTUPDATE] = &StartUpdate;
    pupdate_fun[SETIPVERSION] = &SetVersionIp;
    pupdate_fun[STARTCONFIG] = &StartConfigFile;
    pupdate_fun[SENDBACKINFO] = &StartBackXML;
    
}
void AnalyseUpdate(uint8 nID)
{
    if(nID<UpdateCmdNum)
    {
        SendUpdateInfo();  
        usleep(10);
        (*pupdate_fun[nID])();
               
    }
}
uint32 check_syscmd()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,SYSCMD_FIFO_USEDW);
        return temp_data;
}  
uint32 get_syscommand()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,SYSCMD_FIFO_DATA);
        return temp_data;
}  

void SysManageInterface(void)
{
        checksys_command();
        if (epcs_rec_workstate != 0)
        {
            Rec2EPCS();
        }
        if (epcs_burn_workstate != 0)
        {
            Write2EPCS();
        }
        if (epcs_burn_workstate != 0)
        {
            Write2EPCS();
        }
        if (config_workstate != 0)
        {
            RecConfig();
        }
        
}
void InitSysManage(void)
{
    RegistUpdateFun();
    InitUpdateCon();
}
/*****************************************************************************************/
/****************************��ȡ������Ϣ***************************************************/
void GetVersion(alt_u8* temp)
{
    ReadEPCS(CONFIG_INFO_BASE,temp,3);
}
void GetIp(alt_u8* temp)
{
    ReadEPCS(CONFIG_INFO_BASE + 4,temp,4);
}
/*************************************************************************************************/
