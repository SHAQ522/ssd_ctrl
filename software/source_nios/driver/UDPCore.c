
#include "source_reg.h"

static struct UDPacket sendPacket;
static struct UDPacket recvPacket;

#define IP_LENGTH_INDEX 16
#define IP_CHECKSUM_INDEX 24
#define UDP_LENGTH_INDEX 38
#define UDP_CHECKSUM_INDEX 40

//offset for global arrays
#define DES_MAC_INDEX 0
#define SRC_MAC_INDEX 6
#define DES_IP_INDEX 16 
#define SRC_IP_INDEX 12

#define CAMERA_SEND_BUF_ADDR *(char *)0x90090000
#define ctr_MAC *(volatile char *)0x90080012 
#define CAMERA_RECV_BUF_ADDR *(int *)0xA0240000            //CE2 cs[0]

static U8 gMacHeader[UDP_MAC_LENGTH] = {0x00, 0x30, 0x53, 0x0d, 0xf5, 0x84, 0x00, 0x1f, 0x16, 0x31, 0x6f, 0xb7, 0x08, 0x00};//0x0800 Íø¼ÊÐ­Òé£¨IP£©
static U8 gIPHeader[UDP_IPHEADER_LENGTH] = {0x45, 0x00, 0x00, 0x28, 0x25, 0xeb, 0x00, 0x00, 0x80, 0x11, 0x00, 0x00, 0xc0, 0xa8, 0x08, 0xca, 0xc0, 0xa8, 0x08, 0x7b};
static U8 gUDPHeader[UDP_UDPHEADER_LENGTH] = {0xd4, 0xba, 0x0f, 0x74, 0x00, 0x14, 0x00, 0x00};

static S32 initUDPacket(struct UDPacket *packet, U32 size);
static S32 setupUDPacket(struct UDPacket *packet, U8 *buffer, U32 size);
static S32 sendUDPacket(struct UDPacket *packet);
static S32 recvUDPacket(struct UDPacket *packet);
static void IPChecksum(struct UDPacket *packet);
static void UDPChecksum(struct UDPacket *packet);
static U16 checksum(U16 *buffer, U32 size);
static U32 getUDPPacketLength(struct UDPacket *packet);
void camera_isr();

//***************************************************************************************************************************//
static U8 gBroadCastMacMac[] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
static U8 gBroadCastIp[] = {0xFF, 0xFF, 0xFF, 0xFF};
//static U8 gBroadCastIp[] = {0xc0, 0xa8, 0x01, 0xFF};
static U8 gLocalMac[] = {0x00, 0x57, 0x48, 055, 0x00, 0x01};
       U8 gLocalIp[] = {0xc0, 0xa8, 0x08, 203};//192.168.8.203 
//static U8 gDstMac[] = {0x00, 0x15, 0x17, 0xa9, 0xf4, 0x69};
//static U8 gDstIp[] = {0xc0, 0xa8, 0x08, 3}; //192.168.1.1
//***************************************************************************************************************************//

S32 initUDPModule()
{
    setSrcMacAddr(gLocalMac);
    setSrcIpAddr(gLocalIp);
//    setDesMacAddr(gDstMac);    
//    setDesIpAddr(gDstIp);
    setDesMacAddr(gBroadCastMacMac);    
    setDesIpAddr(gBroadCastIp);
    return FUN_OK;
}

static S32 setupUDPacket(struct UDPacket *packet, U8 *buffer, U32 size)
{
    //sanity check
    U16 * packetBuffer16;
    if((packet == NULL) || (buffer == NULL)|| (size == 0))
        return BAD_PARAMETERS;

//    memset(packet->m_buffer, 0xAA, UDP_MAX_LENGTH);
    //init data structure
    initUDPacket(packet, size); 
    
    //fill data
    memcpy(packet->m_MACHeader, gMacHeader, UDP_MAC_LENGTH);    
    memcpy(packet->m_IPHeader, gIPHeader, UDP_IPHEADER_LENGTH);
    memcpy(packet->m_UDPHeader, gUDPHeader, UDP_UDPHEADER_LENGTH);
    memcpy(packet->m_UDPPayload, buffer, size);

    //calculate lenth parameters
    packetBuffer16 =  (U16 *)packet->m_buffer;
    //IP total length
    packetBuffer16[IP_LENGTH_INDEX/2] = size + UDP_UDPHEADER_LENGTH + UDP_IPHEADER_LENGTH;
    changeMode16(&(packetBuffer16[IP_LENGTH_INDEX/2]),1);
    //UDP length
    packetBuffer16[UDP_LENGTH_INDEX/2] = size + UDP_UDPHEADER_LENGTH;   
    changeMode16(&(packetBuffer16[UDP_LENGTH_INDEX/2]),1);  

    //calculate checksum parameters
    IPChecksum(packet);
    UDPChecksum(packet);
    //
    
    return FUN_OK;
}

