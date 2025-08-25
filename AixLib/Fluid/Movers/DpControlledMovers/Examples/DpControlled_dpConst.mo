within AixLib.Fluid.Movers.DpControlledMovers.Examples;
model DpControlled_dpConst
  extends Modelica.Icons.Example;
  package Medium = AixLib.Media.Water "Medium model";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=1.0
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal_max=2*m_flow_nominal
    "To describe max point of mover's characteristic curve.";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=100000 "Nominal pressure raise, used to normalized the filter if use_inputFilter=true,
        to set default values of constantHead and heads, and
        and for default pressure curve if not specified in record per";

  AixLib.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    use_p_in=false,
    p=101325,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));

  AixLib.Fluid.Actuators.Valves.TwoWayLinear val(
    redeclare package Medium = Medium,
    from_dp=true,
    m_flow_nominal=m_flow_nominal_max,
    dpValve_nominal=0.5*dp_nominal,
    y_start=rampValve.offset)
                      "Pressure drop"
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  AixLib.Fluid.Sensors.MassFlowRate masFloRat(redeclare package Medium = Medium) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  AixLib.Fluid.Movers.DpControlledMovers.DpControlled_dp dpControlled_dp(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    redeclare Data.Generic per(pressure=dpControlled_dp.pressureCurve_default, motorCooledByFluid=false),
    dp_nominal=dp_nominal,
    ctrlType=AixLib.Fluid.Movers.DpControlledMovers.Types.CtrlType.dpConst)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  AixLib.Fluid.FixedResistances.PressureDrop dp(
    m_flow_nominal=m_flow_nominal_max,
    redeclare package Medium = Medium,
    dp_nominal=0.5*dp_nominal,
    from_dp=true) "Pressure drop" annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));

  Modelica.Blocks.Sources.Ramp rampValve(
    height=1,
    duration=1800,
    offset=0,
    startTime=900)  annotation (Placement(transformation(extent={{62,30},{42,50}})));
  AixLib.Fluid.Delays.DelayFirstOrder vol(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal_max,
    nPorts=2) annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=293.15) annotation (Placement(transformation(extent={{-36,-48},{-20,-32}})));

  Modelica.Blocks.Continuous.Integrator integrator(u(final quantity="Power", final unit="W"), y(final quantity="Energy", final unit="J", final displayUnit="kW.h")) annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Interfaces.RealOutput elEnergy(final quantity="Energy", final unit="J", final displayUnit="kW.h") "Cumulated electrical power" annotation (Placement(transformation(extent={{100,60},{120,80}})));
equation

  connect(dpControlled_dp.port_b,val. port_a) annotation (Line(points={{0,0},{22,0}},   color={0,127,255}));
  connect(dp.port_b, dpControlled_dp.port_a) annotation (Line(points={{-32,0},{-20,0}},   color={0,127,255}));
  connect(val.port_b, masFloRat.port_a) annotation (Line(points={{42,0},{60,0}},   color={0,127,255}));
  connect(sou.ports[1], dp.port_a) annotation (Line(points={{-76,0},{-52,0}},   color={0,127,255}));
  connect(rampValve.y,val. y) annotation (Line(points={{41,40},{32,40},{32,12}}, color={0,0,127}));
  connect(masFloRat.port_b, vol.ports[1]) annotation (Line(points={{80,0},{88,0},{88,-60},{-2,-60},{-2,-50}},color={0,127,255}));
  connect(vol.ports[2], dp.port_a) annotation (Line(points={{2,-50},{2,-60},{-60,-60},{-60,0},{-52,0}},         color={0,127,255}));
  connect(fixedTemperature.port, vol.heatPort) annotation (Line(points={{-20,-40},{-10,-40}},
                                                                                            color={191,0,0}));
  connect(dpControlled_dp.P, integrator.u) annotation (Line(points={{1,9},{8,9},{8,70},{38,70}},   color={0,0,127}));
  connect(integrator.y, elEnergy) annotation (Line(points={{61,70},{110,70}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Movers/DpControlledMovers/Examples/DpControlled_dpConst.mos"
        "Simulate and plot"),
    experiment(
      StopTime=3600,
      Tolerance=1e-06));
end DpControlled_dpConst;
