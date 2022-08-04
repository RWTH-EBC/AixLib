within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model PlugFlowPipeZeta
  "Pipe model using spatialDistribution for temperature delay and conditional HydraulicResistance"
  extends AixLib.Fluid.Interfaces.PartialTwoPortVector(show_T=true);

  parameter Boolean use_zeta=false
    "= true HydraulicResistance is implemented, zeta value has to be given next"
    annotation(Dialog(group="Additional pressurelosses"));

  parameter Boolean from_dp=false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.Units.SI.Length dh=sqrt(4*m_flow_nominal/rho_default/
      v_nominal/Modelica.Constants.pi)
    "Hydraulic diameter (assuming a round cross section area)"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Velocity v_nominal=1.5
    "Velocity at m_flow_nominal (used to compute default value for hydraulic diameter dh)"
    annotation (Dialog(group="Nominal condition"));

  parameter Real ReC=4000
    "Reynolds number where transition to turbulent starts";

  parameter Modelica.Units.SI.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Length length "Pipe length"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter Modelica.Units.SI.MassFlowRate m_flow_small=1E-4*abs(m_flow_nominal)
    "Small mass flow rate for regularization of zero flow"
    annotation (Dialog(tab="Advanced"));

  parameter Modelica.Units.SI.Length dIns
    "Thickness of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.Units.SI.ThermalConductivity kIns
    "Heat conductivity of pipe insulation, used to compute R"
    annotation (Dialog(group="Thermal resistance"));

  parameter Modelica.Units.SI.SpecificHeatCapacity cPip=2300
    "Specific heat of pipe wall material. 2300 for PE, 500 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Density rhoPip(displayUnit="kg/m3") = 930
    "Density of pipe wall material. 930 for PE, 8000 for steel"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Length thickness=0.0035 "Pipe wall thickness"
    annotation (Dialog(group="Material"));

  parameter Modelica.Units.SI.Temperature T_start_in(start=Medium.T_default) =
    Medium.T_default "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_start_out(start=Medium.T_default)
     = T_start_in "Initialization temperature at pipe outlet"
    annotation (Dialog(tab="Initialization"));
  parameter Boolean initDelay(start=false) = false
    "Initialize delay for a constant mass flow rate if true, otherwise start from 0"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_start=0
    "Initial value of mass flow rate through pipe"
    annotation (Dialog(tab="Initialization", enable=initDelay));

  parameter Real R(unit="(m.K)/W")=1/(kIns*2*Modelica.Constants.pi/
    Modelica.Math.log((dh/2 + dIns)/(dh/2)))
    "Thermal resistance per unit length from fluid to boundary temperature"
    annotation (Dialog(group="Thermal resistance"));

  parameter Real fac= 1.0
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal"
    annotation (Dialog(group="Additional pressurelosses", enable=not use_zeta));

  parameter Real sum_zetas=0
    "Sum of all zeta values. Takes into account additional pressure drops due to bends/valves/etc."
    annotation (Dialog(group="Additional pressurelosses", enable=use_zeta));

  constant Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean linearized = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  Modelica.Units.SI.Velocity v_med "Velocity of the medium in the pipe";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    "Heat transfer to or from surroundings (heat loss from pipe results in a positive heat flow)"
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore plugFlowCore(
    redeclare final package Medium = Medium,
    final dh=dh,
    final v_nominal=v_nominal,
    final length=length,
    final C=C,
    final R=R,
    final m_flow_small=m_flow_small,
    final m_flow_nominal=m_flow_nominal,
    final T_start_in=T_start_in,
    final T_start_out=T_start_out,
    final m_flow_start=m_flow_start,
    final initDelay=initDelay,
    final from_dp=from_dp,
    final fac=if not use_zeta then fac else 1.0,
    final ReC=ReC,
    final thickness=thickness,
    final roughness=roughness,
    final allowFlowReversal=allowFlowReversal,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearized) "Describing the pipe behavior"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  // In the volume, below, we scale down V and use
  // mSenFac. Otherwise, for air, we would get very large volumes
  // which affect the delay of water vapor and contaminants.
  // See also AixLib.Fluid.FixedResistances.Validation.PlugFlowPipes.TransportWaterAir
  // for why mSenFac is 10 and not 1000, as this gives more reasonable
  // temperature step response
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare final package Medium = Medium,
    final m_flow_nominal=m_flow_nominal,
    final V=if rho_default > 500 then VEqu else VEqu/1000,
    final nPorts=nPorts + 1,
    final T_start=T_start_out,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final mSenFac = if rho_default > 500 then 1 else 10)
    "Control volume connected to ports_b. Represents equivalent pipe wall thermal capacity."
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

