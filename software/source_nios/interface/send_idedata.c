
#include "..\driver\source_reg.h"
#include "..\driver\command_driver.h"
#include "command_process.h"
#include "command_table.h"
#include "send_idedata.h"

extern RdSSD_para RdSSD_paraA;
                
/*
*********************************************************************************************************
*                                                  FUNCTIONS
*********************************************************************************************************
*/
void prepare_send_idedata(void)
{  
    uint16 wraddr_begin,wraddr_end,rdaddr_begin,rdaddr_end;
    uint32 frame_length,sdram_length;
    uint32 temp;
    float temp_f;
    
    wraddr_begin = 0;
    rdaddr_begin = 0;
    
//----cyq 2012.9.12�޸�---//     
    printf("�������ܳ��� %u\r\n", RdSSD_paraA.dat_len);
    temp_f = RdSSD_paraA.dat_len/16384.0;
    temp = (uint32)temp_f + 1;
    if(temp>32768)
       temp = 32768;
    wraddr_end = temp;
    rdaddr_end = temp;
    RdSSD_paraA.lba_end = RdSSD_paraA.lba_begin + temp*32 + 8;
  
    frame_length =  RdSSD_paraA.dat_len/2;
    sdram_length = (rdaddr_end - rdaddr_begin)*1024*8;
    
    IOWR(EXPORT_BASE,SDRAM_RESET,off);
    IOWR(EXPORT_BASE,IDE_RESET,off);
    IOWR(EXPORT_BASE,SDRAM_WR,off);
    IOWR(EXPORT_BASE,SDRAM_RD,off);
    IOWR(EXPORT_BASE,IDE_RD,off);       
        
    IOWR(EXPORT_BASE,FRAME_LENGTH,frame_length);   
    IOWR(EXPORT_BASE,SDRAM_LENGTH,sdram_length);
    IOWR(EXPORT_BASE,LBA_BEGIN,RdSSD_paraA.lba_begin);
    IOWR(EXPORT_BASE,LBA_END,RdSSD_paraA.lba_end);
    IOWR(EXPORT_BASE,WRADDR_BEGIN,wraddr_begin);
    IOWR(EXPORT_BASE,WRADDR_END,wraddr_end);
    IOWR(EXPORT_BASE,RDADDR_BEGIN,rdaddr_begin);
    IOWR(EXPORT_BASE,RDADDR_END,rdaddr_end);    
    usleep(2000);
              
    IOWR(EXPORT_BASE,SDRAM_RESET,on);//��λ
    IOWR(EXPORT_BASE,IDE_RESET,on);//��λ
    usleep(2000);
    IOWR(EXPORT_BASE,SDRAM_WR,on);
    IOWR(EXPORT_BASE,IDE_RD,on);
    usleep(500000);
    while(check_sdram_wr_done() != 1);
    usleep(500000);
    IOWR(EXPORT_BASE,SDRAM_WR,off);
    IOWR(EXPORT_BASE,IDE_RD,off);
    IOWR(EXPORT_BASE,IDE_RESET,off);
    usleep(1000);
     printf("��дSDRAM�ɹ�\n");
    

//----lsw 2013.3.21�޸�---//    
         
//    IOWR(EXPORT_BASE,SDRAM_RD,on);
//    usleep(100);
}
//
void stop_send_idedata(void)
{     
    IOWR(EXPORT_BASE,SDRAM_RD,off);
    usleep(100);
}
void start_send_idedata(void)
{     
    printf("��ʼ����SSD\n");
    IOWR(EXPORT_BASE,SDRAM_RD,on);
    usleep(100);
}

uint32 check_sdram_wr_done()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,SDRAM_WR_DONE);
        return temp_data;
} 


