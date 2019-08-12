within AixLib.Systems.HydraulicModules.BaseClasses;
partial model PartialHydraulicModule "Base class for hydraulic module."
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    final allowFlowReversal1 = allowFlowReversal,
    final allowFlowReversal2 = allowFlowReversal);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));

  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Length dIns
    "Thickness of insulation of all pipes (can be overwritten in each pipe) "
    annotation (Dialog(group="Pipes"));
  parameter Modelica.SIunits.ThermalConductivity kIns
    "Heat conductivity of pipe insulation of all pipes (can be overwritten in each pipe)"
    annotation (Dialog(group="Pipes"));
  parameter Modelica.SIunits.Length d
    "Hydraulic diameter of all pipes (can be overwritten in each pipe)"
    annotation (Dialog(group="Pipes"));
  parameter Modelica.SIunits.Length length "Pipe length of all pipes (can be overwritten in each pipe)"
    annotation (Dialog(group="Pipes"));
  parameter Real Kv "Kv value of valve (can be overwritten in valve)"  annotation (Dialog(group="Actuators"));

  BaseClasses.HydraulicBus hydraulicBus annotation (Placement(transformation(
          extent={{-20,80},{20,120}}), iconTransformation(extent={{-20,80},{20,120}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={40,-20})));

  Modelica.Blocks.Sources.Constant const(k=T_amb)
    annotation (Placement(transformation(extent={{72,-28},{56,-12}})));

  // -------------------------------------------------
  // Sensors
  // -------------------------------------------------
protected
  Fluid.Sensors.VolumeFlowRate VFSen_out(
    redeclare package Medium = Medium,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-100,40})));
  Fluid.Sensors.VolumeFlowRate VFSen_in(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal) "Outflow out of forward line"
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={100,42})));

  Fluid.Sensors.TemperatureTwoPort senT_a1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-100,14},{-88,26}})));
  Fluid.Sensors.TemperatureTwoPort senT_a2(
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{84,-66},{72,-54}})));
  Fluid.Sensors.TemperatureTwoPort senT_b1(
    final m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{88,14},{100,26}})));
  Fluid.Sensors.TemperatureTwoPort senT_b2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final TAmb=T_amb,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal)
    annotation (Placement(transformation(extent={{-78,-66},{-90,-54}})));

  Modelica.Blocks.Continuous.FirstOrder PT1_b2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,-30})));
  Modelica.Blocks.Continuous.FirstOrder PT1_b1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={70,70})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a1(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-70,70})));
  Modelica.Blocks.Continuous.FirstOrder PT1_a2(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=T_start,
    final T=tau) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={110,-30})));

equation

  connect(VFSen_out.V_flow, hydraulicBus.VF_in) annotation (Line(
      points={{-111,40},{-112,40},{-112,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_in.V_flow, hydraulicBus.VF_out) annotation (Line(
      points={{111,42},{116,42},{116,100.1},{0.1,100.1}},
      color={0,0,127},
      visible=true), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(VFSen_out.port_a, port_a1)
    annotation (Line(points={{-100,50},{-100,60}}, color={0,127,255}));
  connect(VFSen_in.port_b, port_b1)
    annotation (Line(points={{100,52},{100,60}}, color={0,127,255}));
  connect(port_b2, senT_b2.port_b)
    annotation (Line(points={{-100,-60},{-90,-60}}, color={0,127,255}));
  connect(VFSen_out.port_b, senT_a1.port_a) annotation (Line(points={{-100,30},{
          -100,20}},                  color={0,127,255}));
  connect(senT_b1.port_b, VFSen_in.port_a)
    annotation (Line(points={{100,20},{100,32}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2) annotation (Line(points={{84,-60},{92,-60},{92,
          -60},{100,-60}}, color={0,127,255}));
  connect(PT1_b2.u, senT_b2.T) annotation (Line(points={{-98,-30},{-84,-30},{-84,
          -53.4}}, color={0,0,127}));
  connect(senT_a1.T, PT1_a1.u) annotation (Line(points={{-94,26.6},{-82,26.6},{-82,
          58},{-70,58}}, color={0,0,127}));
  connect(senT_b1.T, PT1_b1.u) annotation (Line(points={{94,26.6},{86,26.6},{86,
          58},{70,58}}, color={0,0,127}));
  connect(PT1_b1.y, hydraulicBus.TFwrd_out) annotation (Line(points={{70,81},{70,
          100.1},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_a1.y, hydraulicBus.TFwrd_in) annotation (Line(points={{-70,81},{-70,
          100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PT1_b2.y, hydraulicBus.TRtrn_out) annotation (Line(points={{-121,-30},
          {-122,-30},{-122,100},{0.1,100},{0.1,100.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(senT_a2.T, PT1_a2.u)
    annotation (Line(points={{78,-53.4},{78,-30},{98,-30}}, color={0,0,127}));
  connect(PT1_a2.y, hydraulicBus.TRtrn_in) annotation (Line(points={{121,-30},{130,
          -30},{130,100},{116,100},{116,100.1},{0.1,100.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, prescribedTemperature.T)
    annotation (Line(points={{55.2,-20},{49.6,-20}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>Admix circuit with a replaceable pump model for the distribution of hot or cold water. All sensor and actor values are connected to the hydraulic bus.</p>
<h4>Characteristics</h4>
<p>There is a connecting pipe between distributer and collector of manifold so that the pressure difference between them becomes insignificant. The main pump only works against the resistance in the main circuit.</p>
<p>The mass flow in primary and secondary circuits stay constant.</p>
<p>The scondary circuits do not affect each other when switching operational modes.</p>
</html>", revisions="<html>
<ul>
<li>August, 2018, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"),
    experiment(StopTime=86400),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
         graphics={
        Line(
          points={{0,100}},
          color={95,95,95},
          thickness=0.5)}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)));
end PartialHydraulicModule;
