#ifndef SEND_RAMDATA_H_
#define SEND_RAMDATA_H_

void turnon_write_ramdata(void);
void set_fixeddata(void);
void set_headdata(void);
void set_framepara(void);
void set_frameready(void);
void set_channelstart(void);
int check_ramstate(void);
uint32 check_channelstate(void);
void set_scr(void);


#endif /*SEND_RAMDATA_H_*/
