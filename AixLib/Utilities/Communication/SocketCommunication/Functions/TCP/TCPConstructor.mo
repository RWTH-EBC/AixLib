within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP;
function TCPConstructor
  "External C function to construct a socket for TCP communication"
input String IP "IP of PC to connect to";
input String port "Port number where to connect to";
output Integer socketHandle "SocketHandle";
output Integer ans
    "dummy answer 0 = OK!, 1 == Intialization failed, 2 == Connect failed";

external "C" ans = TCPConstructor(IP,port,socketHandle) annotation (
Include="#include \"TCP_Lib.h\"",
 IncludeDirectory="modelica://ConnectivityTCP/Resources/Include");

annotation (Documentation(info="<html>

<p>
Intializes a TCP socket and connects to a server on a certain port.
 Comprises MySocketInit() and MySocketConnect().
 
 
</p>
<h4>Usage of function</h4>

This code snippet will create a local socket and connect to server 
with IP 0.11.11.11 on port 1234.
<p>

<pre>
model dummyUsage

  Integer state \"Return variable of functions 0 == OK!\";
   
initial algorithm 

  state := TCP_Constructor(\"0.11.11.11\",\"1234\");

equation

algorithm
 
end dummyUsage;

</pre>

<h4>Errors</h4>
state == 0, everything fine, state == 1, error where an error message will be reported in the 
Dymola messages window. Error codes and descriptions can be found in UsersGuide.

<h4>C Source Code of TCP_Constructor()</h4>

Source code of TCP_Constructor() in external header file.
<p>
<pre>
int TCP_Constructor(tIpAddr ip, tPort port)
{
        // Intialize socket
    if (0 != MySocketInit())
        {
        ModelicaFormatMessage(\"MySocketInit(): Unable to initialise socket!\n\");  
      return 1;
    }
                        
        // Connect to Server with ip on port
        if (0 != MySocketConnect(ip, port)) {
        ModelicaFormatMessage(\"MySocketConnect(): Unable to connect to server!\n\");  
                return 1;
        }
        return 0;
}
</pre>

</html>"));
end TCPConstructor;
