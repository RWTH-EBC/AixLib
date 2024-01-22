within AixLib.Fluid.Actuators.Valves.ExpansionValves.Examples;
model ExpansionValvePressureDifference
  "Simple model to check different flow coefficient models with fixed inlet 
   and outlet states"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Actual medium of the compressor";

  parameter Modelica.Units.SI.AbsolutePressure pInl=Medium.pressure(
      Medium.setBubbleState(Medium.setSat_T(TInl + 5)))
    "Actual pressure at inlet conditions";
  parameter Modelica.Units.SI.Temperature TInl=348.15
    "Actual temperature at inlet conditions";
  parameter Modelica.Units.SI.AbsolutePressure pOut=Medium.pressure(
      Medium.setDewState(Medium.setSat_T(TOut)))
    "Actual set point of the compressor's outlet pressure";
  parameter Modelica.Units.SI.Temperature TOut=278.15
    "Actual temperature at outlet conditions";

  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=0.1
    "Nominal mass flow rate";

  // Define components
  //
  Sources.Boundary_pT                source(
    redeclare package Medium = Medium,
    nPorts=1,
    p=pInl,
    T=TInl)
    "Source of constant pressure and temperature"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Sine valOpe(
    amplitude=0.45,
    f=1,
    offset=0.5) "Input signal to prediscribe expansion valve's opening"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  SimpleExpansionValves.IsenthalpicExpansionValve linearValve(
    redeclare package Medium = Medium,
    show_flow_coefficient=true,
    show_staInl=true,
    show_staOut=false,
    useInpFil=false,
    AVal=2.01e-6,
    m_flow_nominal=m_flow_nominal,
    calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
    dpNom=1000000,
    redeclare model FlowCoefficient =
        Utilities.FlowCoefficient.SpecifiedFlowCoefficients.Power_R134a_EEV_15)
    "Simple isothermal valve"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Sources.Boundary_pT                sink(
    redeclare package Medium = Medium,
    p=pOut,
    T=TOut,
    nPorts=1)
    "Sink of constant pressure and temperature"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));


equation
  // Define connections of components
  //
  connect(source.ports[1], linearValve.port_a)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
  connect(valOpe.y, linearValve.manVarVal)
    annotation (Line(points={{-59,50},{-5,50},{-5,10.6}}, color={0,0,127}));
  connect(linearValve.port_b,sink. ports[1])
    annotation (Line(points={{10,0},{60,0}}, color={0,127,255}));

  annotation (Documentation(revisions="<html><ul>
  <li>October 16, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/457\">issue 457</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This is a simple example model to test expansion valves presented in
  <a href=
  \"modelica://AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves\">
  AixLib.Fluid.Actuators.Valves.ExpansionValves.SimpleExpansionValves</a>.
  Therefore, both the valve's inlet and outlet conditions are
  prescribed in terms of pressure and temperature.
</p>
</html>"));
end ExpansionValvePressureDifference;
