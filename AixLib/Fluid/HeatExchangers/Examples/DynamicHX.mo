within AixLib.Fluid.HeatExchangers.Examples;
model DynamicHX
  "Model that demonstrates use of a simple dynamic heat exchanger"
 package Medium1 = AixLib.Media.Water "Medium model";
  import AixLib;
  extends Modelica.Icons.Example;

 package Medium2 = AixLib.Media.Air "Medium model";

  AixLib.Fluid.Sources.Boundary_pT sin_2(
    redeclare package Medium = Medium2,
    use_p_in=true,
    T=273.15 + 10,
    X={0.001,0.999},
    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{-58,-10},
            {-38,10}})));
    Modelica.Blocks.Sources.Ramp PIn(
    height=200,
    duration=60,
    offset=101325,
    startTime=50)
    "Ramp signal for pressure"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  AixLib.Fluid.Sources.Boundary_pT sou_2(
    redeclare package Medium = Medium2, T=273.15 + 5,
    use_p_in=true,
    use_T_in=true,
    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{40,-70}, {60,-50}})));

    Modelica.Blocks.Sources.Ramp TWat(
    height=10,
    duration=60,
    offset=273.15 + 30,
    startTime=60) "Water temperature"
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Constant TDb(k=293.15) "Drybulb temperature"
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));

  Modelica.Blocks.Sources.Constant POut(k=101325) "Pressure"
    annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));

  AixLib.Fluid.Sources.Boundary_pT sin_1(
    redeclare package Medium = Medium1,
    use_p_in=true,
    p=300000,
    T=273.15 + 25,
    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{84,2},{64,22}})));

  AixLib.Fluid.Sources.Boundary_pT sou_1(
    redeclare package Medium = Medium1,
    p=300000 + 5000,
    T=273.15 + 50,
    use_T_in=true,
    nPorts=1)
    "Boundary condition"
    annotation (Placement(transformation(extent={{-60,36}, {-40,56}})));

  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=5000,
    rising=10,
    width=100,
    falling=10,
    period=3600,
    offset=300000)
    "Signal for pressure boundary condition"
    annotation (Placement(transformation(extent={{40,62},{60,82}})));
  AixLib.Fluid.HeatExchangers.DynamicHX dynamicHX(
    redeclare package Medium1 = Medium1,
    redeclare package Medium2 = Medium2,
    m1_flow_nominal=1,
    m2_flow_nominal=1,
    dp1_nominal=5000,
    dp2_nominal=1000,
    dT_nom=30,
    Q_nom=50000) annotation (Placement(transformation(extent={{2,-4},{22,16}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort THeaOut1(
    redeclare package Medium = Medium1,
    m_flow_nominal=1,
    T_start=289.15) "Outlet temperature of the heater"
    annotation (Placement(transformation(extent={{32,2},{52,22}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort THeaOut2(
    redeclare package Medium = Medium2,
    m_flow_nominal=1,
    T_start=289.15) "Outlet temperature of the heater" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-18,0})));
equation
  connect(PIn.y,sou_2. p_in) annotation (Line(
      points={{1,-40},{20,-40},{20,-52},{38,-52}},
      color={0,0,127}));
  connect(TDb.y, sou_2.T_in) annotation (Line(points={{1,-80},{20,-80},{20,-56},
          {38,-56}}, color={0,0,127}));
  connect(TWat.y, sou_1.T_in)
    annotation (Line(points={{-79,50},{-70.5,50},{-62,50}},
                                                 color={0,0,127}));
  connect(POut.y, sin_2.p_in) annotation (Line(
      points={{-79,8},{-69.5,8},{-69.5,8},{-60,8}},
      color={0,0,127}));
  connect(trapezoid.y, sin_1.p_in) annotation (Line(
      points={{61,72},{94,72},{94,20},{86,20}},
      color={0,0,127}));
  connect(sou_1.ports[1], dynamicHX.port_a1) annotation (Line(points={{-40,46},
          {-20,46},{-20,12},{2,12}}, color={0,127,255}));
  connect(sou_2.ports[1], dynamicHX.port_a2) annotation (Line(points={{60,-60},
          {62,-60},{62,-10},{32,-10},{32,0},{22,0}}, color={0,127,255}));
  connect(THeaOut1.port_a, dynamicHX.port_b1)
    annotation (Line(points={{32,12},{22,12}}, color={0,127,255}));
  connect(THeaOut1.port_b, sin_1.ports[1])
    annotation (Line(points={{52,12},{64,12}}, color={0,127,255}));
  connect(dynamicHX.port_b2, THeaOut2.port_a) annotation (Line(points={{2,0},{
          -4,0},{-4,-1.22125e-015},{-8,-1.22125e-015}}, color={0,127,255}));
  connect(THeaOut2.port_b, sin_2.ports[1])
    annotation (Line(points={{-28,0},{-38,0}}, color={0,127,255}));
  annotation(experiment(Tolerance=1e-6, StopTime=360),
Documentation(info="<html><p>
  This model tests <a href=
  \"modelica://AixLib.Fluid.HeatExchangers.DynamicHX\">AixLib.Fluid.HeatExchangers.DynamicHX</a>
  for different inlet conditions.
</p>
<ul>
  <li>December 12, 2018, by Alexander Kümpel:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end DynamicHX;
