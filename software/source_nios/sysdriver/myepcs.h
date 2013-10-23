#ifndef MYEPCS_H_
#define MYEPCS_H_

#include "..\driver\source_reg.h"

alt_u32 InitEPCS(void);

alt_u32 GetEPCSBlockSize(void);
alt_u32 GetEPCSBlockNum(void);

alt_u32 EraseEPCS(int offset,int length);
alt_u32 WriteEPCS(int offset,const void* src_addr,int length);
alt_u32 ReadEPCS(int offset,void* src_addr,int length);

void test_interface(void);
void CloseEPCS();




#endif /*MYEPCS_H_*/




