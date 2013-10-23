#ifndef COMMAND_PROCESS_H_
#define COMMAND_PROCESS_H_

uint8 now_command[128];

int check_command();
void get_para(int command);
void ExecuteCommand(int command);
int send_back(int command);

//extern uint32 check_cmd();
//extern uint32 check_state();
//extern uint32 get_command();




#endif /*COMMAND_PROCESS_H_*/
