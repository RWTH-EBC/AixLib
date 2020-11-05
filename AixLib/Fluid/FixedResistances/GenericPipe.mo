within AixLib.Fluid.FixedResistances;
model GenericPipe
  "Pipe model that includes several selectable pipe models"

  extends AixLib.Fluid.Interfaces.PartialTwoPort;

  parameter String pipeModel="SimplePipe" annotation(choices(
              choice="SimplePipe",
              choice="PlugFlowPipe"),Dialog(enable=true, group="Parameters"));

  parameter AixLib.DataBase.Pipes.PipeBaseDataDefinition parameterPipe=
      AixLib.DataBase.Pipes.Copper.Copper_6x1() "Pipe type"
    annotation (choicesAllMatching=true, Dialog(group="Parameters"));

  parameter Modelica.SIunits.Length length(min=0) "Pipe length";

  parameter Boolean withInsulation=true "Pipe with or without insulation" annotation (Dialog(group="Heat Transfer"),choices(checkBox=true));

  parameter AixLib.DataBase.Pipes.InsulationBaseDataDefinition parameterIso=
      AixLib.DataBase.Pipes.Insulation.Iso50pc() "Insulation Type"
    annotation (choicesAllMatching=true, Dialog(enable=withInsulation==true,group="Heat Transfer"));

  parameter Boolean withConvection=true "convectional heat transfer" annotation (Dialog(group="Heat Transfer"),choices(checkBox=true));

  parameter Modelica.SIunits.CoefficientOfHeatTransfer hCon=4
    "Convection heat transfer coeffient" annotation (choicesAllMatching=true, Dialog(enable=withConvection==true,group="Heat Transfer"));

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate" annotation (Dialog(group="Nominal condition"));

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

  // Assumptions
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true, Dialog(tab="Dynamics", group="Equations"));

  // Initialization
  parameter Modelica.SIunits.Temperature T_start=Medium.T_default
    "Initialization temperature at pipe inlet"
    annotation (Dialog(tab="Initialization"));

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
    redeclare final package Medium = Medium,
    final allowFlowReversal=allowFlowReversal,
    final nNodes=nNodes,
    final dh=parameterPipe.d_i,
    final withHeattransfer=true,
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
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(
    final m=nNodes) if
       pipeModel == "SimplePipe"
                annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,14})));

    Utilities.HeatTransfer.CylindricHeatTransfer Insulation(
    final energyDynamics=energyDynamics,
    final c=parameterIso.c,
    final d_out=parameterPipe.d_o*parameterIso.factor*2 + parameterPipe.d_o,
    final d_in=parameterPipe.d_o,
    final length=length/nNodes,
    final lambda=parameterIso.lambda,
    final T0=T_start,
    final rho=parameterIso.d,
    final nParallel=1) if withInsulation
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Utilities.HeatTransfer.HeatConv heatConv(
    final hCon=hCon,
    final A=Modelica.Constants.pi*parameterPipe.d_o*length) if withConvection
    "Convection from insulation" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,70})));

  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalPassthroughInsulation(final m=1) if
       not withInsulation annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,42})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalPassthroughConvection(final m=1)
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-32,70})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort "Heat port at outside surface of pipe"
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
    annotation (Line(points={{1.77636e-15,80},{1.77636e-15,90},{0,90},{0,100}},
                                              color={191,0,0}));
  connect(Insulation.port_b, heatConv.port_b)
    annotation (Line(points={{0,48.8},{0,60},{-1.77636e-15,60}},
                                               color={191,0,0}));
  connect(plugFlowPipe.heatPort, thermalPassthroughInsulation.port_a[1])
    annotation (Line(
      points={{0,-50},{-32,-50},{-32,32}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermalCollector.port_b, thermalPassthroughInsulation.port_a[1])
    annotation (Line(
      points={{1.33227e-15,24},{-32,24},{-32,32}},
      color={191,0,0},
      pattern=LinePattern.Dash));
  connect(thermalPassthroughInsulation.port_b, thermalPassthroughConvection.port_a[1]) annotation (Line(points={{-32,52},{-32,60}}, color={191,0,0}));
  connect(thermalPassthroughConvection.port_b, heatPort) annotation (Line(points={{-32,80},{-32,100},{0,100}}, color={191,0,0}));
  connect(thermalPassthroughInsulation.port_b, heatConv.port_b) annotation (
      Line(points={{-32,52},{0,52},{0,60},{-1.77636e-15,60}}, color={191,0,0}));
  connect(Insulation.port_b, thermalPassthroughConvection.port_a[1]) annotation (Line(points={{0,48.8},{0,56},{-32,56},{-32,60}}, color={191,0,0}));
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
    Documentation(info="<html><p>
  This is an easy-to-use pipe model with predefined parameter records
  for the diameter, pipe material and insulaton thickness. The model
  includes different pipe models that can be selected for different use
  cases:
</p>
<p>
  <a href=
  \"modelica://AixLib/Fluid/FixedResistances/SimplePipe.mo\">SimplePipe</a>:
  This pipe can be used for fast calculation (only for small number of
  elements nNodes) and if the thermal wave propagation can be
  neglected. Further, this pipe supports a phyiscal heat transfer, thus
  it can be used for prescribed heat flows or dynamic heat losses to
  the environment.
</p>
<p>
  <a href=
  \"modelica://AixLib/Fluid/FixedResistances/PlugFlowPipe.mo\">PlugFlowPipe</a>:
  This pipe can be used for large pipes where the delay of the thermal
  wave propagation is relevant. However, this pipe can lead to
  unphysical heat transfer (e.g. peaks that increase the temperature
  above or below the allowed range) for small volume flow rates.
</p>
</html>", revisions="<html>
<ul>
  <li>August 12, 2020, by Alexander Kümpel:<br/>
    <a href=\"https://github.com/RWTH-EBC/AixLib/issues/910\">#910</a>
    Make insulation and heat convection optional
  </li>
  <li>Mai 14, 2020, by Alexander Kümpel:<br/>
    First implementation
  </li>
</ul>
</html>"));
end GenericPipe;
