within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations;
model SubstationHeating

     extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;

     parameter Modelica.SIunits.Temperature T_Supply_Set;
     parameter Modelica.SIunits.TemperatureDifference deltaT;
     parameter Real maxHeatDemand;
     parameter Modelica.SIunits.MassFlowRate m_flow_nominal;
     parameter Modelica.SIunits.MassFlowRate m_flow_smal;

  Modelica.Blocks.Interfaces.RealInput HeatDemand
    annotation (Placement(transformation(extent={{-122,48},{-82,88}}),
        iconTransformation(extent={{-122,48},{-82,88}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-54,20},{-42,32}})));
  Modelica.Blocks.Continuous.LimPID PID(
    k=100,
    Ti=100,
    yMax=1,
    yMin=0)
    annotation (Placement(transformation(extent={{-26,40},{-40,54}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=0.5,
    duration=3600,
    offset=0.1,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,8},{-70,18}})));
  Modelica.Blocks.Sources.Constant T_Return_Set(k=273.15 + 50)
    annotation (Placement(transformation(extent={{2,42},{-8,52}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=time > 3500)
    annotation (Placement(transformation(extent={{-80,20},{-66,32}})));
  Actuators.Valves.SimpleValve simpleValve(redeclare package Medium = Medium,
      m_flow_small=0.00001)
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  Sensors.TemperatureTwoPort T_Return(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-66,-56},{-54,-44}})));
  MixingVolumes.MixingVolume vol(nPorts=2, redeclare package Medium = Medium,
    V=0.001,
    m_flow_nominal=0.005,
    T_start=323.15)
    annotation (Placement(transformation(extent={{14,0},{34,20}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-90,-54},{-82,-46}})));
equation
  connect(port_a, simpleValve.port_a)
    annotation (Line(points={{-100,0},{-24,0}}, color={0,127,255}));
  connect(simpleValve.port_b, vol.ports[1])
    annotation (Line(points={{-4,0},{22,0}},  color={0,127,255}));
  connect(vol.ports[2], T_Return.port_a)
    annotation (Line(points={{26,0},{40,0}}, color={0,127,255}));
  connect(T_Return.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(switch1.y, simpleValve.opening)
    annotation (Line(points={{-41.4,26},{-14,26},{-14,8}}, color={0,0,127}));
  connect(booleanExpression.y, switch1.u2)
    annotation (Line(points={{-65.3,26},{-55.2,26}}, color={255,0,255}));
  connect(ramp.y, switch1.u3) annotation (Line(points={{-69.5,13},{-55.2,13},{-55.2,
          21.2}}, color={0,0,127}));
  connect(PID.y, switch1.u1) annotation (Line(points={{-40.7,47},{-64,47},{-64,30.8},
          {-55.2,30.8}}, color={0,0,127}));
  connect(PID.u_s, T_Return_Set.y)
    annotation (Line(points={{-24.6,47},{-8.5,47}}, color={0,0,127}));
  connect(T_Return.T, PID.u_m) annotation (Line(points={{50,11},{48,11},{48,34},
          {-33,34},{-33,38.6}}, color={0,0,127}));
  connect(HeatDemand, gain.u)
    annotation (Line(points={{-102,68},{-96,68},{-96,-50},{-90.8,-50}},
                                                      color={0,0,127}));
  connect(gain.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-81.6,-50},{-66,-50}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, vol.heatPort)
    annotation (Line(points={{-54,-50},{14,-50},{14,10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SubstationHeating;
