within AixLib.Fluid.Storage.Examples;
model TwoPhaseTank
  "Test model to show the functionality of the two-phase tank"
  import AixLib;
  extends Modelica.Icons.Example;

  // Definition of medium and parameters
  //
  package Medium =
   WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
   "Actual medium of the compressor";

  parameter Modelica.SIunits.AbsolutePressure pInl=
    Medium.pressure(Medium.setBubbleState(Medium.setSat_T(TInl+5)))
    "Actual pressure at inlet conditions";
  parameter Modelica.SIunits.Temperature TInl = 348.15
    "Actual temperature at inlet conditions";
  parameter Modelica.SIunits.AbsolutePressure pOut=
    Medium.pressure(Medium.setDewState(Medium.setSat_T(TOut)))
    "Actual set point of the compressor's outlet pressure";
  parameter Modelica.SIunits.Temperature TOut = 278.15
    "Actual temperature at outlet conditions";

  // Definition of models
  //


  Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    T=TInl,
    m_flow=0.5,
    use_T_in=true,
    nPorts=1) "Source of constant mass flow and variable temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  AixLib.Fluid.Storage.TwoPhaseTank twoPhaseTank(
    redeclare package Medium = Medium,
    show_T=false,
    show_V_flow=false,
    useHeatLoss=false) "Model of a two-phase tank loacted after condenser"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp rampTInl(
    duration=1,
    height=TInl - TOut,
    offset=TOut) "Ramp to provide temperature at tank's inlet"
    annotation (Placement(transformation(extent={{-88,72},{-68,92}})));
  AixLib.Fluid.Sources.Boundary_pT Sink(
    redeclare package Medium = Medium,
    use_p_in=true,
    T=TOut,
    nPorts=1) "Sink of constant temperature and variable pressure" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={30,-50})));
  Modelica.Blocks.Sources.Ramp rampPOut(
    duration=1,
    height=pOut - pInl,
    offset=pInl) "Ramp to provide pressure at tank's outlet"
    annotation (Placement(transformation(extent={{90,-90},{70,-70}})));
equation

  connect(source.ports[1], twoPhaseTank.port_a)
    annotation (Line(points={{-20,50},{0,50},{0,10}}, color={0,127,255}));
  connect(twoPhaseTank.port_b, Sink.ports[1])
    annotation (Line(points={{0,-10},{0,-50},{20,-50}}, color={0,127,255}));
  connect(rampTInl.y, source.T_in) annotation (Line(points={{-67,82},{-60,82},{
          -60,54},{-42,54}}, color={0,0,127}));
  connect(rampPOut.y, Sink.p_in) annotation (Line(points={{69,-80},{50,-80},{50,
          -42},{42,-42}}, color={0,0,127}));
end TwoPhaseTank;