static S32 initUDPacket(struct UDPacket *packet, U32 size)
{
    packet->m_UDPPayloadLength = size;
    packet->m_MACHeader = packet->m_buffer;
    packet->m_IPHeader = packet->m_MACHeader + UDP_MAC_LENGTH;
    packet->m_UDPHeader = packet->m_IPHeader + UDP_IPHEADER_LENGTH;
    packet->m_UDPPayload = packet->m_UDPHeader + UDP_UDPHEADER_LENGTH;
    return FUN_OK;
}

S32 sendNet(U8 *buffer, U32 size)
{
    U32 retVal;
    //struct UDPacket packet;
    //sanity check
    if((buffer == NULL)|| (size == 0))
        return BAD_PARAMETERS;
    retVal = setupUDPacket(&sendPacket, (U8 *)buffer, (U32)size);   
    if(retVal)
        return retVal;
    IOWR(EXPORT_BASE,PACKET_SIZE,size+UDP_MAC_LENGTH+UDP_IPHEADER_LENGTH+UDP_UDPHEADER_LENGTH+2);
    retVal = sendUDPacket(&sendPacket);
    IOWR(EXPORT_BASE,START_SEND,0);
    IOWR(EXPORT_BASE,START_SEND,1);
    IOWR(EXPORT_BASE,START_SEND,0);
    return retVal;
}

S32 recvNet(U8 *buffer, U32 size)
{
    int i = 0;
    camera_isr();
    if(size > UDP_MAX_LENGTH - UDP_MAC_LENGTH - UDP_IPHEADER_LENGTH - UDP_UDPHEADER_LENGTH)
        return BAD_PARAMETERS;
    for(i = 0; i < size; i++)
    {
        buffer[i] = recvPacket.m_buffer[i];
    }
    
    if(((U16 *)(buffer))[(UDP_MAC_LENGTH+UDP_IPHEADER_LENGTH+UDP_UDPHEADER_LENGTH)/2] != 0)
        return FUN_FAILED;
    
    //recvUDPacket(&recvPacket);
    //memcpy(recvPacket.m_UDPPayload, buffer, size);
    //memcpy(buffer, recvPacket.m_UDPPayload, size);
    //memcpy(buffer, recvPacket.m_buffer, size);
    return FUN_OK;
}

void setSrcMacAddr(U8 srcMacAddr[])
{
    if(srcMacAddr == NULL)
        return;
    memcpy(gMacHeader+SRC_MAC_INDEX, srcMacAddr, 6);
}

void setDesMacAddr(U8 desMacAddr[])
{
    if(desMacAddr == NULL)
        return;
    memcpy(gMacHeader+DES_MAC_INDEX, desMacAddr, 6);
}

void setSrcIpAddr(U8 srcIpAddr[])
{
    if(srcIpAddr == NULL)
        return;
    memcpy(gIPHeader+SRC_IP_INDEX, srcIpAddr, 4);   
}

void setDesIpAddr(U8 desIpAddr[])
{
    if(desIpAddr == NULL)
        return;
    memcpy(gIPHeader+DES_IP_INDEX, desIpAddr, 4);
}

static U16 checksum(U16 *buf, U32 count)
{
    U32 sum;

    for(sum=0;count>0;count--)
        sum += *buf++;
    sum = (sum>>16) + (sum&0xffff);
    sum += (sum>>16);

    return ~sum;
}

