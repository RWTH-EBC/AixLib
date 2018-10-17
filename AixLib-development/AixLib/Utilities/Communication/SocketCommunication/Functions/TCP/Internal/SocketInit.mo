within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP.Internal;
function SocketInit "External C function to initialize a TCP Socket"
  output Integer ans
    "External C-Function returns error handling and prints in case of failure a message. 0 = OK!, 1 == failed";

external "C" ans = SocketInit() annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include");

annotation (Documentation(
info="<HTML>
<p>
Function to initialize a TCP-Socket. Needs to be called at first. Note that <code>SocketInit()</code> 
is already included in <code>TCP_Constructor()</code> and is here just for debugging. Returns 0 if initialization 
was successful.
</p>

<h4>Usage of Function</h4>
This code snippet will create a local socket.
<p>

<pre>
model dummyUsage

Integer state \"Return variable of functions 0 == OK!, 1 == error\";
Integer socketHandle \" Socket Handle\";
   
initial algorithm 

  state := SocketInit();

equation

algorithm
 
end dummyUsage;

</pre>

<h4>Errors</h4>
state == 0, everything fine, state == 1, error where an error message will be reported in the 
Dymola messages window. Error codes and descriptions can be found in <code>UsersGuide</code>.

<h4>C-Code of <code>SocketInit()</code></h4>

<p>Source code of function <code>SocketInit()</code>.
</p>
<pre>
int SocketInit(void) // Initialize a Socket, Incorporated in TCP_Constructor()
{
        int ans;
   // Initialize Winsock
    ans = WSAStartup(MAKEWORD(2,2), &gWsaData);
    if (ans != 0) {
    ModelicaFormatMessage(&quot;SocketInit(): WSAStartup failed with error: %d
 &quot;, ans);
        return 1;
    }
        
    ZeroMemory( &gHints, sizeof(gHints) );
    gHints.ai_family = AF_UNSPEC;
    gHints.ai_socktype = SOCK_STREAM;
    gHints.ai_protocol = IPPROTO_TCP;
        return ans;
}
</pre>
</p>
</HTML>",
revisions="<HTML>
<ul><li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
         <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Implemented</li>
</ul>
</HTML>"));
end SocketInit;
