#ifndef UPDATEFUN_H_
#define UPDATEFUN_H_

#include "..\driver\source_reg.h"

void ReserveUpdate(void);
void StartUpdate(void);
void SetVersionIp(void);
void StartConfigFile(void);
void StartBackXML(void);


void SendUpdateInfo(void);
void InitUpdateCon();

void SendUpdateReq(void);//再发送数据

void Rec1Packet(void);
void Rec2EPCS(void);
void CheckRecState(void);

alt_u32 CheckUpateDat(void);
alt_u32 GetUpdateDat(void);

void ShowUpdateOver(alt_u8 id);

void ShowRecStart(alt_u32 len,alt_u8 sum);
void ShowRecOver(alt_u8 sum);
void ShowRecSuccess(void);
void ShowRecFail(void);
void ShowBurnStatus(void);

void Write2EPCS(void);
void WritEPCS1Block(void);
void CheckWritEPCS(void);

alt_u8 CheckEPCSSum(void);

void RecConfig(void);
void SendConfigReq(void);
void RecConfig(void);
void Rec1Conpack(void);
alt_u8 CheckConfigSum(void);
void ShowConfigDone(alt_u8 id);

void SenBackLen();
void str_sysupload(char *str_in);


#endif /*UPDATEFUN_H_*/
