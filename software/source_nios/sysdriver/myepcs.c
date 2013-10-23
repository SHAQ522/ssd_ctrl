#include "myepcs.h"
#include "sys/alt_flash.h"
#define ALT_USE_EPCS_FLASH
#include <altera_avalon_epcs_flash_controller.h>
//#include <epcs_commands.h>

static alt_flash_fd *my_epcs;
flash_region* regions;
int number_of_regions;
alt_u8 epcsbuf[32];

alt_u32 InitEPCS(void)
{
    my_epcs = alt_flash_open_dev(EPCS_FLASH_CONTROLLER_0_NAME);
       
    alt_get_flash_info(my_epcs, &regions,
                            &number_of_regions  );
//    printf("number_of_regions : %d\n",number_of_regions);
//    printf("block_size : %d\n",regions->block_size);
//    printf("number_of_blocks : %d\n",regions->number_of_blocks);
//    printf("region_size : %d\n",regions->region_size);
//    printf("offset : %d\n",regions->offset);
     
    return 0;
}

alt_u32 GetEPCSBlockSize(void)
{
    return regions->region_size;
}
alt_u32 GetEPCSBlockNum(void)
{
    return regions->number_of_blocks;
}
alt_u32 EraseEPCS(int offset,int length)
{
    alt_u32 ret_num;
    my_epcs = alt_flash_open_dev(EPCS_FLASH_CONTROLLER_0_NAME);
    ret_num = alt_epcs_flash_erase_block(my_epcs,offset);
    alt_flash_close_dev(my_epcs);
    return ret_num;
}
alt_u32 WriteEPCS(int offset,const void* src_addr,int length)
{
    alt_u32 ret_num;
     my_epcs = alt_flash_open_dev(EPCS_FLASH_CONTROLLER_0_NAME);
    ret_num = alt_epcs_flash_write(my_epcs,offset,src_addr,length);
    alt_flash_close_dev(my_epcs);    
    //ret_num = alt_epcs_flash_write(my_epcs,offset,src_addr,length);
   // ret_num = alt_epcs_flash_write_block(my_epcs,0,offset,src_addr,length);
    
    return ret_num;
}
alt_u32 ReadEPCS(int offset,void* src_addr,int length)
{
    alt_u32 ret_num;
    //ret_num = alt_read_flash(my_epcs,offset,src_addr,length);
    my_epcs = alt_flash_open_dev(EPCS_FLASH_CONTROLLER_0_NAME);
    ret_num = alt_epcs_flash_read(my_epcs,offset,src_addr,length);
    alt_flash_close_dev(my_epcs);   
    return ret_num;
}

void CloseEPCS()
{
     alt_flash_close_dev(my_epcs);
}



