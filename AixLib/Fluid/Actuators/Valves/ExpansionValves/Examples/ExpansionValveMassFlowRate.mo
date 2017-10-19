within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model ExpansionValveMassFlowRate
  "Simple model to check different flow coefficient models with fixed mass 
   flow rate"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   WorkingVersion.Media.Refrigerants.R410a.R410a_IIR_P1_48_T233_473_Horner
   "Actual medium of the compressor";

  parameter Modelica.SIunits.Temperature TInl = 318.15
    "Actual temperature at inlet conditions";
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut)))
    "Actual set point of the compressor's outlet pressure";
  parameter Modelica.SIunits.Temperature TOut = 278.15
    "Actual temperature at outlet conditions";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate";

  // Define components
  //
  AixLib.Fluid.Sources.MassFlowSource_T Source(
    redeclare package Medium = Medium,
    T=TInl,
    nPorts=1,
    m_flow=0.5*m_flow_nominal)
    "Source of constant mass flow and temperature"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Sine valveOpening(
    freqHz=1,
    amplitude=0.3,
    offset=0.7)
    "Input signal to prediscribe expansion valve's opening"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  SimpleExpansionValves.IsothermalExpansionValve
    linearValve(
    redeclare package Medium = Medium,
    m_flow_small=1e-6,
    m_flow_nominal=m_flow_nominal,
    show_flow_coefficient=false,
    show_staInl=false,
    show_staOut=false,
    useInpFil=false,
    dp_start=1e6,
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.R410a.R410a_EEV_18,
    AVal=2.55e-5,
    calcProc=Utilities.Choices.CalcProc.flowCoefficient,
    dpNom=1000000) "Simple isothermal valve"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

  AixLib.Fluid.FixedResistances.PressureDrop simplePipe(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=7.5e5)
    " Simple pipe to provide pressure loss"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  AixLib.Fluid.Sources.FixedBoundary Sink(
    redeclare package Medium = Medium,
    p=pOut,
    T=TOut,
    nPorts=1)
    "Sink of constant pressure and temperature"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));

equation
  // Define connections of components
  //
  connect(valveOpening.y, linearValve.opeSet)
    annotation (Line(points={{-59,50},{-25,50},{-25,10.6}}, color={0,0,127}));
  connect(linearValve.port_b, simplePipe.port_a)
    annotation (Line(points={{-10,0},{10,0}},
                color={0,127,255}));
  connect(simplePipe.port_b, Sink.ports[1])
    annotation (Line(points={{30,0},{46,0},{60,0}},
                color={0,127,255}));
  connect(Source.ports[1], linearValve.port_a)
    annotation (Line(points={{-60,0},{-30,0}},
                color={0,127,255}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 16, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>"));
end ExpansionValveMassFlowRate;
