within AixLib.Utilities.Communication.SocketCommunication.Examples;
model ExampleClientLoop
  "Example to include TCP communication to simple test server in the control loop"
extends Modelica.Icons.Example;
  Modelica.Blocks.Continuous.FirstOrder system(
    k=1,
    T=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y_start=5) "Simple first order system to be controlled"
               annotation (Placement(transformation(extent={{-26,28},{-6,48}})));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-10})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=100, uMin=-100)
    "limits output of controller"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-64,-10})));
  Modelica.Blocks.Math.Gain gain(k=10) "Only gain controller"
                                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,-10})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=5,
    period=1,
    offset=5) "Pulse of set point"
              annotation (preferredView="diagram",
    experiment(StartTime=0, StopTime=10,Tolerance=1.0e-4),
    Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-10})));
  Components.TCPCommunicatorExample tCPCommunicatorExample(portExample=27015,
    samplePeriodExample=0.01,
    IP_AddressExample="127.0.0.1")
    "TCP block which sends values and receives values, has no impact on signal"
    annotation (Placement(transformation(extent={{-66,28},{-46,48}})));
equation

  connect(system.y, feedback.u2)  annotation (Line(
      points={{-5,38},{0,38},{0,-2},{8.88178e-016,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.u, feedback.y) annotation (Line(
      points={{-16,-10},{-9,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, limiter.u) annotation (Line(
      points={{-39,-10},{-52,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pulse.y, feedback.u1) annotation (Line(
      points={{39,-10},{8,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tCPCommunicatorExample.y[1], system.u) annotation (Line(
      points={{-45,38},{-28,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tCPCommunicatorExample.u[1], limiter.y) annotation (Line(
      points={{-68,38},{-86,38},{-86,-10},{-75,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (preferredView="diagram",Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -100},{100,100}}), graphics),
Documentation(revisions="<html><ul>
  <li>
    <i>August 25, 2018&#160;</i> by Thomas Beutlich:<br/>
    Changed data type of port from String to Integer. This is
    for:<a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/277\">#277</a>
  </li>
  <li>
    <i>September 03, 2013&#160;</i> by Georg Ferdinand Schneider:<br/>
    Revised documented
  </li>
  <li>
    <i>June 01, 2013&#160;</i> by Georg Ferdinand Schneider:<br/>
    Implemented
  </li>
</ul>
</html>",
info="<html><p>
  This is a very simple example to show the TCP communication
  functionality. A feedback control is modeled where a gain controller
  controls a first order system. The signal is send to a server which
  returns the send message unaltered back to the client.
</p>
<h4>
  TCP/IP-server for testing
</h4>
<p>
  A server to test <code>ExampleClientLoop</code> is provided both as a
  source code <a href=
  \"modelica://AixLib/Resources/SocketCommunicationServer/ExampleServer.cpp\">
  *.cpp-file</a> and as an executable <a href=
  \"modelica://AixLib/Resources/SocketCommunicationServer/ExampleServer.exe\">
  *.exe-file</a>. The server simply echoes the received character
  message and sends it back to the sender (i.e. client). The code may
  be compiled and executed from the console. This code is taken from
  Microsoft's Winsock documentation pages: <a href=
  \"http://msdn.microsoft.com/de-de/library/windows/desktop/ms737591%28v=vs.85%29.aspx\">
  Link to MSDN</a>
</p>The server performs the following tasks:
<ul>
  <li>Initialise Winsock;
  </li>
  <li>Create a socket;
  </li>
  <li>Bind the socket;
  </li>
  <li>Wait and listen on the socket if a client connects;
  </li>
  <li>Accept incoming connection from client;
  </li>
  <li>Receive messages from client as long as it sends and return the
  received messages unaltered;
  </li>
  <li>Terminate connection and shut down.
  </li>
</ul>
<h4>
  Usage
</h4>
<p>
  Open a console in Windows (Start -&gt; Run -&gt; insert: \"cmd\"),
  change folder to
  <code>.../AixLib/Resources/SocketCommunicationServer</code>, run
  <code>ExampleServer.exe</code>. The Server is now ready to operate.
  Now simulate <code>ExampleClientLoop</code>.
</p>
<h4>
  Verification of IP address
</h4>
<p>
  Note: Depending on your network settings it may be required to change
  the IP address in
  <code>ExampleClientLoop.tCPCommunicatorExample</code>. Set the IP
  address to the IP address of your local machine. (You may retrieve
  your local IP address in Windows from the console (Start -&gt; Run
  -&gt; insert: \"cmd\" -&gt; ipconfig)).
</p>
<h4>
  Requirements
</h4>
<p>
  This example and the executable have been tested on Windows 7 64-bit
  using Dymola 2015 32-bit.
</p>
</html>"),
 experiment(StopTime=10, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent={{-120,-100},{100,100}})));
end ExampleClientLoop;
