
#include "source_reg.h" 

#define    OUT     1 
#define    IN      0 
extern U32 SCL_BASE;
extern U32 SDA_BASE;
U8 read_byte(U8 addr); 
void write_byte(U8 addr, U8 dat); 

/*   
  * ===  FUNCTION  ========================================= 
  *         Name:  start 
  *  Description:  IIC开始
  * ===================================================== 
  */ 
static void start(void)      
{ 
     IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT); 
     IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 1); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
     usleep(10); 
     IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 0); 
     usleep(5); 
} 
/*   
  * ===  FUNCTION   ======================================== 
  *         Name:  uart_send_byte 
  *  Description:  IIC停止 
  * ====================================================== 
  */ 
static void stop(void)       
{ 
     IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT); 
     IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 0); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
     usleep(10); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
     usleep(5); 
     IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, 1); 
     usleep(10); 
} 
/*   
  * ===  FUNCTION  ========================================= 
  *         Name:  ack 
  *  Description:  IIC应答 
  * ====================================================== 
  */ 
static void ack(void)       
{
     U8 tmp; 
      
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
     IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, IN); 
     usleep(10); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
     usleep(5); 
     tmp = IORD_ALTERA_AVALON_PIO_DATA(SDA_BASE); 
     usleep(5); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
     usleep(10); 
      
    while(tmp); 
} 
/*   
  * ===  FUNCTION  ======================================== 
  *         Name:  iic_write 
  *  Description:  IIC写一个字节 
  * ===================================================== 
  */ 
void iic_write(U8 dat)      
{ 
     U8 i, tmp; 
      
     IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, OUT); 
      
     for(i=0; i<8; i++){ 
         IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
         usleep(5); 
         tmp = (dat & 0x80) ? 1 : 0; 
         dat <<= 1; 
         IOWR_ALTERA_AVALON_PIO_DATA(SDA_BASE, tmp); 
         usleep(5); 
         IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
         usleep(10); 
     } 
} 
/*   
  * ===  FUNCTION  ======================================== 
  *         Name:  read 
  *  Description:  IIC读一个字节 
  * ===================================================== 
  */ 
static U8 iic_read(void)      
{ 
     U8 i, dat = 0; 
      
     IOWR_ALTERA_AVALON_PIO_DIRECTION(SDA_BASE, IN); 
   
     for(i=0; i<8; i++){ 
         IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
         usleep(10); 
          IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
         usleep(5); 
         dat <<= 1; 
         dat |= IORD_ALTERA_AVALON_PIO_DATA(SDA_BASE); 
         usleep(5); 
     } 
    
     usleep(5); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
     usleep(10); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 1); 
     usleep(10); 
     IOWR_ALTERA_AVALON_PIO_DATA(SCL_BASE, 0); 
      
     return dat; 
} 
 
/*   
  * ===  FUNCTION  ======================================== 
  *         Name:  write_byte 
  *  Description:  向SI5338的register写一个字节 
  * ===================================================== 
  */ 
void write_byte(U8 addr, U8 dat)   
{ 
     alt_u8 cmd; 
     cmd = 0xe0;//------Slv addr
     start(); 
     iic_write(cmd); 
     ack(); 
     iic_write(addr); 
     ack(); 
     iic_write(dat); 
     ack(); 
     stop();     
} 
/*   
  * ===  FUNCTION  ========================================= 
  *         Name:  read_byte 
  *  Description:  从SI5338的register读一个字节
  * ====================================================== 
  */ 
U8 read_byte(U8 addr)   
{ 
     alt_u8 cmd, dat; 
     cmd = 0xe0;//------Slv addr
      
     start(); 
     iic_write(cmd); 
     ack(); 
     iic_write(addr); 
     ack(); 
     start(); 
     cmd |= 0x01; 
     start(); 
     iic_write(cmd); 
     ack(); 
     dat = iic_read(); 
     stop();     
      
     return dat; 
} 
/*   
  * ===  FUNCTION  ======================================== 
  *         Name:  write_byte 
  *  Description:  向EVB的单片机的register写一个字节 
  * ===================================================== 
  */ 
void write_evb_byte(U8 cmd, U8 addr, U8 dat)   
{ 
     start(); 
     iic_write(cmd); 
     ack(); 
     iic_write(addr); 
     ack(); 
     iic_write(dat); 
     ack(); 
     stop();     
} 
