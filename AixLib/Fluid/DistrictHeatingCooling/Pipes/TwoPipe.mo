within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model TwoPipe
  "Pipe model using spatialDistribution for temperature delay"
  extends AixLib.Fluid.Interfaces.PartialFourPortVector(show_T=true, nPorts=1);

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Length dh=sqrt(4*m_flow_nominal/rho_default/v_nominal/Modelica.Constants.pi)
    "Hydraulic diameter (assuming a round cross section area)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Velocity v_nominal = 1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation(Dialog(group="Nominal condition"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length length "Pipe length"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m_flow_small = 1E-4*abs(
    m_flow_nominal) "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.SIunits.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.SIunits.SpecificHeatCapacity cPip=2300
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Density rhoPip(displayUnit="kg/m3")=930
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Length thickness = 0.0035
    "Pipe wall thickness"
    annotation (Dialog(group="Material"));

  parameter Modelica.SIunits.Temperature T_start_in(start=Medium.T_default)=
    Medium.T_default "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.Temperature T_start_out(start=Medium.T_default)=
    T_start_in "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay(start=false) = false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flow_start=0 "Initial value of mass flow rate through pipe"
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real R(unit="(m.K)/W")=1/(kIns*2*Modelica.Constants.pi/
    Modelica.Math.log((dh/2 + dIns)/(dh/2)))
    "Thermal resistance per unit length from fluid to boundary temperature"
    annotation (Dialog(group="Thermal resistance"));

  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal";

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean has_ground = false
  "=true if a ground model around the pipe is used"
  annotation (Dialog(group="Ground"));

  parameter Modelica.SIunits.Length thickness_ground = 0.5
  "thickness of ground if enabled"
  annotation (Dialog(group="Ground", enable=has_ground));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort1
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,84},{10,104}}),
        iconTransformation(extent={{-10,84},{10,104}})));

  // In the volume, below, we scale down V and use
  // mSenFac. Otherwise, for air, we would get very large volumes
  // which affect the delay of water vapor and contaminants.
  // See also AixLib.Fluid.FixedResistances.Validation.PlugFlowPipes.TransportWaterAir
  // for why mSenFac is 10 and not 1000, as this gives more reasonable
  // temperature step response

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort2
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,-84},{10,-104}}),
        iconTransformation(extent={{-10,-84},{10,-104}})));
  PlugFlowPipeZeta plugFlowPipeZeta(redeclare package Medium = Medium,
    length=length,
    m_flow_nominal=m_flow_nominal,
    dIns=dIns,
    kIns=kIns,                                                         nPorts=1)
    annotation (Placement(transformation(extent={{-10,-50},{10,-70}})));
  replaceable StaticPipe staticPipe(
    redeclare package Medium = Medium,
    length=length,
    m_flow_nominal=m_flow_nominal,
    dIns=dIns,
    kIns=kIns,
    nPorts=nPorts,
    rhoPip=rhoPip,
    cPip=cPip,
    thickness_ground=thickness_ground,
    lambda_ground=lambda_ground) constrainedby Interfaces.PartialTwoPortVector(
    redeclare package Medium = Medium,
    length=length,
    m_flow_nominal=m_flow_nominal,
    dIns=dIns,
    kIns=kIns,
    nPorts=nPorts,
    rhoPip=rhoPip,
    cPip=cPip,
    thickness_ground=thickness_ground,
    lambda_ground=lambda_ground) annotation (Placement(transformation(extent={{10,
            50},{-10,70}})), __Dymola_choicesAllMatching=true);
protected
  parameter Modelica.SIunits.HeatCapacity CPip=
    length*((dh + 2*thickness)^2 - dh^2)*Modelica.Constants.pi/4*cPip*rhoPip "Heat capacity of pipe wall";

  final parameter Modelica.SIunits.Volume VEqu=CPip/(rho_default*cp_default)
    "Equivalent water volume to represent pipe wall thermal inertia";

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.SIunits.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

  parameter Real C(unit="J/(K.m)")=
    rho_default*Modelica.Constants.pi*(dh/2)^2*cp_default
    "Thermal capacity per unit length of water in pipe";

  parameter Modelica.SIunits.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

