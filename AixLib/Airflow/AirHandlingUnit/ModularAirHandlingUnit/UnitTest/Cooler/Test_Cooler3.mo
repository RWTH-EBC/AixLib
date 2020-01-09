within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Cooler;
model Test_Cooler3
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=4,
    duration=600,
    offset=291.15,
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
    offset=280.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-100,-64},{-80,-44}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.006,1 - 0.006},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-30,36},{-10,56}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{102,78},{82,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{48,66},{68,86}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y=cooler.Q_flow)
    annotation (Placement(transformation(extent={{-50,86},{-30,106}})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{12,44},{32,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=280.15)
    annotation (Placement(transformation(extent={{-56,-44},{-36,-24}})));
equation
  connect(m_watIn.y,fluidSource. dotm) annotation (Line(points={{-79,-90},{-62,-90},
          {-62,-76.6},{-44,-76.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b,workingFluid. enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b,vessel. enthalpyPort_a) annotation (Line(
        points={{17,-70},{36,-70},{36,-68},{55,-68}}, color={176,0,0}));
  connect(workingFluid.heatPort,convection. fluid)
    annotation (Line(points={{8,-60.6},{8,-56}}, color={191,0,0}));
  connect(const.y,convection. Gc) annotation (Line(points={{59,-34},{40,-34},{
          40,-46},{18,-46}}, color={0,0,127}));
  connect(T_watIn.y,fluidSource. T_fluid) annotation (Line(points={{-79,-54},{-60,
          -54},{-60,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(hea.port_b,T_airOut_fluid. port_a)
    annotation (Line(points={{32,54},{46,54},{46,76},{48,76}},
                                               color={0,127,255}));
  connect(boundary.ports[1],hea. port_a) annotation (Line(points={{-10,46},{4,46},
          {4,54},{12,54}},      color={0,127,255}));
  connect(Q_flow.y,hea. u) annotation (Line(points={{-29,96},{2,96},{2,60},{10,60}},
                     color={0,0,127}));
  connect(convection.solid, cooler.heatPort)
    annotation (Line(points={{8,-36},{8,-24}}, color={191,0,0}));
  connect(m_airIn.y, cooler.m_flow_airIn) annotation (Line(points={{-79,60},{-50,
          60},{-50,-6},{-3,-6}}, color={0,0,127}));
  connect(T_airIn.y, cooler.T_airIn) annotation (Line(points={{-79,20},{-70,20},
          {-70,-9},{-3,-9}}, color={0,0,127}));
  connect(X_in.y, cooler.X_airIn) annotation (Line(points={{-79,-20},{-64,-20},{
          -64,-12},{-3,-12}}, color={0,0,127}));
  connect(realExpression.y, cooler.T_coolingSurf) annotation (Line(points={{-35,
          -34},{-26,-34},{-26,-28},{3.1,-28},{3.1,-23.9}}, color={0,0,127}));
  connect(m_airIn.y, boundary.m_flow_in) annotation (Line(points={{-79,60},{-44,
          60},{-44,54},{-32,54}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,20},{-48,20},{
          -48,50},{-32,50}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-20},{-46,-20},
          {-46,42},{-32,42}}, color={0,0,127}));
  connect(T_airOut_fluid.port_b, bou.ports[1]) annotation (Line(points={{68,76},
          {72,76},{72,89},{82,89}}, color={0,127,255}));
  annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html>
<p>
In this model the cooler <a href=\"modelica://SimpleAHU.Components.Cooler\">
SimpleAHU.Components.Cooler</a> uses water to cool the incoming air.
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
end Test_Cooler3;
