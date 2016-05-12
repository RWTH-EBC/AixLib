within AixLib.Utilities.Communication.SocketCommunication.Examples;
model ExampleClientLoop
  "Example to include TCP Communication to simple test server in the control loop"
extends Modelica.Icons.Example;
  Modelica.Blocks.Continuous.FirstOrder system(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=5) "Simple first order system to be controlled"
               annotation (Placement(transformation(extent={{-26,28},{-6,48}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-10})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=100, uMin=-100)
    "limits output of controller"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,-10})));
  Modelica.Blocks.Math.Gain gain(k=10) "Only gain controller"
                                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,-10})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=5,
    period=1,
    offset=5) "Pulse of set point"
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-10})));
  Components.TCPCommunicatorExample tCPCommunicatorExample(portExample="27015",
      IP_AddressExample="127.0.0.1")
    "TCP block which sends values and receives values, has no impact on signal"
    annotation (Placement(transformation(extent={{-66,32},{-46,52}})));
equation

  connect(system.y, feedback.u2)  annotation (Line(
      points={{-5,38},{0,38},{0,-2},{8.88178e-016,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.u, feedback.y) annotation (Line(
      points={{-16,-10},{-9,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, limiter.u) annotation (Line(
      points={{-39,-10},{-52,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, feedback.u1) annotation (Line(
      points={{39,-10},{8,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tCPCommunicatorExample.y[1], system.u) annotation (Line(
      points={{-45,42},{-38,42},{-38,38},{-28,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tCPCommunicatorExample.u[1], limiter.y) annotation (Line(
      points={{-68,42},{-86,42},{-86,-10},{-75,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}), graphics),
Documentation(revisions="<html>
<ul>
  <li><i>September 03, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised documented</li>
           <li><i>June 01, 2013&nbsp;</i>
  by Georg Ferdinand Schneider:<br />
         Implemented</li>
</ul>
</html>",
info="<html>

<p>This is a very simple example to show TCP-Communication functionality. A feedback
 control is modeled where a gain controller controls a first order block. The signal
 is send to a server and back. The signal is not altered by the server.</p>

<h4>Source code of TCP/IP-server</h4>

<p>This is is the source code of a server which may be utilized for testing. The
server simply returns after receiving the character message and sends it back
to the sender. The code may be compiled and executed from the console. This code
is taken from Microsoft´s Winsock documentation pages: <a href=\"http://msdn.microsoft.com/de-de/library/windows/desktop/ms737591%28v=vs.85%29.aspx\">Link to MSDN</a> </p>
The server performs the following tasks:
<ul>
<li>Initialise Winsock;</li>
<li>Create a socket;</li>
<li>Bind the socket;</li>
<li>Wait and listen on the socket if a client connects;</li>
<li>Accept incoming connection from client;</li>
<li>Receive messages from client as long as it sends and return the received messages unaltered;</li>
<li>Terminate connection and shut down.</li>
</ul>

<p>Note before copying for compiling: Some characters needed to be
changed to comply for HTML documentation (e.g. &amp;).
</p>

<pre>
// Copyright (c) 2015 Microsoft Corporation

#undef UNICODE

#define WIN32_LEAN_AND_MEAN

#include &lt;windows.h>&gt;
#include &lt;winsock2.h>&gt;
#include &lt;ws2tcpip.h>&gt;
#include &lt;stdlib.h>&gt;
#include &lt;stdio.h&gt;
#include \"stdafx.h\"

// Need to link with Ws2_32.lib
#pragma comment (lib, \"Ws2_32.lib\")

#define DEFAULT_BUFLEN 512
#define DEFAULT_PORT \"27015\"

int __cdecl main(void) 
{
    WSADATA wsaData;
    int iResult;

    SOCKET ListenSocket = INVALID_SOCKET;
    SOCKET ClientSocket = INVALID_SOCKET;

    struct addrinfo *result = NULL;
    struct addrinfo hints;

    int iSendResult;
    char recvbuf[DEFAULT_BUFLEN];
    int recvbuflen = DEFAULT_BUFLEN;
    
    // Initialize Winsock
    iResult = WSAStartup(MAKEWORD(2,2), &amp;wsaData);
    if (iResult != 0) {
        printf(\"WSAStartup failed with error: %d\n\", iResult);
        return 1;
    }

    ZeroMemory(&amp;hints, sizeof(hints));
    hints.ai_family = AF_INET;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_TCP;
    hints.ai_flags = AI_PASSIVE;

    // Resolve the server address and port
    iResult = getaddrinfo(NULL, DEFAULT_PORT, &amp;hints, &amp;result);
    if ( iResult != 0 ) {
        printf(\"getaddrinfo failed with error: %d\n\", iResult);
        WSACleanup();
        return 1;
    }

    // Create a SOCKET for connecting to server
    ListenSocket = socket(result->ai_family, result->ai_socktype, result->ai_protocol);
    if (ListenSocket == INVALID_SOCKET) {
        printf(\"socket failed with error: %ld\n\", WSAGetLastError());
        freeaddrinfo(result);
        WSACleanup();
        return 1;
    }

    // Setup the TCP listening socket
    iResult = bind( ListenSocket, result->ai_addr, (int)result->ai_addrlen);
    if (iResult == SOCKET_ERROR) {
        printf(\"bind failed with error: %d\n\", WSAGetLastError());
        freeaddrinfo(result);
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    freeaddrinfo(result);

    iResult = listen(ListenSocket, SOMAXCONN);
    if (iResult == SOCKET_ERROR) {
        printf(\"listen failed with error: %d\n\", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // Accept a client socket
    ClientSocket = accept(ListenSocket, NULL, NULL);
    if (ClientSocket == INVALID_SOCKET) {
        printf(\"accept failed with error: %d\n\", WSAGetLastError());
        closesocket(ListenSocket);
        WSACleanup();
        return 1;
    }

    // No longer need server socket
    closesocket(ListenSocket);

    // Receive until the peer shuts down the connection
    do {

        iResult = recv(ClientSocket, recvbuf, recvbuflen, 0);
        if (iResult > 0) {
            printf(\"Bytes received: %d\n\", iResult);

        // Echo the buffer back to the sender
            iSendResult = send( ClientSocket, recvbuf, iResult, 0 );
            if (iSendResult == SOCKET_ERROR) {
                printf(\"send failed with error: %d\n\", WSAGetLastError());
                closesocket(ClientSocket);
                WSACleanup();
                return 1;
            }
            printf(\"Bytes sent: %d\n\", iSendResult);
        }
        else if (iResult == 0)
            printf(\"Connection closing...\n\");
        else  {
            printf(\"recv failed with error: %d\n\", WSAGetLastError());
            closesocket(ClientSocket);
            WSACleanup();
            return 1;
        }

    } while (iResult > 0);

    // shutdown the connection since we're done
    iResult = shutdown(ClientSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        printf(\"shutdown failed with error: %d\n\", WSAGetLastError());
        closesocket(ClientSocket);
        WSACleanup();
        return 1;
    }

    // cleanup
    closesocket(ClientSocket);
    WSACleanup();

    return 0;
}
</pre>

</html>"),
 experiment(StopTime=100, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-120,-100},{100,100}})));
end ExampleClientLoop;
