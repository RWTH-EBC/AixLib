within AixLib.Utilities.Communication.SocketCommunication.Components.BaseClasses;
partial model PartialTCPCommunicator
  "Partial Model of TCP-Interface, minimum code which needs additional information"

 // Base Class Discrete MIMO from MSL with discrete event mechanism via sampleTrigger
extends Modelica.Blocks.Interfaces.DiscreteMIMO;

/**************** Required input ****************************/
  parameter String IP_Address="127.0.0.1" "IP address or name of server";
  parameter Integer port(min=0)=27015 "Port on server";

 /**************** socket handle ***********************/
protected
  Modelica_DeviceDrivers.Communication.TCPIPSocketClient socketHandle = Modelica_DeviceDrivers.Communication.TCPIPSocketClient() "Socket handle";

  Boolean isConnected(start=false, fixed=true);

equation
  when initial() then
    isConnected = Modelica_DeviceDrivers.Communication.TCPIPSocketClient_.connect_(socketHandle, IP_Address, port);
  end when;

annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
            Documentation(info="<html><p>
  This is a partial model for a model which handles TCP communication.
  It only establishes a connection to a server on a certain port and
  terminates it when the simulation ends.
</p>
<p>
  Check <a href=
  \"modelica://AixLib.Utilities.Communication.SocketCommunication.Components.TCPCommunicatorExample\">
  TCPCommunicatorExample</a> for an algorithm example for sending and
  receiving telegrams.
</p>
<p>
  Note a server needs to be accessible for communication.
</p>
<p>
  Higher Level protocols (&gt;OSI-Level 5) need to be added depending
  on the specific application.
</p>
</html>",
revisions="<HTML>
<ul>
<li><i>August 25, 2018&nbsp;</i>
         by Thomas Beutlich:<br/>
         Utilize TCPIPSocketClient from Modelica_DeviceDrivers library. This is for:<a href=\"https://github.com/RWTH-EBC/AixLib/issues/277\">#277</a></li>

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
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end PartialTCPCommunicator;
