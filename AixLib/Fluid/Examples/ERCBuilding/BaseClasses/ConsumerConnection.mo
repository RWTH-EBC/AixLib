within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model ConsumerConnection

  replaceable package Water = AixLib.Media.Water;

  parameter Modelica.SIunits.ThermodynamicTemperature T_start=293.15;
  parameter Modelica.SIunits.Time T_toCons(start=1) = 5*60 "Time Constant";
  parameter Modelica.SIunits.Time delayTimeToCons(start=1) = 2*60
    "Delay time of output with respect to input signal";
      parameter Modelica.SIunits.Time T_toGen(start=1)= 5*60
    "Time Constant";
  parameter Modelica.SIunits.Time delayTimeToGen(start=1) = 5*60
    "Delay time of output with respect to input signal";

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  AixLib.Fluid.Sources.MassFlowSource_T supplyCircuitSource(
    redeclare package Medium = Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-60,30},{-80,50}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));

  AixLib.Fluid.Sources.MassFlowSource_T supplyCircuitSink(
    redeclare package Medium = Water,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=false)
    annotation (Placement(transformation(extent={{-30,-50},{-50,-30}})));
  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=180,
        origin={-9,-32})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureSupplyCircuit(
    redeclare package Medium = Water,
    m_flow_nominal=0.5,
    T_start=T_start)
    annotation (Placement(transformation(extent={{-86,-50},{-66,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort temperatureSupplyCircuit1(
    redeclare package Medium = Water,
    m_flow_nominal=0.5,
    T_start=T_start) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,-40})));
  AixLib.Fluid.Sources.Boundary_pT consumerCircuitSource(
    redeclare package Medium = Water,
    use_T_in=true,
    p=200000,
    nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={50,40})));
  AixLib.Fluid.Sources.Boundary_pT consumerCircuitSink(
    redeclare package Medium = Water,
    nPorts=1,
    p=200000) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={28,-40})));
  Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={52,-40})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelayToCons(delayTime=
        delayTimeToCons)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderToCons(T=T_toCons, y_start=
        T_start) annotation (Placement(transformation(extent={{6,26},{26,46}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelayToGen(delayTime=delayTimeToGen)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={16,0})));
  Modelica.Blocks.Continuous.FirstOrder firstOrderToGen(T=T_toGen, y_start=
        T_start) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-20,34})));
equation

  connect(port_b1, supplyCircuitSource.ports[1]) annotation (Line(points={{-100,
          40},{-100,40},{-80,40}}, color={0,127,255}));
  connect(port_a1, temperatureSupplyCircuit.port_a)
    annotation (Line(points={{-100,-40},{-86,-40}}, color={0,127,255}));
  connect(temperatureSupplyCircuit.port_b, supplyCircuitSink.ports[1])
    annotation (Line(points={{-66,-40},{-50,-40}}, color={0,127,255}));
  connect(gain.y, supplyCircuitSink.m_flow_in) annotation (Line(points={{-14.5,-32},
          {-19.25,-32},{-30,-32}}, color={0,0,127}));
  connect(temperatureSupplyCircuit1.port_a, port_a2)
    annotation (Line(points={{90,-40},{90,-40},{100,-40}}, color={0,127,255}));
  connect(consumerCircuitSource.ports[1], port_b2)
    annotation (Line(points={{60,40},{60,40},{100,40}}, color={0,127,255}));
  connect(consumerCircuitSink.ports[1], senMasFlo.port_b)
    annotation (Line(points={{38,-40},{42,-40}}, color={0,127,255}));
  connect(senMasFlo.port_a, temperatureSupplyCircuit1.port_b)
    annotation (Line(points={{62,-40},{70,-40}}, color={0,127,255}));
  connect(senMasFlo.m_flow, supplyCircuitSource.m_flow_in) annotation (Line(
        points={{52,-29},{52,-20},{-40,-20},{-40,48},{-60,48}},
                                                            color={0,0,127}));
  connect(senMasFlo.m_flow, gain.u) annotation (Line(points={{52,-29},{52,-29},
          {52,-20},{52,-20},{10,-20},{10,-32},{-3,-32}},
                                                   color={0,0,127}));
  connect(temperatureSupplyCircuit.T, fixedDelayToCons.u)
    annotation (Line(points={{-76,-29},{-76,0},{-32,0}}, color={0,0,127}));
  connect(fixedDelayToCons.y, firstOrderToCons.u)
    annotation (Line(points={{-9,0},{-4,0},{-4,36},{4,36}}, color={0,0,127}));
  connect(firstOrderToCons.y, consumerCircuitSource.T_in)
    annotation (Line(points={{27,36},{27,36},{38,36}},   color={0,0,127}));
  connect(temperatureSupplyCircuit1.T, fixedDelayToGen.u)
    annotation (Line(points={{80,-29},{80,0},{28,0}}, color={0,0,127}));
  connect(fixedDelayToGen.y, firstOrderToGen.u)
    annotation (Line(points={{5,0},{-2,0},{-2,34},{-8,34}}, color={0,0,127}));
  connect(firstOrderToGen.y, supplyCircuitSource.T_in) annotation (Line(points=
          {{-31,34},{-46,34},{-46,44},{-58,44}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={{-100,-100},{100,100}},
            fileName="N:/Forschung/EBC0155_PTJ_Exergiebasierte_regelung_rsa/Students/Students-Exchange/Photos Dymola/CCA.jpg"),
                                 Text(
          extent={{-153,135},{147,95}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name"),
        Text(
          extent={{-68,44},{76,-34}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Consumer")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end ConsumerConnection;
