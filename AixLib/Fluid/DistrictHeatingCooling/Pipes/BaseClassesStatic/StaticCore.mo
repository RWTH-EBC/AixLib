within AixLib.Fluid.DistrictHeatingCooling.Pipes.BaseClassesStatic;
model StaticCore
  "Pipe model using static conditions"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;

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

  parameter Modelica.SIunits.Temperature T_start_in=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start_out=Medium.T_default
    "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay=false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start=0
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));
  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  AixLib.Fluid.FixedResistances.HydraulicDiameter res(
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
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss heaLos_a(
    redeclare final package Medium = Medium,
    final C=C,
    final R=R,
    final m_flow_small=m_flow_small,
    final T_start=T_start_in,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_start=m_flow_start,
    final show_T=false,
    final show_V_flow=false) "Heat loss for flow from port_b to port_a"
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));

  AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss heaLos_b(
    redeclare final package Medium = Medium,
    final C=C,
    final R=R,
    final m_flow_small=m_flow_small,
    final T_start=T_start_out,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_start=m_flow_start,
    final show_T=false,
    final show_V_flow=false) "Heat loss for flow from port_a to port_b"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare final package Medium = Medium) "Mass flow sensor"
    annotation (Placement(transformation(extent={{-50,10},{-30,-10}})));
  StaticTransportDelay                                             timDel(
    final length=length,
    final dh=dh,
    final rho=rho_default,
    final initDelay=initDelay,
    final m_flow_nominal=m_flow_nominal,
    final m_flow_start=m_flow_start) "Time delay"
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat port to connect environment (positive heat flow for heat loss to surroundings)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

protected
  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

equation
  connect(senMasFlo.m_flow, timDel.m_flow) annotation (Line(
      points={{-40,-11},{-40,-40},{-12,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heaLos_a.heatPort, heatPort) annotation (Line(points={{-70,10},{-70,40},
          {0,40},{0,100}}, color={191,0,0}));
  connect(heaLos_b.heatPort, heatPort) annotation (Line(points={{70,10},{70,40},
          {0,40},{0,100}}, color={191,0,0}));

  connect(timDel.tauRev, heaLos_a.tau) annotation (Line(points={{11,-36},{50,-36},
          {50,28},{-64,28},{-64,10}}, color={0,0,127}));
  connect(timDel.tau, heaLos_b.tau) annotation (Line(points={{11,-44},{54,-44},
          {54,28},{64,28},{64,10}}, color={0,0,127}));

  connect(port_a, heaLos_a.port_b)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(heaLos_a.port_a, senMasFlo.port_a)
    annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
  connect(heaLos_b.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, res.port_a)
    annotation (Line(points={{-30,0},{-20,0}}, color={0,127,255}));
  connect(res.port_b, heaLos_b.port_a)
    annotation (Line(points={{0,0},{60,0}}, color={0,127,255}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,50},{100,40}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-40},{100,-50}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{0,100},{40,62},{20,62},{20,38},{-20,38},{-20,62},{-40,62},{0,
              100}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,30},{28,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187})}),
    Documentation(revisions="<html><ul>
  <li>September 25, 2019, by Nils Neuland:<br/>
    Revised variable names and documentation to follow guidelines.
    Corrected malformed hyperlinks.
  </li>
</ul>
</html>", info="<html>
<p>
  Pipe with heat loss using the time delay based heat losses for the
  transport delay of the fluid.
</p>
<h4>
  Implementation
</h4>
<p>
  This model is based on <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">FixedResistances.BaseClasses.PlugFlowCore</a>
  but does not contain the <span style=
  \"font-family: Courier New;\">spatialDistribution</span> operator.
</p>
<p>
  The <span style=
  \"font-family: Courier New;\">spatialDistribution</span> operator is
  used for the temperature wave propagation through the length of the
  pipe. This operator is contained in <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlow\">BaseClasses.PlugFlow</a>.
</p>
<p>
  This model does not include thermal inertia of the pipe wall. The
  wall inertia is implemented in <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Pipes.StaticPipe\">StaticPipe</a>.
</p>
<p>
  The removal of the thermal inertia with a mixing volume can be
  desirable in the case where mixing volumes are added manually at the
  pipe junctions.
</p>
<p>
  The model <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss\">
  PlugFlowHeatLoss</a> implements a heat loss in design direction, but
  leaves the enthalpy unchanged in opposite flow direction. Therefore
  it is used in front of and behind the time delay.
</p>
<p>
  The pressure drop is implemented using <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>.
</p>
</html>"));
end StaticCore;
