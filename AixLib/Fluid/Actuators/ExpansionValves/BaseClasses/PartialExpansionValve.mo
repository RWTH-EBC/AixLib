within AixLib.Fluid.Actuators.ExpansionValves.BaseClasses;
partial model PartialExpansionValve
  "Base model for all expansion valve models"

  // Definition of parameters
  //
  parameter Modelica.SIunits.Area AVal = 2.5e-6
    "Cross-sectional area of the valve when it is fully opened"
    annotation(Dialog(group="Geometry"));
  parameter Modelica.SIunits.Diameter dInlPip = 7.5e-3
    "Diameter of the pipe at valve's inlet"
    annotation(Dialog(group="Geometry"));

  parameter Boolean useInpFil = true
    "= true, if transient behaviour of valve opening or closing is computed"
    annotation(Dialog(group="Transient behaviour"));
  parameter Modelica.SIunits.Time risTim = 0.5
    "Time until valve opening reaches 99.6 % of its set value"
    annotation(Dialog(
      enable = useInpFil,
      group="Transient behaviour"));

  parameter Utilities.Choices.CalcProc calcProc=Utilities.Choices.CalcProc.nominal
    "Chose predefined calculation method for flow coefficient"
    annotation (Dialog(tab="Flow Coefficient"));
  parameter Modelica.SIunits.MassFlowRate mFlowNom = m_flow_nominal
    "Mass flow at nominal conditions"
    annotation(Dialog(
               tab="Flow Coefficient",
               group="Nominal calculation",
               enable=if ((calcProc == Utilities.Choices.CalcProc.nominal) or (
          calcProc == Utilities.Choices.CalcProc.flowCoefficient)) then true
           else false));
  parameter Modelica.SIunits.PressureDifference dpNom = 15e5
    "Pressure drop at nominal conditions"
    annotation(Dialog(
               tab="Flow Coefficient",
               group="Nominal calculation",
               enable=if ((calcProc == Utilities.Choices.CalcProc.nominal) or (
          calcProc == Utilities.Choices.CalcProc.flowCoefficient)) then true
           else false));

  // Definition of model describing flow coefficient
  //
  replaceable model FlowCoefficient =
    Utilities.FlowCoefficient.ConstantFlowCoefficient constrainedby
    PartialFlowCoefficient
    "Model that describes the calculation of the flow coefficient"
    annotation(choicesAllMatching=true,
               Dialog(
               enable = if (calcProc ==
               Utilities.Choices.CalcProc.flowCoefficient) then true
               else false,
               tab="Flow Coefficient",
               group="Flow coefficient model"));

  // Extends from partial two port (insert here for position of tabs)
  //
  extends AixLib.Fluid.Interfaces.PartialTwoPortTransport(
    redeclare replaceable package Medium =
        Modelica.Media.Interfaces.PartialTwoPhaseMedium,
    show_T = false,
    show_V_flow = false,
    dp_start = 1e6,
    m_flow_start = 0.5*m_flow_nominal,
    m_flow_small = 1e-6*m_flow_nominal);

  // Definition of parameters describing diagnostic options
  //
  parameter Medium.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate"
    annotation(Dialog(tab = "Advanced"));
  parameter Boolean show_flow_coefficient = true
    "= true, if flow coefficient model is computed"
    annotation(Dialog(
               tab="Advanced",
               group="Diagnostics"));
  parameter Boolean show_staInl = true
    "= true, if thermodynamic state at valve's inlet is computed"
    annotation(Dialog(
               tab="Advanced",
               group="Diagnostics"));
  parameter Boolean show_staOut = false
    "= true, if thermodynamic state at valve's outlet is computed"
    annotation(Dialog(
               tab="Advanced",
               group="Diagnostics"));

  // Definition of variables
  //
  Medium.ThermodynamicState staInl
    "Thermodynamic state of the fluid at inlet condtions"
    annotation(HideResult = (if show_staInl then false else true));
  Medium.ThermodynamicState staOut
    "Thermodynamic state of the fluid at outlet condtions"
    annotation(HideResult = (if show_staOut then false else true));
  FlowCoefficient flowCoefficient(
    redeclare package Medium = Medium,
    opening = opening,
    AVal = AVal,
    dInlPip = dInlPip,
    staInl = staInl,
    staOut = staOut,
    pInl = pInl,
    pOut = pOut)
    "Instance of model 'flow coefficient'";
     //annotation(HideResult = (if show_flow_coefficient then false else true));
  Real C "Flow coefficient used to calculate mass flow and pressure drop";

  // Definition of connectors and submodels
  //
  Modelica.Blocks.Interfaces.RealInput opeSet(min=0, max=1)
    "Prescribed expansion valve's opening" annotation (Placement(transformation(
        extent={{16,-16},{-16,16}},
        rotation=90,
        origin={-50,106})));
  Modelica.Blocks.Interfaces.RealOutput opeAct(min=0, max=1)
    "Actual expansion valve's opening" annotation (Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=90,
        origin={51,105})));
  Modelica.Blocks.Continuous.Filter filterOpening(
    final analogFilter=Modelica.Blocks.Types.AnalogFilter.CriticalDamping,
    final filterType=Modelica.Blocks.Types.FilterType.LowPass,
    order=2,
    f_cut=5/(2*Modelica.Constants.pi*risTim),
    x(each stateSelect=StateSelect.always)) if
        useInpFil
    "Second order filter to approximate valve opening or closing time"
    annotation (Placement(transformation(
        extent={{-30,59},{-10,80}})));
  Modelica.Blocks.Routing.RealPassThrough openingThrough
    "Dummy passing through of opening signal to allow usage of filter"
    annotation (Placement(transformation(
      extent={{10,60},{30,80}})));

