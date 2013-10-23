#ifndef COMMAND_DRIVER_H_
#define COMMAND_DRIVER_H_


uint32 check_cmd();
uint32 check_state();
uint32 get_command();
uint32 check_uartfifo();

void send_uart16(uint32 temp);
void send_uart_empty(const uint8 num);


#endif /*COMMAND_DRIVER_H_*/
