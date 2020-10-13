within AixLib.Fluid.MassExchangers.MembraneBasedEnthalpyExchangers.obsolete.BaseClasses;
model AirDuct
  "Model transporting fluid between two ports without storing mass or energy"
  extends Interfaces.PartialTwoPortFlowMassExchange(
    final lengths={i*(lengthDuct/((n + 1)*n/2)) for i in 1:n},
    final crossAreas=fill(heightDuct*widthDuct, n),
    final dimensions=fill(2*heightDuct, n) "characteristic length for pressure drop model?",
    final roughnesses=fill(0.02e-3, n),
    useLumpedPressure=true,
    nParallel=1 "we always use one flow path.",
    flowModel(dp_nominal=dp_nominal, m_flow_nominal=m_flow_nominal),
    X_start={Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p_a_start, T_start)*0.7,1 -
        Modelica.Media.Air.ReferenceMoistAir.Utilities.xws_pT(p_a_start, T_start)*0.7}
      "Start value of mass fractions m_i/m",
    redeclare package Medium = AixLib.Media.Air);

  import Modelica.Fluid.Types.ModelStructure;

  // model for heat transfer
  replaceable model HeatTransfer =
      BaseClasses.HeatTransfer.LocalDuctConvectiveHeatFlow
      "heat transfer model in air duct";

  // model for mass transfer
  replaceable model MassTransfer =
      BaseClasses.MassTransfer.LocalDuctConvectiveMassFlow
      "mass transfer model in air duct";

  // Parameters
  parameter Modelica.SIunits.Area[n] surfaceAreas "Heat transfer areas"
                                                                       annotation(Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length heightDuct "height of duct"
                                                               annotation(Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length widthDuct "width of duct"
                                                             annotation(Dialog(group="Geometry"));
  parameter Modelica.SIunits.Length lengthDuct "height of duct"
                                                               annotation(Dialog(group="Geometry"));

  //flow model parameters
  parameter Modelica.SIunits.Pressure dp_nominal "nominal pressure loss";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal "nominal mass flow rate";

  // Heat and mass transfer parameters
  parameter Boolean UWT "true if UWT(uniform wall temperature) boundary conditions";
  parameter Real C1 "constant C1: 3.24 for UWT(uniform wall temperature), 3.86 for UWF(uniform wall flux)";
  parameter Real C2 "constant C2: 1 for local Nusselt number, 1.5 for average Nusselt number";
  parameter Real C3 "constant C3: 0.409 for UWT, 0.501 for UWF";
  parameter Real C4 "constant C4: 1 for local Nusselt number, 2 for average Nusselt number";

  final parameter Real s[Medium.nXi] = {if Modelica.Utilities.Strings.isEqual(
                                            string1=Medium.substanceNames[i],
                                            string2="Water",
                                            caseSensitive=false)
                                            then 1 else 0 for i in 1:Medium.nXi}
    "Vector with zero everywhere except where species is";

  final parameter Real[n] dxs = lengths/sum(lengths);

  input Modelica.SIunits.SpecificEnthalpy dhAds "adsorption enthalpy";

  Modelica.SIunits.MassFraction[n] Xis;

  // Initialization
  parameter Medium.MassFlowRate m_flow_start = system.m_flow_start
    "Start value for mass flow rate"
     annotation(Evaluate=true, Dialog(tab = "Initialization"));

  //Definition of mean state for heat transfer calculation
  input Medium.ThermodynamicState meanState;
  Medium.ThermodynamicState[n] meanStates;

  // Heat transfer definition
  HeatTransfer heatTransfer(
    redeclare package Medium=Medium,
    n=n,
    lengths=lengths,
    states=fill(meanState,n),
    surfaceAreas={lengths[i] * widthDuct for i in 1:n},
    vs=vs,
    heightsDuct=fill(heightDuct,n),
    widthsDuct=fill(widthDuct,n),
    nParallel=nParallel,
    UWT=UWT,
    C1=C1,
    C2=1.5,
    C3=C3,
    C4=2);

  // Mass transfer definition
  MassTransfer massTransfer(
    redeclare package Medium = Medium,
    n=n,
    lengths=lengths,
    states=mediums.state,
    Xis=Xis,
    surfaceAreas={lengths[i] * widthDuct for i in 1:n},
    vs=vs,
    heightsDuct=fill(heightDuct,n),
    widthsDuct=fill(widthDuct,n),
    nParallel=nParallel,
    UWT=UWT,
    C1=C1,
    C2=C2,
    C3=C3,
    C4=C4);

  Modelica.Fluid.Interfaces.HeatPorts_a[n] heatPorts annotation (Placement(
        transformation(extent={{-50,-108},{-30,-88}}), iconTransformation(
          extent={{-88,-104},{-8,-84}})));
  Interfaces.FlowPort[n] flowPorts annotation (Placement(transformation(extent={{28,-106},{48,-86}})));
protected
  Modelica.SIunits.Temperature[n] meanTs "mean temperature of segments";
  Modelica.SIunits.MassFraction[n] meanXs "mean mass fraction of segments";
  Modelica.SIunits.Pressure[n] meanPs "mean pressure of segments";
equation

  // Source/sink terms for mass and energy balances
   for i in 1:n loop
     mb_flows[i] = m_flows[i] - m_flows[i + 1];
     mbXi_flows[i, :] = mXi_flows[i, :] - mXi_flows[i + 1, :] - flowPorts[i].m_flow * s;
     mbC_flows[i, :]  = mC_flows[i, :]  - mC_flows[i + 1, :];
     Hb_flows[i] = H_flows[i] - H_flows[i + 1] - flowPorts[i].m_flow * dhAds;
   end for;

  Qb_flows = heatTransfer.Q_flows;

   if n == 1 or useLumpedPressure then
     //Wb_flows = dxs * ((vs*dxs)*(crossAreas*dxs)*((port_b.p - port_a.p) + sum(flowModel.dps_fg) - system.g*(dheights*mediums.d)))*nParallel;
     for i in 1:n loop
       Wb_flows[i] = dxs[i] * ((vs[i]*dxs[i])*(crossAreas[i]*dxs[i])*((port_b.p - port_a.p) - system.g*(dheights[i]*mediums[i].d)))*nParallel;
     end for;
   else
     if modelStructure == ModelStructure.av_vb or modelStructure == ModelStructure.av_b then
       Wb_flows[2:n-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i-1]+flowModel.dps_fg[i])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:n-1}*nParallel;
     else
       Wb_flows[2:n-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i]+flowModel.dps_fg[i+1])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:n-1}*nParallel;
     end if;
     if modelStructure == ModelStructure.av_vb then
       Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
       Wb_flows[n] = vs[n]*crossAreas[n]*((mediums[n].p - mediums[n-1].p)/2 + flowModel.dps_fg[n-1]/2 - system.g*dheights[n]*mediums[n].d)*nParallel;
     elseif modelStructure == ModelStructure.av_b then
       Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
       Wb_flows[n] = vs[n]*crossAreas[n]*((port_b.p - mediums[n-1].p)/1.5 + flowModel.dps_fg[n-1]/2+flowModel.dps_fg[n] - system.g*dheights[n]*mediums[n].d)*nParallel;
     elseif modelStructure == ModelStructure.a_vb then
       Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
       Wb_flows[n] = vs[n]*crossAreas[n]*((mediums[n].p - mediums[n-1].p)/2 + flowModel.dps_fg[n]/2 - system.g*dheights[n]*mediums[n].d)*nParallel;
     elseif modelStructure == ModelStructure.a_v_b then
       Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
       Wb_flows[n] = vs[n]*crossAreas[n]*((port_b.p - mediums[n-1].p)/1.5 + flowModel.dps_fg[n]/2+flowModel.dps_fg[n+1] - system.g*dheights[n]*mediums[n].d)*nParallel;
     else
       assert(false, "Unknown model structure");
     end if;
   end if;
  for i in 1:n loop
    Xis[i] * s = mediums[i].Xi;
    flowPorts[i].p = mediums[i].p;
  end for;

  if n == 1 or n == 2 then
    meanTs[1:n]={meanState.T for i in 1:n};
    meanXs[1:n]={meanState.X[1] for i in 1:n};
    meanPs[1:n]={meanState.p for i in 1:n};
  else
    for i in 1:n loop
      meanTs[i]=mediums[i].T;
      meanXs[i]=mediums[i].Xi[1];
      meanPs[i]=mediums[i].p;
    end for;
  end if;

  for i in 1:n loop
    meanStates[i] = Medium.setState_pTX(p=meanPs[i],T=meanTs[i],X={meanXs[i],1-meanXs[i]});
  end for;

  connect(heatPorts, heatTransfer.heatPorts);
  connect(flowPorts, massTransfer.flowPorts);

  annotation (
    preferredView="info",
    Documentation(info="<html><p>
  This model provides the definition of the air duct in a parallel
  membrane enthalpy exchanger. It is based on the <a href=
  \"modelica://MembraneBasedEnthalpyExchanger_KoesterAVT/CrossCounterFlow/DistributedVolumes/Interfaces/PartialTwoPortFlowMassExchange.mo\">
  PartialTwoPortMassExchange</a> model.
</p>
<p>
  The geometry of the air duct is defined in this model. Moreover the
  flow model, such as the convective heat and mass transfer in the air
  duct are part of this model.
</p>
<ul>
  <li>April 23, 2019, by Martin Kremer:<br/>
    Changing mean state definition for heat transfer calculation for n
    &gt; 2.
  </li>
  <li>November 23, 2018, by Martin Kremer:<br/>
    Changing adsorption enthalpy dhAds from parameter to input for
    usage of adsorption enthalpy model.
  </li>
  <li>September 4, 2018, by Martin Kremer:<br/>
    Adding cross-flow coefficient for reduced heat and mass transfer.
  </li>
  <li>August 21, 2018, by Martin Kremer:<br/>
    First Implementation
  </li>
</ul>
</html>"),
    Icon(graphics={
        Line(
          points={{-100,-94},{100,-94}},
          color={0,0,0},
          thickness=1),
        Line(
          points={{-100,80},{100,80}},
          color={0,0,0},
          thickness=1,
          pattern=LinePattern.DashDot),
        Line(
          points={{-100,-94},{-100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=1),
        Line(
          points={{100,-94},{100,100}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=1)}));
end AirDuct;
