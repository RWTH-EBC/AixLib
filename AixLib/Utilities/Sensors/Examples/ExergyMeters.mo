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
    each amplitude=1000,
    each freqHz=1/3600,
    each offset=3000) "Sine wave to vary heat generation and demand"
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
  ExergyMeter.StoredExergyMeter exergyStorageMeterMedium(
    redeclare package Medium = Medium,
    T_ref_start=T_ref.k,
    T_start=T_start,
    exergyContent_start=1.70904e+08,
    n=n,
    mass=mass)
    "Outputs the exergy content and rate of change of the considered storage"
    annotation (Placement(transformation(extent={{-44,-40},{-24,-20}})));
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
    dp_nominal=50000) "Main resistance in primary circuit"
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
    V(displayUnit="l") = 0.05,
    T_start=T_start) "Volume to heat up the medium"                             annotation (Placement(
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
    dp_nominal=50000) "Main resistance in secondary circuit"
                        annotation (Placement(transformation(
        extent={{-8,-7.5},{8,7.5}},
        rotation=180,
        origin={66,54.5})));
  Modelica.Fluid.Vessels.ClosedVolume consumer(
    redeclare package Medium = Medium,
    use_HeatTransfer=true,
    V(displayUnit="l") = 0.05,
    use_portsData=false,
    nPorts=2,
    T_start=T_start) "Volume to cool down the medium"
                     annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={94,70})));
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
        origin={2,-58})));
  Modelica.Blocks.Sources.Constant pumpMassFlow(k=0.5)
    annotation (Placement(transformation(extent={{-100,88},{-88,100}})));
  AixLib.Fluid.Sources.Boundary_pT expansionVesselSec(
    redeclare package Medium = Medium,
    nPorts=1,
    p=110000) "Expansion vessel in secondary circuit"
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={58,94})));
  AixLib.Fluid.Sources.Boundary_pT expansionVesselPrim(
    redeclare package Medium = Medium,
    nPorts=1,
    p=110000) "Expansion vessel in primary circuit"
              annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={-70,94})));
