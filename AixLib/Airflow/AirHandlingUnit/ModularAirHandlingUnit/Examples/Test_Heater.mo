within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_Heater
  extends Modelica.Icons.Example;

  Components.Heater heater(redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-22,-22},{24,24}})));
  Modelica.Blocks.Sources.Ramp m_air_in(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.006)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Ramp T_air_in(
    height=10,
    duration=600,
    offset=273.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Ramp T_wat_in(
    height=20,
    duration=600,
    offset=323.15,
    startTime=3600)
    annotation (Placement(transformation(extent={{-98,-66},{-78,-46}})));
  Modelica.Blocks.Sources.Ramp m_wat_in(
    height=-1/3.6,
    duration=600,
    offset=1,
    startTime=4800)
    annotation (Placement(transformation(extent={{-100,-96},{-80,-76}})));
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
  Components.Heater           heater1(use_T_set=true, redeclare model
      PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,44},{22,90}})));
  Modelica.Blocks.Sources.Ramp T_set(
    height=4,
    duration=600,
    offset=291.15,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
equation
  connect(m_air_in.y, heater.m_flow_airIn) annotation (Line(points={{-79,60},{-50,
          60},{-50,19.4},{-24.3,19.4}}, color={0,0,127}));
  connect(X_in.y, heater.X_airIn) annotation (Line(points={{-79,-20},{-62,-20},{
          -62,5.6},{-24.3,5.6}}, color={0,0,127}));
  connect(T_air_in.y, heater.T_airIn) annotation (Line(points={{-79,20},{-54,20},
          {-54,12.5},{-24.3,12.5}}, color={0,0,127}));
  connect(T_wat_in.y, fluidSource.T_fluid) annotation (Line(points={{-77,-56},{
          -60,-56},{-60,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(m_wat_in.y, fluidSource.dotm) annotation (Line(points={{-79,-86},{-62,
          -86},{-62,-76.6},{-44,-76.6}}, color={0,0,127}));
  connect(fluidSource.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{17,-70},{36,-70},{36,-68},{55,-68}}, color={176,0,0}));
  connect(workingFluid.heatPort, convection.fluid)
    annotation (Line(points={{8,-60.6},{8,-56}}, color={191,0,0}));
  connect(convection.solid, heater.heatPort) annotation (Line(points={{8,-36},{8,
          -30},{1,-30},{1,-22}}, color={191,0,0}));
  connect(const.y, convection.Gc) annotation (Line(points={{59,-34},{40,-34},{
          40,-46},{18,-46}}, color={0,0,127}));
  connect(m_air_in.y, heater1.m_flow_airIn) annotation (Line(points={{-79,60},{
          -50,60},{-50,85.4},{-26.3,85.4}}, color={0,0,127}));
  connect(T_air_in.y, heater1.T_airIn) annotation (Line(points={{-79,20},{-54,
          20},{-54,78.5},{-26.3,78.5}}, color={0,0,127}));
  connect(X_in.y, heater1.X_airIn) annotation (Line(points={{-79,-20},{-62,-20},
          {-62,71.6},{-26.3,71.6}}, color={0,0,127}));
  connect(T_set.y, heater1.T_set) annotation (Line(points={{-79,90},{-56,90},{-56,
          100},{-1,100},{-1,90}},       color={0,0,127}));
   annotation (experiment(StopTime=7200, __Dymola_NumberOfIntervals=7200),
 Documentation(info="<html><p>
  Testing <a href=
  \"modelica://SimpleAHU.Components.Heater\">SimpleAHU.Components.Heater</a>
  with set temperature and heatport. The heatport uses water as heat
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
end Test_Heater;
