
#include "..\driver\source_reg.h"
#include "..\driver\command_driver.h"
#include "..\driver\clock.h"
#include "command_process.h"
#include "command_table.h"
#include "send_idedata.h"
#include "send_updatedata.h"
#include "show_state.h"
//#include "send_frame.h"
//#include "send_ramdata.h"
//#include "send_idedata.h"

SetSource_para SetSource_paraA;
SetHead_para  SetHead_paraA;
SetFrame_para SetFrame_paraA;
uint32     my_channel;
RdSSD_para RdSSD_paraA;
TeleFre_para TeleFre_paraA;
Scr_para Scr_paraA;

int check_command()
{
    uint32 gbit_data_to_process;
    uint32 i;
    uint32 temp_data;
    uint32 sync_data;
    
    gbit_data_to_process = check_cmd();//��ȡ1394�������������
    if(gbit_data_to_process < 16)
        return 0;
        
    sync_data = get_command();
    if(sync_data != COMMAND_SYNC_CODE)
        return -1;
        
    usleep(1000);
    //��ȡ���ε�62�ֽ�����
    for(i=0;i<15;i++)
    {
        temp_data=get_command();
        gbit_data_to_process=IORD(EXPORT_BASE,COMMAND_FIFO_USEDW);
        now_command[i*2+1]=(uint8)(temp_data%256);
        now_command[i*2]=(uint8)(temp_data/256);
        usleep(1000);
    }
    if (now_command[0]== 0x01&&now_command[1]== 0x01)
    {
        printf("��ʼ��дӲ������\n");
        return START_PROGRAM_DISK; 
    }
    if (now_command[0]== 0x01&&now_command[1]== 0x02)
    {
        printf("������дӲ������\n");
        return STOP_PROGRAM_DISK; 
    }
    if (now_command[0]== 0x02&&now_command[1]== 0x01)
    {
        return START_PROGRAM_RAM; 
    }
    if (now_command[0]== 0x02&&now_command[1]== 0x02)
    {
        return SET_FIXED_DAT; 
    }
    if (now_command[0]== 0x03&&now_command[1]== 0x01)
    {
        return SET_CLK_DATA; 
    }
     if (now_command[0]== 0x04&&now_command[1]== 0x01)
    {
        return SET_HEAD_DATA; 
    }
     if (now_command[0]== 0x05&&now_command[1]== 0x01)
    {
        return SET_SSD_SDRAM; 
    }
     if (now_command[0]== 0x05&&now_command[1]== 0x02)
    {
        return START_SSD_SDRAM; 
    }
     if (now_command[0]== 0x05&&now_command[1]== 0x03)
    {
        return STOP_SSD_SDRAM; 
    }
    
    if (now_command[0]== 0x06&&now_command[1]== 0x01)
    {
        return SET_FRAME_PARA; 
    }
    if (now_command[0]== 0x06&&now_command[1]== 0x02)
    {
        return SET_FRAME_SCRPARA; 
    }
    if (now_command[0]== 0x07&&now_command[1]== 0x01)
    {
        return SET_FRAME_READY; 
    }
    if (now_command[0]== 0x08&&now_command[1]== 0x01)
    {
        return SET_CHANNEL_START; 
    }
     if (now_command[0]== 0x09&&now_command[1]== 0x01)
    {
        return MEASURE_CLK; 
    }
    if (now_command[0]== 0xff&&now_command[1]== 0xff)
    {
        return SYS_RESET_FLAG; 
    }
    if (now_command[0]== 0xaa&&now_command[1]== 0xaa)
    {
        return HEART_BEAT_FLAG; 
    }
    
    return -2;
}
void get_para(int command)
{
     float temp_data;
    //uint64 temp_data_u64;
    switch (command)
    {
        case START_PROGRAM_DISK :
          Disk_ParaGlobal.lba_begin=((uint32)(now_command[2])*256*256*256)+((uint32)(now_command[3])*256*256)
                    +((uint32)(now_command[4])*256)+((uint32)(now_command[5])*1);
          Disk_ParaGlobal.lba_end=((uint32)(now_command[6])*256*256*256)+((uint32)(now_command[7])*256*256)
                    +((uint32)(now_command[8])*256)+((uint32)(now_command[9])*1);
          temp_data = ((float)(Disk_ParaGlobal.lba_end-Disk_ParaGlobal.lba_begin))/2;         
        break;
        case STOP_PROGRAM_DISK :
        break;
        
        case START_PROGRAM_RAM :
            SetSource_paraA.channel =  now_command[2];
        break;
        
        case SET_FIXED_DAT :
            SetSource_paraA.channel =  now_command[2];
            SetSource_paraA.fixed_init =  now_command[3];
            SetSource_paraA.fixed_step =  now_command[4];
        break;
        
        case SET_CLK_DATA :
            Clk_ParaGlobal.channel =  now_command[2];
            Clk_ParaGlobal.fre_set=((uint32)(now_command[3])*256*256*256)+((uint32)(now_command[4])*256*256)
                    +((uint32)(now_command[5])*256)+((uint32)(now_command[6])*1);
            Clk_ParaGlobal.fre_set = Clk_ParaGlobal.fre_set/10000.0;  
            Clk_ParaGlobal.pho_set=((uint32)(now_command[7])*256*256*256)+((uint32)(now_command[8])*256*256)
                    +((uint32)(now_command[9])*256)+((uint32)(now_command[10])*1);
            Clk_ParaGlobal.pho_set = Clk_ParaGlobal.pho_set/10000.0;         
        break;
        
         case SET_HEAD_DATA :
            SetHead_paraA.channel =  now_command[2];
            SetHead_paraA.sync_len = now_command[3];
            SetHead_paraA.sync_db2 = ((uint32)(now_command[4])*256)+((uint32)(now_command[5])*1);
            SetHead_paraA.sync_db1 = ((uint32)(now_command[6])*256*256*256)+((uint32)(now_command[7])*256*256)
                    +((uint32)(now_command[8])*256)+((uint32)(now_command[9])*1);
            SetHead_paraA.sync_db0 = ((uint32)(now_command[10])*256*256*256)+((uint32)(now_command[11])*256*256)
                    +((uint32)(now_command[12])*256)+((uint32)(now_command[13])*1);
            SetHead_paraA.cntr_len = now_command[14];
            SetHead_paraA.cntr_init1 = ((uint32)(now_command[15])*256)+((uint32)(now_command[16])*1);
            SetHead_paraA.cntr_init0 = ((uint32)(now_command[17])*256*256*256)+((uint32)(now_command[18])*256*256)
                    +((uint32)(now_command[19])*256)+((uint32)(now_command[20])*1); 
             SetHead_paraA.cntr_step = now_command[21];
            SetHead_paraA.res_flag = now_command[22]&0x01;
            SetHead_paraA.res_init = now_command[23];
            
        break;
        
        case SET_FRAME_PARA :
            SetFrame_paraA.channel = now_command[2];
            SetFrame_paraA.source = now_command[3];
            SetFrame_paraA.framedat_len = ((uint32)(now_command[4])*256)+((uint32)(now_command[5])*1);
            SetFrame_paraA.trace_len = ((uint32)(now_command[6])*256)+((uint32)(now_command[7])*1);
            SetFrame_paraA.retrace_len = ((uint32)(now_command[8])*256)+((uint32)(now_command[9])*1);
        break;
        case SET_FRAME_READY :
            //SetSource_paraA.channel =  now_command[2];
        break;   
        case SET_CHANNEL_START :
            my_channel =  ((uint32)(now_command[2])*256)+((uint32)(now_command[3])*1);
        break;
        
        case SET_SSD_SDRAM :
            RdSSD_paraA.dat_len = ((uint32)(now_command[2])*256*256*256)+((uint32)(now_command[3])*256*256)
                    +((uint32)(now_command[4])*256)+((uint32)(now_command[5])*1);
            RdSSD_paraA.lba_begin = ((uint32)(now_command[6])*256*256*256)+((uint32)(now_command[7])*256*256)
                    +((uint32)(now_command[8])*256)+((uint32)(now_command[9])*1);
        break;
        
        case MEASURE_CLK :
            TeleFre_paraA.channel =  now_command[2];
        break;
        
        case SET_FRAME_SCRPARA :
            Scr_paraA.channel =  now_command[2];
            Scr_paraA.scr_choose = now_command[3];
            Scr_paraA.unscr_len = now_command[4];
        break;
        
        default:
        break;
    }
}
void ExecuteCommand(int command)
{
   // float temp_data;
   // uint64 temp_data_u64;
    
    switch (command)
    {
        case START_PROGRAM_DISK :
            start_write_idedata();
        break;
        case STOP_PROGRAM_DISK :
            stop_write_idedata();
        break;
        case START_PROGRAM_RAM :
            turnon_write_ramdata();
        break;
        case SET_FIXED_DAT :
             set_fixeddata();
        break;
        case SET_CLK_DATA :
             set_clock(Clk_ParaGlobal.channel,Clk_ParaGlobal.fre_set,Clk_ParaGlobal.pho_set);
        break;
        case SET_HEAD_DATA :
             set_headdata();
        break;
        case SET_FRAME_PARA :
             set_framepara();
        break;
        case SET_FRAME_READY :
            set_frameready();
        break;
         case SET_CHANNEL_START :
           set_channelstart();
        break;
         case SET_SSD_SDRAM :
             prepare_send_idedata();
        break;
        case START_SSD_SDRAM :
             start_send_idedata();
        break;
        case STOP_SSD_SDRAM :
             stop_send_idedata();
        break;
        case MEASURE_CLK :
             measure_clock();
        break;
        case SYS_RESET_FLAG :
             reset_fun();
             usleep(100000);
             init_mysystem();
        break;
        case SET_FRAME_SCRPARA :
             set_scr();
        break;
        default:
        break;
    }
}
int send_back(int command)
{
    uint32 temp;
    if (command<=0)
        return 0;
   
    temp = check_uartfifo();//fifo�Ƿ���
    //printf("FIFO�ɶ�д����%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
        
    send_uart16(0xfaf4);
    send_uart16((uint32)(command));
     switch (command)
    {
        case START_PROGRAM_DISK :
             
              send_uart_empty(6);
        break;
        case STOP_PROGRAM_DISK :
             
              send_uart_empty(6);
        break;
        case START_PROGRAM_RAM :
            printf("��ʼ��дRAM����\n");
           temp =  check_ramstate();//
           send_uart16(temp);
            send_uart_empty(5);
            printf("��дRAMʧ��\n");
        break;
        case SET_FIXED_DAT :
             //printf("���ù̶�֡������\n");
              send_uart_empty(6);
        break;
        case SET_CLK_DATA :
             //printf("ʱ������\n");
             send_uart_empty(6);
        break;
        case SET_HEAD_DATA :
             //printf("����֡ͷ����\n");
             temp = SetHead_paraA.res_flag + SetHead_paraA.sync_len + SetHead_paraA.cntr_len;
             send_uart16(temp);
             send_uart_empty(5);
        break;
        case SET_FRAME_PARA :
             //printf("����֡����\n");
             send_uart16(SetFrame_paraA.channel);
             send_uart16(SetFrame_paraA.source);
             send_uart16(SetFrame_paraA.framedat_len);
             send_uart16(SetFrame_paraA.trace_len);
             send_uart16(SetFrame_paraA.retrace_len);
             send_uart_empty(1);
        break;
        case SET_FRAME_READY :
            //printf("׼�����ݷ���\n");
             send_uart_empty(6);
        break;
         case SET_CHANNEL_START :
          //printf("���ݷ���ָ��\n");
          temp = check_channelstate();//
           send_uart16(temp);
           send_uart_empty(5);
        break;
         case SET_SSD_SDRAM :
             //printf("׼��Ӳ������\n");
              send_uart_empty(6);
        break;
        case START_SSD_SDRAM :
             //printf("Ӳ�����ݷ��Ϳ�ʼ\n");
             send_uart_empty(6);
        break;
        case STOP_SSD_SDRAM :
            // printf("Ӳ�����ݷ��ͽ���\n");
             send_uart_empty(6);
        break;
        case MEASURE_CLK :
             //printf("ң��ʱ��\n");
             send_uart16(TeleFre_paraA.channel);
             send_uart16((TeleFre_paraA.fre_db/0x10000));
             send_uart16((TeleFre_paraA.fre_db%0x10000));
             send_uart_empty(3);            
        break;
        case SYS_RESET_FLAG :
             //printf("ϵͳ��λ������\n");
             send_uart_empty(6);
        break;
        case HEART_BEAT_FLAG :
             //printf("��������ѽ ��ѽ\n");
             send_uart_empty(6);
        break;
        case SET_FRAME_SCRPARA :
            //printf("���ü��Ų���\n");
             send_uart_empty(6);
        break;
        default:
            send_uart_empty(6);
        break;
    }
    return 1;
}

