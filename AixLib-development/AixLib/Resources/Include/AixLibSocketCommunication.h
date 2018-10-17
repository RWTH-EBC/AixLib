/** TCP socket support (header-only library).
 *
 * @author		Georg Ferdinand Schneider <Georg.Schneider@ibp.fraunhofer.de> supervised by Dr. Jens Oppermann <jens.oppermann@wilo.com> and Ana Constantin
 * @author		Artur Loewen<aloewen@eonerc.rwth-aachen.de> and Ana Constantin <aconstantin@eonerc.rwth-aachen.de>
 * @version	    2016-01-25 12:00:00 V1.2
				2015-11-12 17:00:00 V1.1
 * @since		2012-04-01
 */

  
#ifndef AIXLIBSOCKETCOMMUNICATION_H_
#define AIXLIBSOCKETCOMMUNICATION_H_

#include "ModelicaUtilities.h"

#if defined(_MSC_VER)

#include <winsock2.h>
#include <ws2tcpip.h>
#include <string.h>

#define MAX_SIZE	256 // Defines maximum number of characters in one message

// Need to link with Ws2_32.lib, Mswsock.lib, and Advapi32.lib
#pragma comment (lib, "Ws2_32.lib")
#pragma comment (lib, "Mswsock.lib")
#pragma comment (lib, "AdvApi32.lib")

// Typedefinitions in the begining
typedef const char* tIpAddr; // string with IP Address of Server
typedef const char* tPort; // String with port number of Server
typedef const char* tData; // String of Data to be send
typedef unsigned char* tByte; // Array of Byte to be received
 
 
// Global data needed in process
    WSADATA gWsaData; 
    struct addrinfo *gpResult = NULL,
                    *gPtr = NULL,
                    gHints; // 3 times struct addrinfo
					
/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
// Functions to handle TCP communication


int SocketInit(void) // Initialize a Socket, incorporated in TCPConstructor()
{
	int ans;
   // Initialize Winsock
    ans = WSAStartup(MAKEWORD(2,2), &gWsaData);
    if (ans != 0) {
	ModelicaFormatMessage("SocketInit(): WSAStartup failed with error: %d\n", ans);
	return 1;
    }
	
    ZeroMemory( &gHints, sizeof(gHints) );
    gHints.ai_family = AF_UNSPEC;
    gHints.ai_socktype = SOCK_STREAM;
    gHints.ai_protocol = IPPROTO_TCP;
	return ans;
}

int SocketDestruct(int socketHandle) // Destruct socket identified by socketHandle and clean up
{
    // cleanup
    closesocket(socketHandle);
    WSACleanup();
	return 0;
}

// socketHandle is output
int SocketConnect(tIpAddr ip, tPort port, int* socketHandle) // Connect to server on ip and port via socket identified by socketHandle
{
	int iResult;
    // Resolve the server address and port
    iResult = getaddrinfo(ip, port, &gHints, &gpResult);
    if ( iResult != 0 ) {
		ModelicaFormatMessage("SocketConnect(): getaddrinfo failed with error: %d\n", iResult);
        WSACleanup();
        return 1;
    }

    // Attempt to connect to an address until one succeeds
    for(gPtr=gpResult; gPtr != NULL ;gPtr=gPtr->ai_next) {

        // Create a SOCKET for connecting to server
        *socketHandle = socket(gPtr->ai_family, gPtr->ai_socktype, 
            gPtr->ai_protocol);
        if (*socketHandle == INVALID_SOCKET) {
			ModelicaFormatMessage("SocketConnect(): Socket failed with error: %ld\n", WSAGetLastError());
			WSACleanup();
            return 1;
        }

        // Connect to server.
        iResult = connect( *socketHandle, gPtr->ai_addr, (int)gPtr->ai_addrlen);
        if (iResult == SOCKET_ERROR) {
            closesocket(*socketHandle);
            *socketHandle = INVALID_SOCKET;
            continue;
        }
        break;
    }

    freeaddrinfo(gpResult);

    if (*socketHandle == INVALID_SOCKET) {
		ModelicaFormatMessage("SocketConnect(): Unable to connect to server!\n");     
		WSACleanup();
        return 1;
    }
	return 0;
}

int SocketDisconnect(int socketHandle) // End communcation of socket identified by socketHandle
{
 	int iResult;
   // shutdown the connection since no more data will be sent
    iResult = shutdown(socketHandle, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        ModelicaFormatMessage("SocketDisconnect(): Shutdown failed with error: %d\n", WSAGetLastError());
        closesocket(socketHandle);
        WSACleanup();
        return 1;
    }
	return 0;
}

int SocketSend(tData sendbuf, int len, int socketHandle) // Send data via socket identified by socketHandle
{
	int iResult;
    // Send an initial buffer
    iResult = send(socketHandle, sendbuf, len, 0 );
    if (iResult == SOCKET_ERROR) {
        ModelicaFormatMessage("SocketSend(): Send failed with error: %d\n", WSAGetLastError());
        closesocket(socketHandle);
        WSACleanup();
        return 1;
    }
	return iResult;
}

int SocketReceive(const char **buffer, int maxLen, int socketHandle) // Receive data on socket identified by socketHandle
{
	int iResult;
	char *answerBuffer;
	answerBuffer = ModelicaAllocateString(maxLen);
	iResult = recv(socketHandle, answerBuffer, maxLen, 0);
	*buffer = answerBuffer;
	return iResult;
}

