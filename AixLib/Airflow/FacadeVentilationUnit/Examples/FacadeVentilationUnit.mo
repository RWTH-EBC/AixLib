within AixLib.Airflow.FacadeVentilationUnit.Examples;
model FacadeVentilationUnit
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium1 = AixLib.Media.Air;
  package Medium2 = AixLib.Media.Water;

  AixLib.Airflow.FacadeVentilationUnit.FVUController FVUController
    annotation (Placement(transformation(extent={{-46,-30},{-6,10}})));
  Modelica.Blocks.Sources.Constant roomTemperature(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-94,48},{-74,68}})));
  Modelica.Blocks.Sources.Constant roomSetTemperature(k=273.15 + 22)
    annotation (Placement(transformation(extent={{-94,-28},{-74,-8}})));
  Modelica.Blocks.Sources.Constant co2Concentration(k=1000)
    annotation (Placement(transformation(extent={{-94,-72},{-74,-52}})));
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
  Modelica.Blocks.Sources.Sine outdoorTemperature(
    amplitude=5,
    freqHz=1/86400,
    offset=273.15 + 10)
    annotation (Placement(transformation(extent={{-94,14},{-74,34}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort supplyAirTemperature(redeclare
      package Medium = Medium1, m_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{120,-54},{140,-34}})));
equation
  connect(roomTemperature.y, FVUController.roomTemperature) annotation (Line(
        points={{-73,58},{-54,58},{-54,8},{-46,8}}, color={0,0,127}));
  connect(roomSetTemperature.y, FVUController.roomSetTemperature)
    annotation (Line(points={{-73,-18},{-46,-18},{-46,-16}}, color={0,0,127}));
  connect(co2Concentration.y, FVUController.co2Concentration) annotation (Line(
        points={{-73,-62},{-56,-62},{-56,-28},{-46,-28}}, color={0,0,127}));
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
  connect(roomTemperature.y, room_out.T_in) annotation (Line(points={{-73,58},{
          -73,58},{198,58},{198,-70},{180,-70}}, color={0,0,127}));
  connect(FVU.Cooler_Return, cooling_sink.ports[1]) annotation (Line(points={{
          102.2,-36},{102,-36},{102,22}}, color={0,127,255}));
  connect(heating_source.ports[1], FVU.Heater_Flow) annotation (Line(points={{
          54,22},{54,22},{54,10},{98.2,10},{98.2,-36}}, color={0,127,255}));
  connect(ambient_in.ports[1], FVU.OutgoingExhaustAir) annotation (Line(points=
          {{24,-43},{42,-43},{42,-43.4},{70,-43.4}}, color={0,127,255}));
  connect(ambient_out.ports[1], FVU.FreshAir) annotation (Line(points={{26,-74},
          {26,-70},{42,-70},{42,-52.8},{70.2,-52.8}}, color={0,127,255}));
  connect(FVUController.coolingValveOpening, FVU.coolingValveOpening)
    annotation (Line(points={{-6,8},{44,8},{107.2,8},{107.2,-36}}, color={0,0,
          127}));
  connect(FVUController.heatingValveOpening, FVU.heatingValveOpening)
    annotation (Line(points={{-6,2},{40,2},{100.2,2},{100.2,-36}}, color={0,0,
          127}));
  connect(FVUController.fanExhaustAirPower, FVU.fanExhaustAirPower) annotation (
     Line(points={{-6,-4},{26,-4},{71.3,-4},{71.3,-36.3}}, color={0,0,127}));
  connect(FVUController.fanSupplyAirPower, FVU.fanSupplyAirPower) annotation (
      Line(points={{-6,-10},{91.4,-10},{91.4,-36.4}}, color={0,0,127}));
  connect(FVUController.circulationdamperOpening, FVU.damperCircularAirOpening)
    annotation (Line(points={{-6,-16},{86.3,-16},{86.3,-36.3}}, color={0,0,127}));
  connect(FVUController.HRCDamperOpening, FVU.HRCDamperOpening) annotation (
      Line(points={{-6,-22},{18,-22},{76.3,-22},{76.3,-36.3}}, color={0,0,127}));
  connect(FVUController.freshAirDamperOpening, FVU.damperFreshAirOpening)
    annotation (Line(points={{-6,-28},{81,-28},{81,-36}}, color={0,0,127}));
  connect(outdoorTemperature.y, FVUController.outdoorTemperature) annotation (
      Line(points={{-73,24},{-62,24},{-62,-4},{-46,-4}}, color={0,0,127}));
  connect(outdoorTemperature.y, ambient_out.T_in) annotation (Line(points={{-73,
          24},{-62,24},{-62,-70},{4,-70}}, color={0,0,127}));
  connect(FVU.SupplyAir, supplyAirTemperature.port_a) annotation (Line(points={
          {106.2,-43.4},{106.2,-44},{120,-44}}, color={0,127,255}));
  connect(supplyAirTemperature.port_b, room_in.ports[1]) annotation (Line(
        points={{140,-44},{148,-44},{148,-27},{160,-27}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,100}})),
    experiment(StopTime=10000),
    Documentation(revisions="<html>
<ul>
  <li><i>Septmeber, 2014&nbsp;</i>
    by by Roozbeh Sangi and Marc Baranski:<br/>
    Model implemented</li>
</ul>
</html>"));
end FacadeVentilationUnit;