protected
  Modelica.SIunits.Area AThr
    "Actual cross-sectional area of the valve";
  Real opening(unit="1")
    "Actual valve's opening";

  Modelica.SIunits.Density dInl = Medium.density(staInl)
    "Density at valves's inlet conditions";
  Modelica.SIunits.AbsolutePressure pInl = port_a.p
    "Pressure of the fluid at inlet conditions";
  Modelica.SIunits.AbsolutePressure pOut = port_b.p
    "Pressure of the fluid at outlet conditions";

equation
  // Calculation of thermodynamic states
  //
  staInl = Medium.setState_phX(port_a.p,
    inStream(port_a.h_outflow), inStream(port_a.Xi_outflow))
    "Thermodynamic state of the fluid at inlet condtions";
  staOut = Medium.setState_phX(port_b.p,
    port_b.h_outflow, port_b.Xi_outflow)
    "Thermodynamic state of the fluid at outlet condtions";

  // Calculation of valve's opening degree
  //
  connect(filterOpening.u, opeSet);
  if useInpFil then
    connect(openingThrough.u, filterOpening.y)
      "Transient behaviour of valve opening";
  else
    connect(openingThrough.u, opeSet)
      "No transient behaiviour of valve opnening";
  end if;
  opening = openingThrough.y "Actual valve's opening";

  // Calculation of active cross-sectional flow area
  //
  AThr = opening * AVal "Actual cross-sectional area of the valve";

  // Calculation of outputs
  //
  opeAct = opening "No delay to change the valve opening";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{0,0},{-40,30},{-40,-30},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Polygon(
          points={{0,0},{40,30},{40,-30},{0,0}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          lineThickness=0.5),
        Line(
          points={{-100,0},{-40,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Line(
          points={{40,0},{90,0}},
          color={0,127,255},
          smooth=Smooth.Bezier,
          thickness=0.5),
        Ellipse(
          extent={{-20,64},{20,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-20,64},{20,24}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="M",
          textStyle={TextStyle.Bold}),
        Line(
          points={{0,24},{0,0}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-50,92},{-50,44}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{50,90},{50,44}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{50,44},{20,44}},
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{-50,44},{-20,44}},
          color={244,125,35},
          thickness=0.5)}),
        Diagram(
          coordinateSystem(preserveAspectRatio=false)));
end PartialExpansionValve;
