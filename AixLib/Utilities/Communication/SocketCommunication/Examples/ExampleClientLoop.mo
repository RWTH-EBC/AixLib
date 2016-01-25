within AixLib.Utilities.Communication.SocketCommunication.Examples;
model ExampleClientLoop
  "Example to include TCP Communication to simple test server in the control loop"
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
              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={50,-10})));
  Components.TCPCommunicatorExample tCPCommunicatorExample(portExample="27015",
      IP_AddressExample="10.39.190.48")
    "TCP block which sends values and receives values, has no impact on signal"
    annotation (Placement(transformation(extent={{-66,30},{-46,50}})));
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
      points={{-45,40},{-38,40},{-38,38},{-28,38}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(tCPCommunicatorExample.u[1], limiter.y) annotation (Line(
      points={{-68,40},{-86,40},{-86,-10},{-75,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
Documentation(revisions="<html>
<ul>
  <li><i>June 01, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Implemented</li>
  <li><i>September 03, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised documented</li>
</ul>
</html>",information="<html>

This is a very simple example to show TCP-Communication functionality. A feedback
 control is modeled where a gain controller controls a first order block. The signal
 is send to a server and back. The signal is not altered by the server.
</html>"),
 experiment(StopTime=100, __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput);
end ExampleClientLoop;