equation
  for i in 1:nPorts loop
  end for;

  connect(ports_b2[1], plugFlowPipeZeta.port_a)
    annotation (Line(points={{-100,-60},{-10,-60}}, color={0,127,255}));
  connect(plugFlowPipeZeta.ports_b[1], port_a2)
    annotation (Line(points={{10,-60},{100,-60}}, color={0,127,255}));
  connect(plugFlowPipeZeta.heatPort, heatPort2)
    annotation (Line(points={{0,-70},{0,-94}}, color={191,0,0}));
  connect(port_a1, staticPipe.ports_b[1])
    annotation (Line(points={{-100,60},{-10,60}}, color={0,127,255}));
  connect(staticPipe.port_a, ports_b1[1])
    annotation (Line(points={{10,60},{100,60}}, color={0,127,255}));
  connect(staticPipe.heatPort, heatPort1)
    annotation (Line(points={{0,70},{0,94}}, color={191,0,0}));
  annotation (
    Line(points={{70,20},{72,20},{72,0},{100,0}}, color={0,127,255}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-80,80},{80,40}},
          lineColor={0,0,0},
          fillColor={165,165,165},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,-40},{80,-80}},
          lineColor={0,0,0},
          fillColor={165,165,165},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-70,80},{-24,62}},
          lineColor={0,0,0},
          fillColor={165,165,165},
          fillPattern=FillPattern.None,
          textString="pipeFlow"),
        Text(
          extent={{-70,-40},{-24,-58}},
          lineColor={0,0,0},
          fillColor={165,165,165},
          fillPattern=FillPattern.None,
          textString="pipeReturn")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
        Rectangle(
          extent={{-100,84},{100,36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,76},{100,44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,100},{100,90}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-90},{100,-100}},
          lineColor={175,175,175},
          fillColor={255,255,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,-36},{100,-84}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={192,192,192}),
        Rectangle(
          extent={{-100,-44},{100,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,36},{100,-36}},
          lineColor={28,108,200},
          fillColor={165,165,165},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html><ul>
  <li>October 23, 2017, by Michael Wetter:<br/>
    Revised variable names and documentation to follow guidelines.
    Corrected malformed hyperlinks.
  </li>
  <li>July 4, 2016 by Bram van der Heijde:<br/>
    Introduce <code>pipVol</code>.
  </li>
  <li>October 10, 2015 by Marcus Fuchs:<br/>
    Copy Icon from KUL implementation and rename model. Replace
    resistance and temperature delay by an adiabatic pipe.
  </li>
  <li>September, 2015 by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Pipe with heat loss using the time delay based heat losses and
  transport of the fluid using a plug flow model, applicable for
  simulation of long pipes such as in district heating and cooling
  systems.
</p>
<p>
  This model takes into account transport delay along the pipe length
  idealized as a plug flow. The model also includes thermal inertia of
  the pipe wall.
</p>
<h4>
  Implementation
</h4>
<p>
  Heat losses are implemented by <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss\">
  AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowHeatLoss</a> at
  each end of the pipe (see <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore</a>).
  Depending on the flow direction, the temperature difference due to
  heat losses is subtracted at the right fluid port.
</p>
<p>
  The pressure drop is implemented using <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>.
</p>
<p>
  The thermal capacity of the pipe wall is implemented as a mixing
  volume of the fluid in the pipe, of which the thermal capacity is
  equal to that of the pipe wall material. In addition, this mixing
  volume allows the hydraulic separation of subsequent pipes. Thanks to
  the vectorized implementation of the (design) outlet port, splits and
  junctions of pipes can be handled in a numerically efficient way.<br/>
  This mixing volume is not present in the <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">PlugFlowCore</a>
  model, which can be used in cases where mixing volumes at pipe
  junctions need to be added manually.
</p>
<h4>
  Assumptions
</h4>
<ul>
  <li>Heat losses are for steady-state operation.
  </li>
  <li>The axial heat diffusion in the fluid, the pipe wall and the
  ground are neglected.
  </li>
  <li>The boundary temperature is uniform.
  </li>
  <li>The thermal inertia of the pipe wall material is lumped on the
  side of the pipe that is connected to <code>ports_b</code>.
  </li>
</ul>
<h4>
  References
</h4>
<p>
  Full details on the model implementation and experimental validation
  can be found in:
</p>
<p>
  van der Heijde, B., Fuchs, M., Ribas Tugores, C., Schweiger, G.,
  Sartor, K., Basciotti, D., Müller, D., Nytsch-Geusen, C., Wetter, M.
  and Helsen, L. (2017).<br/>
  Dynamic equation-based thermo-hydraulic pipe model for district
  heating and cooling systems.<br/>
  <i>Energy Conversion and Management</i>, vol. 151, p. 158-169.
  <a href=\"https://doi.org/10.1016/j.enconman.2017.08.072\">doi:
  10.1016/j.enconman.2017.08.072</a>.
</p>
</html>"));
end TwoPipe;
