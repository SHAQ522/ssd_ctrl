
#include "source_reg.h"
#include "clock.h"

float freq_reg[16];//---------时钟频率寄存器
float phoffset_reg[16];//-----时钟相位寄存器
U32 SCL_BASE;
U32 SDA_BASE;

/*
*********************************************************************************************************
*                                         FUNCTIONS
*********************************************************************************************************
*/
void set_clock(U8 channel,float freq,float phoffset)
{
    uint8 clk_type;
    float freq_temp;
    freq_temp = freq;
    if(freq > 4.99)
        {clk_type = 0;freq_temp = freq;}
    else if(freq > 1)
        {clk_type = 1;freq_temp = freq*8;}
    else if(freq > 0.1)
        {clk_type = 2;freq_temp = freq*128;}
    else if(freq > 0.009)
        {clk_type = 3;freq_temp = freq*1024;}
        
//    if(channel == 0)IOWR(EXPORT_BASE,CLK_SEL_CH0,clk_type);
//    else if(channel == 1)IOWR(EXPORT_BASE,CLK_SEL_CH1,clk_type);
//    else if(channel == 2)IOWR(EXPORT_BASE,CLK_SEL_CH2,clk_type);
//    else if(channel == 3)IOWR(EXPORT_BASE,CLK_SEL_CH3,clk_type);
//    else if(channel == 4)IOWR(EXPORT_BASE,CLK_SEL_CH4,clk_type);
//    else if(channel == 5)IOWR(EXPORT_BASE,CLK_SEL_CH5,clk_type);
//    else if(channel == 6)IOWR(EXPORT_BASE,CLK_SEL_CH6,clk_type);
//    else if(channel == 7)IOWR(EXPORT_BASE,CLK_SEL_CH7,clk_type);
//    else;
    switch(channel)
    {
        case CH0 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH0,clk_type);
        break;
        case CH1 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH1,clk_type);
        break;
        case CH2 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH2,clk_type);
        break;
        case CH3 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH3,clk_type);
        break;
        case CH4 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH4,clk_type);
        break;
        case CH5 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH5,clk_type);
        break;
        case CH6 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH6,clk_type);
        break;
        case CH7 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH7,clk_type);
        break;
        case CH8 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH8,clk_type);
        break;
        case CH9 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH9,clk_type);
        break;
        case CH10 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH10,clk_type);
        break;
        case CH11 : 
            IOWR(EXPORT_BASE,CLK_SEL_CH11,clk_type);
        break;
        default:
        break;
    }
    if(phoffset < 0)
        phoffset = phoffset + 1000/freq_temp;
    updatafreq(channel,freq_temp,phoffset); 
}

void updatafreq(U8 channel,float freq,float phoffset)
{ 
    U8 site;
    U8 iic_sel; 
    U8 channel_s; 
    
    channel_s  = channel;     
    iic_sel = channel_s/4;
    site = channel_s%4;
    freq_reg[channel_s] = freq;
    phoffset_reg[channel_s] = phoffset;
    
    if(iic_sel==0){SCL_BASE=SCL_A_BASE;SDA_BASE=SDA_A_BASE;}
    else if(iic_sel==1){SCL_BASE=SCL_B_BASE;SDA_BASE=SDA_B_BASE;}
    else ;
    
    site = iic_sel*4;
    setfrequence(0,freq_reg[site]);
    setfrequence(1,freq_reg[site+1]);
    setfrequence(2,freq_reg[site+2]);
    setfrequence(3,freq_reg[site+3]);
    initsi5338();
    usleep(10000);
            
 /*   pll_config(0,freq_reg[0],phoffset_reg[0]);//--20121112
    usleep(10000);
    pll_config(1,freq_reg[1],phoffset_reg[1]);
    usleep(10000);
    pll_config(0,freq_reg[0],phoffset_reg[0]);//--20121112
    usleep(10000);
    pll_config(1,freq_reg[1],phoffset_reg[1]);
    usleep(10000);*/
    //不响应相位变化    刘帅威 2013年3月11日10:43:32
}