int TCPConstructor(int* socketHandle, tIpAddr ip, tPort port) // Initialize socket identified by socketHandle and connect to server
{
	// Intialize socket
    if (0 != SocketInit())
	{
	ModelicaFormatMessage("SocketInit(): Unable to initialise socket!\n");  
      return 1;
    }
			
	// Connect to Server with ip on port
	if (0 != SocketConnect(ip, port, socketHandle)) {
	ModelicaFormatMessage("SocketConnect(): Unable to connect to server!\n");  
		return 2;
	}
	return 0;
}

/* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
// Functions for data conversion of protocol specific problems
 
unsigned char *convertHextoByte(char *HEXStr) {
    int i, n;
	int len = strlen(HEXStr)/2;
	char *buffer;
 
	buffer = ModelicaAllocateString(len);
//	ModelicaFormatMessage("HEX-String: %s\n", HEXStr); //for Debugging

	for(i = 0; i < len; i++) {
        sscanf(HEXStr+2*i, "%02X", &n);
        buffer[i] = (char)n;
//		ModelicaFormatMessage("Byte: %02X %s", buffer[i],"\n"); // for Debugging
    }
	return buffer;
}

float convertBytetoSgl(unsigned char *ByteArray) {
	char byArr[4];
    int i;
  
    union record_4 {
      char c[4];
      unsigned char u[4];
      short s[2];
      long l;
      float f;
    } r;
  
//    strcpy(r.c, "Error !"); // for Debugging
//    strcpy(r.c, "1234567");

// Change order high and low byte
	r.u[0] = ByteArray[1];
	r.u[1] = ByteArray[0];
	r.u[2] = ByteArray[3];
	r.u[3] = ByteArray[2];
  
//    ModelicaFormatMessage("%s\n", r.c);
//    for(i=0;i<4;i++) ModelicaFormatMessage("%d ",  r.c[i]); ModelicaFormatMessage("\n");
//    for(i=0;i<4;i++) ModelicaFormatMessage("%d ",  r.u[i]); ModelicaFormatMessage("\n");
//    for(i=0;i<2;i++) ModelicaFormatMessage("%d ",  r.s[i]); ModelicaFormatMessage("\n");
//    for(i=0;i<1;i++) ModelicaFormatMessage("%ld ", r.l[i]); ModelicaFormatMessage("\n");
//    for(i=0;i<1;i++) ModelicaFormatMessage("%f ",  r.f[i]); ModelicaFormatMessage("\n");
//    ModelicaFormatMessage("%lf\n", r.d);
//    ModelicaFormatMessage("%f\n", r.f);

//		ModelicaFormatMessage("Byte: %02X %s", buffer[i],"\n"); // for Debugging

	return r.f; // *((Float*)&byArr)
}

unsigned char *convertDbltoHex(double num) {
	unsigned char *byArr;
	unsigned char *buffer;
    int i;
    float num_f;

    union record_4 {
      char c[4];
      unsigned char u[4];
      short s[2];
      long l;
      float f;
    } r;
  
	r.f = (float)num; //Type cast into float, because Modelica Type Real is Double.
	byArr = ModelicaAllocateString(4);
	buffer = ModelicaAllocateString(8);
	
	// Change order high and low byte
	byArr[0] = r.u[1];
	byArr[1] = r.u[0];
	byArr[2] = r.u[3];
	byArr[3] = r.u[2];

	//    ModelicaFormatMessage("%s\n", r.c);
/*    for(i=0;i<4;i++) ModelicaFormatMessage("%d ",  r.c[i]); ModelicaFormatMessage("\n");
    for(i=0;i<4;i++) ModelicaFormatMessage("%d ",  r.u[i]); ModelicaFormatMessage("\n");
    for(i=0;i<2;i++) ModelicaFormatMessage("%d ",  r.s[i]); ModelicaFormatMessage("\n");
    for(i=0;i<1;i++) ModelicaFormatMessage("%ld ", r.l); ModelicaFormatMessage("\n");
    for(i=0;i<1;i++) ModelicaFormatMessage("%f ",  r.f); ModelicaFormatMessage("\n");
    ModelicaFormatMessage("%lf\n", num);
	for(i=0;i<4;i++) ModelicaFormatMessage("Byte: %02X %s", byArr[i],"\n"); ModelicaFormatMessage("\n");// for Debugging
*/	
	for(i = 0; i < 4; i++) {
        sprintf(buffer+2*i, "%02X", byArr[i]);
	}
//	ModelicaFormatMessage("%s\n", buffer);
	
	return buffer; // *((Float*)&byArr)
}

char *convertBytetoHex(unsigned char *ByteStr) {
    int i;
	char *buffer;
	int len = strlen(ByteStr);

	buffer = ModelicaAllocateString(len*2+1);

    for(i = 0; i < len; i++) {
        sprintf(buffer+2*i, "%02X", ByteStr[i]);
   //     ModelicaFormatMessage("Byte out: %02X ", ByteStr[i]); // for Debugging
	}
    return buffer;
}
 
#endif /* defined(_MSC_VER) */

#endif /* AIXLIBSOCKETCOMMUNICATION_H_ */