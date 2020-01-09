within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Cooler;
model Test_Cooler2
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.015)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=2,
    duration=600,
    offset=288.15,
    startTime=3000)
    annotation (Placement(transformation(extent={{-100,-66},{-80,-46}})));
  Modelica.Blocks.Sources.Ramp T_set(
    height=2,
    duration=600,
    offset=283.15,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.015,1 - 0.015},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-24,36},{-4,56}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,58},{80,80}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{44,58},{64,78}})));
  AixLib.Fluid.HeatExchangers.SensibleCooler_T coo(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{12,58},{32,78}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=280.15)
    annotation (Placement(transformation(extent={{-62,-60},{-42,-40}})));
  Modelica.Blocks.Sources.Constant X_set_equation(k=0.011)
    annotation (Placement(transformation(extent={{54,0},{34,20}})));
equation
  connect(bou.ports[1],T_airOut_fluid. port_b) annotation (Line(points={{80,69},
          {63,69},{63,68},{64,68}}, color={0,127,255}));
  connect(coo.port_b,T_airOut_fluid. port_a)
    annotation (Line(points={{32,68},{44,68}}, color={0,127,255}));
  connect(boundary.ports[1],coo. port_a) annotation (Line(points={{-4,46},{2,46},
          {2,68},{12,68}}, color={0,127,255}));
  connect(T_set.y, cooler.T_set)
    annotation (Line(points={{-79,10},{-18,10},{-18,-14}}, color={0,0,127}));
  connect(m_airIn.y, cooler.m_flow_airIn) annotation (Line(points={{-79,-22},{-76,
          -22},{-76,-16},{-29,-16}}, color={0,0,127}));
  connect(T_airIn.y, cooler.T_airIn) annotation (Line(points={{-79,-56},{-74,-56},
          {-74,-19},{-29,-19}}, color={0,0,127}));
  connect(X_in.y, cooler.X_airIn) annotation (Line(points={{-79,-90},{-72,-90},{
          -72,-22},{-29,-22}}, color={0,0,127}));
  connect(realExpression.y, cooler.T_coolingSurf) annotation (Line(points={{-41,
          -50},{-22.9,-50},{-22.9,-33.9}}, color={0,0,127}));
  connect(X_set_equation.y, cooler.X_set)
    annotation (Line(points={{33,10},{-12,10},{-12,-14}},   color={0,0,127}));
  connect(T_set.y, coo.TSet) annotation (Line(points={{-79,10},{-56,10},{-56,76},
          {10,76}}, color={0,0,127}));
  connect(boundary.m_flow_in, m_airIn.y) annotation (Line(points={{-26,54},{-54,
          54},{-54,-4},{-76,-4},{-76,-22},{-79,-22}}, color={0,0,127}));
  connect(boundary.T_in, T_airIn.y) annotation (Line(points={{-26,50},{-52,50},{
          -52,-14},{-74,-14},{-74,-56},{-79,-56}}, color={0,0,127}));
  connect(boundary.Xi_in[1], X_in.y) annotation (Line(points={{-26,42},{-50,42},
          {-50,-26},{-70,-26},{-70,-90},{-79,-90}}, color={0,0,127}));
  annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html>
<p>
Simple test for 
<a href=\"modelica://SimpleAHU.Components.Cooler\">
SimpleAHU.Components.Cooler</a>.
The temperature of the outflowing air is beeing controlled under changing massflow and incoming temperature.
<p>The results are then compared to <a href=\"modelica://AixLib.Fluid.HeatExchangers.SensibleCooler_T\">
AixLib.Fluid.HeatExchangers.SensibleCooler_T</a> (boundary conditions are consistent).
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
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),
    experiment(StopTime=7000));
end Test_Cooler2;
