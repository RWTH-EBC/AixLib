within AixLib.Fluid.Actuators.ExpansionValves.Examples;
model ModularExpansionValvesPressureDifference
  "Simple model to check modular expansion valves models with fixed inlet 
   and outlet states"
  extends Modelica.Icons.Example;

  // Definition of medium and parameters
  //
  package Medium =
   WorkingVersion.Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner
   "Actual medium of the compressor";

  parameter Integer nVal = 3
    "Number of valves - each valve will be connected to an individual port_b";
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
  Sources.FixedBoundary Source(
    redeclare package Medium = Medium,
    use_p=true,
    use_T=true,
    nPorts=1,
    p=pInl,
    T=TInl)
    "Source of constant pressure and temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,70})));
  replaceable ModularExpansionValves.ModularExpansionValvesSensorsPipes
    modularValves(
    redeclare package Medium = Medium,
    nVal=nVal,
    redeclare SimpleExpansionValves.IsothermalExpansionValve
      expansionValves,
    redeclare Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController
      expansionValveController,
    redeclare model FlowCoefficient =
      Utilities.FlowCoefficient.R134a.R134a_EEV_15,
    show_parVal=false,
    show_parCon=false,
    useInpFil={true,true,true},
    AVal={2e-6,1.5e-6,1e-6},
    risTim={0.25,0.25,0.5},
    useExt=false)
    annotation (Placement(transformation(
        extent={{-18,18},{18,-18}},
        rotation=-90,
        origin={-40,0})));
  Interfaces.PortsAThroughPortB portsAThroughPortB(
    redeclare package Medium = Medium, nVal=nVal)
    "Model to connect each valves' outlet pipe with each other"
    annotation (Placement(
      transformation(
      extent={{-10,-10},{10,10}},
      rotation=-90,
      origin={-40,-40})));
  AixLib.Fluid.Sources.FixedBoundary Sink(
    redeclare package Medium = Medium,
    p=pOut,
    T=TOut,
    nPorts=1)
    "Sink of constant pressure and temperature"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-40,-70})));

  Controls.Interfaces.ModularHeatPumpControlBus dataBus(nComp=nVal)
    "Data bus used to enable communication with dummy signals" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,0})));
  Modelica.Blocks.Routing.Replicator replicatorValveOpening(nout=nVal)
    "Replicating the valves' opening signal"
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Sources.Sine valveOpening(
    freqHz=1,
    amplitude=0.45,
    offset=0.5)
    "Input signal to prediscribe expansion valve's opening"
    annotation (Placement(transformation(extent={{80,16},{60,36}})));
  Modelica.Blocks.Routing.Replicator replicatorInternal(nout=nVal)
    "Replicating the internal set signal"
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Routing.Replicator replicatorActual(nout=nVal)
    "Replicating the actual value of the controlled variables"
    annotation (Placement(transformation(extent={{40,-60},{20,-40}})));
  Modelica.Blocks.Sources.Ramp rampActual(height=0.5, offset=0.3,
    duration=1)
    "Ramp to fake actual value of the controlled variables"
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));


equation
  connect(Source.ports[1], modularValves.port_a)
    annotation(Line(points={{-40,60},{-40,18}}, color={0,127,255}));
  connect(modularValves.ports_b, portsAThroughPortB.ports_a)
    annotation(Line(points={{-40,-18},{-40,-30}}, color={0,127,255}));
  connect(portsAThroughPortB.port_b, Sink.ports[1])
    annotation(Line(points={{-40,-50},{-40,-60}}, color={0,127,255}));
  connect(valveOpening.y, replicatorValveOpening.u)
    annotation(Line(points={{59,26},{50,26},{50,50},{42,50}},
               color={0,0,127}));
  connect(valveOpening.y, replicatorInternal.u)
    annotation(Line(points={{59,26},{50,26},{50,0},{42,0}}, color={0,0,127}));
  connect(rampActual.y, replicatorActual.u)
    annotation(Line(points={{59,-50},{50,-50},{42,-50}}, color={0,0,127}));
  connect(modularValves.dataBus, dataBus)
    annotation(Line(points={{-22,0},{0,0}},
               color={255,204,51},
               thickness=0.5));
  connect(replicatorValveOpening.y, dataBus.extSetSigValve)
    annotation(Line(points={{19,50},{10,50},{10,0.05},{-0.05,0.05}},
               color={0,0,127}));
  connect(replicatorInternal.y, dataBus.intSetSigValve)
    annotation(Line(points={{19,0},{10,0},{10,0.05},{-0.05,0.05}},
               color={0,0,127}));
  connect(replicatorActual.y, dataBus.actConVarValve)
    annotation(Line(points={{19,-50},{10,-50},{10,0.05},{-0.05,0.05}},
               color={0,0,127}));

  annotation (Diagram(graphics={Text(
          extent={{12,86},{88,74}},
          lineColor={28,108,200},
          textString="Provide dummy signals"), Rectangle(extent={{10,90},{90,70}},
            lineColor={28,108,200})}));
end ModularExpansionValvesPressureDifference;
