
/*
*********************************************************************************************************
*                                                  MAIN
*********************************************************************************************************
*/
#include "driver\source_reg.h"
#include "interface\command_process.h"
#include "managesys\sysmanage.h"

int main()
{  
    int command; 
    
    init_mysystem();
    
    InitSysManage();
    
    
    usleep(100000);
    printf("hello world!!!\n");  
    
    while (1)
    {
        SysManageInterface();
        
        command = check_command();
        get_para(command);
        ExecuteCommand(command);
        send_back(command);
        usleep(1000);
    }  
    
    return 0;
}
