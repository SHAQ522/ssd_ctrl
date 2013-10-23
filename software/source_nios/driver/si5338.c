
#include "source_reg.h"
#include "si5338.h" 



U8 writeRegister(struct SIRegister *reg);
U8 getRegister(struct SIRegister *reg);

void initevb();//--------------初始化开发板，使电压为3.3V
void initsi5338();
void setfrequence(U8 channel,float freq_s);

extern U8 read_byte(U8 addr); 
extern void write_byte(U8 addr, U8 dat);
extern void write_evb_byte(U8 cmd, U8 addr, U8 dat);

U8 writeRegister(struct SIRegister *reg)
{
    if(reg->mask == 0x00)
        return true;
    
    if(reg->mask == 0xFF) {
        // do a write transaction only since the mask
        // is all ones
         write_byte(reg->addr,reg->value);
            return true;
    } else {
        //do a read-modify-write
        U8 curr_chip_val, clear_curr_val, clear_new_val, combined;
        curr_chip_val =  read_byte(reg->addr);
        clear_curr_val = curr_chip_val & ~reg->mask;
        clear_new_val = reg->value & reg->mask;
        combined = clear_new_val | clear_curr_val;
         write_byte(reg->addr,combined);
            return true;
    }   
}

U8 getRegister(struct SIRegister *reg)
{
    if( read_byte(reg->addr) == reg->value)
            return true;
    return false;
}

void initsi5338()
{
  //----------------------------------------------------------------
  // See Si5338 datasheet Figure 9 for more details on this procedure
  // delay added to wait for Si5338 to be ready to communicate 
  // after turning on
    U32 count;
    count = 0;
    while(count<250000){count++;}
     write_byte(OEB_ALL, 0x10);
     write_byte(DIS_LOL, 0xe5);
    //for all the register values in the Reg_Store array
    //get each value and mask and apply it to the Si5338
    U16 i;
    struct SIRegister reg;
    for(i=0; i<NUM_REGS_MAX; i++)
    {
        reg.addr = Reg_Store[i][0];
        reg.value = Reg_Store[i][1];
        reg.mask = Reg_Store[i][2];
        writeRegister(&reg);
    }
    // check LOS alarm for the xtal input 
    // on IN1 and IN2 (and IN3 if necessary) - 
    // change this mask if using inputs on IN4, IN5, IN6
    U8 regdata;
    regdata =  read_byte(LOS_ADDR) & LOS_MASK;
    while(regdata != 0)
    {
        regdata =  read_byte(LOS_ADDR) & LOS_MASK;
    }
     write_byte(FCAL_OVRD_EN,  read_byte(FCAL_OVRD_EN) & 0x7F);
     write_byte(REG_RESET, 2);
     write_byte(DIS_LOL, 0x65);
   // wait for Si5338 to be ready after calibration (ie, soft reset)
    count = 0;
    while(count<250000){count++;}
   //make sure the device locked by checking PLL_LOL and SYS_CAL
    regdata =  read_byte(LOS_ADDR) & LOCK_MASK;
    while(regdata != 0)
    {
        regdata =  read_byte(LOS_ADDR) & LOCK_MASK;
    }
    //copy FCAL values
     write_byte(45,  read_byte(235));
     write_byte(46,  read_byte(236));
    // clear bits 0 and 1 from 47 and 
    // combine with bits 0 and 1 from 237
    regdata = ( read_byte(47) & 0xFC) & ( read_byte(237) & 3);
     write_byte(47, regdata);
     write_byte(FCAL_OVRD_EN,  read_byte(FCAL_OVRD_EN) | 0x80);
     write_byte(OEB_ALL, 0x00);
    //------------------------------------------------------------
}

void setfrequence(U8 site,float freq_s)
{
    U32 M_Integ_Reg = 0;   //M整数部分
    U32 M_Num_Reg = 0;     //M小数部分分子
    U32 M_Den_Reg = 0;     //M小数部分分母
    U16 a,b,c;
    float temp;
    U8 regdata[10];
    temp = 2500/freq_s;//------2.5GHz/fMHz
    a = (U16)temp;
    c = 10000;
    b = (U16)((temp-(float)a)*10000);
    M_Integ_Reg = (U32)((a*c+b)*128/10000-512);
    M_Num_Reg = (U32)((a*c+b*128)%c);
    M_Den_Reg = (U32)c;
    regdata[0] = (U8)(M_Integ_Reg);
    regdata[1] = (U8)(M_Integ_Reg >> 8);
    M_Num_Reg = M_Num_Reg*4;
    regdata[2] = (U8)(M_Integ_Reg >> 16) | (U8)M_Num_Reg;
    regdata[3] = (U8)(M_Num_Reg >> 8); 
    regdata[4] = (U8)(M_Num_Reg >> 16);
    regdata[5] = (U8)(M_Num_Reg >> 24);
    regdata[6] = (U8)(M_Den_Reg);
    regdata[7] = (U8)(M_Den_Reg >> 8); 
    regdata[8] = (U8)(M_Den_Reg >> 16);
    regdata[9] = (U8)(M_Den_Reg >> 24);
    U16 location;
    U16 i;
    switch(site)
        {
        case 0:
            location=53;
            for(i=0;i<10;i++)
            {
               Reg_Store[location+i][1] =  regdata[i];
            }
            break;
        case 1:
            location=64;
            for(i=0;i<10;i++)
            {
               Reg_Store[location+i][1] =  regdata[i];
            }
            break;
        case 2:
            location=75;
            for(i=0;i<10;i++)
            {
               Reg_Store[location+i][1] =  regdata[i];
            }
            break;
        case 3:
            location=86;
            for(i=0;i<10;i++)
            {
               Reg_Store[location+i][1] =  regdata[i];
            }
            break;
        }
}

void initevb()
{
    write_evb_byte(0x58, 0x46, 0xc1); 
    write_evb_byte(0x58, 0x6, 0xc9);
    write_evb_byte(0x58, 0x66, 0xc1);
    write_evb_byte(0x58, 0x26, 0xc9);
    write_evb_byte(0x5a, 0x46, 0xc1); 
    write_evb_byte(0x5a, 0x6, 0xc9);
    write_evb_byte(0x5a, 0x66, 0xc1);
    write_evb_byte(0x5a, 0x26, 0xc9); 
}
