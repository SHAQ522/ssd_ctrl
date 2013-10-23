#include "source_reg.h"
#include "clock.h"
#include "command_driver.h"

void init_net()
{     
    initUDPModule(); //-----初始化UDP
    usleep(2000000);//延时5秒等待初始化
    IOWR(EXPORT_BASE,MAC_RESET,0);//----初始化MAC
    IOWR(EXPORT_BASE,MAC_RESET,1);
    IOWR(EXPORT_BASE,MAC_RESET,0);
    IOWR(EXPORT_BASE,MAC_RESET,1);
    IOWR(EXPORT_BASE,MAC_RESET,0);
    IOWR(EXPORT_BASE,MAC_RESET,1);
    usleep(2000000);//延时5秒等待初始化
}
void init_mysystem()
{ 
    init_net();
    init_clock();    
    //printf("载荷数据模拟源-XX3\r\n"); 
    //printf("系统初始化中...\r\n"); 
    show_initing();
    usleep(2000000);//延时5秒等待初始化  
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
        
    temp = check_uartfifo();//fifo是否满
    //printf("FIFO可读写数据%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//同步头
    send_uart16(0x0100);
    send_uart_empty(6);
    
}
void show_init_end()
{
     uint32 temp;
        
    temp = check_uartfifo();//fifo是否满
    //printf("FIFO可读写数据%d\n",temp);
    while(temp > 220)
    {
        temp = check_uartfifo();
        usleep(100);
    }
    send_uart16(0xfaf4);//同步头
    send_uart16(0x0101);
    
    if(check_state()!=0)
    {
        usleep(3000000);
  
        temp = check_state();
        send_uart16(temp);
        send_uart_empty(5);
       // printf("初始化失败\n");
                
    }
    else
    {
        send_uart_empty(6);
        // printf("初始化成功\n");
    }
    
}