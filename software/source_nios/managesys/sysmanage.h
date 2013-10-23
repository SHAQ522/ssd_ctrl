#ifndef SYSMANAGE_H_
#define SYSMANAGE_H_

#define SYSCMD_FIFO_USEDW 23
#define SYSCMD_FIFO_DATA 24

#define MAXUPDATE 5
#define RESERVEUPDATE0 0
#define STARTUPDATE    1
#define SETIPVERSION   2
#define STARTCONFIG 3
#define SENDBACKINFO 4

#define EPCS_DAT_REG 26 //11    //--------------EPCS更新端口
#define EPCS_USEDW_REG 25 //12    //--------------EPCS更新查询数据端口
#define EPCS_FIFO_CLR 13    //--------------EPCS更新查询数据端口

#define CONFIG_INFO_BASE 0x600000

#define INFO_SYS_LENGTH  120

void SysManageInterface(void);
void InitSysManage(void);
void GetVersion(alt_u8* temp);
void GetIp(alt_u8* temp);





#endif /*SYSMANAGE_H_*/
