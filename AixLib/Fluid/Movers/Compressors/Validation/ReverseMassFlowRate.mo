within AixLib.Fluid.Movers.Compressors.Validation;
model ReverseMassFlowRate
  "Valdiation model to check reverse mass flow rate"
  extends Modelica.Icons.Example;

  // Define medium and parameters
  //
  package Medium =
   Modelica.Media.R134a.R134a_ph
   "Medium of the compressor";

  parameter Modelica.SIunits.AbsolutePressure pInl=
    Medium.pressure(Medium.setBubbleState(Medium.setSat_T(TInl+1)))
    "Current pressure at inlet conditions";
  parameter Modelica.SIunits.Temperature TInl = 283.15
    "Current temperature at inlet conditions";
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut-5)))
    "Current set point of the compressor's outlet pressure";
  parameter Modelica.SIunits.Temperature TOut = 333.15
    "Current temperature at outlet conditions";

  // Definition of models
  //
  Sources.FixedBoundary source(
    redeclare package Medium = Medium,
    use_p=true,
    use_T=true,
    nPorts=1,
    p=pInl,
    T=TOut)
    "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Sine rotSpe(
    freqHz=1,
    amplitude=0,
    offset=0)
    "Prescribed compressor's rotational speed"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixTem(T=283.15)
    "Fixed ambient temperature"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  SimpleCompressors.RotaryCompressors.RotaryCompressor rotCom(
    redeclare package Medium = Medium,
    show_staEff=true,
    show_qua=true,
    useInpFil=true,
    redeclare model EngineEfficiency =
        Utilities.EngineEfficiency.SimilitudeTheory.Poly_GeneralLiterature,
    redeclare model VolumetricEfficiency =
        Utilities.VolumetricEfficiency.RotaryCompressors.SimilitudeTheory.Buck_R134aR450aR1234yfR1234zee_Rotary,
    redeclare model IsentropicEfficiency =
        Utilities.IsentropicEfficiency.RotaryCompressors.SimilitudeTheory.Buck_R134aR450aR1234yfR1234zee_Rotary)
    "Model of a rotary compressor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Sources.MassFlowSource_T sink(
    redeclare package Medium = Medium,
    nPorts=1,
    m_flow=0.1,
    T=TOut)
    "Sink of constant temperature and mass flow"
    annotation (Placement(transformation(extent={{60,-10},{40,10}})));

equation
  // Connection of components
  //
  connect(source.ports[1], rotCom.port_a)
    annotation (Line(points={{-60,0},{-10,0}},         color={0,127,255}));
  connect(rotSpe.y, rotCom.manVarCom)
    annotation (Line(points={{-59,40},{-6,40},{-6,10}},   color={0,0,127}));
  connect(fixTem.port, rotCom.heatPort)
    annotation (Line(points={{-60,-50},{0,-50},{0,-10}},     color={191,0,0}));

  connect(sink.ports[1], rotCom.port_b)
    annotation (Line(points={{40,0},{25,0},{10,0}}, color={0,127,255}));
  annotation (Documentation(revisions="<html>
<ul>
  <li>
  October 20, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>"),
experiment(StopTime=1));
end ReverseMassFlowRate;
