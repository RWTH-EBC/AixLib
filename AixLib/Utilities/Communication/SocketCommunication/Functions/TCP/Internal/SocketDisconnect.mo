within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP.Internal;
function SocketDisconnect
  "External C function which disconnects connection on current port"

input Integer socketHandle "SocketHandle";
output Integer ans "dummy variable answer, 0 = OK!, 1 == error";

external "C" ans = SocketDisconnect(socketHandle) annotation (
Include="#include \"TCP_Lib.h\"",
 IncludeDirectory="modelica://ConnectivityTCP/Resources/Include");

annotation (Documentation(revisions="<HTML>
<ul>
  <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         First implementation
</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

</ul>
</HTML>",info="<html>

<p>
Function to shut down current TCP-connection and socket.
</p>

<h4>Usage of Function</h4>

Example connect to server with IP (0.11.11.11) on port 1234 and directly disconnect.

<pre>

model dummyUsage

  Integer state \"Return variable of functions 0 == OK!, 1 == error\";
   
initial algorithm 

  state := SocketInit();
  state := SocketConnect(\"0.11.11.11\",\"1234\");
  
equation

algorithm

 when terminal() then
  state := SocketDisconnect();
 end when;
end dummyUsage;
</pre>
<p>
If server is running function connects to server 0.11.11.11 on port 1234, and directly disconnects.


<h4>Errors</h4>
state == 0, everything fine, state == 1, error where an error message will be reported in the 
Dymola messages window. Error codes and descriptions can be found in UsersGuide.

<h4>C Source Code of SocketDisconnect()</h4>

Source code of SocketDisconnect().
<p>
<pre>
int SocketDisconnect(void)
{
         int iResult;
   // shutdown the connection since no more data will be sent
    iResult = shutdown(gConnectSocket, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        ModelicaFormatMessage(\"SocketDisconnect(): Shutdown failed with error: %d\n\", WSAGetLastError());
        closesocket(gConnectSocket);
        WSACleanup();
        return 1;
    }
        return 0;
}
</pre>

</html>"));
end SocketDisconnect;
