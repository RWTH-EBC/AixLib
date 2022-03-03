within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Examples;
model Test_Cooler2 "advanced test with weather data for one year"
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp m_air_in(
    duration=600,
    offset=2000/3600*1.18,
    startTime=600,
    height=0)
    annotation (Placement(transformation(extent={{-64,74},{-44,94}})));
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
  Modelica.Blocks.Sources.Constant const(k=2500)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Components.Cooler cooler(redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-24,-16},{36,44}})));
  AixLib.FastHVAC.Components.Sensors.TemperatureSensor temWatOut
    annotation (Placement(transformation(extent={{34,-76},{48,-64}})));
  Modelica.Blocks.Sources.RealExpression T_coolingSurf(y=(T_wat_in.y +
        temWatOut.T)/2)
    annotation (Placement(transformation(extent={{-52,-48},{-32,-28}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-94,-2},{-54,38}}), iconTransformation(extent={
            {-160,22},{-140,42}})));
  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-76,-20},{-56,0}})));
  Modelica.Blocks.Sources.Constant T_wat_in(k=283.15)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Continuous.LimPID PID_T(
    yMin=0,
    Ti=80,
    Td=0.0001,
    k=-0.001,
    yMax=10) annotation (Placement(transformation(extent={{36,76},{56,96}})));
  Modelica.Blocks.Sources.Constant T_airSet(k=295.15)
    annotation (Placement(transformation(extent={{2,76},{22,96}})));
  Modelica.Blocks.Continuous.LimPID PID_X(
    Td=0.001,
    yMin=0,
    k=-1,
    Ti=80,
    yMax=10) annotation (Placement(transformation(extent={{74,32},{94,52}})));
  Modelica.Blocks.Sources.Constant X_airMaxSet(k=0.01)
    annotation (Placement(transformation(extent={{94,70},{74,90}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-86,-94},{-66,-74}})));
equation
  connect(fluidSource.enthalpyPort_b, workingFluid.enthalpyPort_a) annotation (
      Line(points={{-26,-73},{-14,-73},{-14,-70},{-1,-70}}, color={176,0,0}));
  connect(workingFluid.heatPort, convection.fluid)
    annotation (Line(points={{8,-60.6},{8,-56}}, color={191,0,0}));
  connect(const.y, convection.Gc) annotation (Line(points={{59,-34},{40,-34},{
          40,-46},{18,-46}}, color={0,0,127}));
  connect(m_air_in.y, cooler.m_flow_airIn) annotation (Line(points={{-43,84},{
          -36,84},{-36,38},{-27,38}}, color={0,0,127}));
  connect(convection.solid, cooler.heatPort)
    annotation (Line(points={{8,-36},{8,-16},{6,-16}}, color={191,0,0}));
  connect(workingFluid.enthalpyPort_b, temWatOut.enthalpyPort_a) annotation (
      Line(points={{17,-70},{24.1,-70},{24.1,-70.06},{34.84,-70.06}}, color={
          176,0,0}));
  connect(temWatOut.enthalpyPort_b, vessel.enthalpyPort_a) annotation (Line(
        points={{47.3,-70.06},{58,-70.06},{58,-70},{67,-70}}, color={176,0,0}));
  connect(T_coolingSurf.y, cooler.T_coolingSurf) annotation (Line(points={{-31,
          -38},{-8.7,-38},{-8.7,-15.7}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-80,50},{-74,50},{-74,18}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, cooler.T_airIn) annotation (Line(
      points={{-74,18},{-52,18},{-52,29},{-27,29}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm, x_pTphi.p_in) annotation (Line(
      points={{-74,18},{-92,18},{-92,-4},{-78,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, x_pTphi.T) annotation (Line(
      points={{-74,18},{-92,18},{-92,-10},{-78,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum, x_pTphi.phi) annotation (Line(
      points={{-74,18},{-92,18},{-92,-16},{-78,-16}},
      color={255,204,51},
      thickness=0.5));
  connect(x_pTphi.X[1], cooler.X_airIn) annotation (Line(points={{-55,-10},{-40,
          -10},{-40,20},{-27,20}}, color={0,0,127}));
  connect(T_wat_in.y, fluidSource.T_fluid) annotation (Line(points={{-79,-50},{
          -62,-50},{-62,-69.8},{-44,-69.8}}, color={0,0,127}));
  connect(T_airSet.y, PID_T.u_s)
    annotation (Line(points={{23,86},{34,86}}, color={0,0,127}));
  connect(cooler.T_airOut, PID_T.u_m)
    annotation (Line(points={{39,29},{46,29},{46,74}}, color={0,0,127}));
  connect(X_airMaxSet.y, PID_X.u_s) annotation (Line(points={{73,80},{66,80},{
          66,42},{72,42}}, color={0,0,127}));
  connect(cooler.X_airOut, PID_X.u_m)
    annotation (Line(points={{39,20},{84,20},{84,30}}, color={0,0,127}));
  connect(PID_T.y, max.u1) annotation (Line(points={{57,86},{64,86},{64,100},{
          100,100},{100,-100},{-100,-100},{-100,-78},{-88,-78}}, color={0,0,127}));
  connect(PID_X.y, max.u2) annotation (Line(points={{95,42},{100,42},{100,-100},
          {-100,-100},{-100,-90},{-88,-90}}, color={0,0,127}));
  connect(max.y, fluidSource.dotm) annotation (Line(points={{-65,-84},{-58,-84},
          {-58,-76.6},{-44,-76.6}}, color={0,0,127}));
 annotation (experiment(StopTime=31536000, Interval=1800),Documentation(info="<html><p>
  Testing modell <a href=
  \"modelica://SimpleAHU.Components.FlowControlled_dp\">SimpleAHU.Components.FlowControlled_dp</a>
  using weater data.
</p>
<p>
  Incoming pressure rise and massflow increase over time.
</p>
</html>", revisions="<html>

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
end Test_Cooler2;
