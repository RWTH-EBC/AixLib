within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.SensibleCooler;
model Test_SensibleCooler4
  Modelica.Blocks.Continuous.LimPID PID_T(
    yMin=0,
    Ti=80,
    Td=0.0001,
    k=-0.05,
    yMax=10) annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.Constant T_airSet(k=291.15)
    annotation (Placement(transformation(extent={{26,40},{46,60}})));
  Modelica.Blocks.Sources.Ramp m_airIn(
    duration=600,
    offset=2000/3600*1.18,
    startTime=600,
    height=0) annotation (Placement(transformation(extent={{-98,72},{-78,92}})));
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
    annotation (Placement(transformation(extent={{12,68},{32,88}})));
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
    annotation (Placement(transformation(extent={{100,80},{80,102}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{38,68},{58,88}})));
  Modelica.Blocks.Sources.RealExpression Q_flow(y=sensibleCooler.Q_flow)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.SensibleCooler
    sensibleCooler(redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-2,2},{18,22}})));
  AixLib.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    computeWetBulbTemperature=false,
    filNam=ModelicaServices.ExternalReferences.loadResource(
        "modelica://AixLib/Airflow/AirHandlingUnit/ModularAirHandlingUnit/Resources/TRY2015_507931060546_Jahr_City_Aachen.mos"),
    calTSky=AixLib.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));

  AixLib.Utilities.Psychrometrics.X_pTphi x_pTphi
    annotation (Placement(transformation(extent={{-76,-20},{-56,0}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-94,-2},{-54,38}}), iconTransformation(extent={
            {-160,22},{-140,42}})));
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
  connect(bou.ports[1],T_airOut_fluid. port_b) annotation (Line(points={{80,91},
          {79,91},{79,78},{58,78}}, color={0,127,255}));
  connect(hea.port_b,T_airOut_fluid. port_a) annotation (Line(points={{32,78},{38,
          78}},                 color={0,127,255}));
  connect(Q_flow.y,hea. u) annotation (Line(points={{-19,90},{-2,90},{-2,84},{10,
          84}},     color={0,0,127}));
  connect(T_airSet.y,PID_T. u_s)
    annotation (Line(points={{47,50},{58,50}}, color={0,0,127}));
  connect(sensibleCooler.T_airOut, PID_T.u_m)
    annotation (Line(points={{19,17},{70,17},{70,38}}, color={0,0,127}));
  connect(sensibleCooler.heatPort, convection.solid)
    annotation (Line(points={{8,2},{8,-24}}, color={191,0,0}));
  connect(m_airIn.y, sensibleCooler.m_flow_airIn) annotation (Line(points={{-77,
          82},{-72,82},{-72,40},{-40,40},{-40,20},{-3,20}}, color={0,0,127}));
  connect(boundary.ports[1], hea.port_a) annotation (Line(points={{-10,46},{0,46},
          {0,78},{12,78}},    color={0,127,255}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-80,50},{-74,50},{-74,18}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.pAtm,x_pTphi. p_in) annotation (Line(
      points={{-74,18},{-92,18},{-92,-4},{-78,-4}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul,x_pTphi. T) annotation (Line(
      points={{-74,18},{-92,18},{-92,-10},{-78,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.relHum,x_pTphi. phi) annotation (Line(
      points={{-74,18},{-92,18},{-92,-16},{-78,-16}},
      color={255,204,51},
      thickness=0.5));
  connect(weaBus.TDryBul, sensibleCooler.T_airIn) annotation (Line(
      points={{-74,18},{-3,18},{-3,17}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(x_pTphi.X[1], boundary.Xi_in[1]) annotation (Line(points={{-55,-10},{-38,
          -10},{-38,42},{-32,42}}, color={0,0,127}));
  connect(weaBus.TDryBul, boundary.T_in) annotation (Line(
      points={{-74,18},{-46,18},{-46,50},{-32,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(m_airIn.y, boundary.m_flow_in) annotation (Line(points={{-77,82},{-60,
          82},{-60,54},{-32,54}}, color={0,0,127}));
  connect(x_pTphi.X[1], sensibleCooler.X_airIn) annotation (Line(points={{-55,-10},
          {-24,-10},{-24,14},{-3,14}}, color={0,0,127}));
  annotation (experiment(StopTime=31536000, Interval=1800),
   Documentation(info="<html>
<p>
In this model the cooler <a href=\"modelica://SimpleAHU.Components.SensibleCooler\">
SimpleAHU.Components.SensibleCooler</a> uses water to cool the incoming air.
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
end Test_SensibleCooler4;
