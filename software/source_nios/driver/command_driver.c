#include "source_reg.h"
#include "command_driver.h"

uint32 check_cmd()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,COMMAND_FIFO_USEDW);
        return temp_data;
}  

uint32 check_state()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,SYSTEM_STATE);
        return temp_data;
}     

uint32 get_command()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,COMMAND_FIFO_DATA);
        return temp_data;
}   

uint32 check_uartfifo()
{
    uint32 temp_data;
    temp_data=IORD(EXPORT_BASE,UART_FIFO_NUM);
        return temp_data;
}

void send_uart16(uint32 temp)
{
    IOWR(EXPORT_BASE,UART_DB_REG,temp);
}
void send_uart_empty(const uint8 num)
{
    uint8 i=0;
    for(i=0;i<num;i++)
        send_uart16(0);
}