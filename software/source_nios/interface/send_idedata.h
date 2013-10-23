#ifndef SEND_IDEDATA_H_
#define SEND_IDEDATA_H_

void start_send_idedata(void);
void stop_send_idedata(void); 
void prepare_send_idedata(void);
void stop_write_idedata();
void start_write_idedata();

uint32 check_sdram_wr_done();  

void show_write_percent(uint32 per);
void show_write_num(uint32 num); 
void show_write_fail(uint32 num);
void show_write_success();

//extern int check_command();
//extern uint32 check_state();   

#endif /*SEND_IDEDATA_H_*/
