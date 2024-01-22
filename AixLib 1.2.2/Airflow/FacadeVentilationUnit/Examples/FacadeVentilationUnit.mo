within AixLib.Airflow.FacadeVentilationUnit.Examples;
model FacadeVentilationUnit
  "Example showing the use of facade ventilation unit and controller"
  extends Modelica.Icons.Example;

  package Medium1 = AixLib.Media.Air;
  package Medium2 = AixLib.Media.Water;

  AixLib.Controls.AirHandling.FVUController FVUController(
      maxSupFanPower=0.6,
      maxExFanPower=0.6)
    "Comprehensive rule-based controller for the facade ventilation unit"
    annotation (Placement(transformation(extent={{-46,-30},{-6,10}})));
  AixLib.Airflow.FacadeVentilationUnit.FacadeVentilationUnit FVU(redeclare
      package                                                                      Air =
                    Medium1, redeclare package Water = Medium2)
    "The facade ventilation unit to be tested in this example"
    annotation (Placement(transformation(extent={{70,-56},{106,-36}})));
  AixLib.Fluid.Sources.Boundary_pT freshAirSource(
    nPorts=1,
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300) "Sink of the exhaust air"
    annotation (Placement(transformation(extent={{6,-84},{26,-64}})));
  AixLib.Fluid.Sources.Boundary_pT exhaustAirSink(
    nPorts=1,
    redeclare package Medium = Medium1,
    p(displayUnit="Pa") = 101300) "Source of freah air"
    annotation (Placement(transformation(extent={{4,-47},{24,-27}})));
  AixLib.Fluid.Sources.Boundary_pT heatingSnk(
    redeclare package Medium = Medium2,
    nPorts=1,
    p=100000) "Sink of the heating water" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,30})));
  AixLib.Fluid.Sources.Boundary_pT coolingSink(
    redeclare package Medium = Medium2,
    nPorts=1,
    p=100000) "Sink of the cooling water" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={102,32})));
  AixLib.Fluid.Sources.Boundary_pT coolingSource(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1,
    p=101000) "Source of the cooling water" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={126,31})));
  AixLib.Fluid.Sources.Boundary_pT heatingSource(
    redeclare package Medium = Medium2,
    use_T_in=true,
    nPorts=1,
    p=101000) "Source of the heating water" annotation (Placement(
        transformation(
        extent={{-9,-10},{9,10}},
        rotation=270,
        origin={54,31})));
  AixLib.Fluid.Sources.Boundary_pT supplyAirSink(
    redeclare package Medium = Medium1,
    use_T_in=false,
    nPorts=1,
    p(displayUnit="Pa") = 101300) "Sink of the supply air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={170,-27})));
  AixLib.Fluid.Sources.Boundary_pT extractAirSource(
    nPorts=1,
    redeclare package Medium = Medium1,
    use_T_in=true,
    p(displayUnit="Pa") = 101300) "Source of the extract air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={168,-66})));
  Modelica.Blocks.Sources.Constant heatingWaterTemperature(k=273.15 + 30)
    "Provides a test value of the heating water temperatrure"
    annotation (Placement(transformation(extent={{24,74},{44,94}})));
  Modelica.Blocks.Sources.Constant coolingWaterTemperature(k=273.15 + 17)
    "Provides a test value of the cooling water temperatiure"
    annotation (Placement(transformation(extent={{84,74},{104,94}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort supplyAirTemperature(redeclare
      package                                                                    Medium =
                       Medium1, m_flow_nominal=0.1)
    "Measures the supply air temperature"
    annotation (Placement(transformation(extent={{120,-54},{140,-34}})));
  Modelica.Blocks.Sources.Sine roomTemperature(
    amplitude=5,
    f=1/86400,
    phase=3.1415926535898,
    offset=273.15 + 20) "Provides a test value of the room temperature"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Sine roomSetTemperature(
    amplitude=5,
    f=1/86400,
    phase=1.5707963267949,
    offset=273.15 + 20) "Provides a test value of the room set temperature"
    annotation (Placement(transformation(extent={{-100,-36},{-80,-16}})));
  Modelica.Blocks.Sources.Constant co2Concentration(k=1000)
    "Provides a test value of the CO2 concnetration"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Sine outdoorTemperature(
    amplitude=5,
    f=1/86400,
    offset=273.15 + 10) "Provides a test value of the outdoor temperature"
    annotation (Placement(transformation(extent={{-100,6},{-80,26}})));
  AixLib.Controls.Interfaces.FVUControlBus fVUControlBus
  "Bus with controller sginals"
   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,28})));
