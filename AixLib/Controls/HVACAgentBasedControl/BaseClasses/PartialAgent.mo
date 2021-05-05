within AixLib.Controls.HVACAgentBasedControl.BaseClasses;
partial model PartialAgent
  parameter Integer name "Name of the agent (five-digit number, eg. 10001)";
  parameter Boolean usePoke=false
    "Use Modelica internal communication for inbox update";
  parameter Real sampleRate=5
    "Sample time for inbox update (used if usePoke=false)";

  outer HVACAgentBasedControl.Agents.MessageNotification messageNotification if
    usePoke;

  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.Packager packager
    annotation (Placement(transformation(extent={{176,184},{196,204}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddReal content(nu=1, n=2)
    annotation (Placement(transformation(extent={{176,18},{196,38}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetReal get_content(nu=
       1, n=2)
          annotation (Placement(transformation(extent={{-200,14},{-180,34}})));
  Modelica_DeviceDrivers.Blocks.Communication.UDPReceive
                     uDPReceive_adapted(port_recv=name,
    enableExternalTrigger= if usePoke then true else false,
    sampleTime= if usePoke then 10e20 else sampleRate)          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-190,190})));
  UDPSend_adapted                                       uDPSend_adapted annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={186,-70})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger sender(nu=1)
    annotation (Placement(transformation(extent={{176,106},{196,126}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger receiver(nu=
       1) annotation (Placement(transformation(extent={{176,74},{196,94}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger reply_to(nu=
       1) annotation (Placement(transformation(extent={{176,46},{196,66}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddReal    ontology(nu=1)
          annotation (Placement(transformation(extent={{176,-10},{196,10}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger
    getperformative(nu=1)
    annotation (Placement(transformation(extent={{-200,136},{-180,156}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getsender(
      nu=1)
    annotation (Placement(transformation(extent={{-200,106},{-180,126}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getreceiver(
      nu=1) annotation (Placement(transformation(extent={{-200,76},{-180,96}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getreply_to(
      nu=1) annotation (Placement(transformation(extent={{-200,44},{-180,64}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetReal    getontology(nu=1)
    annotation (Placement(transformation(extent={{-200,-14},{-180,6}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger performative(nu=1)
    annotation (Placement(transformation(extent={{176,138},{196,158}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.GetInteger getMessageID
    annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.AddInteger messageID(nu=1)
          annotation (Placement(transformation(extent={{176,-44},{196,-24}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-160,180},{-140,200}})));
  SendSample                                       sendSample if
                                                        usePoke
    annotation (Placement(transformation(extent={{160,-200},{180,-180}})));
  Modelica.Blocks.Interfaces.BooleanOutput sendOut if usePoke
    "Turns true when the sending unit of the agent is active"
    annotation (Placement(transformation(extent={{80,-40},{100,-20}}),
        iconTransformation(extent={{80,-40},{100,-20}})));
equation

  if usePoke then
  connect(messageNotification.y, uDPReceive_adapted.trigger);
  end if;
  connect(sender.pkgOut[1], receiver.pkgIn) annotation (Line(
      points={{186,105.2},{186,94.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(receiver.pkgOut[1], reply_to.pkgIn) annotation (Line(
      points={{186,73.2},{186,66.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(reply_to.pkgOut[1], content.pkgIn) annotation (Line(
      points={{186,45.2},{186,38.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(content.pkgOut[1], ontology.pkgIn) annotation (Line(
      points={{186,17.2},{186,10.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getperformative.pkgIn, uDPReceive_adapted.pkgOut) annotation (Line(
      points={{-190,156.8},{-188,156.8},{-188,179.2},{-190,179.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getperformative.pkgOut[1], getsender.pkgIn) annotation (Line(
      points={{-190,135.2},{-190,126.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getsender.pkgOut[1], getreceiver.pkgIn) annotation (Line(
      points={{-190,105.2},{-190,96.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getreceiver.pkgOut[1], getreply_to.pkgIn) annotation (Line(
      points={{-190,75.2},{-190,64.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getreply_to.pkgOut[1], get_content.pkgIn) annotation (Line(
      points={{-190,43.2},{-190,34.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(get_content.pkgOut[1], getontology.pkgIn) annotation (Line(
      points={{-190,13.2},{-190,6.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(performative.pkgIn, packager.pkgOut) annotation (Line(
      points={{186,158.8},{186,183.2},{186,183.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(performative.pkgOut[1], sender.pkgIn) annotation (Line(
      points={{186,137.2},{186,126.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(getontology.pkgOut[1], getMessageID.pkgIn) annotation (Line(
      points={{-190,-14.8},{-190,-29.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(ontology.pkgOut[1], messageID.pkgIn) annotation (Line(
      points={{186,-10.8},{186,-23.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(messageID.pkgOut[1], uDPSend_adapted.pkgIn) annotation (Line(
      points={{186,-44.8},{186,-59.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sendSample.u, uDPSend_adapted.send) annotation (Line(points={{160,-190},
          {148,-190},{148,-176},{200,-176},{200,-70.6},{195,-70.6}},
        color={255,0,255}));
  connect(sendOut, sendSample.y) annotation (Line(points={{90,-30},{194,-30},{
          194,-190},{180,-190}},        color={255,0,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}})),           Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-54,56},{66,-50}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="A")}),
    Documentation(revisions="<html><ul>
  <li>July 2017, by Roozbeh Sangi: Documentation revised
  </li>
  <li>December 2016, by Felix Bünning: Changed some variables to
  Integer type in order to avoid warnings caused by using the \"==\"
  operator
  </li>
  <li>November 2016, by Felix Bünning: Added feature to use internal
  inbox refresh (better performance), updated Info window
  </li>
  <li>October 2015, by Felix Bünning: Developed and implemented
  </li>
</ul>
</html>",
      info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<ul>
  <li>This model implements the communication system of the agent
  library as a partial model
  </li>
  <li>It is based on communication via UDP
  </li>
  <li>It is used by all implemented agents
  </li>
</ul>
<h4>
  <span style=\"color: #008000\">Concept</span>
</h4>
<p>
  The communication takes place via UDP network communication and is
  implemented with the help of elements from the DeviceDriver library.
  The inbox is refreshed based on a sample time, the outbox is
  triggered by an external boolean input.
</p>
<p>
  Since sampling creates time events, the simulation performance will
  be bad for models with a high number of equations. For this reason,
  an alternative refresh mechanism can be used with \"usePoke=true\". In
  order to use this mechanism the component \"MessageNotification\" needs
  to be added to the system.
</p>
<p>
  The partial agent implements the message parameters performative,
  sender, receiver, reply to, content, ontology and message ID. The
  parameters are described in the reference.
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
</html>"));
end PartialAgent;
