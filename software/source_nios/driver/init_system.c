#include "source_reg.h"
#include "clock.h"
#include "command_driver.h"

void init_net()
{     
    initUDPModule(); //-----��ʼ��UDP
    usleep(2000000);//��ʱ5��ȴ���ʼ��
    IOWR(EXPORT_BASE,MAC_RESET,0);//----��ʼ��MAC
    IOWR(EXPORT_BASE,MAC_RESET,1);
    IOWR(EXPORT_BASE,MAC_RESET,0);
    IOWR(EXPORT_BASE,MAC_RESET,1);
    IOWR(EXPORT_BASE,MAC_RESET,0);
    IOWR(EXPORT_BASE,MAC_RESET,1);
    usleep(2000000);//��ʱ5��ȴ���ʼ��
}
void init_mysystem()
{ 
    init_net();
    init_clock();    
    //printf("�غ�����ģ��Դ-XX3\r\n"); 
    //printf("ϵͳ��ʼ����...\r\n"); 
    show_initing();
    usleep(2000000);//��ʱ5��ȴ���ʼ��  
    show_init_end();
    
}
void init_clock()
{     
    set_clock(0,56,0);
    set_clock(1,56,0);
    set_clock(2,56,0);
    set_clock(3,56,0);
}
void show_initing()
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
    send_uart16(0x0100);
    send_uart_empty(6);
    
}
void show_init_end()
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
    send_uart16(0x0101);
    
    if(check_state()!=0)
    {
        usleep(3000000);
  
        temp = check_state();
        send_uart16(temp);
        send_uart_empty(5);
       // printf("��ʼ��ʧ��\n");
                
    }
    else
    {
        send_uart_empty(6);
        // printf("��ʼ���ɹ�\n");
    }
    
}