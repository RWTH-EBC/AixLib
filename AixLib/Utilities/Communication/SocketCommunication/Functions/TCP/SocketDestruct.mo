within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP;
function SocketDestruct "External C function to close socket and free memory"
input Integer socketHandle "SocketHandle";
output Integer ans
    "External C-Function returns error handling and prints in case of failure a message. 0 = OK!, 1 == failed";

external "C" ans = SocketDestruct(socketHandle) annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include");

annotation (Documentation(info="<html>

<p>
Function to destruct current socket. Closes socket and frees memory.
 Necessary to call as last function.
</p>
<h4>Usage of Function</h4>

This code snippet will create a local socket and connect to server with IP 0.11.11.11 on port 1234
and send the message \"I am a message!\" with the length of 15 characters to the server
 every 1 second. If the server sends something after receiving the send message it will receive 
 this message and safe it into bufferRecv. When the simulation ends the socket is closed and 
 blocked memory ist freed.
 <p>
<pre>

model dummyUsage

  Integer state \"Return variable of functions 0 == OK!, 1 == Error\";
  Integer socketHandle(start = 0) \"socket handle\";
  Modelica.SIUnits.Time sampleTrigger=1 \" Sampletime how often per second telegram is send\";
  parameter Interger maxLen = 512 \"Limits the maximum number of characters receiveable\";
  String bufferRecv \"Variable where received message\";
  
initial algorithm 

  (socketHandle,state) := TCPConstructor(\"0.11.11.11\",\"1234\");

equation

algorithm

  when {sampleTrigger} then

    state = SocketSend(\"I am a message!\", 15,socketHandle);
    (bufferRecv, state) = SocketReceive(maxLen,socketHandle);
  
  end when;

  when terminal() then
    state := SocketDestruct(socketHandle);
  end when;

end dummyUsage;


</pre>


<h4>Errors</h4>
state == 0, everything fine, state == 1, error where an error message will be reported in the 
Dymola messages window. Error codes and descriptions can be found in UsersGuide.

<h4>C Source Code of SocketDestruct()</h4>

Source code of SocketDestruct().
<p>
<pre>
int SocketDestruct(int socketHandle)
{
    // cleanup
    closesocket(socketHandle);
    WSACleanup();
        return 0;
}
</pre>
</html>"));
end SocketDestruct;