static void IPChecksum(struct UDPacket *packet)
{
    U16 * packetBuffer16 =  (U16 *)packet->m_buffer;
    packetBuffer16[IP_CHECKSUM_INDEX/2] = checksum((U16 *)packet->m_IPHeader, UDP_IPHEADER_LENGTH/2);   
}

/****************************************************
*    virtual header of TCP/UDP checksum
*  0        7        15      24       31 
*  +--------+--------+--------+--------+
*  |           source address          |
*  +--------+--------+--------+--------+
*  |        destination address        |
*  +--------+--------+--------+--------+
*  | zero   |protocol| TCP/UDP length  |
*  +--------+--------+--------+--------+
*
*  This program exec with a very low efficiency, someone
*   need to improve it in the future.
******************************************************/
static void UDPChecksum(struct UDPacket *packet)
{
    static U8 buffer[UDP_MAX_LENGTH];
    U16 *length;
    U16 * packetBuffer16 =  (U16 *)packet->m_buffer;
//    memset(buffer, 0x0, UDP_MAX_LENGTH);
    memcpy(buffer, packet->m_buffer+26, 8); // copy src & des address from packet
    buffer[8] = 0;
    buffer[9] = 0x11;
    length = (U16*)(buffer +10);
    *length = packet->m_UDPPayloadLength + UDP_UDPHEADER_LENGTH;    
    memcpy(buffer+12, packet->m_UDPHeader, packet->m_UDPPayloadLength+UDP_UDPHEADER_LENGTH);
    changeMode16(length, 1);
    packetBuffer16[UDP_CHECKSUM_INDEX/2] = checksum((U16*)buffer, (packet->m_UDPPayloadLength+12+UDP_UDPHEADER_LENGTH)/2);
    //packetBuffer16[UDP_CHECKSUM_INDEX/2] = 0x35;
}

static U32 getUDPPacketLength(struct UDPacket *packet)
{
    return (packet->m_UDPPayloadLength + UDP_MAC_LENGTH + UDP_IPHEADER_LENGTH + UDP_UDPHEADER_LENGTH);
}

/*static S32 sendUDPacket(struct UDPacket *packet)
{   
    U8 *addr;
    U32 i = 0;
    addr= (U8 *)&CAMERA_SEND_BUF_ADDR;
    
    //sanity check
    if(packet == NULL)
        return BAD_PARAMETERS;
    
        
    for(i=0;i<getUDPPacketLength(packet);i++)
    {
        *addr=packet->m_buffer[i];
        //printf("%02x ", packet->m_buffer[i]);
        addr=addr+0x1;
    }
    //printf("\n");    
    ctr_MAC=0xAA;
    usleep(100);              
    
    return FUN_OK;
}*/
static S32 sendUDPacket(struct UDPacket *packet)
{   
    U32 addr = 0;
    U32 i = 0;  
    //sanity check
    if(packet == NULL)
        return BAD_PARAMETERS;
          
    for(i=0;i<getUDPPacketLength(packet);i++)
    {
        IOWR_8DIRECT(UDPRAM_BASE,addr,packet->m_buffer[i]);
        addr=addr+1;
    }
    return FUN_OK;
}

static S32 recvUDPacket(struct UDPacket *packet)
{
    //sanity check
    if(packet == NULL)
        return BAD_PARAMETERS;
    //camera_isr(); 

    return FUN_OK;
}

void camera_isr()
{   
    U32 *rdaddr = (U32 *)&CAMERA_RECV_BUF_ADDR;
    int i = 0;    
    U32 tempData = 0;
    //U32 * recvBuf = (U32 *)recvPacket.m_buffer;
    //memset(recvPacket.m_buffer, 0xff, UDP_MAX_LENGTH);
    ctr_MAC = 0xCC;
    
    for(i = 0; i < (UDP_MAX_LENGTH/4); i++)
    {
        //recvBuf[i] = *rdaddr;
        tempData = *rdaddr;
        changeMode32(&tempData,1);
        memcpy(&(recvPacket.m_buffer[i*4]), &tempData, sizeof(U32));
    
        rdaddr=rdaddr+0x01;
        
    }

    
    initUDPacket(&recvPacket, UDP_MAX_LENGTH);  
    
    ctr_MAC=0xDD;   
}





