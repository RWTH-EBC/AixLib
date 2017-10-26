within AixLib.Utilities.Sensors.Examples;
model ExergyMeters

  extends Modelica.Icons.Example;

  parameter Modelica.SIunits.Temperature T_start=323.15
    "Start reference temperature of medium";

  parameter Integer n = 10 "Number of layers";

  parameter Modelica.SIunits.Mass mass = 1000 "Mass of one layer";

  package Medium = AixLib.Media.Water "Medium in the sensor"
                           annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.Sine pulse(
    each freqHz=1/3600,
    each offset=3000,
    each amplitude=3000)
                      "Sine wave to vary heat generation and demand"
    annotation (Placement(transformation(extent={{-12,-14},{8,6}})));
  ExergyMeter.StoredExergyMeter exergyStorageMeterMedium(
    redeclare package Medium = Medium,
    T_ref_start=T_ref.k,
    T_start=T_start,
    exergyContent_start=1.70904e+08,
    n=n,
    mass=mass)
    "Outputs the exergy content and rate of change of the considered storage"
    annotation (Placement(transformation(extent={{-44,-26},{-24,-6}})));
  Modelica.Blocks.Sources.Constant T_ref(k=273.15) "Reference temperature"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.Constant p_ref(k=101300) "Reference pressure"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Constant X_ref[1](k={1}) "Reference composition"
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  inner Modelica.Fluid.System system "Basic parameters"
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  ExergyMeter.HeatExergyMeter exHeatSec
    "Exergy content of the heat flux on secondary side"
    annotation (Placement(transformation(extent={{74,5},{94,25}})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpPrim(
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = Medium,
    T_start=T_start,
    m_flow_nominal=0.5,
    m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-64,76},{-44,96}})));
  AixLib.Fluid.Storage.Storage
  bufferStorageHeatingcoils(
  layer_HE(each T_start=T_start), layer(each T_start=T_start),
    redeclare package Medium = Medium,
    lambda_ins=0.075,
    s_ins=0.2,
    alpha_in=100,
    alpha_out=10,
    k_HE=300,
    h=1.5,
    V_HE=0.02,
    A_HE=7,
    n=10,
    d=2) "Storage tank"
         annotation (Placement(transformation(extent={{26,54},{-2,88}})));
  Fluid.FixedResistances.PressureDrop      pipePrim(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=10000) "Main resistance in primary circuit"
                        annotation (Placement(transformation(
        extent={{-7,-7.5},{7,7.5}},
        rotation=180,
        origin={-53,56.5})));
  ExergyMeter.FlowExergyMeter exPrimIn(redeclare package Medium = Medium)
    "Exergy content of medium flow entering the storage on primary side"
    annotation (Placement(transformation(extent={{-36,76},{-14,96}})));
  ExergyMeter.FlowExergyMeter exPrimOut(redeclare package Medium = Medium)
    "Exergy content of medium flow exiting the storage on primary side"
    annotation (Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=180,
        origin={-25,57})));
  Modelica.Fluid.Vessels.ClosedVolume heater(redeclare package Medium = Medium,
    nPorts=2,
    use_HeatTransfer=true,
    use_portsData=false,
    T_start=T_start,
    V(displayUnit="l") = 0.001)
                     "Volume to heat up the medium"                             annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-84,70})));
  AixLib.Fluid.Movers.FlowControlled_m_flow pumpSec(
    addPowerToMedium=false,
    nominalValuesDefineDefaultPressureCurve=true,
    redeclare package Medium = Medium,
    T_start=T_start,
    m_flow_nominal=0.5,
    m_flow_small=0.001) "Pump in secondary circuit"
    annotation (Placement(transformation(extent={{60,72},{80,92}})));
  Fluid.FixedResistances.PressureDrop      pipeSec(
    redeclare package Medium = Medium,
    m_flow_nominal=0.5,
    dp_nominal=10000) "Main resistance in secondary circuit"
                        annotation (Placement(transformation(
        extent={{-8,-7.5},{8,7.5}},
        rotation=180,
        origin={66,54.5})));
  Modelica.Fluid.Vessels.ClosedVolume consumer(
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    use_portsData=false,
    nPorts=2,
    T_start=T_start,
    V(displayUnit="l") = 0.001)
                     "Volume to cool down the medium"
                     annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={96,70})));
  ExergyMeter.FlowExergyMeter exSecOut(redeclare package Medium = Medium)
    "Exergy content of medium flow entering the storage on secondary side"
    annotation (Placement(transformation(extent={{34,72},{56,92}})));
  ExergyMeter.FlowExergyMeter exSecIn(redeclare package Medium = Medium)
    "Exergy content of medium flow exiting the storage on secondary side"
    annotation (Placement(transformation(
        extent={{-11,10},{11,-10}},
        rotation=180,
        origin={41,54})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow consumerHeatFlow
    annotation (Placement(transformation(extent={{48,14},{68,34}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heaterHeatFlow
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-28,24})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    "Negative sign to switch the direction of the heat flux"
    annotation (Placement(transformation(extent={{28,18},{40,30}})));
  ExergyMeter.HeatExergyMeter exHeatPrim
    "Exergy content of the heat flux on primary side"
                                         annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-68,15})));
  Modelica.Blocks.Sources.RealExpression storageTemperatures[n](y=
        bufferStorageHeatingcoils.layer[:].heatPort.T)
    "Outputs the temperatures of the single storage layers"
                                                       annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={2,-36})));
  Modelica.Blocks.Sources.Constant pumpMassFlow(k=0.5)
    annotation (Placement(transformation(extent={{-100,88},{-88,100}})));
  AixLib.Fluid.Sources.Boundary_pT expansionVesselSec(
    redeclare package Medium = Medium,
    nPorts=1,
    p=p_ref.k)
              "Expansion vessel in secondary circuit"
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={58,94})));
  AixLib.Fluid.Sources.Boundary_pT expansionVesselPrim(
    redeclare package Medium = Medium,
    nPorts=1,
    p=p_ref.k)
              "Expansion vessel in primary circuit"
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-70,94})));
  Modelica.Blocks.Math.Sum calcExergyDestructionLoss_1(nin=7, k={1,1,-1,-1,-1,-1,
        -1})
    "Calculate the sum of exergy destruction and loss, calculated from enthalpy flows"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Math.Sum calcExergyDestructionLoss_2(nin=5, k={1,-1,-1,-1,-1})
    "Calculate the sum of exergy destruction and loss, calculated from heat flows"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Math.Gain gain1(
                                 k=-1)
    "Negative sign to switch the direction of the exergy flow"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=180,
        origin={66,-4})));
  ExergyMeter.StoredExergyMeter exergyStorageMeterConsumer(
    redeclare package Medium = Medium,
    T_ref_start=T_ref.k,
    T_start=T_start,
    n=1,
    exergyContent_start=17074.08599,
    mass=1)
    "Outputs the exergy content and rate of change of the consumer volume"
    annotation (Placement(transformation(extent={{-50,-56},{-30,-36}})));
  ExergyMeter.StoredExergyMeter exergyStorageMeterHeater(
    redeclare package Medium = Medium,
    T_ref_start=T_ref.k,
    T_start=T_start,
    n=1,
    exergyContent_start=17074.08599,
    mass=1)
    "Outputs the exergy content and rate of change of the heater volume"
    annotation (Placement(transformation(extent={{-42,-94},{-22,-74}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor heaterTemperature
    "Measure the temperature in the heater volume "
    annotation (Placement(transformation(extent={{-80,42},{-68,54}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor consumerTemperature
    "Measure the temperature in the consumer volume "
    annotation (Placement(transformation(extent={{76,36},{64,48}})));
equation
  connect(T_ref.y, exergyStorageMeterMedium.T_ref) annotation (Line(points={{-79,-10},
          {-72,-10},{-72,-9},{-44,-9}},
        color={255,0,0}));
  connect(p_ref.y, exergyStorageMeterMedium.p_ref) annotation (Line(points={{-79,-50},
          {-76,-50},{-76,-16},{-44,-16}},color={85,85,255}));
  connect(X_ref.y, exergyStorageMeterMedium.X_ref) annotation (Line(points={{-79,-90},
          {-54,-90},{-54,-23},{-44,-23}},    color={0,127,0}));
  connect(p_ref.y, exergyStorageMeterMedium.p) annotation (Line(points={{-79,-50},
          {-60,-50},{-60,-32},{-42,-32},{-42,-32},{-39,-32},{-39,-30},{-39,-26.8}},
                                                  color={0,0,127}));
  connect(X_ref.y, exergyStorageMeterMedium.X) annotation (Line(points={{-79,-90},
          {-79,-74},{-24,-74},{-24,-32},{-29,-32},{-29,-26.8}},
                                         color={0,0,127}));

  connect(pumpPrim.port_b, exPrimIn.port_a)
    annotation (Line(points={{-44,86},{-40,86},{-36,86}}, color={0,127,255}));
  connect(exPrimIn.port_b, bufferStorageHeatingcoils.port_a_heatGenerator)
    annotation (Line(points={{-16,86},{0.24,86},{0.24,85.96}},  color={0,127,255}));
  connect(bufferStorageHeatingcoils.port_b_heatGenerator, exPrimOut.port_a)
    annotation (Line(points={{0.24,57.4},{-5.88,57.4},{-5.88,57},{-14,57}},
        color={0,127,255}));
  connect(exPrimOut.port_b, pipePrim.port_a) annotation (Line(points={{-34,57},{
          -46,57},{-46,56.5}}, color={0,127,255}));
  connect(pipePrim.port_b, heater.ports[1]) annotation (Line(points={{-60,56.5},
          {-72,56.5},{-72,68},{-74,68}}, color={0,127,255}));
  connect(heater.ports[2], pumpPrim.port_a) annotation (Line(points={{-74,72},{-70,
          72},{-70,86},{-64,86}}, color={0,127,255}));
  connect(bufferStorageHeatingcoils.port_b_consumer, exSecOut.port_a)
    annotation (Line(points={{12,88},{12,92},{28,92},{28,82},{34,82}}, color={0,
          127,255}));
  connect(exSecOut.port_b, pumpSec.port_a)
    annotation (Line(points={{54,82},{54,82},{60,82}}, color={0,127,255}));
  connect(exSecIn.port_a, pipeSec.port_b)
    annotation (Line(points={{52,54},{58,54},{58,54.5}}, color={0,127,255}));
  connect(exSecIn.port_b, bufferStorageHeatingcoils.port_a_consumer)
    annotation (Line(points={{32,54},{28,54},{28,46},{12,46},{12,54}}, color={0,
          127,255}));
  connect(pipeSec.port_a, consumer.ports[1]) annotation (Line(points={{74,54.5},
          {80,54.5},{80,68},{86,68}}, color={0,127,255}));
  connect(pumpSec.port_b, consumer.ports[2]) annotation (Line(points={{80,82},{82,
          82},{82,72},{86,72}}, color={0,127,255}));
  connect(consumerHeatFlow.Q_flow, gain.y)
    annotation (Line(points={{48,24},{40.6,24}}, color={0,0,127}));
  connect(pulse.y, gain.u) annotation (Line(points={{9,-4},{20,-4},{20,24},{26.8,
          24}}, color={0,0,127}));
  connect(pulse.y, heaterHeatFlow.Q_flow) annotation (Line(points={{9,-4},{20,-4},
          {20,24},{-18,24}},      color={0,0,127}));
  connect(consumerHeatFlow.port, exHeatSec.port_a) annotation (Line(points={{68,
          24},{71,24},{71,24.2},{74,24.2}}, color={191,0,0}));
  connect(exHeatSec.port_b, consumer.heatPort)
    annotation (Line(points={{94,24.2},{94,24},{96,24},{96,24},{96,60},{96,60}},
                                                 color={191,0,0}));
  connect(heaterHeatFlow.port, exHeatPrim.port_a) annotation (Line(points={{-38,
          24},{-48,24},{-48,24.2},{-58,24.2}}, color={191,0,0}));
  connect(exHeatPrim.port_b, heater.heatPort)
    annotation (Line(points={{-78,24.2},{-84,24},{-84,60}}, color={191,0,0}));
  connect(T_ref.y, exHeatPrim.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,15},{-58,15}}, color={255,0,0}));
  connect(T_ref.y, exHeatSec.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,15},{74,15}}, color={255,0,0}));
  connect(storageTemperatures.y, exergyStorageMeterMedium.T)
    annotation (Line(points={{-9,-36},{-34,-36},{-34,-26}}, color={0,0,127}));
  connect(T_ref.y, exPrimOut.T_ref) annotation (Line(points={{-79,-10},{-64,-10},
          {-50,-10},{-50,38},{-33,38},{-33,47}}, color={255,0,0}));
  connect(T_ref.y, exPrimIn.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,38},{-40,38},{-40,66},{-34,66},{-17,66},{-17,76}}, color={255,0,0}));
  connect(T_ref.y, exSecIn.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,38},{33,38},{33,44}},color={255,0,0}));
  connect(T_ref.y, exSecOut.T_ref) annotation (Line(points={{-79,-10},{-64,-10},
          {-50,-10},{-50,38},{56,38},{56,62},{53,62},{53,72}}, color={255,0,0}));
  connect(p_ref.y, exPrimOut.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,-30},{-52,-30},{-52,40},{-24,40},{-24,47}}, color={85,85,255}));
  connect(p_ref.y, exPrimIn.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,-30},{-52,-30},{-52,40},{-42,40},{-42,68},{-26,68},{-26,76}},
        color={85,85,255}));
  connect(p_ref.y, exSecOut.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,40},{-42,40},{-42,68},{-8,68},{-8,96},{30,96},{30,64},{44,64},{44,
          72}}, color={85,85,255}));
  connect(p_ref.y, exSecIn.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,40},{-42,40},{-42,68},{-8,68},{-8,40},{42,40},{42,44}},color={85,85,
          255}));
  connect(X_ref.y, exSecIn.X_ref) annotation (Line(points={{-79,-90},{-78,-90},{
          -78,-74},{40,-74},{40,18},{51,18},{51,44}},
                                            color={0,127,0}));
  connect(X_ref.y, exSecOut.X_ref) annotation (Line(points={{-79,-90},{-78,-90},
          {-78,-74},{-76,-74},{44,-74},{44,34},{54,34},{54,62},{35,62},{35,72}},
                                                             color={0,127,0}));
  connect(X_ref.y, exPrimOut.X_ref) annotation (Line(points={{-79,-90},{-54,-90},
          {-54,42},{-15,42},{-15,47}}, color={0,127,0}));
  connect(X_ref.y, exPrimIn.X_ref) annotation (Line(points={{-79,-90},{-54,-90},
          {-54,44},{-35,44},{-35,76}}, color={0,127,0}));
  connect(pumpMassFlow.y, pumpPrim.m_flow_in) annotation (Line(points={{-87.4,94},
          {-76,94},{-76,100},{-54,100},{-54,98}},     color={0,0,127}));
  connect(pumpMassFlow.y, pumpSec.m_flow_in) annotation (Line(points={{-87.4,94},
          {-76,94},{-76,100},{70,100},{70,94}},     color={0,0,127}));
  connect(expansionVesselSec.ports[1], pumpSec.port_a) annotation (Line(points={{58,90},
          {58,82},{60,82}},                                  color={0,127,255}));
  connect(expansionVesselPrim.ports[1], pumpPrim.port_a)
    annotation (Line(points={{-70,90},{-70,86},{-64,86}}, color={0,127,255}));
  connect(exPrimIn.exergyFlow, calcExergyDestructionLoss_1.u[1]) annotation (
      Line(points={{-26,97},{-26,100},{100,100},{100,-8},{50,-8},{50,-31.7143},
          {58,-31.7143}},color={0,0,127}));
  connect(exSecIn.exergyFlow, calcExergyDestructionLoss_1.u[2]) annotation (
      Line(points={{42,65},{80,65},{80,40},{100,40},{100,-8},{50,-8},{50,
          -31.1429},{58,-31.1429}},
                          color={0,0,127}));
  connect(exPrimOut.exergyFlow, calcExergyDestructionLoss_1.u[3]) annotation (
      Line(points={{-24,68},{-8,68},{-8,10},{50,10},{50,-30.5714},{58,-30.5714}},
        color={0,0,127}));
  connect(exSecOut.exergyFlow, calcExergyDestructionLoss_1.u[4]) annotation (
      Line(points={{44,93},{44,93},{44,102},{44,100},{100,100},{100,-46},{50,-46},
          {50,-30},{58,-30}}, color={0,0,127}));
  connect(exergyStorageMeterMedium.exergyChangeRate,
    calcExergyDestructionLoss_1.u[5]) annotation (Line(points={{-23.4,-22.2},{
          24,-22.2},{24,-29.4286},{58,-29.4286}},
                                               color={0,0,127}));
  connect(exHeatPrim.exergyFlow, calcExergyDestructionLoss_2.u[1]) annotation (
      Line(points={{-68,4},{-68,-6},{-18,-6},{-18,-48},{42,-48},{42,-71.6},{58,-71.6}},
        color={0,0,127}));
  connect(exergyStorageMeterMedium.exergyChangeRate,
    calcExergyDestructionLoss_2.u[3]) annotation (Line(points={{-23.4,-22.2},{24,
          -22.2},{24,-70},{58,-70}}, color={0,0,127}));
  connect(exHeatSec.exergyFlow, gain1.u)
    annotation (Line(points={{84,4},{84,-4},{73.2,-4}}, color={0,0,127}));
  connect(gain1.y, calcExergyDestructionLoss_2.u[2]) annotation (Line(points={{59.4,
          -4},{42,-4},{42,-70.8},{58,-70.8}}, color={0,0,127}));
  connect(p_ref.y, exergyStorageMeterConsumer.p_ref) annotation (Line(points={{
          -79,-50},{-76,-50},{-76,-46},{-50,-46}}, color={85,85,255}));
  connect(p_ref.y, exergyStorageMeterConsumer.p) annotation (Line(points={{-79,
          -50},{-76,-50},{-76,-64},{-45,-64},{-45,-60},{-45,-56.8}}, color={0,0,
          127}));
  connect(X_ref.y, exergyStorageMeterConsumer.X_ref) annotation (Line(points={{
          -79,-90},{-70,-90},{-70,-53},{-50,-53}}, color={0,127,0}));
  connect(X_ref.y, exergyStorageMeterConsumer.X) annotation (Line(points={{-79,
          -90},{-70,-90},{-70,-66},{-35,-66},{-35,-56.8}}, color={0,0,127}));
  connect(T_ref.y, exergyStorageMeterConsumer.T_ref) annotation (Line(points={{
          -79,-10},{-72,-10},{-72,-39},{-50,-39}}, color={255,0,0}));
  connect(exergyStorageMeterConsumer.exergyChangeRate,
    calcExergyDestructionLoss_2.u[4]) annotation (Line(points={{-29.4,-52.2},{
          38,-52.2},{38,-69.2},{58,-69.2}}, color={0,0,127}));
  connect(X_ref.y, exergyStorageMeterHeater.X_ref) annotation (Line(points={{-79,
          -90},{-70,-90},{-70,-91},{-42,-91}}, color={0,127,0}));
  connect(X_ref.y, exergyStorageMeterHeater.X) annotation (Line(points={{-79,-90},
          {-70,-90},{-70,-100},{-28,-100},{-28,-98},{-27,-98},{-27,-94.8}},
        color={0,0,127}));
  connect(p_ref.y, exergyStorageMeterHeater.p_ref) annotation (Line(points={{-79,
          -50},{-76,-50},{-76,-84},{-42,-84}}, color={85,85,255}));
  connect(p_ref.y, exergyStorageMeterHeater.p) annotation (Line(points={{-79,-50},
          {-76,-50},{-76,-100},{-37,-100},{-37,-98},{-37,-94.8}}, color={0,0,
          127}));
  connect(T_ref.y, exergyStorageMeterHeater.T_ref) annotation (Line(points={{-79,
          -10},{-72,-10},{-72,-77},{-42,-77}}, color={255,0,0}));
  connect(exergyStorageMeterHeater.exergyChangeRate,
    calcExergyDestructionLoss_2.u[5]) annotation (Line(points={{-21.4,-90.2},{
          38,-90.2},{38,-68.4},{58,-68.4}}, color={0,0,127}));
  connect(exergyStorageMeterConsumer.exergyChangeRate,
    calcExergyDestructionLoss_1.u[6]) annotation (Line(points={{-29.4,-52.2},{
          38,-52.2},{38,-32},{38,-28.8571},{58,-28.8571}}, color={0,0,127}));
  connect(exergyStorageMeterHeater.exergyChangeRate,
    calcExergyDestructionLoss_1.u[7]) annotation (Line(points={{-21.4,-90.2},{
          38,-90.2},{38,-28.2857},{58,-28.2857}}, color={0,0,127}));
  connect(heaterTemperature.port, heater.heatPort)
    annotation (Line(points={{-80,48},{-84,48},{-84,60}}, color={191,0,0}));
  connect(heaterTemperature.T, exergyStorageMeterHeater.T[1]) annotation (Line(
        points={{-68,48},{-62,48},{-62,34},{-100,34},{-100,-70},{-16,-70},{-16,
          -98},{-32,-98},{-32,-94}}, color={0,0,127}));
  connect(consumerTemperature.port, consumer.heatPort) annotation (Line(points=
          {{76,42},{88,42},{96,42},{96,60}}, color={191,0,0}));
  connect(consumerTemperature.T, exergyStorageMeterConsumer.T[1]) annotation (
      Line(points={{64,42},{60,42},{60,36},{22,36},{22,-62},{-40,-62},{-40,-56}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=7200, Interval=10),
    Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This model shows the usage of all three ExergyMeters, namely</p>
<p>- enthalpy flow: 
<a href=\"modelica://AixLib.Utilities.Sensors.ExergyMeter.FlowExergyMeter\">
AixLib.Utilities.Sensors.ExergyMeter.FlowExergyMeter</a></p>
<p>- heat flow: 
<a href=\"modelica://AixLib.Utilities.Sensors.ExergyMeter.HeatExergyMeter\">
AixLib.Utilities.Sensors.ExergyMeter.HeatExergyMeter</a></p>
<p>- stored energy: 
<a href=\"modelica://AixLib.Utilities.Sensors.ExergyMeter.StoredExergyMeter\">
AixLib.Utilities.Sensors.ExergyMeter.StoredExergyMeter</a></p>
<p>The system is a simplified energy supply system. The supplied heat flow rate
matches the extracted heat flow rate. Due to the irreversibilities, especially
in the storage, the exergy output is smaller than the exergy input.</p>
 <p>Two different exergy balances can be compared. One is calculated using the
 enthalpy flows. The other is calculated using the heat flow rates. Due to the
 different system boundaries, the exergy destructions is a little different, as
 the following figure shows. </p>
  <p> <img src=\"modelica://AixLib/Resources/Images/Utilities/Sensors/ExergyMeter/ExergyMeters.jpg\" 
  alt=\"Result of exergy meter example\"/> </p>
</html>", revisions="<html>
 <ul>
 <li>by Marc Baranski and Roozbeh Sangi:<br/>implemented</li>
 </ul>
</html>"));
end ExergyMeters;
