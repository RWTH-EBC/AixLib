within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP;
function TCPConstructor
  "External C function to construct a socket for TCP communication"

  output Integer socketHandle "SocketHandle";
  input String IP "IP of PC to connect to";
  input String port "Port number where to connect to";
  output Integer ans
    "External C-Function returns error handling and prints in case of failure a message. 0 = OK!, 1 == Intialization failed, 2 == Connect failed";

external "C" ans = TCPConstructor(socketHandle,IP,port) annotation (
Include="#include \"AixLibSocketCommunication.h\"",
 IncludeDirectory="modelica://AixLib/Resources/Include");

annotation (Documentation(info="<html>

<p>
Intializes a TCP socket and connects to a server on a certain port.
Comprises <code>SocketInit()</code> and <code>SocketConnect()</code>. </p>
 
 

<h4>Usage of function</h4>

<p>This code snippet will create a local socket and connect to server 
with IP 0.11.11.11 on port 1234.</p>

<pre>
model dummyUsage

  Integer state \"Return variable of functions 0 == OK!\";
  Integer socketHandle(start = 0) \"socket handle\";
  
initial algorithm 

  (socketHandle,state) := TCPConstructor(1,\"0.11.11.11\",\"1234\");

equation

algorithm
 
end dummyUsage;

</pre>

<h4>Errors</h4>
<p>state == 0, everything fine, state == 1, error where an error message will be
reported in the simulation messages window. Error codes and descriptions can be
found in <code>UsersGuide</code>.</p>

<h4>C Source Code of <code>TCPConstructor()</code></h4>

<p>Source code of <code>TCPConstructor()</code> in external header file.</p>

<pre>
int TCPConstructor(int* socketHandle, tIpAddr ip, tPort port)
{
        // Intialize socket
    if (0 != SocketInit())
        {
        ModelicaFormatMessage(\"SocketInit(): Unable to initialise socket!&#92;n\");  
      return 1;
    }
                        
        // Connect to Server with ip on port
        if (0 != SocketConnect(ip, port,socketHandle)) {
        ModelicaFormatMessage(\"SocketConnect(): Unable to connect to server!&#92;n\");  
                return 1;
        }
        return 0;
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
end TCPConstructor;