void pll_config(U8 channel,float freq,float phoffset)
{ 
    U32  taps;       //输出偏移相位抽头数  计算值
    U32  MValue;     //计算值
    U8   HC0Val;
    U8   LC0Val;
    U8   QVal;
    U8   LFilterRVal;
    U8   LFilterCVal;
    U32  NValue;
    U8   Direct;
    
    uint32 pll_config_phasetap;
    uint32 pll_config_m_set;
    uint32 pll_config_c0_high_set;
    uint32 pll_config_c0_low_set;
    uint32 pll_config_charge_pump;
    uint32 pll_config_lowpass_filter_r;
    uint32 pll_config_lowpass_filter_c;
    uint32 pll_config_n;
    uint32 pll_config_phase_posedge;

    int max_freq_vco=1040;
    int min_freq_vco=300;
    float taps_temp[750]={0};  //  [2011/10/20 cyq]
    float min_tap_temp;
    int max_m;
    int min_m;
    int i=0;

    max_m=(int)((float)max_freq_vco/freq);
    min_m=(int)((float)min_freq_vco/freq)+1;
    MValue=min_m;
    
        for(i=0;i<=max_m-min_m;i++)
        {
            taps_temp[i]=8*phoffset*freq*MValue/1000;
            if(taps_temp[i]==(int)taps_temp[i])  //modified here
                taps_temp[i]=0;
            else
                taps_temp[i]=fabs(taps_temp[i]-(int)(taps_temp[i]+0.5));//calc difference between int and float
            MValue++;
        }
        min_tap_temp = taps_temp[0];
        MValue = min_m;     //addedd here
        for(i = 0;i <= max_m - min_m;i++)  
        {   if(min_tap_temp>taps_temp[i])
            {  
                min_tap_temp=taps_temp[i];
                MValue=i+min_m;
            }
        }
            if(MValue * freq * phoffset * 8/1000 !=(int)(MValue * freq * phoffset * 8/1000))   //modified here
                    taps = (int)(MValue * freq * phoffset * 8/1000+0.5);        
            else taps = MValue * freq * phoffset * 8/1000;
    
    HC0Val = MValue/2 + MValue%2;
    LC0Val = MValue/2;
    QVal = 13;
    LFilterRVal = 0;
    LFilterCVal = 3;
    NValue = 1;
    Direct = 1;    //默认偏移方向为 正 
    
    pll_config_phasetap=taps;
    pll_config_m_set=MValue;
    pll_config_c0_high_set=(uint32)(HC0Val);
    pll_config_c0_low_set=(uint32)(LC0Val);
    pll_config_charge_pump=(uint32)(QVal);
    pll_config_lowpass_filter_r=(uint32)(LFilterRVal);
    pll_config_lowpass_filter_c=(uint32)(LFilterCVal);
    pll_config_n=(uint32)(NValue);
    pll_config_phase_posedge=(uint32)(Direct);
     
    U32 PLL_CONFIG_START; 
    if(channel==0)  PLL_CONFIG_START = PLL_CONFIG_START1;  
    if(channel==1)  PLL_CONFIG_START = PLL_CONFIG_START2;
    if(channel==2)  PLL_CONFIG_START = PLL_CONFIG_START3;
    if(channel==3)  PLL_CONFIG_START = PLL_CONFIG_START4; 
    if(channel==4)  PLL_CONFIG_START = PLL_CONFIG_START5;  
    if(channel==5)  PLL_CONFIG_START = PLL_CONFIG_START6;
    if(channel==6)  PLL_CONFIG_START = PLL_CONFIG_START7;
    if(channel==7)  PLL_CONFIG_START = PLL_CONFIG_START8; 
         
    IOWR(EXPORT_BASE,PLL_CONFIG_START,1);//拉高
    IOWR(EXPORT_BASE,PLL_CONFIG_PHASETAP,pll_config_phasetap);
    IOWR(EXPORT_BASE,PLL_CONFIG_M_SET,pll_config_m_set);
    IOWR(EXPORT_BASE,PLL_CONFIG_C0_HIGH_SET,pll_config_c0_high_set);
    IOWR(EXPORT_BASE,PLL_CONFIG_C0_LOW_SET,pll_config_c0_low_set);
    IOWR(EXPORT_BASE,PLL_CONFIG_CHARGE_PUMP,pll_config_charge_pump);
    IOWR(EXPORT_BASE,PLL_CONFIG_LOWPASS_FILTER_R,pll_config_lowpass_filter_r);
    IOWR(EXPORT_BASE,PLL_CONFIG_LOWPASS_FILTER_C,pll_config_lowpass_filter_c);
    IOWR(EXPORT_BASE,PLL_CONFIG_N,pll_config_n);
    IOWR(EXPORT_BASE,PLL_CONFIG_PHASE_POSEDGE,pll_config_phase_posedge);
    IOWR(EXPORT_BASE,PLL_CONFIG_START,0);//拉低，开始     
}