protected
  parameter Modelica.Units.SI.HeatCapacity CPip=length*((dh + 2*thickness)^2 -
      dh^2)*Modelica.Constants.pi/4*cPip*rhoPip "Heat capacity of pipe wall";

  final parameter Modelica.Units.SI.Volume VEqu=CPip/(rho_default*cp_default)
    "Equivalent medium volume to represent pipe wall thermal inertia";

  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default) "Default medium state";

  parameter Modelica.Units.SI.SpecificHeatCapacity cp_default=
      Medium.specificHeatCapacityCp(state=sta_default)
    "Heat capacity of medium";

  parameter Real C(unit="J/(K.m)")=
    rho_default*Modelica.Constants.pi*(dh/2)^2*cp_default
    "Thermal capacity per unit length of medium in pipe";

  parameter Modelica.Units.SI.Density rho_default=Medium.density_pTX(
      p=Medium.p_default,
      T=Medium.T_default,
      X=Medium.X_default)
    "Default density (e.g., rho_liquidWater = 995, rho_air = 1.2)"
    annotation (Dialog(group="Advanced"));

public
  FixedResistances.HydraulicResistance hydraulicResistance(
    diameter=dh,
    m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    zeta=sum_zetas,
    allowFlowReversal=allowFlowReversal,
    from_dp=from_dp,
    homotopyInitialization=homotopyInitialization,
    linearized=linearized,
    m_flow_start=m_flow_start) if use_zeta
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
equation
  //calculation of the flow velocity of medium in the pipes
  v_med = (4 * port_a.m_flow) / (Modelica.Constants.pi * rho_default * dh * dh);

  for i in 1:nPorts loop
    connect(vol.ports[i + 1], ports_b[i])
    annotation (Line(points={{70,20},{72,20},{72,6},{72,0},{100,0}},
        color={0,127,255}));
  end for;
  connect(plugFlowCore.heatPort, heatPort)
    annotation (Line(points={{0,10},{0,10},{0,100}}, color={191,0,0}));

  connect(plugFlowCore.port_b, vol.ports[1])
    annotation (Line(points={{10,0},{70,0},{70,20}}, color={0,127,255}));
  if use_zeta then
  connect(hydraulicResistance.port_b, plugFlowCore.port_a)
    annotation (Line(points={{-40,20},{-20,20},{-20,0},{-10,0}},
                                               color={0,127,255}, pattern=LinePattern.Dash));
  connect(hydraulicResistance.port_a, port_a)
    annotation (Line(points={{-60,20},{-80,20},{-80,0},{-100,0}},
                                                color={0,127,255}, pattern=LinePattern.Dash));
  else
  connect(port_a, plugFlowCore.port_a)
    annotation (Line(points={{-100,0},{-80,0},{-80,-20},{-20,-20},{-20,0},{-10,0}},
                                                color={0,127,255}));
  end if;
    annotation (Dialog(group="Additional pressurelosses"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics={
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
          points={{0,90},{40,62},{20,62},{20,38},{-20,38},{-20,62},{-40,62},{0,
              90}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,30},{28,-30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187}),
        Text(
          extent={{-100,-72},{100,-88}},
          lineColor={0,0,0},
          textString="L = %length
d = %dh")}),
    Documentation(revisions="<html><ul>
  <li>September 25, 2019, by Nils Neuland:<br/>
    Revised variable names and documentation to follow guidelines.
    Corrected malformed hyperlinks.
  </li>
  <li>October 23, 2017, by Michael Wetter:<br/>
    Revised variable names and documentation to follow guidelines.
    Corrected malformed hyperlinks.
  </li>
  <li>July 4, 2016 by Bram van der Heijde:<br/>
    Introduce pipVol.
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
  the pipe wall. This model determines the pressure drop either through
  a static factor or using the sum of zeta values.
</p>
<h4>
  Implementation
</h4>
<p>
  This model is based on <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore</a>
  and contains the spatialDistribution operator.
</p>
<p>
  The spatialDistribution operator is used for the temperature wave
  propagation through the length of the pipe.
</p>
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
  junctions of pipes can be handled in a numerically efficient way.
</p>
<p>
  This mixing volume is not present in the <a href=
  \"modelica://AixLib.Fluid.FixedResistances.BaseClasses.PlugFlowCore\">PlugFlowCore</a>
  model, which can be used in cases where mixing volumes at pipe
  junctions need to be added manually.
</p>
<p>
  If Boolean use_zeta is set \"true\" <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>
  is used.
</p>
<p>
  <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicResistance\">HydraulicResistance</a>
  takes into account additional pressure drops due to bends/valves/etc.
  Therefore the sum of zeta values has to be given prior.
</p>
<p>
  If Boolean use_zeta is set \"false\" the pressureloss is determine
  through a static factor which has to given prior.
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
  side of the pipe that is connected to <span style=
  \"font-family: Courier New;\">ports_b</span>.
  </li>
</ul>
</html>"));
end PlugFlowPipeZeta;
