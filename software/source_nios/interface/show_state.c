#include "..\driver\source_reg.h"
#include "..\driver\command_driver.h"
#include "command_process.h"
#include "command_table.h"
#include "send_updatedata.h"

extern TeleFre_para TeleFre_paraA;

void measure_clock(void)
{
    //uint32 temp_data;
    switch (TeleFre_paraA.channel)
    {
        case CH0 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH0);
        case CH1 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH1);
        case CH2 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH2);
        case CH3 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH3); 
        case CH4 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH4);
        case CH5 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH5);
        case CH6 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH6);
        case CH7 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH7);  
        case CH8 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH8);
        case CH9 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH9);
        case CH10 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH10);
        case CH11 :
            TeleFre_paraA.fre_db = IORD(EXPORT_BASE,FREQ_TELE_CH11);    
        break;
        
        default:
        break;
    }
     //printf("通道%d时钟频率为：%fMHz\n",TeleFre_paraA.channel,(float)( TeleFre_paraA.fre_db/100000.0));
}
void reset_fun(void)
{
     IOWR(EXPORT_BASE,RESET_DB_REG,RESET_DB_1);   
     usleep(5);
     IOWR(EXPORT_BASE,RESET_DB_REG,RESET_DB_0);    
}

