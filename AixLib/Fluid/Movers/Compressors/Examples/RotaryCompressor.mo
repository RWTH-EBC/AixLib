within AixLib.Fluid.Movers.Compressors.Examples;
model RotaryCompressor
  "Example model to test simple rotary compressors"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
   "Actual medium of the compressor";

  parameter Modelica.SIunits.AbsolutePressure pInl=
    Medium.pressure(Medium.setBubbleState(Medium.setSat_T(TInl+1)))
    "Actual pressure at inlet conditions";
  parameter Modelica.SIunits.Temperature TInl = 283.15
    "Actual temperature at inlet conditions";
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut-5)))
    "Actual set point of the compressor's outlet pressure";
  parameter Modelica.SIunits.Temperature TOut = 333.15
    "Actual temperature at outlet conditions";

  parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1
    "Nominal mass flow rate";

  // Definition of models
  //
  Sources.FixedBoundary source(
    redeclare package Medium = Medium,
    use_p=true,
    use_T=true,
    nPorts=1,
    p=pInl,
    T=TOut) "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Modelica.Blocks.Sources.Sine rotationalSpeed(
    offset=75,
    freqHz=1,
    amplitude=75)
    "Prescribed compressor's rotational speed"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  SimpleCompressors.RotaryCompressor rotaryCompressor(
    redeclare package Medium = Medium,
    show_staEff=true,
    show_qua=true)
    "Model of a rotary compressor"
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.Sources.Sine valveOpening(
    offset=0.5,
    amplitude=0,
    freqHz=1)
    "Prescribed valve's opening"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Actuators.Valves.SimpleValve simpleValve(
    redeclare package Medium = Medium,
    m_flow_start=0.025,
    m_flow_small=1e-6,
    Kvs=1.4) "Model of a simple valve to simulate pressure losses"
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Sources.FixedBoundary sink(
    redeclare package Medium = Medium,
    use_p=true,
    use_T=true,
    nPorts=1,
    p=pInl,
    T=TInl) "Sink with constant pressure and temperature"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));


equation
  // Connection of components
  //
  connect(source.ports[1], rotaryCompressor.port_a)
    annotation (Line(points={{-62,0},{-46,0},{-30,0}}, color={0,127,255}));
  connect(rotaryCompressor.port_b, simpleValve.port_a)
    annotation (Line(points={{-10,0},{6,0},{20,0}}, color={0,127,255}));
  connect(simpleValve.port_b, sink.ports[1])
    annotation (Line(points={{40,0},{50,0},{60,0}}, color={0,127,255}));
  connect(rotationalSpeed.y, rotaryCompressor.preRotSpe)
    annotation (Line(points={{-59,40},{-20,40},{-20,10}}, color={0,0,127}));
  connect(valveOpening.y, simpleValve.opening)
    annotation (Line(points={{-59,80},{30,80},{30,8}}, color={0,0,127}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RotaryCompressor;
