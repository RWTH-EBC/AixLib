within AixLib.Controls.HVACAgentBasedControl.BaseClasses;
model UDPSend_adapted "A block for sending UDP datagrams"
  import Modelica_DeviceDrivers;
  extends Modelica_DeviceDrivers.Utilities.Icons.BaseIcon;
  extends Modelica_DeviceDrivers.Utilities.Icons.UDPconnection;
  import Modelica_DeviceDrivers.Packaging.SerialPackager;
  import Modelica_DeviceDrivers.Communication.UDPSocket;

  // Parameter Modelica.SIunits.Period sampleTime=0.01
  //  "Sample time for update";
  parameter Boolean autoBufferSize = true
    "true, buffer size is deduced automatically, otherwise set it manually."
    annotation(Dialog(group="Outgoing data"), choices(checkBox=true));
  parameter Integer userBufferSize=16*1024
    "Buffer size of message data in bytes (if not deduced automatically)." annotation(Dialog(enable=not autoBufferSize, group="Outgoing data"));
  parameter String IPAddress="127.0.0.1" "IP address of remote UDP server"
    annotation (Dialog(group="Outgoing data"));
  Real port_send "Target port of the receiving UDP server"
    annotation (Dialog(group="Outgoing data"));
  Modelica_DeviceDrivers.Blocks.Interfaces.PackageIn pkgIn
    "Port for the data to send"                                                        annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-108,0})));
protected
  UDPSocket socket = UDPSocket(0);
  Integer bufferSize;
  Real dummy;
public
  Modelica.Blocks.Interfaces.BooleanInput trigger
    "Input to start the sending procedure"                                                annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput receiver
    "Input for receiving agent name"                                             annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,100})));
  Modelica.Blocks.Interfaces.BooleanOutput send
    "Turns true when a message is send"                                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={6,-90})));
equation
  port_send = receiver;
  when initial() then
    pkgIn.userPkgBitSize = if autoBufferSize then -1 else userBufferSize*8;
    pkgIn.autoPkgBitSize = 0;
    bufferSize = if autoBufferSize then Modelica_DeviceDrivers.Packaging.SerialPackager_.getBufferSize(pkgIn.pkg) else userBufferSize;
  end when;
  pkgIn.backwardTrigger = trigger;
  // pkgIn.backwardTrigger = noEvent(sample(0, sampleTime));
  when noEvent(trigger) then
    dummy = AixLib.Controls.HVACAgentBasedControl.BaseClasses.Internal.sendToUDP(
      socket,
      IPAddress,
      port_send,
      pkgIn.pkg,
      bufferSize,
      pkgIn.dummy);
  end when;
  connect(trigger, send) annotation (Line(points={{0,100},{4,100},{4,-90},{
          6,-90}}, color={255,0,255}));
  annotation (preferredView="info",
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Text(extent={{-150,136},{150,96}},
            textString="%name")}), Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model implements sending data via UDP
  </li>
  <li>It is copied and extended from the Modelica_DeviceDrivers library
  </li>
  <li>It is used by all implemented agents
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The model changes the model published in the Modelica_DeviceDrivers
  library by an input for the name of the receiver. The receiver is
  therefore no longer a parameter but now a variable of the model. This
  change is necessary as some agents need to communicate with a number
  of different recipents (the broker for example).
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<ul>
  <li>Roozbeh Sangi, Felix Bünning, Johannes Fütterer, Dirk Müller. A
  Platform for the Agent-based Control of HVAC Systems. Modelica
  Conference, 2017, Prague, Czech Republic.
  </li>
  <li>Felix Bünning, Roozbeh Sangi, Dirk Müller. A Modelica library for
  agent-based control of building HVAC systems. Applied Energy,
  193:52-59, 2017.
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Example Results</span>
</h4>
<ul>
  <li>
    <a href=
    \"HVACAgentBasedControl.Examples.HVACAgentsCommunications.SimpleCommunication\">
    ExampleAgentSystem</a>
  </li>
</ul>
<ul>
  <li>July 2017, by Roozbeh Sangi: Documentation revised
  </li>
  <li>October 2015, by Felix Bünning: Copied and adapted from the
  Modelica DeviceDrivers library
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})));
end UDPSend_adapted;
