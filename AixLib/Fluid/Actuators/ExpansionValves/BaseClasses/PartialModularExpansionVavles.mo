within AixLib.Fluid.Actuators.ExpansionValves.BaseClasses;
partial model PartialModularExpansionVavles
  "Base model for all modular expansion valve models"

  // Definition of parameters describing the modular approach in general
  //
  parameter Integer nVal = 1
    "Number of valves - each valve will be connected to an individual port_b"
    annotation(Dialog(tab="General",group="Modular approach"));

  // Definition of replaceavle expansion valve models
  //
  replaceable BaseClasses.PartialExpansionValve expansionValves[nVal](
    redeclare each final package Medium = Medium,
    AVal=AVal,
    dInlPip=dInlPip,
    useInpFil=useInpFil,
    risTim=risTim,
    calcProc=calcProc,
    mFlowNom=mFlowNom,
    dpNom=dpNom,
    redeclare model FlowCoefficient = FlowCoefficient,
    each allowFlowReversal=allowFlowReversal,
    each dp_start=dp_start,
    m_flow_nominal=mFlowNom) "Array of expansion valves" annotation (
    Placement(transformation(extent={{-10,10},{10,-10}})),
    choicesAllMatching=true,
    Dialog(tab="Expansion valves", group="General"));

  // Definition of parameters describing the expansion valves
  //
  parameter Modelica.SIunits.Area AVal[nVal] = fill(2e-6, nVal)
    "Cross-sectional areas of the valves when they are fully opened"
    annotation(Dialog(tab="Expansion valves",group="Geometry"));
  parameter Modelica.SIunits.Diameter dInlPip[nVal] = fill(7.5e-3, nVal)
    "Diameters of the pipes at valves' inlets"
    annotation(Dialog(tab="Expansion valves",group="Geometry"));

  parameter Boolean useInpFil[nVal] = fill(false, nVal)
    "= true, if transient behaviours of valves opening or closing are computed"
    annotation(Dialog(tab="Expansion valves",group="Transient behaviour"));
  parameter Modelica.SIunits.Time risTim[nVal] = fill(0.5, nVal)
    "Time until valves opening reach 99.6 % of the set values"
    annotation(Dialog(tab="Expansion valves",group="Transient behaviour"));

  parameter Utilities.Choices.CalcProc calcProc[nVal]=
      fill(Utilities.Choices.CalcProc.flowCoefficient,
      nVal) "Chose predefined calculation method for flow coefficients"
    annotation (Dialog(tab="Expansion valves", group="Flow Coefficient"));
  parameter Modelica.SIunits.MassFlowRate mFlowNom[nVal]=
    {m_flow_nominal/sum(AVal)*AVal[i] for i in 1:nVal}
    "Mass flow at nominal conditions"
    annotation(Dialog(
               tab="Expansion valves",
               group="Flow Coefficient",
               enable=if ((calcProc == Utilities.Choices.CalcProc.nominal)
               or (calcProc == Utilities.Choices.CalcProc.flowCoefficient))
               then true else false));
  parameter Modelica.SIunits.PressureDifference dpNom[nVal]=
    fill(dp_nominal, nVal)
    "Pressure drop at nominal conditions"
    annotation(Dialog(
               tab="Expansion valves",
               group="Flow Coefficient",
               enable=if ((calcProc == Utilities.Choices.CalcProc.nominal)
               or (calcProc == Utilities.Choices.CalcProc.flowCoefficient))
               then true else false));

  replaceable model FlowCoefficient =
    Utilities.FlowCoefficient.ConstantFlowCoefficient
    constrainedby BaseClasses.PartialFlowCoefficient
    "Model that describes the calculation of the flow coefficient"
    annotation(choicesAllMatching=true,
               Dialog(
               enable = if (calcProc ==
               Utilities.Choices.CalcProc.flowCoefficient) then true
               else false,
               tab="Expansion valves",
               group="Flow Coefficient"));

  /*Parameters presented above are used to define each element of the 
    expansion valve vector. Therefore, the parameters are identically to the 
    parameters of a simple expension valve aside from the fact that the 
    parameters are introduced as arraies
  */

  // Definition of replaceable controller model
  //
  replaceable
    Controls.HeatPump.ModularHeatPumps.BaseClasses.PartialModularController
    expansionValveController(nVal=nVal) "Model of internal controller"
    annotation (
    Placement(transformation(extent={{-10,-78},{10,-58}})),
    choicesAllMatching=true,
    Dialog(tab="Controller", group="General"));

  // Extends base port model and set base parameters
  //
  extends Fluid.Interfaces.PartialModularPort_b(
    final nPorts=nVal);

  // Definition of connectors
  //
  Controls.Interfaces.ModularExpansionValveBus dataBus(final
      nComp=nVal)
      annotation(Placement(transformation(extent={{-10,-110},{10,-90}}),
                 iconTransformation(extent={{-10,-110},{10,-90}})));

equation
  // Connect port_a with inlet ports of expansion valves
  //
  for i in 1:nVal loop
    connect(port_a,expansionValves[i].port_a);
  end for;

  // Connect data bus and further control signals
  //
  for i in 1:nVal loop
    expansionValveController.opeSet[i] = expansionValves[i].opeSet;
    expansionValves[i].opeAct =expansionValveController.opeAct[i];
  end for;
  connect(expansionValveController.dataBus, dataBus)
    annotation(Line(points={{0,-78},{0,-100}},
               color={0,0,0},
               thickness=0.5));

  annotation (Icon(graphics={
        Polygon(
          points={{0,-50},{-20,-34},{-20,-64},{0,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,-50},{20,-34},{20,-64},{0,-50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-90,0},{-50,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,50},{50,50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-10,-18},{10,-38}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,-18},{10,-38}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,-38},{0,-50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{30,72},{30,-66}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,72},{10,72}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{10,22},{30,22}},
          color={244,125,35},
          thickness=0.5),
        Polygon(
          points={{0,0},{-20,16},{-20,-14},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,0},{20,16},{20,-14},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-10,32},{10,12}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,32},{10,12}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,12},{0,0}},
          color={0,0,0},
          thickness=0.5),
        Polygon(
          points={{0,50},{-20,66},{-20,36},{0,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,50},{20,66},{20,36},{0,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Ellipse(
          extent={{-10,82},{10,62}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-10,82},{10,62}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,62},{0,50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-52,50},{-20,50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,0},{-20,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,-50},{-20,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{-52,50},{-52,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-54,2},{-50,-2}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{10,-28},{30,-28}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{20,0},{90,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{20,-50},{50,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,26},{90,26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,-26},{90,-26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,50},{50,26}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{50,-26},{50,-50}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Rectangle(
          extent={{-20,-70},{20,-90}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Text(
          extent={{-18,-70},{18,-90}},
          lineColor={175,175,175},
          lineThickness=0.5,
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Control"),
        Ellipse(
          extent={{-2,-88},{2,-92}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-2,-68},{2,-72}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Line(
          points={{0,-68},{0,-66}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{0,-92},{0,-96}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{30,-66},{0,-66}},
          color={244,125,35},
          thickness=0.5)}));
end PartialModularExpansionVavles;
