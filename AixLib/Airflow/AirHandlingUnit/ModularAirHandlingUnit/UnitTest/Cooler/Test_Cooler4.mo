within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Cooler;
model Test_Cooler4
  Modelica.Blocks.Continuous.LimPID PID_T(
    yMin=0,
    Ti=80,
    Td=0.0001,
    k=-0.05,
    yMax=10) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.Constant T_airSet(k=290.15)
    annotation (Placement(transformation(extent={{26,40},{46,60}})));
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=2,
    duration=600,
    offset=293.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
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
        origin={8,-34})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Modelica.Blocks.Sources.Ramp T_wat_in(
    height=0,
    duration=600,
    offset=273.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  AixLib.Fluid.HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium = AixLib.Media.Air,
    m_flow_nominal=2000/3600*1.18,
    dp_nominal=0,
    Q_flow_nominal=1)
    annotation (Placement(transformation(extent={{-6,66},{14,86}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.006,1 - 0.006},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{-42,38},{-22,58}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{102,80},{82,102}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{38,66},{58,86}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y=cooler.Q_flow)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Cooler cooler(
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-2,2},{18,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=280.15)
    annotation (Placement(transformation(extent={{-34,-18},{-14,2}})));
equation
  connect(fluidSource.enthalpyPort_b,workingFluid. enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b,vessel. enthalpyPort_a) annotation (Line(
        points={{17,-70},{36,-70},{36,-68},{55,-68}}, color={176,0,0}));
  connect(workingFluid.heatPort,convection. fluid)
    annotation (Line(points={{8,-60.6},{8,-44}}, color={191,0,0}));
  connect(const.y,convection. Gc) annotation (Line(points={{59,-34},{18,-34}},
                             color={0,0,127}));
  connect(PID_T.y,fluidSource. dotm) annotation (Line(points={{81,50},{92,50},{92,
          -94},{-82,-94},{-82,-76.6},{-44,-76.6}},    color={0,0,127}));
  connect(T_wat_in.y,fluidSource. T_fluid) annotation (Line(points={{-79,-50},{
          -64,-50},{-64,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(bou.ports[1],T_airOut_fluid. port_b) annotation (Line(points={{82,91},
          {59,91},{59,76},{58,76}}, color={0,127,255}));
  connect(hea.port_b,T_airOut_fluid. port_a) annotation (Line(points={{14,76},{38,
          76}},                 color={0,127,255}));
  connect(Q_flow.y,hea. u) annotation (Line(points={{-39,90},{-22,90},{-22,82},{
          -8,82}},  color={0,0,127}));
  connect(T_airSet.y,PID_T. u_s)
    annotation (Line(points={{47,50},{58,50}}, color={0,0,127}));
  connect(boundary.ports[1],hea. port_a) annotation (Line(points={{-22,48},{-14,
          48},{-14,76},{-6,76}},
                              color={0,127,255}));
  connect(realExpression.y, cooler.T_coolingSurf)
    annotation (Line(points={{-13,-8},{3.1,-8},{3.1,2.1}}, color={0,0,127}));
  connect(cooler.T_airOut, PID_T.u_m)
    annotation (Line(points={{19,17},{70,17},{70,38}}, color={0,0,127}));
  connect(convection.solid, cooler.heatPort)
    annotation (Line(points={{8,-24},{8,2}}, color={191,0,0}));
  connect(X_in.y, cooler.X_airIn) annotation (Line(points={{-79,-10},{-64,-10},{
          -64,14},{-3,14}}, color={0,0,127}));
  connect(T_airIn.y, cooler.T_airIn) annotation (Line(points={{-79,30},{-64,30},
          {-64,17},{-3,17}}, color={0,0,127}));
  connect(m_airIn.y, cooler.m_flow_airIn) annotation (Line(points={{-79,70},{-70,
          70},{-70,42},{-60,42},{-60,20},{-3,20}}, color={0,0,127}));
  connect(m_airIn.y, boundary.m_flow_in) annotation (Line(points={{-79,70},{-66,
          70},{-66,56},{-44,56}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,30},{-58,30},{
          -58,52},{-44,52}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-10},{-56,-10},
          {-56,44},{-44,44}}, color={0,0,127}));
  annotation (experiment(StopTime=6000, Interval=1800),
   Documentation(info="<html>
<p>
In this model the cooler <a href=\"modelica://SimpleAHU.Components.Cooler\">
SimpleAHU.Components.Cooler</a> uses water to cool the incoming air.
<p>With <a href=\"modelica://Modelica.Blocks.Continuous.LimPID\">Modelica.Blocks.Continuous.LimPID</a> 
the outflowing air temperature is beeing controlled by changing the massflow of water.</p>
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
end Test_Cooler4;
