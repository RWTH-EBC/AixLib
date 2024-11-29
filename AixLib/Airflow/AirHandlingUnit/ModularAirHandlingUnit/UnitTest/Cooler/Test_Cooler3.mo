within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.UnitTest.Cooler;
model Test_Cooler3 "Test case using T_set without condensation"
  Modelica.Blocks.Sources.Ramp m_airIn(
    height=1000/3600*1.18,
    duration=600,
    offset=2000/3600*1.18,
    startTime=600)
    annotation (Placement(transformation(extent={{-100,-32},{-80,-12}})));
  Modelica.Blocks.Sources.Constant X_in(k=0.005)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Ramp T_airIn(
    height=2,
    duration=600,
    offset=298.15,
    startTime=3000)
    annotation (Placement(transformation(extent={{-100,-66},{-80,-46}})));
  Modelica.Blocks.Sources.Ramp T_set(
    height=2,
    duration=600,
    offset=288.15,
    startTime=1800)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AixLib.Media.Air,
    use_m_flow_in=true,
    use_T_in=true,
    X={0.015,1 - 0.015},
    use_Xi_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-42,40},{-22,60}})));
  AixLib.Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        AixLib.Media.Air, nPorts=1)
    annotation (Placement(transformation(extent={{100,58},{80,80}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort T_airOut_fluid(redeclare package Medium =
               AixLib.Media.Air, m_flow_nominal=2000/3600*1.18)
    annotation (Placement(transformation(extent={{54,66},{74,86}})));
  AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.Cooler cooler(
    cp_air=1006,
    use_T_set=true,
    redeclare model PartialPressureDrop =
        AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{-30,-34},{-10,-14}})));
  Fluid.HeatExchangers.PrescribedOutlet preOut(
    redeclare package Medium = Media.Air,
    m_flow_nominal=3000/3600*1.18,
    show_T=true,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{16,66},{36,86}})));
  Utilities.Psychrometrics.SaturationPressure        pSat
    annotation (Placement(transformation(extent={{-58,86},{-48,96}})));
  Utilities.Psychrometrics.X_pW        humRat(use_p_in=false)
    annotation (Placement(transformation(extent={{-40,86},{-30,96}})));
  Modelica.Blocks.Math.Abs abs1 annotation (Placement(transformation(extent={{64,24},{76,36}})));
protected
  Modelica.Blocks.Math.Min min_X              annotation (Placement(transformation(extent={{-18,88},{-4,102}})));
equation
  connect(bou.ports[1],T_airOut_fluid. port_b) annotation (Line(points={{80,69},
          {77,69},{77,76},{74,76}}, color={0,127,255}));
  connect(T_set.y, cooler.T_set)
    annotation (Line(points={{-79,10},{-20,10},{-20,-14}}, color={0,0,127}));
  connect(m_airIn.y, cooler.m_flow_airIn) annotation (Line(points={{-79,-22},{-76,-22},{-76,-16},{-31,-16}},
                                     color={0,0,127}));
  connect(T_airIn.y, cooler.T_airIn) annotation (Line(points={{-79,-56},{-74,-56},{-74,-19},{-31,-19}},
                                color={0,0,127}));
  connect(X_in.y, cooler.X_airIn) annotation (Line(points={{-79,-90},{-72,-90},{-72,-22},{-31,-22}},
                               color={0,0,127}));
  connect(boundary.m_flow_in, m_airIn.y) annotation (Line(points={{-44,58},{-54,
          58},{-54,-4},{-76,-4},{-76,-22},{-79,-22}}, color={0,0,127}));
  connect(boundary.T_in, T_airIn.y) annotation (Line(points={{-44,54},{-52,54},
          {-52,-14},{-74,-14},{-74,-56},{-79,-56}},color={0,0,127}));
  connect(boundary.Xi_in[1], X_in.y) annotation (Line(points={{-44,46},{-50,46},
          {-50,-26},{-70,-26},{-70,-90},{-79,-90}}, color={0,0,127}));
  connect(boundary.ports[1], preOut.port_a) annotation (Line(points={{-22,50},{
          -8,50},{-8,76},{16,76}}, color={0,127,255}));
  connect(preOut.port_b, T_airOut_fluid.port_a)
    annotation (Line(points={{36,76},{54,76}}, color={0,127,255}));
  connect(T_set.y, preOut.TSet) annotation (Line(points={{-79,10},{-62,10},{-62,
          84},{14,84}}, color={0,0,127}));
  connect(pSat.pSat,humRat. p_w)
    annotation (Line(points={{-47.5,91},{-40.5,91}},
                                                   color={0,0,127}));
  connect(T_set.y, pSat.TSat) annotation (Line(points={{-79,10},{-62,10},{-62,91},{-58.5,91}}, color={0,0,127}));
  connect(humRat.X_w, min_X.u2) annotation (Line(points={{-29.5,91},{-22,91},{-22,90.8},{-19.4,90.8}}, color={0,0,127}));
  connect(X_in.y, min_X.u1) annotation (Line(points={{-79,-90},{-72,-90},{-72,99.2},{-19.4,99.2}}, color={0,0,127}));
  connect(min_X.y, preOut.X_wSet) annotation (Line(points={{-3.3,95},{2,95},{2,80},{14,80}}, color={0,0,127}));
  connect(preOut.Q_flow, abs1.u) annotation (Line(points={{37,84},{46,84},{46,30},{62.8,30}}, color={0,0,127}));
  annotation (experiment(StopTime=8000, __Dymola_NumberOfIntervals=7200),
   Documentation(info="<html><p>
  Simple test for <a href=
  \"modelica://SimpleAHU.Components.Cooler\">SimpleAHU.Components.Cooler</a>.
  The temperature of the outflowing air is beeing controlled under
  changing massflow and incoming temperature.
</p>
<p>
  The results are then compared to <a href=
  \"modelica://AixLib.Fluid.HeatExchangers.SensibleCooler_T\">AixLib.Fluid.HeatExchangers.SensibleCooler_T</a>
  (boundary conditions are consistent).
</p>
</html>", revisions="<html>
<ul>
  <li>November, 2019, by Ervin Lejlic:<br/>
    First implementation.
  </li>
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
end Test_Cooler3;
