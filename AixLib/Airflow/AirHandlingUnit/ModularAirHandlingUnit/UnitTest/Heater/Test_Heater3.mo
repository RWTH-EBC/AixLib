within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Heater;
model Test_Heater3
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=273.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp m_watIn(
    height=-1/3.6,
    duration=600,
    offset=1,
    startTime=4800)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{52,-78},{72,-58}})));
  AixLib.FastHVAC.Components.Pumps.FluidSource fluidSource
    annotation (Placement(transformation(extent={{-46,-84},{-26,-64}})));
  AixLib.FastHVAC.BaseClasses.WorkingFluid workingFluid(T0=293.15, m_fluid=1)
    annotation (Placement(transformation(extent={{-2,-80},{18,-60}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={8,-46})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Modelica.Blocks.Sources.Sine T_watIn(
    amplitude=10,
    freqHz=1/1000,
    offset=333.15,
    startTime=3000)
    annotation (Placement(transformation(extent={{-100,-64},{-80,-44}})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{20,64},{40,84}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.006,1 - 0.006},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-30,54},{-10,74}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,78},{80,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{44,64},{64,84}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y=heater.Q_flow)
    annotation (Placement(transformation(extent={{-12,86},{8,106}})));
equation
  connect(m_airIn.y, heater.m_flow_airIn) annotation (Line(points={{-79,60},{-50,
          60},{-50,17.4},{-18.3,17.4}}, color={0,0,127}));
  connect(X_in.y, heater.X_airIn) annotation (Line(points={{-79,-20},{-62,-20},{
          -62,3.6},{-18.3,3.6}}, color={0,0,127}));
  connect(T_airIn.y, heater.T_airIn) annotation (Line(points={{-79,20},{-68,20},
          {-68,10.5},{-18.3,10.5}}, color={0,0,127}));
  connect(m_watIn.y, fluidSource.dotm) annotation (Line(points={{-79,-90},{-62,-90},
          {-62,-76.6},{-44,-76.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b,workingFluid. enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b,vessel. enthalpyPort_a) annotation (Line(
        points={{17,-70},{36,-70},{36,-68},{55,-68}}, color={176,0,0}));
  connect(workingFluid.heatPort,convection. fluid)
    annotation (Line(points={{8,-60.6},{8,-56}}, color={191,0,0}));
  connect(convection.solid,heater. heatPort) annotation (Line(points={{8,-36},{8,
          -30},{7,-30},{7,-24}}, color={191,0,0}));
  connect(const.y,convection. Gc) annotation (Line(points={{59,-34},{40,-34},{
          40,-46},{18,-46}}, color={0,0,127}));
  connect(T_watIn.y, fluidSource.T_fluid) annotation (Line(points={{-79,-54},{-60,
          -54},{-60,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(boundary.ports[1],hea. port_a) annotation (Line(points={{-10,64},{-10,
          74},{20,74}},                    color={0,127,255}));
  connect(hea.port_b,T_airOut_fluid. port_a) annotation (Line(points={{40,74},{44,
          74}},                 color={0,127,255}));
  connect(Q_flow.y, hea.u) annotation (Line(points={{9,96},{12,96},{12,80},{18,80}},
                    color={0,0,127}));
  connect(m_airIn.y, boundary.m_flow_in) annotation (Line(points={{-79,60},{-50,
          60},{-50,72},{-32,72}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,20},{-68,20},{
          -68,54},{-44,54},{-44,68},{-32,68}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-20},{-62,-20},
          {-62,48},{-38,48},{-38,60},{-32,60}}, color={0,0,127}));
  connect(T_airOut_fluid.port_b, bou.ports[1]) annotation (Line(points={{64,74},
          {70,74},{70,89},{80,89}}, color={0,127,255}));
 annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html>
<p>
In this model the heater <a href=\"modelica://SimpleAHU.Components.Heater\">
SimpleAHU.Components.Heater</a> uses water as a heat source to heat the incoming air.
<p>The results are then compared to <a href=\"modelica://AixLib.Fluid.HeatExchangers.HeaterCooler_u\">
AixLib.Fluid.HeatExchangers.HeaterCooler_u</a> (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
<li>November, 2019, by Ervin Lejlic:<br/>First implementation. </li>
</ul>
</html>"),
    experiment(StopTime=7000),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Test_Heater3;
