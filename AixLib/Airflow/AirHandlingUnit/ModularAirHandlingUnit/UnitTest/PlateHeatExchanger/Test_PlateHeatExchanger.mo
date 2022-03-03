within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.PlateHeatExchanger;
model Test_PlateHeatExchanger
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PlateHeatExchanger
  plateHeatExchanger(redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-8,-52},{12,-32}})));
  Modelica.Blocks.Sources.Ramp m_flow(
    height=0,
    duration=600,
    offset=2000/3600*1.18,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Constant X_EtaIn(k=0.01)
    annotation (Placement(transformation(extent={{100,-100},{80,-80}})));
  Modelica.Blocks.Sources.Constant T_EtaIn(k=293.15)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Sources.Constant const(k=383.15)
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
  AixLib.Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = AixLib.Media.Air,
    redeclare package Medium2 = AixLib.Media.Air,
    m1_flow_nominal=2000/3600*1.18,
    m2_flow_nominal=2000/3600*1.18,
    dp1_nominal=0,
    dp2_nominal=0,
    dT_nom=20,
    Q_nom=22000)
                annotation (Placement(transformation(extent={{-8,60},{12,80}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    use_Xi_in=true,
    X={0.005,1 - 0.005},
    nPorts=1) annotation (Placement(transformation(extent={{-80,74},{-60,94}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.01,1 - 0.01},
    nPorts=1,
    use_Xi_in=true)
              annotation (Placement(transformation(extent={{86,48},{66,68}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{92,80},{72,102}})));
  AixLib.Fluid.Sources.Boundary_pT bou1(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{-80,40},{-60,62}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOutOda_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{38,80},{58,100}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOutEta_fluid(redeclare package
      Medium = AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{-48,40},{-28,60}})));

  Modelica.Blocks.Sources.Constant X_in(k=0.003)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=10,
    duration=600,
    offset=283.15,
    startTime=2400)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(m_flow.y, plateHeatExchanger.m_flow_airInOda) annotation (Line(points={{-79,10},
          {-12,10},{-12,-34},{-9,-34}},             color={0,0,127}));
  connect(X_EtaIn.y, plateHeatExchanger.X_airInEta) annotation (Line(points={{79,
          -90},{60,-90},{60,-40},{13,-40}}, color={0,0,127}));
  connect(T_EtaIn.y, plateHeatExchanger.T_airInEta) annotation (Line(points={{79,
          -30},{70,-30},{70,-37},{13,-37}}, color={0,0,127}));
  connect(const.y, plateHeatExchanger.T_set)
    annotation (Line(points={{39,10},{2,10},{2,-31}}, color={0,0,127}));
  connect(plateHeatExchanger.m_flow_airInEta, m_flow.y) annotation (Line(points={{13,-34},
          {72,-34},{72,-4},{100,-4},{100,36},{0,36},{0,10},{-79,10}},
        color={0,0,127}));
  connect(boundary.ports[1], dynamicHX.port_a1) annotation (Line(points={{-60,84},
          {-30,84},{-30,76},{-8,76}}, color={0,127,255}));
  connect(boundary1.ports[1], dynamicHX.port_a2) annotation (Line(points={{66,58},
          {54,58},{54,64},{12,64}}, color={0,127,255}));
  connect(dynamicHX.port_b1, T_airOutOda_fluid.port_a) annotation (Line(points={
          {12,76},{26,76},{26,90},{38,90}}, color={0,127,255}));
  connect(T_airOutOda_fluid.port_b, bou.ports[1]) annotation (Line(points={{58,90},
          {65,90},{65,91},{72,91}}, color={0,127,255}));
  connect(bou1.ports[1], T_airOutEta_fluid.port_a) annotation (Line(points={{-60,
          51},{-54,51},{-54,50},{-48,50}}, color={0,127,255}));
  connect(T_airOutEta_fluid.port_b, dynamicHX.port_b2)
    annotation (Line(points={{-28,50},{-28,64},{-8,64}}, color={0,127,255}));
  connect(boundary.m_flow_in, m_flow.y) annotation (Line(points={{-82,92},{-100,
          92},{-100,28},{-70,28},{-70,10},{-79,10}}, color={0,0,127}));
  connect(m_flow.y, boundary1.m_flow_in) annotation (Line(points={{-79,10},{4,10},
          {4,36},{100,36},{100,66},{88,66}}, color={0,0,127}));
  connect(T_EtaIn.y, boundary1.T_in) annotation (Line(points={{79,-30},{72,-30},
          {72,14},{92,14},{92,62},{88,62}}, color={0,0,127}));
  connect(X_EtaIn.y, boundary1.Xi_in[1]) annotation (Line(points={{79,-90},{72,-90},
          {72,14},{92,14},{92,54},{88,54}}, color={0,0,127}));
  connect(T_airIn.y, boundary.T_in) annotation (Line(points={{-79,-30},{-70,-30},
          {-70,28},{-100,28},{-100,88},{-82,88}}, color={0,0,127}));
  connect(X_in.y, boundary.Xi_in[1]) annotation (Line(points={{-79,-70},{-70,
          -70},{-70,28},{-100,28},{-100,80},{-82,80}}, color={0,0,127}));
  connect(X_in.y, plateHeatExchanger.X_airInOda) annotation (Line(points={{-79,
          -70},{-70,-70},{-70,-40},{-9,-40}}, color={0,0,127}));
  connect(T_airIn.y, plateHeatExchanger.T_airInOda) annotation (Line(points={{
          -79,-30},{-70,-30},{-70,-37},{-9,-37}}, color={0,0,127}));
  annotation (experiment(
      StopTime=8000,
      __Dymola_NumberOfIntervals=8000,
      __Dymola_Algorithm="Dassl"),
   Documentation(info="<html><p>
  There are two incoming airflows flowing through <a href=
  \"modelica://SimpleAHU.Components.PlateHeatExchanger\">SimpleAHU.Components.PlateHeatExchanger</a>.
</p>
<p>
  The first one has weather Temperature and Massfraction and the second
  one has constant temperature and Massfraction.
</p>
<p>
  The results are then compared to <a href=
  \"modelica://AixLib.Fluid.HeatExchangers.DynamicHX\">AixLib.Fluid.HeatExchangers.DynamicHX</a>
  (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
  <li>November, 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    experiment(StopTime=31536000),
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
end Test_PlateHeatExchanger;
