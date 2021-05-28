within AixLib.Fluid.Storage.Examples;
model StorageBoiler
  extends Modelica.Icons.Example;
  import AixLib;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.Storage.Storage storage(
    n=10,
    V_HE=0.05,
    kappa=0.4,
    beta=350e-6,
    A_HE=20,
    lambda_ins=0.04,
    s_ins=0.1,
    hConIn=1500,
    hConOut=15,
    d=1,
    h=2,
    k_HE=1500,
    redeclare package Medium = Medium,
    m_flow_nominal_layer=pipe1.m_flow_nominal,
    m_flow_nominal_HE=pipe.m_flow_nominal)
                                       annotation (Placement(transformation(extent={{-18,12},{2,32}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T = 283.15) annotation(Placement(transformation(extent={{-56,12},
            {-36,32}})));
  AixLib.Obsolete.Year2021.Fluid.Movers.Pump pump(redeclare package Medium = Medium, m_flow_small=1e-4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={6,60})));
  AixLib.Fluid.Sources.Boundary_pT
                     boundary_p(nPorts=1, redeclare package Medium = Medium)
                                annotation(Placement(transformation(extent={{-48,68},
            {-28,88}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin={46,48})));
  Modelica.Blocks.Sources.Constant const(k = 273.15 + 80) annotation(Placement(transformation(extent = {{-3, -3}, {3, 3}}, rotation = 180, origin={61,67})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{12,-12},{32,8}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance
                                           hydraulicResistance(zeta = 1000,
    redeclare package Medium = Medium,
    diameter=0.05,
    m_flow_nominal=0.001)                                                   annotation(Placement(transformation(extent={{46,-12},
            {66,8}})));
  AixLib.Fluid.Sources.Boundary_ph
                      boundary_ph1(use_p_in = true, h = 0.8e5,
    nPorts=1,
    redeclare package Medium = Medium)                         annotation(Placement(transformation(extent={{-66,-22},
            {-46,-2}})));
  Modelica.Blocks.Sources.Ramp ramp(duration = 1000,               height = 0.00001e5,
    offset=101325)                                                                     annotation(Placement(transformation(extent={{-96,-14},
            {-76,6}})));
  AixLib.Fluid.Sources.Boundary_pT
                      boundary_ph2(nPorts=1, redeclare package Medium = Medium)
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin={-34,44})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-28,-22},{-8,-2}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{42,68},{22,88}})));
equation
  connect(fixedTemperature.port, storage.heatPort) annotation(Line(points={{-36,22},
          {-16,22}},                                                                                color = {191, 0, 0}));
  connect(booleanExpression.y, pump.IsNight) annotation(Line(points={{35,48},{
          24,48},{24,60},{16.2,60}},                                                                                 color = {255, 0, 255}));
  connect(pipe.port_b, hydraulicResistance.port_a) annotation(Line(points={{32,-2},
          {46,-2}},                                                                            color = {0, 127, 255}));
  connect(pump.port_b, storage.port_a_heatGenerator) annotation(Line(points={{6,50},{
          6,30.8},{0.4,30.8}},                                                                                         color = {0, 127, 255}));
  connect(pipe.port_a, storage.port_b_heatGenerator) annotation(Line(points={{12,-2},
          {6,-2},{6,14},{0.4,14}},                                                                                          color = {0, 127, 255}));
  connect(ramp.y, boundary_ph1.p_in) annotation(Line(points={{-75,-4},{-68,-4}},        color = {0, 0, 127}));
  connect(pipe1.port_b, storage.port_a_consumer) annotation(Line(points={{-8,-12},
          {-8,12}},                                                                                color = {0, 127, 255}));
  connect(boundary_ph1.ports[1], pipe1.port_a) annotation (Line(
      points={{-46,-12},{-28,-12}},
      color={0,127,255}));
  connect(storage.port_b_consumer, boundary_ph2.ports[1]) annotation (Line(
      points={{-8,32},{-8,44},{-24,44}},
      color={0,127,255}));
  connect(boundary_p.ports[1], pump.port_a) annotation (Line(
      points={{-28,78},{6,78},{6,70}},
      color={0,127,255}));
  connect(pump.port_a, hea.port_b) annotation (Line(points={{6,70},{6,70},{6,78},
          {6,78},{22,78}}, color={0,127,255}));
  connect(hydraulicResistance.port_b, hea.port_a) annotation (Line(points={{66,
          -2},{80,-2},{80,78},{42,78}}, color={0,127,255}));
  connect(const.y, hea.TSet) annotation (Line(points={{57.7,67},{52,67},{52,86},
          {44,86}}, color={0,0,127}));
  annotation (experiment(StopTime = 86400, Interval = 60),Documentation(info = "<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This is a simple example of a storage and a boiler.
</p>
<ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>October 11, 2016&#160;</i> by Pooyan Jahangiri:<br/>
    Merged with AixLib and replaced boiler with idealHeater
  </li>
  <li>
    <i>October 11, 2016</i> by Marcus Fuchs:<br/>
    Replace pipe
  </li>
  <li>
    <i>November 2014&#160;</i> by Marcus Fuchs:<br/>
    Changed model to use Annex 60 base class
  </li>
  <li>
    <i>13.12.2013</i> by Sebastian Stinner:<br/>
    implemented
  </li>
</ul>
</html>"));
end StorageBoiler;
