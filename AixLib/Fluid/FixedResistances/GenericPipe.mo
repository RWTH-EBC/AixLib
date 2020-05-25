within AixLib.Fluid.FixedResistances;
model GenericPipe
  "Pipe model that includes several selectable pipe models"

  Utilities.HeatTransfer.HeatConv heatConv(hCon=hCon, final A=Modelica.Constants.pi
        *parameterPipe.d_o*length)
    "Convection from insulation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));
  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  parameter String pipeModel="SimplePipe" annotation(choices(
              choice="SimplePipe",
              choice="PlugFlowPipe"),Dialog(enable=true, group="Parameters"));


  parameter Modelica.SIunits.Length length(min=0) "Pipe length";

  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Pipe type"
    annotation (choicesAllMatching=true, Dialog(group="Parameters"));
  parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
      AixLib.DataBase.Pipes.Insulation.Iso0pc() "Insulation Type"
    annotation (choicesAllMatching=true, Dialog(group="Parameters"));


  // Advanced
  parameter Real fac=1
    "Factor to take into account flow resistance of bends etc., fac=dp_nominal/dpStraightPipe_nominal" annotation (Dialog(tab="Advanced"));
  parameter Real ReC=2300
    "Reynolds number where transition to turbulent starts"
                                                          annotation (Dialog(tab="Advanced"));
  parameter Modelica.SIunits.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
                                                                       annotation (Dialog(tab="Advanced"));
  parameter Integer nNodes=3 "Spatial segmentation for SimplePipe" annotation (Dialog(tab="Advanced", enable=pipeModel=="SimplePipe"));
  parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon=4
    "Convection heat transfer coeffient" annotation (Dialog(tab="Advanced"));


  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));



  PlugFlowPipe plugFlowPipe(
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final dh=parameterPipe.d_i,
    final ReC=ReC,
    final roughness=roughness,
    final length=length,
    final m_flow_nominal=m_flow_nominal,
    final dIns=(parameterPipe.d_o - parameterPipe.d_i)/2,
    final kIns=parameterPipe.lambda,
    final cPip=parameterPipe.c,
    final rhoPip=parameterPipe.d,
    final thickness=(parameterPipe.d_o - parameterPipe.d_i)/2,
    final T_start_in=T_start,
    final T_start_out=T_start,
    final fac=fac,          nPorts=1) if pipeModel == "PlugFlowPipe"
    annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
  SimplePipe simplePipe(
    redeclare package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final nNodes=nNodes,
    final dh=parameterPipe.d_i,
                        withHeattransfer=true,
    final length=length,
    final fac=fac,
    final ReC=ReC,
    final roughness=roughness,
    final lambda=parameterPipe.lambda,
    final c=parameterPipe.c,
    final rho=parameterPipe.d,
    final thickness=(parameterPipe.d_o - parameterPipe.d_i)/2,
    final T_start=T_start,
    final m_flow_nominal=m_flow_nominal,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics) if pipeModel == "SimplePipe"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=nNodes) if
       pipeModel == "SimplePipe"
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,14})));

    Utilities.HeatTransfer.CylindricHeatTransfer Insulation(
    energyDynamics=energyDynamics,
    final c=parameterIso.c,
    final d_out=parameterPipe.d_o*parameterIso.factor*2 + parameterPipe.d_o,
    final d_in=parameterPipe.d_o,
    final length=length/nNodes,
    final lambda=parameterIso.lambda,
    final T0=T_start,
    final rho=parameterIso.d,
    final nParallel=1)
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
equation
  connect(simplePipe.heatPorts, thermalCollector.port_a) annotation (Line(
      points={{0,-14.8},{0,4},{-1.33227e-15,4}},
      color={127,0,0},
      pattern=LinePattern.Dash));
  connect(thermalCollector.port_b, Insulation.port_a) annotation (Line(
      points={{1.33227e-15,24},{1.33227e-15,26},{0,26},{0,40}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(plugFlowPipe.heatPort, Insulation.port_a) annotation (Line(
      points={{0,-50},{-20,-50},{-20,40},{0,40}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(plugFlowPipe.port_a, port_a) annotation (Line(
      points={{-10,-60},{-80,-60},{-80,0},{-100,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(plugFlowPipe.ports_b[1], port_b) annotation (Line(
      points={{10,-60},{80,-60},{80,0},{100,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(simplePipe.port_a, port_a) annotation (Line(
      points={{-10,-20},{-60,-20},{-60,0},{-100,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(simplePipe.port_b, port_b) annotation (Line(
      points={{10,-20},{60,-20},{60,0},{100,0}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  connect(heatConv.port_a, heatPort)
    annotation (Line(points={{0,80},{0,100}}, color={191,0,0}));
//          visible=pipeModel=="PlugFlowPipe",
  connect(Insulation.port_b, heatConv.port_b)
    annotation (Line(points={{0,48.8},{0,60}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,32},{100,-32}},
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
          extent={{-100,36},{100,32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.CrossDiag,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-100,-32},{100,-36}},
          lineColor={0,0,0},
          fillPattern=FillPattern.CrossDiag,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-100,52},{100,36}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          extent={{-100,-36},{100,-52}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Forward),
        Rectangle(
          visible=pipeModel=="PlugFlowPipe",
          extent={{-30,32},{28,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={215,202,187}),
        Line(points={{-40,56},{-40,80},{-48,70}}, color={238,46,47}),
        Line(points={{-40,80},{-32,70}}, color={238,46,47}),
        Line(points={{0,56},{0,80},{-8,70}}, color={238,46,47}),
        Line(points={{0,80},{8,70}}, color={238,46,47}),
        Line(points={{40,56},{40,80},{32,70}}, color={238,46,47}),
        Line(points={{40,80},{48,70}}, color={238,46,47})}),     Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This is an easy to use pipe model with predefined parameter reocrds for the diameter, pipe material and insulaton thickness. The model includes different pipe models that can be selected for different use cases:</p>
<p>&quot;SimplePipe&quot;: This pipe can be used for fast calculation (only for small number of elements nNodes) and if the thermal wave propagation can be neglected. Further, this pipe supports a phyiscal heat transfer, thus it can be used for prescribed heat flows or dynamic heat losses to the environment.</p>
<p>&quot;PlugFlowPipe&quot;: This pipe can be used for large pipes where the delay of the thermal wave propagation is relevant. However, this pipe can lead to unphysical heat transfer (e.g. peaks that increase the temperature above or below the allowed range) for small volume flow rates. </p>
</html>", revisions="<html>
<ul>
<li>Mai 14, 2020, by Alexander K&uuml;mpel:<br/>First implementation</li>
</ul>
</html>"));
end GenericPipe;
