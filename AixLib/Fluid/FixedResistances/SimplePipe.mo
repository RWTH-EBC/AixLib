within AixLib.Fluid.FixedResistances;
model SimplePipe "Simple pipe model with n discrete elements"

  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  parameter Integer nNodes(min=1) = 2 "Spatial segmentation";

  parameter Modelica.SIunits.Length dh
    "Hydraulic diameter (assuming a round cross section area)";

  parameter Modelica.SIunits.Velocity v_nominal
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.Length length(min=0) "Pipe length";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Geometry"));

  parameter Real R(unit="(m.K)/W")
    "Thermal resistance per unit length from fluid to boundary temperature";

  parameter Real C(unit="J/(K.m)")
    "Thermal capacity per unit length of pipe";

  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal";


  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Length thickness(min=0) "Pipe wall thickness";

  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Medium2.AbsolutePressure p_start = Medium.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization"));

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));


  HydraulicDiameter                               res(
    redeclare final package Medium = Medium,
    final dh=dh,
    final m_flow_nominal=m_flow_nominal,
    final from_dp=from_dp,
    final length=length,
    final roughness=roughness,
    final fac=fac,
    final ReC=ReC,
    final v_nominal=v_nominal,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    dp(nominal=fac*200*length))
                 "Pressure drop calculation for this pipe"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  MixingVolumes.MixingVolume vol[nNodes](
    redeclare final package Medium = Medium,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final p_start=p_start,
    final T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final allowFlowReversal=allowFlowReversal,
    final V=dh^2*length*Modelica.Constants.pi/4,
    nPorts=2) annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1[size(vol, 1)]
                      "Heat port for heat exchange with the control volume"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  connect(res.port_a, port_a)
    annotation (Line(points={{-40,0},{-100,0}}, color={0,127,255}));
  connect(vol[1].ports[1], res.port_b)
    annotation (Line(points={{18,0},{-20,0}}, color={0,127,255}));
  connect(vol[nNodes].ports[2], port_b)
    annotation (Line(points={{22,0},{100,0}},color={0,127,255}));

  for i in 1:nNodes-1 loop
    connect(vol[i].ports[2],vol[i+1].ports[1]);
  end for;

  connect(vol.heatPort, heatPort1)
    annotation (Line(points={{10,10},{0,10},{0,100}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          lineThickness=1),
        Text(
          extent={{-40,14},{40,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="%nNodes"),
        Polygon(
          points={{0,88},{40,50},{20,50},{20,32},{-20,32},{-20,50},{-40,50},{0,
              88}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimplePipe;
