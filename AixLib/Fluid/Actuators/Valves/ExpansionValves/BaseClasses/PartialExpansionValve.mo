within AixLib.Fluid.Actuators.Valves.ExpansionValves.BaseClasses;
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

  parameter Utilities.Types.CalcProc calcProc=Utilities.Types.CalcProc.nominal
    "Chose predefined calculation method for flow coefficient"
    annotation (Dialog(tab="Flow Coefficient"));
  parameter Modelica.SIunits.MassFlowRate mFlowNom = m_flow_nominal
    "Mass flow at nominal conditions"
    annotation(Dialog(
               tab="Flow Coefficient",
               group="Nominal calculation",
               enable=if ((calcProc == Utilities.Types.CalcProc.nominal) or (
          calcProc == Utilities.Types.CalcProc.flowCoefficient)) then true
           else false));
  parameter Modelica.SIunits.PressureDifference dpNom = 15e5
    "Pressure drop at nominal conditions"
    annotation(Dialog(
               tab="Flow Coefficient",
               group="Nominal calculation",
               enable=if ((calcProc == Utilities.Types.CalcProc.nominal) or (
          calcProc == Utilities.Types.CalcProc.flowCoefficient)) then true
           else false));

  // Definition of model describing flow coefficient
  //
  replaceable model FlowCoefficient =
    Utilities.FlowCoefficient.SpecifiedFlowCoefficients.ConstantFlowCoefficient
                                                      constrainedby
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
        Modelica.Media.R134a.R134a_ph,
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
  Modelica.Blocks.Interfaces.RealInput manVarVal(min=0, max=1)
    "Prescribed expansion valve's opening" annotation (Placement(transformation(
        extent={{16,-16},{-16,16}},
        rotation=90,
        origin={-50,106})));
  Modelica.Blocks.Interfaces.RealOutput curManVarVal(min=0, max=1)
    "Current expansion valve's opening" annotation (Placement(transformation(
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
    "Current cross-sectional area of the valve";
  Real opening(unit="1")
    "Current valve's opening";

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
    actualStream(port_a.h_outflow), actualStream(port_a.Xi_outflow))
    "Thermodynamic state of the fluid at inlet condtions";
  staOut = Medium.setState_phX(port_b.p,
    actualStream(port_b.h_outflow), actualStream(port_b.Xi_outflow))
    "Thermodynamic state of the fluid at outlet condtions";

  // Calculation of valve's opening degree
  //
  connect(filterOpening.u, manVarVal);
  if useInpFil then
    connect(openingThrough.u, filterOpening.y)
      "Transient behaviour of valve's opening";
  else
    connect(openingThrough.u, manVarVal)
      "No transient behaiviour of valve's opnening";
  end if;
  opening = smooth(1, noEvent(if openingThrough.y>0 then
                              openingThrough.y else 1e-15))
    "Current valve's opening";

  // Calculation of active cross-sectional flow area
  //
  AThr = opening * AVal "Current cross-sectional area of the valve";

  // Calculation of outputs
  //
  curManVarVal = opening "Current valve's opening";

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
          coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This is a base model for simple expansion valves that are used, for example, 
in close-loop systems like heat pumps or chillers.
</p>
<h4>Equations needed for completion</h4>
<p>
Three equations need to be added by an extending class using this component:
</p>
<ul>
<li>The momentum balance specifying the relationship between the pressure 
drop dp and the mass flow rate m_flow. Therefore, different modeling
approaches are suggested that can be easily expanded.</li>
<li><code>port_b.h_outflow</code> for flow in design direction.</li>
<li><code>port_a.h_outflow</code> for flow in reverse direction.</li>
</ul>
<p>
Moreover, appropriate values shall be assigned to the following parameters:
</p>
<ul>
<li><code>dp_start</code> for a guess of the pressure drop</li>
<li><code>m_flow_small</code> for regularization of zero flow.</li>
<li><code>dp_nominal</code> for nominal pressure drop.</li>
<li><code>m_flow_nominal</code> for nominal mass flow rate.</li>
</ul>
<h4>Modeling approaches</h4>
<p>
Actually, three different modelling approaches are suggested and saved as
enumeration in 
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.CalcProc\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.CalcProc</a>.
In the following, these modeling approaches are characterised shortly:<br />
</p>
<table summary=\"Modelling approaches\" border=\"1\" cellspacing=\"0\" 
cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr>
<th>Approach</th>
<th>Formula</th> 
<th>Comment</th> 
</tr> 
<tr>
<td><b>Linear</b></td> 
<td><code>m&#775; = C A<sub>valve</sub> dp</code></td> 
<td>Used for testing or initialisation</td> 
</tr> 
<tr>
<td><b>Nominal</b></td> 
<td><code>m&#775; = m&#775;<sub>nominal</sub> / dp<sub>nominal</sub> 
A<sub>valve</sub> dp</code></td> 
<td>Used mainly for initialisation</td> 
</tr> 
<tr>
<td><b>Flow coefficient</b></td> 
<td><code>m&#775; = C A<sub>valve</sub> sqrt(2 &rho;<sub>inlet</sub> 
dp)</code></td> 
<td>Chosen by default and follows from Bernoulli's law</td> 
</tr> 
</table>
<p>
For the third approach (i.e. flow coefficient), different calculation
models are stored in
<a href=\"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient\">
AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Choices.FlowCoefficient</a>.
Therefore, the calculation procedure of the flow coefficient C is introduced as
replaceable model and must by defined by the User.
</p>
<h4>Transient behaviour</h4>
<p>
The base model has a parameter <code>useInpFil</code> that is used to model
the valve's transient behaviour while opening or closing. Generally, this 
approach uses the same modeling attempt as the stat-up and shut-down
transients introtuced for flow machines (see 
<a href=\"modelica://AixLib.Fluid.Movers.UsersGuide\">
AixLib.Fluid.Movers.UsersGuide</a>). Therefore, just the parameter's affections 
are presented here:
</p>
<ol>
<li>
If <code>useInpFil=false</code>, then the input signal <code>opeSet.y</code> 
is equal to the valve's opening degree. Thus, a step change in the input 
signal causes a step change in the opening degree.
</li>
<li>
If <code>useInpFil=true</code>, which is the default,
then the opening degree is equal to the output of a filter. 
This filter is implemented as a 2nd order differential equation. Thus, a step 
change in the fan input signal will cause a gradual change in the opening
degree. The filter has a parameter <code>risTim</code>, which by default is set to
<i>1</i> second. The rise time is the time required to reach <i>99.6%</i> of 
the full opening degree, or,if the ventil is closed, to reach a opening degree
of <i>0.4%</i>.
</li>
</ol>
<h4>References</h4>
<p>
In the following, some general references are given for information about
modelling expansion valves. The modelling approach presented here is alligned
to the modelling approaches presented in the literature:
</p>
<p>
Li, W. (2013): <a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2012.12.035\">
Simplified modeling analysis ofmass flow characteristics in electronic expansion 
valve</a>. In: <i>Applied Thermal Engineering 53(1)</i>, S. 8&ndash;12
</p>
<p>
X. Cao, Z.-Y. Li, L.-L. Shao and C.-L. Zhang (2016): 
<a href=\"http://dx.doi.org/10.1016/j.applthermaleng.2015.09.062\">
Refrigerant flow through electronic expansion valve: Experiment and 
neural network modeling</a>. In: <i>Applied Thermal Engineering 92</i>, 
S. 210&ndash;218
</p>
</html>"));
end PartialExpansionValve;
