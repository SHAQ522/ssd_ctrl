#ifndef UTILITIES_H
#define UTILITIES_H
#include <stdio.h>
#define U8 unsigned char
#define U16 unsigned short
#define U32 unsigned int
#define S8 char
#define S16 short
#define S32 int


extern void changeMode16(U16 * data, U32 length);
extern void changeMode32(U32 * data, U32 length);

#define BAD_PARAMETERS -1
#define FUN_FAILED -2
#define FUN_OK 0

#endif //UTILITIES_H
