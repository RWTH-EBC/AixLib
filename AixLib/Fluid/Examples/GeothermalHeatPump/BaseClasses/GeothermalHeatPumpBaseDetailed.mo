within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model GeothermalHeatPumpBaseDetailed
  "Base class of the geothermal heat pump system with detailed HP model"

  replaceable package Medium = AixLib.Media.Water "Medium model used for hydronic components";

  parameter Modelica.SIunits.Temperature T_start_cold[5] = 300*ones(5) "Initial temperature of cold components";

  parameter Modelica.SIunits.Temperature T_start_warm[5] = 300*ones(5) "Initial temperature of warm components";

  parameter Modelica.SIunits.Temperature T_start_hot = 300 "Initial temperature of high temperature components";

  HeatPumps.HeatPumpDetailed heatPumpPoly(
    HPctrlType=false,
    redeclare package Medium_con = Medium,
    redeclare package Medium_eva = Medium,
    PT1_cycle=true,
    P_eleOutput=false,
    CoP_output=false,
    redeclare function data_poly = Modes.constantQualityGradeModes,
    N_max=5000)       "Base load energy conversion unit"
    annotation (Placement(transformation(extent={{-40,-14},{-4,10}})));

    replaceable AixLib.Fluid.Interfaces.PartialTwoPortTransport PeakLoadDevice constrainedby
    AixLib.Fluid.Interfaces.PartialTwoPort
    annotation (Placement(transformation(extent={{108,-56},{120,-44}})));

  Storage.Storage coldStorage(
    layer_HE(T_start=T_start_cold),
    layer(T_start=T_start_cold),
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    alpha_in=100,
    alpha_out=10,
    k_HE=300,
    h=1.5,
    V_HE=0.02,
    A_HE=7,
    d=1) "Storage tank for buffering cold demand"
    annotation (Placement(transformation(extent={{52,-14},{24,20}})));
  FixedResistances.PressureDrop                     resistanceColdStorage(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=15000) "Resistance in evaporator circuit"
            annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=180,
        origin={-12,48})));
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
    annotation (Placement(transformation(extent={{-32,-61},{-20,-47}})));
  Actuators.Valves.TwoWayQuickOpening
                                 valveHeatSource(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting geothermal field to the evaporator of the heat pump"          annotation (Placement(
        transformation(
        extent={{-6.5,-6.5},{6.5,6.5}},
        rotation=90,
        origin={-59.5,-28.5})));
  Storage.Storage heatStorage(
    layer_HE(T_start=T_start_warm),
    layer(T_start=T_start_warm),
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    alpha_in=100,
    alpha_out=10,
    k_HE=300,
    A_HE=3,
    h=1,
    V_HE=0.01,
    d=1) "Storage tank for buffering heat demand"
    annotation (Placement(transformation(extent={{52,-96},{24,-62}})));
  FixedResistances.PressureDrop                     resistanceHeatStorage(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=15000) "Resistance in condenser circuit"
            annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=180,
        origin={-16,-112})));
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
        rotation=270,
        origin={-60,36})));
  Actuators.Valves.TwoWayQuickOpening
                                 valveHeatStorage(redeclare package Medium =
        Medium,
    m_flow_nominal=0.5,
    dpValve_nominal=5000)
    "Valve connecting heat storage to the condenser of the heat pump"                annotation (Placement(
        transformation(
        extent={{-6.5,-6.5},{6.5,6.5}},
        rotation=90,
        origin={0.5,-68.5})));

  AixLib.Fluid.Movers.FlowControlled_dp pumpColdConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1])
    "Pump moving fluid from storage tank to cold consumers"
    annotation (Placement(transformation(extent={{58,-27},{72,-13}})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpHeatConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_warm[5])
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
    T_start=T_start_cold[1])
    "Pump moving fluid from storage tank to condenser of heat pump"
                             annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={3,-112})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpEvaporator(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1])
    "Pump moving fluid from storage tank to evaporator of heat pump"
                             annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={7,48})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpGeothermalSource(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1])
    "Pump moving fluid from geothermal source into system" annotation (
      Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-89,-54})));
  Controls.Interfaces.HeatPumpControlBus        heatPumpControlBus
    annotation (Placement(transformation(extent={{-21,60},{20,98}})));
