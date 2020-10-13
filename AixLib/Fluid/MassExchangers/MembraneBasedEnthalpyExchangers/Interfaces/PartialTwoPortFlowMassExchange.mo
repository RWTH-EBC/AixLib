within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.Interfaces;
partial model PartialTwoPortFlowMassExchange
  "Base class for distributed flow models with water vapor exchange"

  import Modelica.Fluid.Types.ModelStructure;

  // extending PartialTwoPort
  extends Modelica.Fluid.Interfaces.PartialTwoPort(
    final port_a_exposesState = (modelStructure == ModelStructure.av_b) or (modelStructure == ModelStructure.av_vb),
    final port_b_exposesState = (modelStructure == ModelStructure.a_vb) or (modelStructure == ModelStructure.av_vb));

  // distributed volume model
  extends Modelica.Fluid.Interfaces.PartialDistributedVolume(
     final n=nNodes, final fluidVolumes={crossAreas[i]*lengths[i] for i in 1:n}*nParallel);

  // Geometry parameters
  parameter Real nParallel(min=1)=1
    "Number of identical parallel flow devices"
    annotation(Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length[n] lengths "lengths of flow segments"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.SIunits.Area[n] crossAreas
    "cross flow areas of flow segments" annotation (Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length[n] dimensions
    "hydraulic diameters of flow segments" annotation (Dialog(group="Geometry"));
  parameter Modelica.SIunits.Height[n] roughnesses
    "Average heights of surface asperities"
    annotation (Dialog(group="Geometry"));

  // Static head
  parameter Modelica.SIunits.Length[n] dheights=zeros(n)
    "Differences in heights of flow segments"
    annotation (Dialog(group="Static head"), Evaluate=true);

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balances"
    annotation (Evaluate=true, Dialog(tab="Assumptions", group="Dynamics"));

  // Initialization
  parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
    "Start value for mass flow rate"
     annotation(Evaluate=true, Dialog(tab = "Initialization"));

  // Discretization
  parameter Integer nNodes(min=1)=2 "Number of discrete flow volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);

  parameter ModelStructure modelStructure=ModelStructure.av_vb
    "Determines whether flow or volume models are present at the ports"
    annotation (Dialog(tab="Advanced"), Evaluate=true);

  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  final parameter Integer nFM=if useLumpedPressure then nFMLumped else nFMDistributed
    "number of flow models in flowModel";
  final parameter Integer nFMDistributed=if modelStructure==ModelStructure.a_v_b
    then n+1 else if (modelStructure==ModelStructure.a_vb or modelStructure==ModelStructure.av_b)                                                                                                                                                                       then n else n-1;
  final parameter Integer nFMLumped=if modelStructure==ModelStructure.a_v_b then 2 else 1;
  final parameter Integer iLumped=integer(n/2)+1
    "Index of control volume with representative state if useLumpedPressure"
    annotation(Evaluate=true);

  // Advanced model options
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  Medium.ThermodynamicState state_a
    "state defined by volume outside port_a";
  Medium.ThermodynamicState state_b
    "state defined by volume outside port_b";
  Medium.ThermodynamicState[nFM+1] statesFM
    "state vector for flowModel model";

  // Pressure loss model
  replaceable model FlowModel =
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow
    constrainedby
    Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Wall friction, gravity, momentum flow"
      annotation(Dialog(group="Pressure loss"), choicesAllMatching=true);
  FlowModel flowModel(
    redeclare final package Medium = Medium,
    final n=nFM+1,
    final states=statesFM,
    final vs=vsFM,
    final momentumDynamics=momentumDynamics,
    final allowFlowReversal=allowFlowReversal,
    final p_a_start=p_a_start,
    final p_b_start=p_b_start,
    final m_flow_start=m_flow_start,
    final nParallel=nParallel,
    final pathLengths=pathLengths,
    final crossAreas=crossAreasFM,
    final dimensions=dimensionsFM,
    final roughnesses=roughnessesFM,
    final dheights=dheightsFM,
    final g=system.g) "Flow model"
     annotation (Placement(transformation(extent={{-77,-37},{75,-19}})));

  // Flow quantities
  Medium.MassFlowRate[n+1] m_flows(
     each min=if allowFlowReversal then -Modelica.Constants.inf else 0,
     each start=m_flow_start)
    "Mass flow rates of fluid across segment boundaries";
  Medium.MassFlowRate[n+1, Medium.nXi] mXi_flows
    "Independent mass flow rates across segment boundaries";
  Medium.MassFlowRate[n+1, Medium.nC] mC_flows
    "Trace substance mass flow rates across segment boundaries";
  Medium.EnthalpyFlowRate[n+1] H_flows
    "Enthalpy flow rates of fluid across segment boundaries";

   Modelica.SIunits.Velocity[n] vs={0.5*(m_flows[i] + m_flows[i + 1])/mediums[i].d
       /crossAreas[i] for i in 1:n}/nParallel "mean velocities in flow segments";
//   //** changed to hard-coded density due to initializing problems
//   Modelica.SIunits.Velocity[n] vs={0.5*(m_flows[i] + m_flows[i + 1])/1.21
//       /crossAreas[i] for i in 1:n}/nParallel "mean velocities in flow segments";

  // Model structure dependent flow geometry
protected
  Modelica.SIunits.Length[nFM] pathLengths "Lengths along flow path";
  Modelica.SIunits.Length[nFM] dheightsFM
    "Differences in heights between flow segments";
  Modelica.SIunits.Area[nFM + 1] crossAreasFM
    "Cross flow areas of flow segments";
  Modelica.SIunits.Velocity[nFM + 1] vsFM "Mean velocities in flow segments";
  Modelica.SIunits.Length[nFM + 1] dimensionsFM
    "Hydraulic diameters of flow segments";
  Modelica.SIunits.Height[nFM + 1] roughnessesFM
    "Average heights of surface asperities";

equation
  assert(nNodes > 1 or modelStructure <> ModelStructure.av_vb,
     "nNodes needs to be at least 2 for modelStructure av_vb, as flow model disappears otherwise!");
  // staggered grid discretization of geometry for flowModel, depending on modelStructure
  if useLumpedPressure then
    if modelStructure <> ModelStructure.a_v_b then
      pathLengths[1] = sum(lengths);
      dheightsFM[1] = sum(dheights);
      if n == 1 then
        crossAreasFM[1:2] = {crossAreas[1], crossAreas[1]};
        dimensionsFM[1:2] = {dimensions[1], dimensions[1]};
        roughnessesFM[1:2] = {roughnesses[1], roughnesses[1]};
      else // n > 1
        crossAreasFM[1:2] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas[iLumped:n])/(n-iLumped+1)};
        dimensionsFM[1:2] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions[iLumped:n])/(n-iLumped+1)};
        roughnessesFM[1:2] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses[iLumped:n])/(n-iLumped+1)};
      end if;
    else
      if n == 1 then
        pathLengths[1:2] = {lengths[1]/2, lengths[1]/2};
        dheightsFM[1:2] = {dheights[1]/2, dheights[1]/2};
        crossAreasFM[1:3] = {crossAreas[1], crossAreas[1], crossAreas[1]};
        dimensionsFM[1:3] = {dimensions[1], dimensions[1], dimensions[1]};
        roughnessesFM[1:3] = {roughnesses[1], roughnesses[1], roughnesses[1]};
      else // n > 1
        pathLengths[1:2] = {sum(lengths[1:iLumped-1]), sum(lengths[iLumped:n])};
        dheightsFM[1:2] = {sum(dheights[1:iLumped-1]), sum(dheights[iLumped:n])};
        crossAreasFM[1:3] = {sum(crossAreas[1:iLumped-1])/(iLumped-1), sum(crossAreas)/n, sum(crossAreas[iLumped:n])/(n-iLumped+1)};
        dimensionsFM[1:3] = {sum(dimensions[1:iLumped-1])/(iLumped-1), sum(dimensions)/n, sum(dimensions[iLumped:n])/(n-iLumped+1)};
        roughnessesFM[1:3] = {sum(roughnesses[1:iLumped-1])/(iLumped-1), sum(roughnesses)/n, sum(roughnesses[iLumped:n])/(n-iLumped+1)};
      end if;
    end if;
  else
    if modelStructure == ModelStructure.av_vb then
      //nFM = n-1
      if n == 2 then
        pathLengths[1] = lengths[1] + lengths[2];
        dheightsFM[1] = dheights[1] + dheights[2];
      else
        pathLengths[1:n-1] = cat(1, {lengths[1] + 0.5*lengths[2]}, 0.5*(lengths[2:n-2] + lengths[3:n-1]), {0.5*lengths[n-1] + lengths[n]});
        dheightsFM[1:n-1] = cat(1, {dheights[1] + 0.5*dheights[2]}, 0.5*(dheights[2:n-2] + dheights[3:n-1]), {0.5*dheights[n-1] + dheights[n]});
      end if;
      crossAreasFM[1:n] = crossAreas;
      dimensionsFM[1:n] = dimensions;
      roughnessesFM[1:n] = roughnesses;
    elseif modelStructure == ModelStructure.av_b then
      //nFM = n
      pathLengths[1:n] = lengths;
      dheightsFM[1:n] = dheights;
      crossAreasFM[1:n+1] = cat(1, crossAreas[1:n], {crossAreas[n]});
      dimensionsFM[1:n+1] = cat(1, dimensions[1:n], {dimensions[n]});
      roughnessesFM[1:n+1] = cat(1, roughnesses[1:n], {roughnesses[n]});
    elseif modelStructure == ModelStructure.a_vb then
      //nFM = n
      pathLengths[1:n] = lengths;
      dheightsFM[1:n] = dheights;
      crossAreasFM[1:n+1] = cat(1, {crossAreas[1]}, crossAreas[1:n]);
      dimensionsFM[1:n+1] = cat(1, {dimensions[1]}, dimensions[1:n]);
      roughnessesFM[1:n+1] = cat(1, {roughnesses[1]}, roughnesses[1:n]);
    elseif modelStructure == ModelStructure.a_v_b then
      //nFM = n+1;
      pathLengths[1:n+1] = cat(1, {0.5*lengths[1]}, 0.5*(lengths[1:n-1] + lengths[2:n]), {0.5*lengths[n]});
      dheightsFM[1:n+1] = cat(1, {0.5*dheights[1]}, 0.5*(dheights[1:n-1] + dheights[2:n]), {0.5*dheights[n]});
      crossAreasFM[1:n+2] = cat(1, {crossAreas[1]}, crossAreas[1:n], {crossAreas[n]});
      dimensionsFM[1:n+2] = cat(1, {dimensions[1]}, dimensions[1:n], {dimensions[n]});
      roughnessesFM[1:n+2] = cat(1, {roughnesses[1]}, roughnesses[1:n], {roughnesses[n]});
    else
      assert(false, "Unknown model structure");
    end if;
  end if;

  // Distributed flow quantities, upwind discretization
  for i in 2:n loop
    H_flows[i] = semiLinear(m_flows[i], mediums[i - 1].h, mediums[i].h);
    mXi_flows[i, :] = semiLinear(m_flows[i], mediums[i - 1].Xi, mediums[i].Xi);
    mC_flows[i, :]  = semiLinear(m_flows[i], Cs[i - 1, :],         Cs[i, :]);
  end for;
  H_flows[1] = semiLinear(port_a.m_flow, inStream(port_a.h_outflow), mediums[1].h);
  H_flows[n + 1] = -semiLinear(port_b.m_flow, inStream(port_b.h_outflow), mediums[n].h);
  mXi_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.Xi_outflow), mediums[1].Xi);
  mXi_flows[n + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.Xi_outflow), mediums[n].Xi);
  mC_flows[1, :] = semiLinear(port_a.m_flow, inStream(port_a.C_outflow), Cs[1, :]);
  mC_flows[n + 1, :] = -semiLinear(port_b.m_flow, inStream(port_b.C_outflow), Cs[n, :]);

  // Boundary conditions
  port_a.m_flow    = m_flows[1];
  port_b.m_flow    = -m_flows[n + 1];
  port_a.h_outflow = mediums[1].h;
  port_b.h_outflow = mediums[n].h;
  port_a.Xi_outflow = mediums[1].Xi;
  port_b.Xi_outflow = mediums[n].Xi;
  port_a.C_outflow = Cs[1, :];
  port_b.C_outflow = Cs[n, :];

  if useInnerPortProperties and n > 0 then
    state_a = Medium.setState_phX(port_a.p, mediums[1].h, mediums[1].Xi);
    state_b = Medium.setState_phX(port_b.p, mediums[n].h, mediums[n].Xi);
  else
    state_a = Medium.setState_phX(port_a.p, inStream(port_a.h_outflow), inStream(port_a.Xi_outflow));
    state_b = Medium.setState_phX(port_b.p, inStream(port_b.h_outflow), inStream(port_b.Xi_outflow));
  end if;

  // staggered grid discretization for flowModel, depending on modelStructure
  if useLumpedPressure then
    if modelStructure <> ModelStructure.av_vb then
      // all pressures are equal
      fill(mediums[1].p, n-1) = mediums[2:n].p;
    elseif n > 2 then
      // need two pressures
      fill(mediums[1].p, iLumped-2) = mediums[2:iLumped-1].p;
      fill(mediums[n].p, n-iLumped) = mediums[iLumped:n-1].p;
    end if;
    if modelStructure == ModelStructure.av_vb then
      port_a.p = mediums[1].p;
      statesFM[1] = mediums[1].state;
      m_flows[iLumped] = flowModel.m_flows[1];
      statesFM[2] = mediums[n].state;
      port_b.p = mediums[n].p;
      vsFM[1] = vs[1:iLumped-1]*lengths[1:iLumped-1]/sum(lengths[1:iLumped-1]);
      vsFM[2] = vs[iLumped:n]*lengths[iLumped:n]/sum(lengths[iLumped:n]);
    elseif modelStructure == ModelStructure.av_b then
      port_a.p = mediums[1].p;
      statesFM[1] = mediums[iLumped].state;
      statesFM[2] = state_b;
      m_flows[n+1] = flowModel.m_flows[1];
      vsFM[1] = vs*lengths/sum(lengths);
      vsFM[2] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
    elseif modelStructure == ModelStructure.a_vb then
      m_flows[1] = flowModel.m_flows[1];
      statesFM[1] = state_a;
      statesFM[2] = mediums[iLumped].state;
      port_b.p = mediums[n].p;
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2] = vs*lengths/sum(lengths);
    elseif modelStructure == ModelStructure.a_v_b then
      m_flows[1] = flowModel.m_flows[1];
      statesFM[1] = state_a;
      statesFM[2] = mediums[iLumped].state;
      statesFM[3] = state_b;
      m_flows[n+1] = flowModel.m_flows[2];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2] = vs*lengths/sum(lengths);
      vsFM[3] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
    else
      assert(false, "Unknown model structure");
    end if;
  else
    if modelStructure == ModelStructure.av_vb then
      //nFM = n-1
      statesFM[1:n] = mediums[1:n].state;
      m_flows[2:n] = flowModel.m_flows[1:n-1];
      vsFM[1:n] = vs;
      port_a.p = mediums[1].p;
      port_b.p = mediums[n].p;
    elseif modelStructure == ModelStructure.av_b then
      //nFM = n
      statesFM[1:n] = mediums[1:n].state;
      statesFM[n+1] = state_b;
      m_flows[2:n+1] = flowModel.m_flows[1:n];
      vsFM[1:n] = vs;
      vsFM[n+1] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
      port_a.p = mediums[1].p;
    elseif modelStructure == ModelStructure.a_vb then
      //nFM = n
      statesFM[1] = state_a;
      statesFM[2:n+1] = mediums[1:n].state;
      m_flows[1:n] = flowModel.m_flows[1:n];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2:n+1] = vs;
      port_b.p = mediums[n].p;
    elseif modelStructure == ModelStructure.a_v_b then
      //nFM = n+1
      statesFM[1] = state_a;
      statesFM[2:n+1] = mediums[1:n].state;
      statesFM[n+2] = state_b;
      m_flows[1:n+1] = flowModel.m_flows[1:n+1];
      vsFM[1] = m_flows[1]/Medium.density(state_a)/crossAreas[1]/nParallel;
      vsFM[2:n+1] = vs;
      vsFM[n+2] = m_flows[n+1]/Medium.density(state_b)/crossAreas[n]/nParallel;
    else
      assert(false, "Unknown model structure");
    end if;
  end if;

  annotation (defaultComponentName="pipe",
Documentation(info="<html><p>
  Base class for distributed flow models. The total volume is split
  into nNodes segments along the flow path. The default value is
  nNodes=2.
</p>
<h4>
  Mass and Energy balances
</h4>
<p>
  The mass and energy balances are inherited from <a href=
  \"modelica://Modelica.Fluid.Interfaces.PartialDistributedVolume\">Interfaces.PartialDistributedVolume</a>.
  One total mass and one energy balance is formed across each segment
  according to the finite volume approach. Substance mass balances are
  added if the medium contains more than one component.
</p>
<p>
  An extending model needs to define the geometry and the difference in
  heights between the flow segments (static head). Moreover it needs to
  define two vectors of source terms for the distributed energy
  balance:
</p>
<ul>
  <li>
    <code><b>Qb_flows[nNodes]</b></code>, the heat flow source terms,
    e.g., conductive heat flows across segment boundaries, and
  </li>
  <li>
    <code><b>Wb_flows[nNodes]</b></code>, the work source terms.
  </li>
</ul>
<h4>
  Momentum balance
</h4>
<p>
  The momentum balance is determined by the
  <b><code>FlowModel</code></b> component, which can be replaced with
  any model extended from <a href=
  \"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel\">
  BaseClasses.FlowModels.PartialStaggeredFlowModel</a>. The default
  setting is <a href=
  \"modelica://Modelica.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow\">
  DetailedPipeFlow</a>.
</p>
<p>
  This considers
</p>
<ul>
  <li>pressure drop due to friction and other dissipative losses, and
  </li>
  <li>gravity effects for non-horizontal devices.
  </li>
  <li>variation of flow velocity along the flow path, which occur due
  to changes in the cross sectional area or the fluid density, provided
  that <code>flowModel.use_Ib_flows</code> is true.
  </li>
</ul>
<h4>
  Model Structure
</h4>
<p>
  The momentum balances are formulated across the segment boundaries
  along the flow path according to the staggered grid approach. The
  configurable <b><code>modelStructure</code></b> determines the
  formulation of the boundary conditions at <code>port_a</code> and
  <code>port_b</code>. The options include (default: av_vb):
</p>
<ul>
  <li>
    <code>av_vb</code>: Symmetric setting with nNodes-1 momentum
    balances between nNodes flow segments. The ports
    <code>port_a</code> and <code>port_b</code> expose the first and
    the last thermodynamic state, respectively. Connecting two or more
    flow devices therefore may result in high-index DAEs for the
    pressures of connected flow segments.
  </li>
  <li>
    <code>a_v_b</code>: Alternative symmetric setting with nNodes+1
    momentum balances across nNodes flow segments. Half momentum
    balances are placed between <code>port_a</code> and the first flow
    segment as well as between the last flow segment and
    <code>port_b</code>. Connecting two or more flow devices therefore
    results in algebraic pressures at the ports. The specification of
    good start values for the port pressures is essential for the
    solution of large nonlinear equation systems.
  </li>
  <li>
    <code>av_b</code>: Asymmetric setting with nNodes momentum
    balances, one between nth volume and <code>port_b</code>, potential
    pressure state at <code>port_a</code>
  </li>
  <li>
    <code>a_vb</code>: Asymmetric setting with nNodes momentum balance,
    one between first volume and <code>port_a</code>, potential
    pressure state at <code>port_b</code>
  </li>
</ul>
<p>
  When connecting two components, e.g., two pipes, the momentum balance
  across the connection point reduces to
</p>
<pre>pipe1.port_b.p = pipe2.port_a.p</pre>
<p>
  This is only true if the flow velocity remains the same on each side
  of the connection. Consider using a fitting for any significant
  change in diameter or fluid density, if the resulting effects, such
  as change in kinetic energy, cannot be neglected. This also allows
  for taking into account friction losses with respect to the actual
  geometry of the connection point.
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>5 Dec 2008</i> by Michael Wetter:<br/>
    Modified mass balance for trace substances. With the new
    formulation, the trace substances masses <code>mC</code> are stored
    in the same way as the species <code>mXi</code>.
  </li>
  <li>
    <i>Dec 2008</i> by Rüdiger Franke:<br/>
    Derived model from original DistributedPipe models
    <ul>
      <li>moved mass and energy balances to PartialDistributedVolume
      </li>
      <li>introduced replaceable pressure loss models
      </li>
      <li>combined all model structures and lumped pressure into one
      model
      </li>
      <li>new ModelStructure av_vb, replacing former avb
      </li>
    </ul>
  </li>
  <li>
    <i>04 Mar 2006</i> by Katrin Prölß:<br/>
    Model added to the Fluid library
  </li>
</ul>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{100,
            100}}), graphics={Ellipse(
          extent={{-72,10},{-52,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},{
            100,100}}), graphics={
        Polygon(
          points={{-100,-50},{-100,50},{100,60},{100,-60},{-100,-50}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Polygon(
          points={{-34,-53},{-34,53},{34,57},{34,-57},{-34,-53}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None,
          lineColor={0,0,0}),
        Line(
          points={{-100,-50},{-100,50}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Text(
          extent={{-99,36},{-69,30}},
          lineColor={0,0,255},
          textString="crossAreas[1]"),
        Line(
          points={{-100,70},{-34,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Text(
          extent={{0,36},{40,30}},
          lineColor={0,0,255},
          textString="crossAreas[2:n-1]"),
        Line(
          points={{100,-60},{100,60}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Text(
          extent={{100.5,36},{130.5,30}},
          lineColor={0,0,255},
          textString="crossAreas[n]"),
        Line(
          points={{-34,52},{-34,-53}},
          pattern=LinePattern.Dash),
        Line(
          points={{34,57},{34,-57}},
          pattern=LinePattern.Dash),
        Line(
          points={{34,70},{100,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Line(
          points={{-34,70},{34,70}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Text(
          extent={{-30,77},{30,71}},
          lineColor={0,0,255},
          textString="lengths[2:n-1]"),
        Line(
          points={{-100,-70},{0,-70}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-80,-63},{-20,-69}},
          lineColor={0,0,255},
          textString="flowModel.dps_fg[1]"),
        Line(
          points={{0,-70},{100,-70}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{20.5,-63},{80,-69}},
          lineColor={0,0,255},
          textString="flowModel.dps_fg[2:n-1]"),
        Line(
          points={{-95,0},{-5,0}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-62,7},{-32,1}},
          lineColor={0,0,255},
          textString="m_flows[2]"),
        Line(
          points={{5,0},{95,0}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{34,7},{64,1}},
          lineColor={0,0,255},
          textString="m_flows[3:n]"),
        Line(
          points={{-150,0},{-105,0}},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{105,0},{150,0}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-140,7},{-110,1}},
          lineColor={0,0,255},
          textString="m_flows[1]"),
        Text(
          extent={{111,7},{141,1}},
          lineColor={0,0,255},
          textString="m_flows[n+1]"),
        Text(
          extent={{35,-92},{100,-98}},
          lineColor={0,0,255},
          textString="(ModelStructure av_vb, n=3)"),
        Line(
          points={{-100,-50},{-100,-86}},
          pattern=LinePattern.Dot),
        Line(
          points={{0,-55},{0,-86}},
          pattern=LinePattern.Dot),
        Line(
          points={{100,-60},{100,-86}},
          pattern=LinePattern.Dot),
        Ellipse(
          extent={{-5,5},{5,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{3,-4},{33,-10}},
          lineColor={0,0,255},
          textString="states[2:n-1]"),
        Ellipse(
          extent={{95,5},{105,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{104,-4},{124,-10}},
          lineColor={0,0,255},
          textString="states[n]"),
        Ellipse(
          extent={{-105,5},{-95,-5}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-96,-4},{-76,-10}},
          lineColor={0,0,255},
          textString="states[1]"),
        Text(
          extent={{-99.5,30},{-69.5,24}},
          lineColor={0,0,255},
          textString="dimensions[1]"),
        Text(
          extent={{-0.5,30},{40,24}},
          lineColor={0,0,255},
          textString="dimensions[2:n-1]"),
        Text(
          extent={{100.5,30},{130.5,24}},
          lineColor={0,0,255},
          textString="dimensions[n]"),
        Line(
          points={{-34,73},{-34,52}},
          pattern=LinePattern.Dot),
        Line(
          points={{34,73},{34,57}},
          pattern=LinePattern.Dot),
        Line(
          points={{-100,50},{100,60}},
          thickness=0.5),
        Line(
          points={{-100,-50},{100,-60}},
          thickness=0.5),
        Line(
          points={{-100,73},{-100,50}},
          pattern=LinePattern.Dot),
        Line(
          points={{100,73},{100,60}},
          pattern=LinePattern.Dot),
        Line(
          points={{0,-55},{0,55}},
          arrow={Arrow.Filled,Arrow.Filled},
          pattern=LinePattern.Dot),
        Line(
          points={{-34,11},{34,11}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{5,18},{25,12}},
          lineColor={0,0,255},
          textString="vs[2:n-1]"),
        Text(
          extent={{-72,18},{-62,12}},
          lineColor={0,0,255},
          textString="vs[1]"),
        Line(
          points={{-100,11},{-34,11}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{63,18},{73,12}},
          lineColor={0,0,255},
          textString="vs[n]"),
        Line(
          points={{34,11},{100,11}},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-80,-75},{-20,-81}},
          lineColor={0,0,255},
          textString="flowModel.pathLengths[1]"),
        Line(
          points={{-100,-82},{0,-82}},
          arrow={Arrow.Filled,Arrow.Filled}),
        Line(
          points={{0,-82},{100,-82}},
          arrow={Arrow.Filled,Arrow.Filled}),
        Text(
          extent={{15,-75},{85,-81}},
          lineColor={0,0,255},
          textString="flowModel.pathLengths[2:n-1]"),
        Text(
          extent={{-100,77},{-37,71}},
          lineColor={0,0,255},
          textString="lengths[1]"),
        Text(
          extent={{34,77},{100,71}},
          lineColor={0,0,255},
          textString="lengths[n]")}));
end PartialTwoPortFlowMassExchange;
