#include "utilities.h"

#define CHANGE_MODE
void changeMode16(U16 * data, U32 length)
{
#ifdef CHANGE_MODE
U32 i;
    for(i = 0; i < length; i++)
    {
        U8 *up8 = (U8 *)data+i*2;
        U8 *low8 = (U8 *)data+i*2+1;
        U8 tempData = *up8;
        *up8 = *low8;
        *low8 = tempData;
    }
#endif // CHANGE_MODE
}
void changeMode32(U32 * _data, U32 length)
{
#ifdef CHANGE_MODE
U32 i,j;
U32 temp32;
U8 *temp8Arr;
U8 * data8Arr;
    for(i = 0; i < length; i++)
    {
        temp32 = _data[i];
        temp8Arr = (U8 *)&(temp32);
        data8Arr = (U8 *)&(_data[i]);           
        
        for(j = 0; j< 4; j++)
        {
            data8Arr[j] = temp8Arr[3-j];               
        }           
    }
#endif // CHANGE_MODE
}
