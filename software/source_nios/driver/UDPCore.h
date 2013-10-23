#ifndef UDPCORE_H_
#define UDPCORE_H_

#endif /*UDPCORE_H_*/

#ifndef UDP_CORE_H
#define UDP_CORE_H

#include "utilities.h"


#define UDP_MAC_LENGTH 14
#define UDP_MAX_LENGTH 1518
#define UDP_IPHEADER_LENGTH 20
#define UDP_UDPHEADER_LENGTH 8

struct UDPacket
{
    U8 m_buffer[UDP_MAX_LENGTH];
    U8 *m_MACHeader;
    U8 *m_IPHeader;
    U8 *m_UDPHeader;
    U8 *m_UDPPayload;

    U16 m_UDPPayloadLength;
};

//extern struct UDPacket sendPacket;
//extern struct UDPacket recvPacket;

S32 initUDPModule();
S32 sendNet(U8 *buffer, U32 size);
S32 recvNet(U8 *buffer, U32 size);

void setSrcMacAddr(U8 srcMacAddr[]);
void setDesMacAddr(U8 desMacAddr[]);
void setSrcIpAddr(U8 srcIpAddr[]);
void setDesIpAddr(U8 desIpAddr[]);

#endif //UDP_CORE_H
#ifndef UDPCORE_H_
#define UDPCORE_H_

#endif /*UDPCORE_H_*/
