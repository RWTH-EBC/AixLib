within AixLib.Fluid.FixedResistances;
model SimplePipe "Simple pipe model with n discrete elements"

  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  parameter Integer nNodes(min=1) = 2 "Spatial segmentation";

  parameter Modelica.SIunits.Length dh
    "Inner/hydraulic diameter (assuming a round cross section area)";

  parameter Boolean withHeattransfer=true "True, if heat transfer to ambient" annotation (Dialog(group="Material"), choices(checkBox=true));

  parameter Modelica.SIunits.Length length(min=0) "Pipe length";


  parameter Modelica.SIunits.MassFlowRate m_flow_small(min=0) = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal";

  // Material properties for resistance
  parameter Real ReC=2300
    "Reynolds number where transition to turbulent starts"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  // Material for heattransfer
  parameter Modelica.SIunits.ThermalConductivity lambda=370
    "Heat conductivity of pipe material" annotation (Dialog(group="Material", enable = withHeattransfer));
  parameter Modelica.SIunits.SpecificHeatCapacity c=1600
    "Specific heat capacity of pipe material" annotation (Dialog(group="Material", enable = withHeattransfer));
  parameter Modelica.SIunits.Density rho=1000 "Density of pipe material"
    annotation (Dialog(group="Material", enable = withHeattransfer));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Length thickness(min=0)=0.001 "Pipe wall thickness"
    annotation (Dialog(group="Material", enable = withHeattransfer));

  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));


  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));


  parameter Boolean homotopyInitialization=true "= true, use homotopy method"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean linearized=false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation (Evaluate=true, Dialog(tab="Advanced"));
  parameter Medium.AbsolutePressure p_start=Medium.p_default
    "Start value of pressure" annotation (Dialog(tab="Initialization"));

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));


  HydraulicDiameter res(
    redeclare final package Medium = Medium,
    final dh=dh,
    final m_flow_nominal=m_flow_nominal,
    final from_dp=from_dp,
    final length=length,
    final roughness=roughness,
    final fac=fac,
    final ReC=ReC,
    final allowFlowReversal=allowFlowReversal,
    final show_T=false,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized,
    dp(nominal=fac*200*length)) "Pressure drop calculation for this pipe"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  MixingVolumes.MixingVolume vol[nNodes](
    redeclare each final package Medium = Medium,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final m_flow_nominal=m_flow_nominal,
    each final allowFlowReversal=allowFlowReversal,
    each final V=dh^2*length*Modelica.Constants.pi/4,
    each nPorts=2) annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Utilities.HeatTransfer.CylindricHeatTransfer PipeWall[nNodes](
    each final energyDynamics=energyDynamics,
    each final rho=rho,
    each final c=c,
    each final d_out=dh + 2*thickness,
    each final d_in=dh,
    each final length=length/nNodes,
    each final lambda=lambda,
    each final T0=T_start,
    each final nParallel=1) if withHeattransfer
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,46})));

  Modelica.Fluid.Interfaces.HeatPorts_a heatPorts[nNodes] if withHeattransfer
                                                          annotation (Placement(
        transformation(extent={{-10,84},{10,104}}), iconTransformation(extent={{-60,42},
            {60,62}})));
equation
  connect(res.port_a, port_a)
    annotation (Line(points={{-40,0},{-100,0}}, color={0,127,255}));
  connect(vol[1].ports[1], res.port_b)
    annotation (Line(points={{18,0},{-20,0}}, color={0,127,255}));
  connect(vol[nNodes].ports[2], port_b)
    annotation (Line(points={{22,0},{100,0}}, color={0,127,255}));

  for i in 1:nNodes - 1 loop
    connect(vol[i].ports[2], vol[i + 1].ports[1]);
  end for;

  connect(PipeWall.port_a, vol.heatPort)
    annotation (Line(points={{0,46},{0,10},{10,10}},         color={191,0,0}));
  connect(PipeWall.port_b, heatPorts)
    annotation (Line(points={{0,54.8},{0,54.8},{0,94}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={7,22,91},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Text(
          visible=pipeModel=="SimplePipe",
          extent={{-40,14},{40,-12}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,0,0},
          textString="%nNodes"),
        Rectangle(
          extent={{-100,40},{100,36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.CrossDiag,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-100,-36},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.CrossDiag,
          fillColor={95,95,95})}),          Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>Mai 07, 2020, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents a pipe using a simple approach and consists of
  a <a href=
  \"modelica://AixLib/Fluid/FixedResistances/HydraulicDiameter.mo\">HydraulicDiamete</a>r
  and n volume elements to approximate the thermal wave propagation.
  The heat transfer through the pipe wall is modeled with a <a href=
  \"modelica://AixLib/Utilities/HeatTransfer/CylindricHeatTransfer.mo\">CylindricHeatTransfer</a>
  and can be deactivated. This model can be used if a heat flow or heat
  transfer to the pipe has to be modeled and the thermal mass of the
  fluid cannot be neglected. Since the pipe is discretized in n
  elements, this model should only be used, if the dead time of the
  thermal wive propagation can be neglected. With an increasing number
  of elements (nNodes) the wave propagation becomes more realistic.
  However, the simulation time will increase as well.
</p>
<p>
  For long pipes, the model <a href=
  \"modelica://AixLib/Fluid/FixedResistances/PlugFlowPipe.mo\">PlugFlowPipe</a>
  can be used (the heat transfer in the PlugFlowPipe can cause problems
  for small volume flows ).
</p>
</html>"));
end SimplePipe;
