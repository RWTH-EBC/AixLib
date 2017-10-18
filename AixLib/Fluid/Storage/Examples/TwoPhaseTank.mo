within AixLib.Fluid.Storage.Examples;
model TwoPhaseTank
  "Test model to show the functionality of the two-phase tank"
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
  AixLib.Fluid.Sources.FixedBoundary Source(
    redeclare package Medium = Medium,
    use_p=true,
    use_T=true,
    p=pInl,
    T=TInl,
    nPorts=1)
    "Source of constant pressure and temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));
  AixLib.Fluid.Storage.TwoPhaseTank twoPhaseTank(
    redeclare package Medium = Medium, useHeatLoss=false)
    "Model of a simple two-phase tank"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
  AixLib.Fluid.Sources.FixedBoundary Sink(
    redeclare package Medium = Medium,
    p=pOut,
    T=TOut,
    nPorts=1)
    "Sink of constant pressure and temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-50})));


equation
  connect(Source.ports[1], twoPhaseTank.port_a)
    annotation (Line(points={{0,40},{0,20},{0,10}},
                                             color={0,127,255}));
  connect(Sink.ports[1], twoPhaseTank.port_b)
    annotation (Line(points={{0,-40},{0,-20},{0,-10}},
                                               color={0,127,255}));

end TwoPhaseTank;
