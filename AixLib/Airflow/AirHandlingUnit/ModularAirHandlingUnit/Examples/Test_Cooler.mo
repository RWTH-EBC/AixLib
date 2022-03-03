within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_Cooler
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp m_air_in(
    duration=600,
    offset=2000/3600*1.18,
    startTime=600,
    height=0)
    annotation (Placement(transformation(extent={{-100,48},{-80,68}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp T_air_in(
    duration=600,
    startTime=2400,
    offset=303.15,
    height=0)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp T_wat_in(
    duration=600,
    startTime=3600,
    height=-8,
    offset=283.15)
    annotation (Placement(transformation(extent={{-98,-66},{-78,-46}})));
  Modelica.Blocks.Sources.Ramp m_wat_in(
    duration=600,
    startTime=4800,
    height=0,
    offset=3)
    annotation (Placement(transformation(extent={{-100,-96},{-80,-76}})));
  AixLib.FastHVAC.Components.Sinks.Vessel vessel
    annotation (Placement(transformation(extent={{64,-80},{84,-60}})));
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
  Components.Cooler cooler(redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,-26},{36,34}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor temWatOut
    annotation (Placement(transformation(extent={{34,-76},{48,-64}})));
  Modelica.Blocks.Sources.RealExpression T_coolingSurf(y=(T_wat_in.y +
        temWatOut.T)/2)
    annotation (Placement(transformation(extent={{-52,-48},{-32,-28}})));
  Components.Cooler cooler1(use_T_set=true,
    use_X_set=true,                         redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,42},{36,102}})));
  Modelica.Blocks.Sources.Ramp T_set(
    height=4,
    duration=600,
    offset=291.15,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Ramp X_set(
    height=-0.002,
    duration=600,
    offset=0.006,
    startTime=1800)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
equation
  connect(T_wat_in.y, fluidSource.T_fluid) annotation (Line(points={{-77,-56},{
          -60,-56},{-60,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(m_wat_in.y, fluidSource.dotm) annotation (Line(points={{-79,-86},{-62,
          -86},{-62,-76.6},{-44,-76.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.heatPort, convection.fluid)
    annotation (Line(points={{8,-60.6},{8,-56}}, color={191,0,0}));
  connect(const.y, convection.Gc) annotation (Line(points={{59,-34},{40,-34},{
          40,-46},{18,-46}}, color={0,0,127}));
  connect(X_in.y, cooler.X_airIn) annotation (Line(points={{-79,-20},{-58,-20},
          {-58,10},{-27,10}}, color={0,0,127}));
  connect(T_air_in.y, cooler.T_airIn) annotation (Line(points={{-79,20},{-68,20},
          {-68,19},{-27,19}}, color={0,0,127}));
  connect(m_air_in.y, cooler.m_flow_airIn) annotation (Line(points={{-79,58},{
          -68,58},{-68,28},{-27,28}}, color={0,0,127}));
  connect(convection.solid, cooler.heatPort)
    annotation (Line(points={{8,-36},{8,-26},{6,-26}}, color={191,0,0}));
  connect(workingFluid.enthalpyPort_b, temWatOut.enthalpyPort_a) annotation (
      Line(points={{17,-70},{24.1,-70},{24.1,-70.06},{34.84,-70.06}}, color={
          176,0,0}));
  connect(temWatOut.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{47.3,-70.06},{58,-70.06},{58,-70},{67,-70}}, color={176,0,0}));
  connect(T_coolingSurf.y, cooler.T_coolingSurf) annotation (Line(points={{-31,-38},
          {-8.7,-38},{-8.7,-25.7}},      color={0,0,127}));
  connect(T_coolingSurf.y, cooler1.T_coolingSurf) annotation (Line(points={{-31,
          -38},{-30,-38},{-30,-4},{-46,-4},{-46,36},{-8.7,36},{-8.7,42.3}},
        color={0,0,127}));
  connect(m_air_in.y, cooler1.m_flow_airIn) annotation (Line(points={{-79,58},{
          -68,58},{-68,96},{-27,96}}, color={0,0,127}));
  connect(T_air_in.y, cooler1.T_airIn) annotation (Line(points={{-79,20},{-62,
          20},{-62,87},{-27,87}}, color={0,0,127}));
  connect(X_in.y, cooler1.X_airIn) annotation (Line(points={{-79,-20},{-58,-20},
          {-58,78},{-27,78}}, color={0,0,127}));
  connect(T_set.y, cooler1.T_set) annotation (Line(points={{-79,90},{-72,90},{-72,
          116},{6,116},{6,102}},     color={0,0,127}));
  connect(X_set.y, cooler1.X_set) annotation (Line(points={{79,90},{70,90},{70,116},
          {24,116},{24,102}},        color={0,0,127}));
   annotation (experiment(StopTime=7200, __Dymola_NumberOfIntervals=7200),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.Cooler\">SimpleAHU.Components.Cooler</a>
  with set temperature and heatport. The heatport uses water as cooling
  source which changes its temperature over time.
</p>
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
end Test_Cooler;
