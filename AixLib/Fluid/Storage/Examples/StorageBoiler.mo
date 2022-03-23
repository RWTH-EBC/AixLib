within AixLib.Fluid.Storage.Examples;
model StorageBoiler
  extends Modelica.Icons.Example;
  import AixLib;

  replaceable package Medium =
     Modelica.Media.Water.ConstantPropertyLiquidWater
     constrainedby Modelica.Media.Interfaces.PartialMedium;

  AixLib.Fluid.Storage.StorageDetailed bufferStorage(
    redeclare package MediumHC1 = Medium,
    redeclare package MediumHC2 = Medium,
    m1_flow_nominal=pipe1.m_flow_nominal,
    m2_flow_nominal=pipe1.m_flow_nominal,
    mHC1_flow_nominal=pipe1.m_flow_nominal,
    useHeatingCoil2=false,
    useHeatingRod=false,
    redeclare AixLib.DataBase.Storage.Generic_New_2000l data(
      hTank=2,
      hUpperPortDemand=1.95,
      hUpperPortSupply=1.95,
      hHC1Up=1.95,
      dTank=1,
      hTS2=1.95),
    n=10,
    hConIn=1500,
    hConOut=15,
    redeclare package Medium = Medium,
    hConHC1=300)                       annotation (Placement(transformation(extent={{6,8},{
            -18,38}})));
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
                                                     annotation(Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 180, origin={-38,56})));
  AixLib.Fluid.FixedResistances.PressureDrop pipe1(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=200)
    annotation (Placement(transformation(extent={{-36,-22},{-16,-2}})));
  AixLib.Fluid.HeatExchangers.Heater_T       hea(
    redeclare package Medium = Medium,
    m_flow_nominal=0.01,
    dp_nominal=0)
    annotation (Placement(transformation(extent={{42,68},{22,88}})));
equation
  connect(booleanExpression.y, pump.IsNight) annotation(Line(points={{35,48},{
          24,48},{24,60},{16.2,60}},                                                                                 color = {255, 0, 255}));
  connect(pipe.port_b, hydraulicResistance.port_a) annotation(Line(points={{32,-2},
          {46,-2}},                                                                            color = {0, 127, 255}));
  connect(ramp.y, boundary_ph1.p_in) annotation(Line(points={{-75,-4},{-68,-4}},        color = {0, 0, 127}));
  connect(boundary_ph1.ports[1], pipe1.port_a) annotation (Line(
      points={{-46,-12},{-36,-12}},
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
  connect(boundary_ph2.ports[1], bufferStorage.fluidportTop2) annotation (Line(
        points={{-28,56},{-9.75,56},{-9.75,38.15}}, color={0,127,255}));
  connect(bufferStorage.fluidportBottom2, pipe1.port_b) annotation (Line(points=
         {{-9.45,7.85},{-9.45,-2},{-10,-2},{-10,-12},{-16,-12}}, color={0,127,
          255}));
  connect(pipe.port_a, bufferStorage.portHC1Out) annotation (Line(points={{12,
          -2},{14,-2},{14,26.9},{6.15,26.9}}, color={0,127,255}));
  connect(pump.port_b, bufferStorage.portHC1In) annotation (Line(points={{6,50},
          {6,44},{12,44},{12,31.55},{6.3,31.55}}, color={0,127,255}));
  connect(fixedTemperature.port, bufferStorage.heatportOutside) annotation (
      Line(points={{-36,22},{-28,22},{-28,23.9},{-17.7,23.9}}, color={191,0,0}));
  annotation (experiment(Tolerance=1e-6, StopTime=86400, Interval=60),
    Documentation(info = "<html><h4>
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
