within AixLib.Systems.HydraulicModules.Example;
model simpleconsumer_1
  extends Modelica.Icons.Example;
  package MediumWater = AixLib.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=0.5
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Volume V_Water = 0.1;
  parameter Modelica.SIunits.PressureDifference dp_nominalPumpConsumer=200000;

public
  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Fluid.Sources.Boundary_pT
                      bou1(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,0})));
  AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer_base(
    demandType=1,
    m_flow_nominal=m_flow_nominal,
    V=V_Water,
    dp_nominalPumpConsumer=dp_nominalPumpConsumer,
    dp_Valve(displayUnit="Pa") = 100,
    dpFixed_nominal(displayUnit="Pa") = {100,100},
    hasPump=true,
    hasFeedback=true,
    T_return=313.15,
    T_flow=323.15,
    kA=10,
    functionality="T_fixed",
      redeclare package Medium = MediumWater)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.MixingVolumes.MixingVolume volume(
    redeclare package Medium = MediumWater,
    final V=V_Water,
    final m_flow_nominal=m_flow_nominal,
    nPorts=2)                                                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-44,10})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature   fixedTemperature(T=323.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-76,48})));
equation
  connect(simpleConsumer_base.port_b, bou1.ports[1])
    annotation (Line(points={{10,0},{76,0}}, color={0,127,255}));
  connect(bou.ports[1], volume.ports[1])
    annotation (Line(points={{-90,0},{-42,0}},         color={0,127,255}));
  connect(volume.ports[2], simpleConsumer_base.port_a)
    annotation (Line(points={{-46,0},{-10,0}}, color={0,127,255}));
  connect(fixedTemperature.port, volume.heatPort) annotation (Line(points={{-66,
          48},{-24,48},{-24,10},{-34,10}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end simpleconsumer_1;
