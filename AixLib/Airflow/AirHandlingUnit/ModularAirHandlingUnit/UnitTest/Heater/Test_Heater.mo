within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Heater;
model Test_Heater
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Heater heater(
    redeclare model PartialPressureDrop =
    AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDrop
        (b=3),
      use_constant_heatTransferCoefficient=true)
    annotation (Placement(transformation(extent={{-12,-14},{8,6}})));
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Constant X_in_(k=0.006)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=273.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=5000)
    annotation (Placement(transformation(extent={{-42,-80},{-22,-60}})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    show_T=true,
    dp_nominal=0,
    Q_flow_nominal=5000)
    annotation (Placement(transformation(extent={{-12,56},{8,76}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.006,1 - 0.006},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-52,38},{-32,58}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,58},{80,80}})));
  Modelica.Blocks.Sources.Constant factor(k=1)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{26,58},{46,78}})));
equation
  connect(m_airIn.y, heater.m_flow_airIn) annotation (Line(points={{-79,-10},{-72,
          -10},{-72,4},{-13,4}}, color={0,0,127}));
  connect(X_in_.y, heater.X_airIn) annotation (Line(points={{-79,-90},{-62,-90},
          {-62,-2},{-13,-2}}, color={0,0,127}));
  connect(T_airIn.y, heater.T_airIn) annotation (Line(points={{-79,-50},{-68,-50},
          {-68,1},{-13,1}}, color={0,0,127}));
  connect(fixedHeatFlow.port, heater.heatPort)
    annotation (Line(points={{-22,-70},{-2,-70},{-2,-14}},color={191,0,0}));
  connect(boundary.ports[1], hea.port_a) annotation (Line(points={{-32,48},{-32,
          58},{-26,58},{-26,66},{-12,66}}, color={0,127,255}));
  connect(factor.y, hea.u) annotation (Line(points={{-39,90},{-24,90},{-24,72},{
          -14,72}}, color={0,0,127}));
  connect(bou.ports[1], T_airOut_fluid.port_b) annotation (Line(points={{80,69},
          {63,69},{63,68},{46,68}}, color={0,127,255}));
  connect(hea.port_b, T_airOut_fluid.port_a) annotation (Line(points={{8,66},{16,
          66},{16,68},{26,68}}, color={0,127,255}));

  connect(m_airIn.y, boundary.m_flow_in) annotation (Line(points={{-79,-10},{
          -72,-10},{-72,56},{-54,56}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,-50},{-68,-50},
          {-68,52},{-54,52}}, color={0,0,127}));
  connect(X_in_.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-90},{-62,
          -90},{-62,44},{-54,44}}, color={0,0,127}));
    annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html>
<p>
Simple test for 
<a href=\"modelica://SimpleAHU.Components.Heater\">
SimpleAHU.Components.Heater</a>.
A set heatflow is prescribed while the incoming temperature and massflow change over time.</p>
<p>The results are then compared to <a href=\"modelica://AixLib.Fluid.HeatExchangers.HeaterCooler_u\">
AixLib.Fluid.HeatExchangers.HeaterCooler_u</a> (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
<li>November, 2019, by Ervin Lejlic:<br/>First implementation. </li>
</ul>
</html>"), Icon(graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_Heater;
