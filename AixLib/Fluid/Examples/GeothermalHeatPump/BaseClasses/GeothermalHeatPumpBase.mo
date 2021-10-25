within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
partial model GeothermalHeatPumpBase
  "Base class of the geothermal heat pump system"

  replaceable package Medium = AixLib.Media.Water
    "Medium model used for hydronic components";

  parameter Modelica.SIunits.Temperature T_start_cold = 300
    "Initial temperature of cold components";

  parameter Modelica.SIunits.Temperature T_start_hot=300
    "Initial temperature of warm components";

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport PeakLoadDevice(
      redeclare package Medium = Medium)                                       constrainedby
    AixLib.Fluid.Interfaces.PartialTwoPort
    annotation (Placement(transformation(extent={{108,-56},{120,-44}})));

  Storage.Storage coldStorage(
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    hConIn=100,
    hConOut=10,
    k_HE=300,
    h=1.5,
    V_HE=0.02,
    A_HE=7,
    d=1,
    m_flow_nominal_layer=m_flow_nominal_layer,
    m_flow_nominal_HE=m_flow_nominal_HE,
    T_start=T_start_cold)
         "Storage tank for buffering cold demand" annotation (Placement(transformation(extent={{52,-14},{24,20}})));
  FixedResistances.PressureDrop                     resistanceColdStorage(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=15000) "Resistance in evaporator circuit"
            annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=180,
        origin={-34,38})));
  AixLib.Fluid.Sources.Boundary_pT geothFieldSource(
    redeclare package Medium = Medium,
    nPorts=1,
    T=284.15) "Source representing geothermal field"
    annotation (Placement(transformation(extent={{-158,-60},{-146,-48}})));
  FixedResistances.PressureDrop                     resistanceGeothermalSource(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=15000) "Resistance in geothermal field circuit"
            annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=0,
        origin={-70,-54})));
  FixedResistances.PressureDrop                     resistanceColdConsumerFlow(
    redeclare package Medium = Medium,
    m_flow_nominal=0.2,
    dp_nominal=10000) "Resistance in cold consumer flow line"
            annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={87,-20})));
  Actuators.Valves.TwoWayQuickOpening valveHeatSink(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting geothermal field to the condenser of the heat pump"
    annotation (Placement(transformation(extent={{-36,-61},{-24,-47}})));
  Actuators.Valves.TwoWayQuickOpening
                                 valveHeatSource(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting geothermal field to the evaporator of the heat pump"          annotation (Placement(
        transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-60,1})));
  Storage.Storage heatStorage(
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    hConIn=100,
    hConOut=10,
    k_HE=300,
    A_HE=3,
    h=1,
    V_HE=0.01,
    d=1,
    m_flow_nominal_layer=m_flow_nominal_layer,
    m_flow_nominal_HE=m_flow_nominal_HE,
    T_start=T_start_hot) "Storage tank for buffering heat demand"
    annotation (Placement(transformation(extent={{52,-96},{24,-62}})));
  FixedResistances.PressureDrop                     resistanceHeatStorage(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=15000) "Resistance in condenser circuit"
            annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-18,-78})));
  AixLib.Fluid.Sources.Boundary_pT geothField_sink1(redeclare package Medium =
        Medium, nPorts=2) "One of two sinks representing geothermal field"
    annotation (Placement(transformation(extent={{-158,20},{-146,32}})));
  FixedResistances.PressureDrop                     resistanceHeatConsumerFlow(
    redeclare package Medium = Medium,
    m_flow_nominal=0.2,
    dp_nominal=10000) "Resistance in heat consumer flow line"
            annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={87,-50})));
  Actuators.Valves.TwoWayQuickOpening
                                 valveColdStorage(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting cold storage to the evaporator of the heat pump"               annotation (Placement(
        transformation(
        extent={{-6,7},{6,-7}},
        rotation=180,
        origin={-52,38})));
  Actuators.Valves.TwoWayQuickOpening
                                 valveHeatStorage(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting heat storage to the condenser of the heat pump"                annotation (Placement(
        transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-18,-63})));

  AixLib.Fluid.Movers.FlowControlled_dp pumpColdConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold)
    "Pump moving fluid from storage tank to cold consumers"
    annotation (Placement(transformation(extent={{58,-27},{72,-13}})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpHeatConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_hot)
    "Pump moving fluid from storage tank to heat consumers"
    annotation (Placement(transformation(extent={{58,-57},{72,-43}})));
  FixedResistances.PressureDrop                     resistanceColdConsumerReturn(
    redeclare package Medium = Medium,
    m_flow_nominal=0.2,
    dp_nominal=10000) "Resistance in cold consumer return line"
            annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={87,32})));
  FixedResistances.PressureDrop                     resistanceHeatConsumerReturn(
    redeclare package Medium = Medium,
    m_flow_nominal=0.2,
    dp_nominal=10000) "Resistance in heat consumer return line"
            annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={87,-106})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpCondenser(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold)
    "Pump moving fluid from storage tank to condenser of heat pump"
                             annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={-1,-98})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpEvaporator(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold)
    "Pump moving fluid from storage tank to evaporator of heat pump"
                             annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={7,36})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpGeothermalSource(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold)
    "Pump moving fluid from geothermal source into system" annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-89,-54})));
  Controls.Interfaces.VapourCompressionMachineControlBus heatPumpControlBus
    annotation (Placement(transformation(extent={{-21,60},{20,98}})));
  HeatPumps.HeatPump heatPump(useBusConnectorOnly=true) annotation (Placement(
        transformation(
        extent={{-14,17},{14,-17}},
        rotation=90,
        origin={-25,5.99998})));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_layer=0.5
    "Nominal mass flow rate in layers of storages";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_HE=0.5
    "Nominal mass flow rate of heat exchanger layers of storages";
