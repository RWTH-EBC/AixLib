within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP.Internal;
function SocketDisconnect
  "External C function which disconnects connection on current port"

input Integer socketHandle "SocketHandle";
output Integer ans
    "External C-Function returns error handling and prints in case of failure a message. 0 = OK!, 1 == failed";

external "C" ans = SocketDisconnect(socketHandle) annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include");

annotation (Documentation(revisions="<HTML>
<ul><li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
         <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Implemented</li>
</ul>
</HTML>",info="<html>
<p>Function to shut down current TCP-connection and socket. </p>
<h4>Usage of Function</h4>
<p>Example connect to server with IP (0.11.11.11) on port 1234 and directly disconnect. </p>
<pre>model dummyUsage
  Integer state &quot;Return variable of functions 0 == OK!, 1 == error&quot;;
  Integer socketHandle &quot; Socket handle&quot;;

initial algorithm

  state := SocketInit();
  (socketHandle,state) := SocketConnect(&quot;0.11.11.11&quot;,&quot;1234&quot;);

equation

algorithm

 when terminal() then
  state := SocketDisconnect(socketHandle);
 end when;
end dummyUsage;</pre>
<p></ br>If server is running function connects to server 0.11.11.11 on port 1234, and directly disconnects. </p>
<h4>Errors</h4>
<p>state == 0, everything fine, state == 1, error where an error message will be reported in the Dymola messages window. Error codes and descriptions can be found in <code>UsersGuide</code>. </p>

<h4>C Source Code of <code>SocketDisconnect()</code></h4>

<p>Source code of <code>SocketDisconnect()</code>. </p>
<pre>int SocketDisconnect(int socketHandle)
{
         int iResult;
   // shutdown the connection since no more data will be sent
    iResult = shutdown(socketHandle, SD_SEND);
    if (iResult == SOCKET_ERROR) {
        ModelicaFormatMessage(&quot;SocketDisconnect(): Shutdown failed with error: &#37;d
&quot;, WSAGetLastError());
        closesocket(socketHandle);
        WSACleanup();
        return 1;
    }
        return 0;</pre>
<p><code>}</code> </p>
</html>"));
end SocketDisconnect;