equation
  connect(T_ref.y, exergyStorageMeterMedium.T_ref) annotation (Line(points={{-79,-10},
          {-72,-10},{-72,-23},{-44,-23}},
        color={0,0,127}));
  connect(p_ref.y, exergyStorageMeterMedium.p_ref) annotation (Line(points={{-79,-50},
          {-76,-50},{-76,-30},{-44,-30}},color={0,0,127}));
  connect(X_ref.y, exergyStorageMeterMedium.X_ref) annotation (Line(points={{-79,-90},
          {-54,-90},{-54,-37},{-44,-37}},    color={0,0,127}));
  connect(p_ref.y, exergyStorageMeterMedium.p) annotation (Line(points={{-79,-50},
          {-74,-50},{-39,-50},{-39,-40.8}},       color={0,0,127}));
  connect(X_ref.y, exergyStorageMeterMedium.X) annotation (Line(points={{-79,-90},
          {-80,-90},{-29,-90},{-29,-40.8}},
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
          {80,54.5},{80,68},{84,68}}, color={0,127,255}));
  connect(pumpSec.port_b, consumer.ports[2]) annotation (Line(points={{80,82},{82,
          82},{82,72},{84,72}}, color={0,127,255}));
  connect(consumerHeatFlow.Q_flow, gain.y)
    annotation (Line(points={{48,24},{40.6,24}}, color={0,0,127}));
  connect(pulse.y, gain.u) annotation (Line(points={{11,-10},{20,-10},{20,24},{26.8,
          24}}, color={0,0,127}));
  connect(pulse.y, heaterHeatFlow.Q_flow) annotation (Line(points={{11,-10},{20,
          -10},{20,24},{-18,24}}, color={0,0,127}));
  connect(consumerHeatFlow.port, exHeatSec.port_a) annotation (Line(points={{68,
          24},{71,24},{71,24.2},{74,24.2}}, color={191,0,0}));
  connect(exHeatSec.port_b, consumer.heatPort)
    annotation (Line(points={{94,24.2},{94,60}}, color={191,0,0}));
  connect(heaterHeatFlow.port, exHeatPrim.port_a) annotation (Line(points={{-38,
          24},{-48,24},{-48,24.2},{-58,24.2}}, color={191,0,0}));
  connect(exHeatPrim.port_b, heater.heatPort)
    annotation (Line(points={{-78,24.2},{-84,24},{-84,60}}, color={191,0,0}));
  connect(T_ref.y, exHeatPrim.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,15},{-58,15}}, color={0,0,127}));
  connect(T_ref.y, exHeatSec.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,15},{74,15}}, color={0,0,127}));
  connect(storageTemperatures.y, exergyStorageMeterMedium.T)
    annotation (Line(points={{-9,-58},{-34,-58},{-34,-40}}, color={0,0,127}));
  connect(T_ref.y, exPrimOut.T_ref) annotation (Line(points={{-79,-10},{-64,-10},
          {-50,-10},{-50,38},{-33,38},{-33,47}}, color={0,0,127}));
  connect(T_ref.y, exPrimIn.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,38},{-40,38},{-40,66},{-34,66},{-17,66},{-17,76}}, color={0,0,127}));
  connect(T_ref.y, exSecIn.T_ref) annotation (Line(points={{-79,-10},{-50,-10},
          {-50,38},{33,38},{33,44}},color={0,0,127}));
  connect(T_ref.y, exSecOut.T_ref) annotation (Line(points={{-79,-10},{-64,-10},
          {-50,-10},{-50,38},{56,38},{56,62},{53,62},{53,72}}, color={0,0,127}));
  connect(p_ref.y, exPrimOut.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,-30},{-52,-30},{-52,40},{-24,40},{-24,47}}, color={0,0,127}));
  connect(p_ref.y, exPrimIn.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,-30},{-52,-30},{-52,40},{-42,40},{-42,68},{-26,68},{-26,76}},
        color={0,0,127}));
  connect(p_ref.y, exSecOut.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,40},{-42,40},{-42,68},{-8,68},{-8,96},{30,96},{30,64},{44,64},{44,
          72}}, color={0,0,127}));
  connect(p_ref.y, exSecIn.p_ref) annotation (Line(points={{-79,-50},{-76,-50},
          {-76,40},{-42,40},{-42,68},{-8,68},{-8,40},{42,40},{42,44}},color={0,0,
          127}));
  connect(X_ref.y, exSecIn.X_ref) annotation (Line(points={{-79,-90},{-50,-90},
          {44,-90},{44,34},{51,34},{51,44}},color={0,0,127}));
  connect(X_ref.y, exSecOut.X_ref) annotation (Line(points={{-79,-90},{-18,-90},
          {44,-90},{44,34},{54,34},{54,62},{35,62},{35,72}}, color={0,0,127}));
  connect(X_ref.y, exPrimOut.X_ref) annotation (Line(points={{-79,-90},{-54,-90},
          {-54,42},{-15,42},{-15,47}}, color={0,0,127}));
  connect(X_ref.y, exPrimIn.X_ref) annotation (Line(points={{-79,-90},{-54,-90},
          {-54,44},{-35,44},{-35,76}}, color={0,0,127}));
  connect(pumpMassFlow.y, pumpPrim.m_flow_in) annotation (Line(points={{-87.4,94},
          {-76,94},{-76,100},{-54,100},{-54,98}},     color={0,0,127}));
  connect(pumpMassFlow.y, pumpSec.m_flow_in) annotation (Line(points={{-87.4,94},
          {-76,94},{-76,100},{70,100},{70,94}},     color={0,0,127}));
  connect(expansionVesselSec.ports[1], pumpSec.port_a) annotation (Line(points={{58,90},
          {58,82},{60,82}},                                  color={0,127,255}));
  connect(expansionVesselPrim.ports[1], pumpPrim.port_a)
    annotation (Line(points={{-70,90},{-70,86},{-64,86}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=1000, Interval=10),
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
matches the extracted heat flow rate. Due to the irreversibilities, 
especially in the storage, the exergy output is smaller than the exergy input. </p>
</html>", revisions="<html>
 <ul>
 <li>by Marc Baranski and Roozbeh Sangi:<br/>implemented</li>
 </ul>
</html>"));
end ExergyMeters;
