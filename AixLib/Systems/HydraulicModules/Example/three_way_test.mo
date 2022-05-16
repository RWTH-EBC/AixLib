within AixLib.Systems.HydraulicModules.Example;
model three_way_test
  extends Modelica.Icons.Example;
  package MediumWater = AixLib.Media.Water;

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Volume V_Water = 0.1;
  parameter Modelica.SIunits.PressureDifference dp_nominalPumpConsumer=200000;
  final parameter Modelica.SIunits.VolumeFlowRate Vflow_nom = m_flow_nominal/rho_default;

protected
  parameter MediumWater.ThermodynamicState sta_default=MediumWater.setState_pTX(
      T=MediumWater.T_default,
      p=MediumWater.p_default,
      X=MediumWater.X_default);
  parameter Modelica.SIunits.Density rho_default=MediumWater.density(sta_default)
    "Density, used to compute fluid volume";

public
  Fluid.Movers.SpeedControlled_y
                          fan(
    redeclare package Medium = MediumWater,
    per(pressure(V_flow={0,Vflow_nom,Vflow_nom/0.7}, dp={dp_nominalPumpConsumer/0.7,dp_nominalPumpConsumer,0})),
    addPowerToMedium=false)       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={4,-1.77636e-15})));
  Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.RealExpression y_pump(y=0.5)  annotation (Placement(transformation(extent={{-34,-96},
            {-14,-76}})));
  Modelica.Blocks.Sources.Constant const(k=0.5)
    annotation (Placement(transformation(extent={{-120,44},{-100,64}})));
  Fluid.MixingVolumes.MixingVolume volume(
    redeclare package Medium = MediumWater,
    final V=V_Water,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3)                                                     annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={32,10})));
  Fluid.Sources.Boundary_pT
                      bou1(
    use_T_in=false,
    redeclare package Medium = MediumWater,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={86,0})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
      redeclare package Medium = MediumWater,
    from_dp=false,
    y_start=0.5,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=100,
    dpFixed_nominal={100,100})
    annotation (Placement(transformation(extent={{-66,-10},{-46,10}})));
equation
  connect(y_pump.y, fan.y)
    annotation (Line(points={{-13,-86},{4,-86},{4,-12}}, color={0,0,127}));
  connect(volume.ports[1], bou1.ports[1])
    annotation (Line(points={{34.6667,0},{76,0}},
                                             color={0,127,255}));
  connect(const.y, val.y)
    annotation (Line(points={{-99,54},{-56,54},{-56,12}}, color={0,0,127}));
  connect(bou.ports[1], val.port_1)
    annotation (Line(points={{-90,0},{-66,0}}, color={0,127,255}));
  connect(val.port_3, volume.ports[2]) annotation (Line(points={{-56,-10},{-56,-40},
          {32,-40},{32,0}},           color={0,127,255}));
  connect(val.port_2, fan.port_a)
    annotation (Line(points={{-46,0},{-6,0}}, color={0,127,255}));
  connect(fan.port_b, volume.ports[3])
    annotation (Line(points={{14,0},{29.3333,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end three_way_test;
