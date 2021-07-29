within AixLib.Fluid.Movers.DpControlledMovers.Examples;
model DpControlled_dp
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Medium model";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=3600/3600*1.0
    "Nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_max = 2*m_flow_nominal "To describe max point of mover's characteristic curve.";
  parameter Modelica.SIunits.PressureDifference dp_nominal=1.0e5 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per";

  AixLib.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p=101325,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-90,20},{-70,40}})));

  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    from_dp=true,
    m_flow_nominal=m_flow_nominal_max,
    dpValve_nominal=0.5*dp_nominal,
    y_start=rampValve.offset)
                      "Pressure drop"
    annotation (Placement(transformation(extent={{28,20},{48,40}})));
  AixLib.Fluid.Sensors.MassFlowRate masFloRat(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{66,20},{86,40}})));
  AixLib.Fluid.Movers.DpControlledMovers.DpControlled_dp dpControlled_dp(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    ctrlType=AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpVar,
    redeclare AixLib.Fluid.Movers.Data.Generic per(pressure(V_flow={0,1,1.5}*
            m_flow_nominal, dp={2,1,0}*m_flow_nominal), motorCooledByFluid=false),
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-14,20},{6,40}})));
  AixLib.Fluid.FixedResistances.PressureDrop dp(
    m_flow_nominal=m_flow_nominal_max,
    redeclare package Medium = Medium,
    dp_nominal=0.5*dp_nominal,
    from_dp=true) "Pressure drop" annotation (Placement(transformation(extent={{-46,20},{-26,40}})));

  Modelica.Blocks.Sources.Ramp rampValve(
    height=1,
    duration=1800,
    offset=0,
    startTime=900)  annotation (Placement(transformation(extent={{80,60},{60,80}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_max,
    nPorts=2) annotation (Placement(transformation(extent={{-10,58},{10,78}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15) annotation (Placement(transformation(extent={{-36,60},{-20,76}})));
equation

  connect(dpControlled_dp.port_b,val. port_a) annotation (Line(points={{6,30},{28,30}}, color={0,127,255}));
  connect(dp.port_b, dpControlled_dp.port_a) annotation (Line(points={{-26,30},{-14,30}}, color={0,127,255}));
  connect(val.port_b, masFloRat.port_a) annotation (Line(points={{48,30},{66,30}}, color={0,127,255}));
  connect(sou.ports[1], dp.port_a) annotation (Line(points={{-70,30},{-46,30}}, color={0,127,255}));
  connect(rampValve.y,val. y) annotation (Line(points={{59,70},{38,70},{38,42}}, color={0,0,127}));
  connect(masFloRat.port_b, vol.ports[1]) annotation (Line(points={{86,30},{96,30},{96,52},{-2,52},{-2,58}}, color={0,127,255}));
  connect(vol.ports[2], dp.port_a) annotation (Line(points={{2,58},{-2,58},{-2,52},{-50,52},{-50,30},{-46,30}}, color={0,127,255}));
  connect(fixedTemperature.port, vol.heatPort) annotation (Line(points={{-20,68},{-10,68}}, color={191,0,0}));
  annotation (experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end DpControlled_dp;
