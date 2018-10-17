within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP;
function SocketSend "External C function to send data via current socket"

input String sendbuffer "Data to be send as a string";
input Integer length "Length of string to be send";
input Integer socketHandle "SocketHandle";
output Integer ans
    "External C-Function returns error handling and prints in case of failure a message. 0 = OK!, 1 == failed";
external "C" ans = SocketSend(sendbuffer,length,socketHandle) annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include");

annotation (Documentation(info="<html>

<p>
<code>SocketSend()</code> sends the data contained in sendbuffer to the server via the current socket.
 It is necessary to specify the current length of the message.
</p>

<h4>Usage of Function</h4>

<p>This code snippet will create a local socket and connect to server with IP 0.11.11.11 on port 1234
and send the message \"I am a message!\" with the length of 15 characters to the server
 every 1 second.</p>

<pre>
model dummyUsage

Integer state \"Return variable of functions 0 == OK!, 1 == Error\";
Integer socketHandle(start = 0) \"socket handle\";

  Modelica.SIUnits.Time sampleTrigger=1 \" Sampletime how often per second telegram is send\";

initial algorithm 

  (socketHandle,state) := TCPConstructor(\"0.11.11.11\",\"1234\");

equation

algorithm

  when {sampleTrigger} then

    state = SocketSend(\"I am a message!\", 15,socketHandle);

  end when;

end dummyUsage;

</pre>

<h4>Errors</h4>
<p>state == 0, everything fine, state == 1, error where an error message will be reported in the 
Dymola messages window. Error codes and descriptions can be found in <code>UsersGuide</code>.</p>

<h4>C Source Code of <code>SocketSend()</code></h4>

<p>Source code of <code>SocketSend()</code>.</p>

<pre>
//source code function
int SocketSend(tData sendbuf, int len, int socketHandle)
{
        int iResult;
    // Send an sendbuf
    iResult = send( socketHandle, sendbuf, len, 0 );
    if (iResult == SOCKET_ERROR) {
        ModelicaFormatMessage(\"SocketSend(): Send failed with error: %d\n\", WSAGetLastError());
        closesocket(socketHandle);
        WSACleanup();
        return 1;
    }
        return iResult;
}
</pre>

</html>",revisions="<HTML>
<ul><li><i>January 25, 2016&nbsp;</i>
         by Ana Constantin:<br />
         Added socketHandle to allow for more than one socket in a model</li>
          <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
         <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Implemented</li>
</ul>
</HTML>"));
end SocketSend;