equation
  connect(FVU.extractAirConnector, extractAirSource.ports[1]) annotation (
   Line(points={{106.2,-52.8},{148,-52.8},{148,-66},{158,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(heatingSnk.ports[1], FVU.heaterReturnConnector) annotation (Line(
        points={{26,20},{26,-6},{95.2,-6},{95.2,-36}}, color={0,127,255}));
  connect(coolingSource.ports[1], FVU.coolerFlowConnector) annotation (Line(
        points={{126,21},{126,-26},{105.2,-26},{105.2,-36}},
        color={0,127,255}));
  connect(heatingWaterTemperature.y, heatingSource.T_in)
    annotation (Line(points={{45,84},{58,84},{58,41.8}}, color={0,0,127}));
  connect(coolingWaterTemperature.y, coolingSource.T_in) annotation (Line(
        points={{105,84},{105,84},{130,84},{130,43}}, color={0,0,127}));
  connect(FVU.coolerReturnConnector, coolingSink.ports[1]) annotation (Line(
        points={{102.2,-36},{102,-36},{102,22}}, color={0,127,255}));
  connect(heatingSource.ports[1], FVU.heaterFlowConnector) annotation (Line(
        points={{54,22},{54,22},{54,10},{98.2,10},{98.2,-36}},
        color={0,127,255}));
  connect(exhaustAirSink.ports[1], FVU.exhaustAirConnector) annotation (Line(
        points={{24,-37},{42,-37},{42,-43.4},{70,-43.4}}, color={0,127,255}));
  connect(freshAirSource.ports[1], FVU.freshAirConnector) annotation (Line(
        points={{26,-74},{26,-70},{42,-70},{42,-52.8},{70.2,-52.8}},
        color={0,127,
          255}));
  connect(FVU.supplyAirConnector, supplyAirTemperature.port_a) annotation (
   Line(points={{106.2,-43.4},{106.2,-44},{120,-44}}, color={0,127,255}));
  connect(supplyAirTemperature.port_b, supplyAirSink.ports[1]) annotation (
   Line(points={{140,-44},{148,-44},{148,-27},{160,-27}}, color={0,127,255}));
  connect(FVU.fVUControlBus, FVUController.fVUControlBus) annotation (Line(
      points={{86,-35.9},{86,-35.9},{86,-12},{86,-10},{86,-8.76923},{-6,
          -8.76923}},color={255,204,51},thickness=0.5));
  connect(FVUController.fVUControlBus, fVUControlBus) annotation (Line(
      points={{-6,-8.76923},{2,-8.76923},{2,28},{-26,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomTemperature.y, extractAirSource.T_in) annotation (
   Line(points={{-79,50},{46,50},{192,50},{192,-70},{180,-70}},
  color={0,0,127}));
  connect(outdoorTemperature.y,freshAirSource. T_in) annotation (
   Line(points={{-79,16},{-64,16},{-64,-70},{4,-70}}, color={0,0,127}));
  connect(roomTemperature.y, fVUControlBus.roomTemperature) annotation (Line(
        points={{-79,50},{-62,50},{-46,50},{-46,27.95},{-25.95,27.95}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outdoorTemperature.y, fVUControlBus.outdoorTemperature) annotation (
      Line(points={{-79,16},{-64,16},{-64,27.95},{-25.95,27.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(roomSetTemperature.y, fVUControlBus.roomSetTemperature) annotation (
      Line(points={{-79,-26},{-74,-26},{-74,27.95},{-25.95,27.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(co2Concentration.y, fVUControlBus.co2Concentration) annotation (Line(
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
    experiment(StopTime=86400),
    Documentation(revisions="<html><ul>
  <li>July, 2017 by Marc Baranski and Roozbeh Sangi:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  This model demonstrates the usage of the facade ventilation unit
  connected to the standard controller. The inputs are the room and the
  outdoor temperaure. Those temperatures and the room temperature set
  point are sine waves with a period of one day, which all have a
  different phase. The simulation result depicted in the following
  figure shows the behavior of the two-point controller that opens the
  heating valve fully for heating. For cooling, it closes the heating
  valve and bypasses the heat recovery unit so that the supply air
  temperature is equal to the outdoor temperature.
</p>
<p>
  <img src=
  \"modelica://AixLib/Resources/Images/Airflow/FacadeVentilationUnit/FacadeVentilationUnitExample.png\"
  alt=\"Example result of facade ventilation unit example\">
</p>
</html>"));
end FacadeVentilationUnit;
