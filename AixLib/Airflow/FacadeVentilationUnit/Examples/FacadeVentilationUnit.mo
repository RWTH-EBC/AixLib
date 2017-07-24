within AixLib.Airflow.FacadeVentilationUnit.Examples;
model FacadeVentilationUnit "Example showing the use of facade ventilation unit
  and controller"
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium1 = AixLib.Media.Air;
  package Medium2 = AixLib.Media.Water;

  AixLib.Controls.AirHandling.FVUController          FVUController
    annotation (Placement(transformation(extent={{-46,-30},{-6,10}})));
  AixLib.Airflow.FacadeVentilationUnit.FacadeVentilationUnit FVU(redeclare
      package Air = Medium1, redeclare package Water = Medium2)
    annotation (Placement(transformation(extent={{70,-56},{106,-36}})));
  AixLib.Fluid.Sources.Boundary_pT ambient_out(
    nPorts=1,
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300)
    annotation (Placement(transformation(extent={{6,-84},{26,-64}})));
  AixLib.Fluid.Sources.Boundary_pT ambient_in(
    nPorts=1,
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 101300)
    annotation (Placement(transformation(extent={{4,-53},{24,-33}})));
  AixLib.Fluid.Sources.Boundary_pT heating_sink(
    redeclare package Medium = Medium2,
    nPorts=1,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,30})));
  AixLib.Fluid.Sources.Boundary_pT cooling_sink(
    redeclare package Medium = Medium2,
    nPorts=1,
    p=100000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={102,32})));
  AixLib.Fluid.Sources.Boundary_pT cooling_source(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1,
    p=140000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={126,31})));
  AixLib.Fluid.Sources.Boundary_pT heating_source(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1,
    p=140000) annotation (Placement(transformation(
        extent={{-9,-10},{9,10}},
        rotation=270,
        origin={54,31})));
  AixLib.Fluid.Sources.Boundary_pT room_in(
    redeclare package Medium = Medium1,
    use_T_in=false,
    nPorts=1,
    p(displayUnit="Pa") = 101300) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={170,-27})));
  AixLib.Fluid.Sources.Boundary_pT room_out(
    nPorts=1,
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={168,-66})));
  Modelica.Blocks.Sources.Constant roomTemperature1(k=273.15 + 30)
    annotation (Placement(transformation(extent={{24,74},{44,94}})));
  Modelica.Blocks.Sources.Constant roomTemperature2(k=273.15 + 17)
    annotation (Placement(transformation(extent={{84,74},{104,94}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort supplyAirTemperature(redeclare
      package Medium = Medium1, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{120,-54},{140,-34}})));
  Modelica.Blocks.Sources.Constant roomTemperature(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant roomSetTemperature(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.Constant co2Concentration(k=1000)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Sine outdoorTemperature(
    amplitude=5,
    freqHz=1/86400,
    offset=273.15 + 10)
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  AixLib.Controls.Interfaces.FVUControlBus fVUControlBus1 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,28})));
equation
  connect(FVU.ExhaustAir, room_out.ports[1]) annotation (Line(
      points={{106.2,-52.8},{148,-52.8},{148,-66},{158,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heating_sink.ports[1], FVU.Heater_Return) annotation (Line(points={{
          26,20},{26,-6},{95.2,-6},{95.2,-36}}, color={0,127,255}));
  connect(cooling_source.ports[1], FVU.Cooler_Flow) annotation (Line(points={{
          126,21},{126,-26},{105.2,-26},{105.2,-36}}, color={0,127,255}));
  connect(roomTemperature1.y, heating_source.T_in)
    annotation (Line(points={{45,84},{58,84},{58,41.8}}, color={0,0,127}));
  connect(roomTemperature2.y, cooling_source.T_in) annotation (Line(points={{
          105,84},{105,84},{130,84},{130,43}}, color={0,0,127}));
  connect(FVU.Cooler_Return, cooling_sink.ports[1]) annotation (Line(points={{
          102.2,-36},{102,-36},{102,22}}, color={0,127,255}));
  connect(heating_source.ports[1], FVU.Heater_Flow) annotation (Line(points={{
          54,22},{54,22},{54,10},{98.2,10},{98.2,-36}}, color={0,127,255}));
  connect(ambient_in.ports[1], FVU.OutgoingExhaustAir) annotation (Line(points=
          {{24,-43},{42,-43},{42,-43.4},{70,-43.4}}, color={0,127,255}));
  connect(ambient_out.ports[1], FVU.FreshAir) annotation (Line(points={{26,-74},
          {26,-70},{42,-70},{42,-52.8},{70.2,-52.8}}, color={0,127,255}));
  connect(FVU.SupplyAir, supplyAirTemperature.port_a) annotation (Line(points={
          {106.2,-43.4},{106.2,-44},{120,-44}}, color={0,127,255}));
  connect(supplyAirTemperature.port_b, room_in.ports[1]) annotation (Line(
        points={{140,-44},{148,-44},{148,-27},{160,-27}}, color={0,127,255}));
  connect(FVU.fVUControlBus, FVUController.fVUControlBus) annotation (Line(
      points={{86,-35.9},{86,-35.9},{86,-12},{86,-10},{86,-8.76923},{-6,
          -8.76923}},
      color={255,204,51},
      thickness=0.5));
  connect(FVUController.fVUControlBus, fVUControlBus1) annotation (Line(
      points={{-6,-8.76923},{2,-8.76923},{2,28},{-26,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomTemperature.y, room_out.T_in) annotation (Line(points={{-79,50},{
          46,50},{192,50},{192,-70},{180,-70}}, color={0,0,127}));
  connect(outdoorTemperature.y, ambient_out.T_in) annotation (Line(points={{-79,
          16},{-64,16},{-64,-70},{4,-70}}, color={0,0,127}));
  connect(roomTemperature.y, fVUControlBus1.roomTemperature) annotation (Line(
        points={{-79,50},{-62,50},{-46,50},{-46,27.95},{-25.95,27.95}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outdoorTemperature.y, fVUControlBus1.outdoorTemperature) annotation (
      Line(points={{-79,16},{-64,16},{-64,27.95},{-25.95,27.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomSetTemperature.y, fVUControlBus1.roomSetTemperature) annotation (
      Line(points={{-79,-26},{-74,-26},{-74,27.95},{-25.95,27.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(co2Concentration.y, fVUControlBus1.co2Concentration) annotation (Line(
        points={{-79,-70},{-79,-70},{-74,-70},{-74,27.95},{-25.95,27.95}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,100}})),
    experiment(StopTime=10000),
    Documentation(revisions="<html>
<ul>
<li>
July, 2017 by Marc Baranski and Roozbeh Sangi:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>This model demonstrates the usage of the facade ventilation unit connected to the standard controller. </p>
</html>"));
end FacadeVentilationUnit;
