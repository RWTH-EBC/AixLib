within AixLib.Fluid.HeatPumps.ModularHeatPumps.SimpleHeatPumps;
model TEST1
  Movers.Compressors.SimpleCompressors.RotaryCompressors.RotaryCompressor
    compressor(
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    show_staEff=true,
    show_qua=true)
               annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,0})));
  Actuators.Valves.ExpansionValves.SimpleExpansionValves.IsothermalExpansionValve
    valve(
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    calcProc=AixLib.Fluid.Actuators.Valves.ExpansionValves.Utilities.Types.CalcProc.flowCoefficient,
    redeclare model FlowCoefficient =
        Actuators.Valves.ExpansionValves.Utilities.FlowCoefficient.ConstantFlowCoefficient)
          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,0})));

  Sources.MassFlowSource_T sourceCondensator(
    redeclare package Medium = Media.Water,
    m_flow=0.1,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-62,60},{-42,80}})));

  Sources.Boundary_ph sinkEvaporator(redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner, p=100000)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Sources.Boundary_ph sinkCondenser(
    redeclare package Medium = Media.Water,
    p=1e5,
    nPorts=1)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));

  Modelica.Blocks.Sources.Constant const(k=60)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Constant const1(k=0.05)
    annotation (Placement(transformation(extent={{-10,-10},{-30,10}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        293.15)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Sources.FixedBoundary source(
    use_p=true,
    use_T=true,
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    p=200000,
    T=273.15)
            "Source with constant pressure and temperature"
    annotation (Placement(transformation(extent={{38,-60},{58,-40}})));
  HeatExchangers.HeaterCooler_u hea(
    redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner,
    m_flow_nominal=0.1,
    dp_nominal=10,
    Q_flow_nominal=-4000)
    annotation (Placement(transformation(extent={{12,34},{-8,54}})));
  Modelica.Blocks.Sources.Constant const2(k=0.5)
    annotation (Placement(transformation(extent={{92,40},{72,60}})));
  Storage.TwoPhaseSeparator twoPhaseSeparator(redeclare package Medium =
        Media.Refrigerants.R134a.R134a_IIR_P1_395_T233_455_Horner, VTanInn=
        10e-3) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,-30})));
equation

  connect(const.y, compressor.manVarCom)
    annotation (Line(points={{31,0},{40,0},{40,-6},{50,-6}}, color={0,0,127}));
  connect(const1.y, valve.manVarVal) annotation (Line(points={{-31,0},{-40,0},{
          -40,5},{-49.4,5}}, color={0,0,127}));
  connect(fixedTemperature.port, compressor.heatPort)
    annotation (Line(points={{80,0},{70,0}}, color={191,0,0}));
  connect(sourceCondensator.ports[1], sinkCondenser.ports[1])
    annotation (Line(points={{-42,70},{40,70}}, color={0,127,255}));
  connect(compressor.port_b, hea.port_a) annotation (Line(points={{60,10},{60,
          38},{12,38},{12,44}}, color={0,127,255}));
  connect(hea.port_b, valve.port_a) annotation (Line(points={{-8,44},{-32,44},{
          -32,36},{-60,36},{-60,10}}, color={0,127,255}));
  connect(const2.y, hea.u)
    annotation (Line(points={{71,50},{14,50}}, color={0,0,127}));
  connect(valve.port_b, twoPhaseSeparator.port_b) annotation (Line(points={{-60,
          -10},{-60,-30},{-10,-30}}, color={0,127,255}));
  connect(twoPhaseSeparator.port_a, compressor.port_a)
    annotation (Line(points={{10,-30},{60,-30},{60,-10}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TEST1;