equation

  connect(resistanceGeothermalSource.port_b, valveHeatSink.port_a) annotation (
      Line(
      points={{-64,-54},{-32,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveHeatSource.port_a, valveHeatSink.port_a) annotation (Line(
      points={{-59.5,-35},{-59.5,-54},{-32,-54}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(resistanceColdStorage.port_b, valveColdStorage.port_a) annotation (
      Line(
      points={{-18,48},{-60,48},{-60,42}},
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
  connect(coldStorage.port_a_heatGenerator, pumpEvaporator.port_a) annotation (
      Line(points={{26.24,17.96},{20,17.96},{20,48},{14,48}}, color={0,127,255}));
  connect(heatStorage.port_b_heatGenerator, pumpCondenser.port_a) annotation (
      Line(points={{26.24,-92.6},{16,-92.6},{16,-112},{10,-112}},
                                                               color={0,127,255}));
  connect(pumpGeothermalSource.port_b, resistanceGeothermalSource.port_a)
    annotation (Line(points={{-82,-54},{-79,-54},{-76,-54}}, color={0,127,255}));
  connect(pumpGeothermalSource.port_a, geothFieldSource.ports[1])
    annotation (Line(points={{-96,-54},{-146,-54}}, color={0,127,255}));
  connect(resistanceHeatConsumerFlow.port_b, PeakLoadDevice.port_a) annotation (
     Line(points={{94,-50},{102,-50},{108,-50}}, color={0,127,255}));
  connect(heatPumpPoly.onOff_in, heatPumpControlBus.onOff) annotation (Line(
        points={{-28,8.8},{-28,79.095},{-0.3975,79.095}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatPumpPoly.N_in, heatPumpControlBus.N) annotation (Line(points={{
          -23.2,8.8},{-23.2,75.4},{-0.3975,75.4},{-0.3975,79.095}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatSource.port_b, heatPumpPoly.port_evaIn) annotation (Line(
        points={{-59.5,-22},{-60,-22},{-60,6.4},{-37.6,6.4}}, color={0,127,255}));
  connect(valveColdStorage.port_b, heatPumpPoly.port_evaIn) annotation (Line(
        points={{-60,30},{-60,6.4},{-37.6,6.4}}, color={0,127,255}));
  connect(heatPumpPoly.port_evaOut, coldStorage.port_b_heatGenerator)
    annotation (Line(points={{-37.6,-10.4},{-48,-10.4},{-48,-22},{22.24,-22},{
          22.24,-10.6},{26.24,-10.6}}, color={0,127,255}));
  connect(heatPumpPoly.port_evaOut, geothField_sink1.ports[1]) annotation (Line(
        points={{-37.6,-10.4},{-91.8,-10.4},{-91.8,27.2},{-146,27.2}}, color={0,
          127,255}));
  connect(heatPumpPoly.port_conOut, geothField_sink1.ports[2]) annotation (Line(
        points={{-6.4,6.4},{9.8,6.4},{9.8,24.8},{-146,24.8}}, color={0,127,255}));
  connect(resistanceColdStorage.port_a, pumpEvaporator.port_b)
    annotation (Line(points={{-6,48},{0,48}}, color={0,127,255}));
  connect(valveHeatSink.port_b, heatPumpPoly.port_conIn) annotation (Line(
        points={{-20,-54},{0,-54},{0,-10.4},{-6.4,-10.4}}, color={0,127,255}));
  connect(resistanceHeatStorage.port_a, pumpCondenser.port_b)
    annotation (Line(points={{-10,-112},{-4,-112}}, color={0,127,255}));
  connect(resistanceHeatStorage.port_b, valveHeatStorage.port_a) annotation (
      Line(points={{-22,-112},{-26,-112},{-26,-80},{0.5,-80},{0.5,-75}}, color=
          {0,127,255}));
  connect(valveHeatStorage.port_b, heatPumpPoly.port_conIn) annotation (Line(
        points={{0.5,-62},{0,-62},{0,-10.4},{-6.4,-10.4}}, color={0,127,255}));
  connect(heatStorage.port_a_heatGenerator, heatPumpPoly.port_conOut)
    annotation (Line(points={{26.24,-64.04},{10,-64.04},{10,6.4},{-6.4,6.4}},
        color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
          -120},{160,80}})),              Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-120},{160,80}})),
    experiment(StopTime=3600, Interval=10),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    Documentation(info="<html>
<p>Base class of an example demonstrating the use of a heat pump connected to two storages and a geothermal source. A replaceable model is connected in the flow line of the heating circuit. A peak load device can be added here. </p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2017, by Marc Baranski:<br/>
First implementation.
</li>
</ul>
</html>"));
end GeothermalHeatPumpBaseDetailed;