void start_write_idedata()
{  
    uint32 temp_data = 0;
    uint32 next_show=0;//�´���ʾ���ȵ�ֵ
    uint32 need_kb;
    need_kb=(Disk_ParaGlobal.lba_end-Disk_ParaGlobal.lba_begin);
    IOWR(EXPORT_BASE,IDE_WR,off);//����ֹͣд
    IOWR(EXPORT_BASE,LBA_BEGIN,Disk_ParaGlobal.lba_begin);//����Ӳ����ʼ����
    IOWR(EXPORT_BASE,LBA_END,Disk_ParaGlobal.lba_end);//����Ӳ����ֹ����
    IOWR(EXPORT_BASE,IDE_WR,on);//���Ϳ�ʼд
    while(check_command() != STOP_PROGRAM_DISK)
    {
        temp_data=IORD(EXPORT_BASE,GIGE_COUNT);
        temp_data = temp_data;
        if((next_show!=0 && ((temp_data)*100/need_kb)>=next_show )
            ||(next_show==0 && temp_data!=0))//��ʾ�ٷֱ�
        {
            printf("����д %u%%\r\n",next_show);
            show_write_percent(next_show);
            next_show+=10;
        }
    }
    temp_data = temp_data;
    printf("�ܹ���д %u KB����\r\n",temp_data);
    show_write_num(temp_data);
    
    usleep(100);
    IOWR(EXPORT_BASE,IDE_WR,off);//����ֹͣд
    usleep(100000);
    if(check_state() != 0)
    {
        printf("��дʧ�ܣ� \r\n");
        
        temp_data=check_state();
        printf("Ӳ�̴��� ������Ϣ��0x%x \r\n",temp_data);
        show_write_fail(temp_data);
        
    }
    else if(temp_data == (Disk_ParaGlobal.lba_end-Disk_ParaGlobal.lba_begin))
    {
        printf("��д�ɹ��� \r\n");
        show_write_success();
    }
    else 
    {
        printf("��дʧ�ܣ�\r\n");
         show_write_fail(0xffff);
    }
}

void stop_write_idedata()
{  
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,GIGE_COUNT);
    temp_data = temp_data;
    printf("�ܹ���д %u KB����\r\n",temp_data);
    show_write_num(temp_data);
    
    usleep(100);
    IOWR(EXPORT_BASE,IDE_WR,off);//����ֹͣд
    usleep(100000);
    if(check_state() != 0)
    {
        printf("��дʧ�ܣ� \r\n");
        
        temp_data=check_state();
        printf("Ӳ�̴��� ������Ϣ��0x%x \r\n",temp_data);
        show_write_fail(temp_data);
        
    }
    else if(temp_data == (Disk_ParaGlobal.lba_end-Disk_ParaGlobal.lba_begin))
    {
        printf("��д�ɹ��� \r\n");
        show_write_success();
    }
    else 
    {
        printf("��дʧ�ܣ�\r\n");
        show_write_fail(0xffff);
    }
}
void show_write_percent(uint32 per)
{
    uint32 temp;
        
    temp = check_uartfifo();//fifo�Ƿ���
    //printf("FIFO�ɶ�д����%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//ͬ��ͷ
    send_uart16(0x0200);
    send_uart16(per);
    send_uart_empty(5);
}
void show_write_num(uint32 num)
{
    uint32 temp;
        
    temp = check_uartfifo();//fifo�Ƿ���
    //printf("FIFO�ɶ�д����%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//ͬ��ͷ
    send_uart16(0x0201);
    send_uart16(num/0x10000);
    send_uart16(num%0x10000);
    send_uart_empty(4);
}
void show_write_fail(uint32 num)
{
     uint32 temp;
        
    temp = check_uartfifo();//fifo�Ƿ���
    //printf("FIFO�ɶ�д����%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//ͬ��ͷ
    send_uart16(0x0202);
    send_uart16(num);
    send_uart_empty(5);
}
void show_write_success()
{
     uint32 temp;
        
    temp = check_uartfifo();//fifo�Ƿ���
    //printf("FIFO�ɶ�д����%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//ͬ��ͷ
    send_uart16(0x0203);
    send_uart_empty(6);
}

