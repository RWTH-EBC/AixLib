within AixLib.Fluid.Actuators.ExpansionValves.Examples;
model ModularExpansionValvesPressureDifference
  "Simple model to check modular expansion valves models with fixed inlet 
   and outlet states"
  extends Modelica.Icons.Example;

  // Define medium and parameters
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

  replaceable ModularExpansionValves.ModularExpansionValves
    modularValves(
    redeclare package Medium = Medium,
    nVal=nVal,
    redeclare SimpleExpansionValves.IsothermalExpansionValve
      expansionValves,
    redeclare Controls.HeatPump.ModularHeatPumps.ModularExpansionValveController
      expansionValveController,
    AVal={2e-6,1.5e-6,1e-6},
    useInpFil={false,true,true},
    risTim={0.5,0.5,0.75},
    calcProc={Utilities.Choices.CalcProc.flowCoefficient,
              Utilities.Choices.CalcProc.flowCoefficient,
              Utilities.Choices.CalcProc.flowCoefficient},
    dpNom={150000000000,10000000000,10000000000},
    redeclare model FlowCoefficient =
      Utilities.FlowCoefficient.R134a.R134a_EEV_15)
    annotation (Placement(transformation(
        extent={{-18,18},{18,-18}},
        rotation=-90,
        origin={-40,0})));

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
  Interfaces.PortsAThroughPortB portsAThroughPortB(
      redeclare package Medium = Medium, nVal=nVal) annotation (Placement(
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
equation
  connect(Source.ports[1], modularValves.port_a)
    annotation (Line(points={{-40,60},{-40,18}}, color={0,127,255}));
  connect(modularValves.ports_b, portsAThroughPortB.ports_a)
    annotation (Line(points={{-40,-18},{-40,-30}}, color={0,127,255}));
  connect(portsAThroughPortB.port_b, Sink.ports[1])
    annotation (Line(points={{-40,-50},{-40,-60}}, color={0,127,255}));

end ModularExpansionValvesPressureDifference;
