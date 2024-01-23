within AixLib.Fluid.DistrictHeatingCooling.Examples;
model CoolingOneSupply
  "A small open loop example with a cooling substation and pressure control"
  extends Modelica.Icons.Example;

  parameter Modelica.Units.SI.Temperature T_amb = 283.15
    "Ambient temperature around pipes";

  package Medium = AixLib.Media.Specialized.Water.ConstantProperties_pT (
    T_nominal=279.15,
    p_nominal=600000.0,
    T_default=279.15);

  Supplies.OpenLoop.SourceIdeal sourceIdeal(
    TReturn=273.15 + 12,
    redeclare package Medium = Medium,
    pReturn=200000)      "Simple suppy model"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  Demands.OpenLoop.VarTSupplyDp varTSupply(
    redeclare package Medium = Medium,
    Q_flow_nominal=-78239.1,
    dp_nominal=50000,
    dTDesign=-6,
    TReturn=285.15) "Simple demand model" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-60})));
  FixedResistances.PlugFlowPipe pipeSupply(
    nPorts=2,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,0})));
  FixedResistances.PlugFlowPipe pipeReturn(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,0})));
  Modelica.Blocks.Sources.Constant TSet(k=6 + 273.15) "Set supply temperature"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,88})));
  Modelica.Blocks.Sources.Constant dpSet(k=1.4e5)
    "Set pressure difference for substation" annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-30,-2})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TGround
    "Ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,-210})));
  Modelica.Blocks.Sources.Constant TGroundSet(k=10 + 273.15)
    "Set ground temperature" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,-250})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=12000,
    f=1/10000,
    offset=-24000) "A sine wave for varying heat demands" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-90})));
  Modelica.Blocks.Continuous.LimPID pControl(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      yMax=6e5) "Pressure controller" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,30})));
  Modelica.Blocks.Sources.Sine sine1(
    amplitude=12000,
    f=1/10000,
    offset=-24000) "A sine wave for varying heat demands" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-210})));
  Demands.OpenLoop.VarTSupplyDp varTSupply1(
    redeclare package Medium = Medium,
    Q_flow_nominal=-78239.1,
    dp_nominal=50000,
    dTDesign=-6,
    TReturn=285.15) "Simple demand model" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-182})));
  FixedResistances.PlugFlowPipe pipeSupply1(
    nPorts=2,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={60,-120})));
  FixedResistances.PlugFlowPipe pipeReturn1(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-120})));
  FixedResistances.PlugFlowPipe pipeReturn2(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={140,0})));
  Demands.OpenLoop.VarTSupplyDp varTSupply2(
    redeclare package Medium = Medium,
    Q_flow_nominal=-78239.1,
    dp_nominal=50000,
    dTDesign=-6,
    TReturn=285.15) "Simple demand model" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={200,-60})));
  FixedResistances.PlugFlowPipe pipeSupply2(
    nPorts=2,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={260,0})));
  FixedResistances.PlugFlowPipe pipeSupply3(
    nPorts=2,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={260,-120})));
  Demands.OpenLoop.VarTSupplyDp varTSupply3(
    redeclare package Medium = Medium,
    Q_flow_nominal=-78239.1,
    dp_nominal=50000,
    dTDesign=-6,
    TReturn=285.15) "Simple demand model" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={200,-182})));
  Modelica.Blocks.Sources.Sine sine2(
    amplitude=12000,
    f=1/10000,
    offset=-24000) "A sine wave for varying heat demands" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={230,-210})));
  Modelica.Blocks.Sources.Sine sine3(
    amplitude=12000,
    f=1/10000,
    offset=-24000) "A sine wave for varying heat demands" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={230,-90})));
  FixedResistances.PlugFlowPipe pipeReturn3(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={140,-120})));
  FixedResistances.PlugFlowPipe pipeSupply4(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Supply pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={170,-240})));
  FixedResistances.PlugFlowPipe pipeReturn4(
    nPorts=1,
    redeclare package Medium = Medium,
    dh=0.05,
    length=50,
    m_flow_nominal=1,
    dIns=0.03,
    kIns=0.027) "Return pipe" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-260})));