equation

  connect(resistanceGeothermalSource.port_b, valveHeatSink.port_a) annotation (
      Line(
      points={{-64,-54},{-36,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveHeatSource.port_a, valveHeatSink.port_a) annotation (Line(
      points={{-60,-5},{-60,-54},{-36,-54}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(resistanceColdStorage.port_b, valveColdStorage.port_a) annotation (
      Line(
      points={{-40,38},{-46,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(resistanceHeatStorage.port_b, valveHeatStorage.port_a) annotation (
      Line(
      points={{-18,-72},{-18,-69}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(coldStorage.port_a_consumer, pumpColdConsumer.port_a) annotation (
      Line(points={{38,-14},{38,-14},{38,-20},{58,-20}}, color={0,127,255}));
  connect(pumpColdConsumer.port_b, resistanceColdConsumerFlow.port_a)
    annotation (Line(points={{72,-20},{80,-20}}, color={0,127,255}));
  connect(pumpHeatConsumer.port_b, resistanceHeatConsumerFlow.port_a)
    annotation (Line(points={{72,-50},{80,-50}}, color={0,127,255}));
  connect(heatStorage.port_b_consumer, pumpHeatConsumer.port_a) annotation (
      Line(points={{38,-62},{38,-62},{38,-50},{58,-50}}, color={0,127,255}));
  connect(resistanceColdConsumerReturn.port_b, coldStorage.port_b_consumer)
    annotation (Line(points={{80,32},{38,32},{38,20}}, color={0,127,255}));
  connect(resistanceHeatConsumerReturn.port_b, heatStorage.port_a_consumer)
    annotation (Line(points={{80,-106},{80,-106},{38,-106},{38,-96}}, color={0,127,
          255}));
  connect(pumpEvaporator.port_b, resistanceColdStorage.port_a) annotation (Line(
        points={{-8.88178e-016,36},{-8.88178e-016,38},{-28,38}}, color={0,127,255}));
  connect(coldStorage.port_a_heatGenerator, pumpEvaporator.port_a) annotation (
      Line(points={{26.24,17.96},{20,17.96},{20,36},{14,36}}, color={0,127,255}));
  connect(heatStorage.port_b_heatGenerator, pumpCondenser.port_a) annotation (
      Line(points={{26.24,-92.6},{16,-92.6},{16,-98},{6,-98}}, color={0,127,255}));
  connect(pumpCondenser.port_b, resistanceHeatStorage.port_a) annotation (Line(
        points={{-8,-98},{-18,-98},{-18,-84}}, color={0,127,255}));
  connect(pumpGeothermalSource.port_b, resistanceGeothermalSource.port_a)
    annotation (Line(points={{-82,-54},{-79,-54},{-76,-54}}, color={0,127,255}));
  connect(pumpGeothermalSource.port_a, geothFieldSource.ports[1])
    annotation (Line(points={{-96,-54},{-146,-54}}, color={0,127,255}));
  connect(resistanceHeatConsumerFlow.port_b, PeakLoadDevice.port_a) annotation (
     Line(points={{94,-50},{102,-50},{108,-50}}, color={0,127,255}));
  connect(heatPump.port_b1, heatStorage.port_a_heatGenerator) annotation (Line(
        points={{-16.5,20},{6,20},{6,-64.04},{26.24,-64.04}}, color={0,127,255}));
  connect(heatPump.port_b1, geothField_sink1.ports[1]) annotation (Line(points={{-16.5,
          20},{-16,20},{-16,28},{-146,28},{-146,27.2}},        color={0,127,255}));
  connect(valveHeatStorage.port_b, heatPump.port_a1) annotation (Line(points={{-18,
          -57},{-18,-8.00001},{-16.5,-8.00001}}, color={0,127,255}));
  connect(heatPump.port_b2, geothField_sink1.ports[2]) annotation (Line(points={
          {-33.5,-8.00001},{-88,-8.00001},{-88,24.8},{-146,24.8}}, color={0,127,
          255}));
  connect(coldStorage.port_b_heatGenerator, heatPump.port_b2) annotation (Line(
        points={{26.24,-10.6},{-33.5,-10.6},{-33.5,-8.00001}}, color={0,127,255}));
  connect(heatPump.port_a2, valveHeatSource.port_b) annotation (Line(points={{-33.5,
          20},{-44,20},{-44,7},{-60,7}}, color={0,127,255}));
  connect(heatPump.port_a2, valveColdStorage.port_b) annotation (Line(points={{-33.5,
          20},{-44,20},{-44,38},{-58,38}}, color={0,127,255}));
  connect(valveHeatSink.port_b, heatPump.port_a1) annotation (Line(points={{-24,
          -54},{-24,-56},{-16.5,-56},{-16.5,-8.00002}}, color={0,127,255}));
  connect(heatPumpControlBus, heatPump.sigBus) annotation (Line(
      points={{-0.5,79},{-0.5,-32},{-30.525,-32},{-30.525,-7.86002}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
          -120},{160,80}})),              Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-120},{160,80}})),
    experiment(StopTime=3600, Interval=10),
    Documentation(info="<html><p>
  Base class of an example demonstrating the use of a heat pump
  connected to two storages and a geothermal source. A replaceable
  model is connected in the flow line of the heating circuit. A peak
  load device can be added here.
</p>
<ul>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end GeothermalHeatPumpBase;
