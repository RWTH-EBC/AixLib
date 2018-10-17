within AixLib.Utilities.Communication.SocketCommunication.Components.BaseClasses;
partial model PartialTCPCommunicator
  "Partial Model of TCP-Interface, minimum code which needs additional information"

 // Base Class Discrete MIMO from MSL with discrete event mechanism via sampleTrigger
extends Modelica.Blocks.Interfaces.DiscreteMIMO;

/**************** Required input ****************************/
  parameter String  IP_Address="127.0.0.1" "IP address or name of Server";
  parameter String  port="27015" "Port on server";

 /**************** socket handle ***********************/
 Integer socketHandle(start = 0) "socket handle";

/**************** Error handling of C functions ***********************/
   Integer state(start = 0)
    "Variable to check state of external C-function, 0 corresponds to OK, 1 to failure. Error messages are reported.";

initial algorithm
  /**************** initialize TCP socket and connect to server**************/
  // At start of simulation socket is created and connection to server is established
  // socketHandle is variable to initialize and access multiple sockets

(socketHandle,state) := Functions.TCP.TCPConstructor(IP_Address, port);

equation

algorithm

// Insert here protocol specific send and receive functions

 when terminal() then
/**************** Terminate connection to server at end of simulation  **************/
    state := Functions.TCP.SocketDestruct(socketHandle);
    socketHandle := 0;
  end when;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                             graphics),
            Documentation(info="<html>
<p>This is a partial model for a model which handles TCP-Communication. It only establishes a connection to a server on a certain port and terminates it when the simulation ends. </p>
<p>Check <a href=\"modelica://AixLib.Utilities.Communication.SocketCommunication.Components.TCPCommunicatorExample\">TCPCommunicatorExample
</a>  for an algorithm example for sending and receiving telegrams. </p>
<p>Note a server needs to be accessible for communcation. </p>
<p>Higher Level protocols (&gt;OSI-Level 5) need to be added depending on the specific application. </p>
</html>",
revisions="<HTML>
<ul>
<li><i>January 25, 2016&nbsp;</i>
         by Ana Constantin:<br/>
         Added socketHandle to allow for more than one socket in a model</li>

<li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br/>
         Revised for publishing</li>

<li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br/>
         First implementation
</li>



</ul>
</HTML>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end PartialTCPCommunicator;
