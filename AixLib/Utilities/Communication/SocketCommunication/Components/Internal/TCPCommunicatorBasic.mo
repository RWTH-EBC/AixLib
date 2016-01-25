within AixLib.Utilities.Communication.SocketCommunication.Components.Internal;
partial model TCPCommunicatorBasic
  "Partial Model of TCP-Interface, minimum code needs additional information"

extends Modelica.Blocks.Interfaces.DiscreteMIMO; // Base Class Discrete MIMO for discrete events (sampleTrigger)

/**************** necessary Input ****************************/
  parameter String  IP_Address="127.0.0.1" "IP address or name of Server";
  parameter String  port="27015" "Port on server";

    /**************** socket handle ***********************/
   Integer socketHandle(start = 0) "socket handle";
/**************** Error handling of functions ***********************/
   Integer state
    "dummy variable to check state of C-function, 0 accords OK, 1 failure";

initial algorithm
  /**************** initialize TCP socket and connect to server**************/
// At start of simulation socket is created and connection to server is established
socketHandle :=0;

(socketHandle,state) :=Functions.TCP.TCPConstructor(IP_Address, port);

equation

algorithm

/* Insert here protocol specific send and receive functions
 Use following when loop for time discrete call of functions
   
/******************* EXAMPLE *********/
/*   when {sampleTrigger} then 
   for j in 1:numberWR loop
        //send message
          state := Functions.TCP.MySocketSend(message, intLength);
        
         //receive
         (messageRecv, state) := Functions.TCP.MySocketReceive(maxLen);
      
      end for;
   end when;
*/

 when terminal() then
/**************** Terminate connection to server at end of simulation  **************/
    state :=Functions.TCP.SocketDestruct(socketHandle);
  end when;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                             graphics),
            Documentation(info="<html>

<p>
This is a partial model for a model which handles TCP-Communication. It only establishes a connection
to a server on a certain port and terminates it when the simulation ends. To send and receive
telegrams the piece of code in algorithm has to be uncommented.
<p>
Note a server needs to be accessible for communcation.
<p>
Higher Level protocols (>OSI-Level 5) need to be added depending on the specific application.

</p>
</html>",
revisions="<HTML>
<ul>
  <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         First implementation
</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

</ul>
</HTML>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics));
end TCPCommunicatorBasic;
