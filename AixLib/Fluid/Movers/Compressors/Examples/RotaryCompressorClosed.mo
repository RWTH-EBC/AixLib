within AixLib.Fluid.Movers.Compressors.Examples;
model RotaryCompressorClosed
  "Example model to test simple rotary compressors in a close-loop system"
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
    p=pInl,
    T=TOut,
    nPorts=1)
            "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
  Modelica.Blocks.Sources.Sine rotationalSpeed(
    offset=75,
    freqHz=1,
    amplitude=75)
    "Prescribed compressor's rotational speed"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  SimpleCompressors.RotaryCompressor rotaryCompressor(
    redeclare package Medium = Medium,
    show_staEff=true,
    show_qua=true)
    "Model of a rotary compressor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine valveOpening(
    offset=0.5,
    amplitude=0,
    freqHz=1)
    "Prescribed valve's opening"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Actuators.Valves.SimpleValve simpleValve(
    redeclare package Medium = Medium,
    m_flow_start=0.025,
    m_flow_small=1e-6,
    Kvs=1.4)
    "Model of a simple valve to simulate pressure losses"
    annotation (Placement(transformation(extent={{10,-30},{-10,-50}})));
  WorkingVersion.Fluid.Storage.TwoPhaseTank twoPhaseTank(
    redeclare package Medium = Medium, steSta=false)
    "Model of a two-phase tank that works as ideal phase seperator"
    annotation (Placement(transformation(extent={{50,-32},{70,-12}})));


equation
  // Connection of components
  //
  connect(source.ports[1], rotaryCompressor.port_a)
    annotation (Line(points={{-62,0},{-10,0}}, color={0,127,255}));
  connect(rotaryCompressor.port_b, twoPhaseTank.port_a)
    annotation (Line(points={{10,0},{60,0},{60,-12}}, color={0,127,255}));
  connect(rotationalSpeed.y, rotaryCompressor.preRotSpe)
    annotation (Line(points={{-59,70},{0,70},{0,10}}, color={0,0,127}));
  connect(valveOpening.y, simpleValve.opening)
    annotation (Line(points={{-59,-70},{0,-70},{0,-48}}, color={0,0,127}));
  connect(twoPhaseTank.port_b, simpleValve.port_a)
    annotation (Line(points={{60,-32},{60,-40},{10,-40}}, color={0,127,255}));
  connect(simpleValve.port_b, rotaryCompressor.port_a)
    annotation (Line(points={{-10,-40},{-40,-40},{-40,0},{-10,0}},
                color={0,127,255}));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"));
end RotaryCompressorClosed;