equation
  connect(sourceIdeal.port_b, pipeSupply.port_a)
    annotation (Line(points={{10,60},{60,60},{60,10}}, color={0,127,255}));
  connect(pipeSupply.ports_b[1], varTSupply.port_a)
    annotation (Line(points={{59,-10},{59,-60},{10,-60}}, color={0,127,255}));
  connect(varTSupply.port_b, pipeReturn.port_a) annotation (Line(points={{-10,-60},
          {-60,-60},{-60,-10}}, color={0,127,255}));
  connect(pipeReturn.ports_b[1], sourceIdeal.port_a)
    annotation (Line(points={{-60,10},{-60,60},{-10,60}}, color={0,127,255}));
  connect(TSet.y, sourceIdeal.TIn)
    annotation (Line(points={{-20,77},{-20,67},{-10.6,67}}, color={0,0,127}));
  connect(TGroundSet.y, TGround.T)
    annotation (Line(points={{-160,-239},{-160,-222}},
                                                   color={0,0,127}));
  connect(TGround.port, pipeReturn.heatPort)
    annotation (Line(points={{-160,-200},{-160,0},{-70,0}},
                                                         color={191,0,0}));
  connect(TGround.port, pipeSupply.heatPort) annotation (Line(points={{-160,
          -200},{-160,-20},{80,-20},{80,0},{70,0}},
                                             color={191,0,0}));
  connect(varTSupply.Q_flow_input, sine.y)
    annotation (Line(points={{10.8,-68},{30,-68},{30,-79}}, color={0,0,127}));
  connect(dpSet.y, pControl.u_s)
    annotation (Line(points={{-30,9},{-30,18}}, color={0,0,127}));
  connect(pControl.y, sourceIdeal.dpIn)
    annotation (Line(points={{-30,41},{-30,53},{-10.6,53}}, color={0,0,127}));
  connect(varTSupply1.port_b, pipeReturn1.port_a) annotation (Line(points={{-10,
          -182},{-60,-182},{-60,-130}}, color={0,127,255}));
  connect(pipeSupply1.ports_b[1], varTSupply1.port_a) annotation (Line(points={{59,-130},
          {59,-182},{10,-182}},           color={0,127,255}));
  connect(varTSupply1.Q_flow_input, sine1.y) annotation (Line(points={{10.8,
          -190},{30,-190},{30,-199}}, color={0,0,127}));
  connect(pipeSupply1.port_a, pipeSupply.ports_b[2])
    annotation (Line(points={{60,-110},{60,-10},{61,-10}}, color={0,127,255}));
  connect(pipeReturn1.ports_b[1], pipeReturn.port_a)
    annotation (Line(points={{-60,-110},{-60,-10}}, color={0,127,255}));
  connect(TGround.port, pipeReturn1.heatPort) annotation (Line(points={{-160,
          -200},{-160,-120},{-70,-120}}, color={191,0,0}));
  connect(TGround.port, pipeSupply1.heatPort) annotation (Line(points={{-160,
          -200},{-160,-140},{80,-140},{80,-120},{70,-120}}, color={191,0,0}));
  connect(pipeReturn3.ports_b[1], pipeReturn2.port_a) annotation (Line(points={
          {140,-110},{140,-78},{140,-78},{140,-50},{140,-50},{140,-10}}, color=
          {0,127,255}));
  connect(varTSupply2.port_b, pipeReturn2.port_a) annotation (Line(points={{190,
          -60},{140,-60},{140,-10}}, color={0,127,255}));
  connect(pipeSupply2.ports_b[1], varTSupply2.port_a) annotation (Line(points={{259,-10},
          {259,-60},{210,-60}},           color={0,127,255}));
  connect(pipeSupply3.port_a, pipeSupply2.ports_b[2]) annotation (Line(points={{260,
          -110},{260,-10},{261,-10}},      color={0,127,255}));
  connect(pipeSupply3.ports_b[1], varTSupply3.port_a) annotation (Line(points={{259,
          -130},{259,-182},{210,-182}},      color={0,127,255}));
  connect(varTSupply2.Q_flow_input, sine3.y) annotation (Line(points={{210.8,
          -68},{230,-68},{230,-79}}, color={0,0,127}));
  connect(varTSupply3.Q_flow_input, sine2.y) annotation (Line(points={{210.8,
          -190},{230,-190},{230,-199}}, color={0,0,127}));
  connect(varTSupply3.port_b, pipeReturn3.port_a) annotation (Line(points={{190,
          -182},{140,-182},{140,-130}}, color={0,127,255}));
  connect(sourceIdeal.port_b, pipeSupply2.port_a)
    annotation (Line(points={{10,60},{260,60},{260,10}}, color={0,127,255}));
  connect(pipeReturn2.ports_b[1], sourceIdeal.port_a) annotation (Line(points={
          {140,10},{140,44},{-60,44},{-60,60},{-10,60}}, color={0,127,255}));
  connect(TGround.port, pipeSupply3.heatPort) annotation (Line(points={{-160,
          -200},{-160,-140},{280,-140},{280,-120},{270,-120}}, color={191,0,0}));
  connect(TGround.port, pipeReturn3.heatPort) annotation (Line(points={{-160,
          -200},{-160,-140},{120,-140},{120,-120},{130,-120}}, color={191,0,0}));
  connect(TGround.port, pipeSupply2.heatPort) annotation (Line(points={{-160,
          -200},{-160,-20},{280,-20},{280,0},{270,0}}, color={191,0,0}));
  connect(TGround.port, pipeReturn2.heatPort) annotation (Line(points={{-160,
          -200},{-160,-20},{120,-20},{120,0},{130,0}}, color={191,0,0}));
  connect(varTSupply3.dpOut, pControl.u_m) annotation (Line(points={{189.2,-190},
          {100,-190},{100,30},{-18,30}}, color={0,0,127}));
  connect(pipeSupply3.ports_b[2], pipeSupply4.port_a) annotation (Line(points={{261,
          -130},{261,-240},{180,-240}},      color={0,127,255}));
  connect(pipeSupply4.ports_b[1], pipeSupply1.ports_b[2]) annotation (Line(
        points={{160,-240},{61,-240},{61,-130}}, color={0,127,255}));
  connect(pipeReturn3.port_a, pipeReturn4.port_a) annotation (Line(points={{140,
          -130},{140,-260},{120,-260}}, color={0,127,255}));
  connect(pipeReturn4.ports_b[1], pipeReturn1.port_a) annotation (Line(points={
          {100,-260},{-60,-260},{-60,-130}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -280},{400,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-280},{400,
            100}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Cvode"),
    Documentation(revisions="<html><ul>
  <li>March 17, 2018, by Marcus Fuchs:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
A small cooling network with 1 supply.
</html>"));
end CoolingOneSupply;
