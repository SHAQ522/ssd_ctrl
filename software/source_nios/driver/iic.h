#ifndef IIC_H_
#define IIC_H_

#define    OUT     1 
#define    IN      0 
 
typedef struct{ 
     void (* write_byte)(unsigned char addr, unsigned char dat); 
     unsigned char (* read_byte)(unsigned char addr); 
}IIC; 
 
extern IIC iic; 

#endif /*IIC_H_*/
