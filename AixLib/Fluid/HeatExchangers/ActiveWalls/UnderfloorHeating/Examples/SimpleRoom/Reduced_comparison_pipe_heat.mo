within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Examples.SimpleRoom;
model Reduced_comparison_pipe_heat

  package MediumAir = AixLib.Media.Air;
  package MediumWater = AixLib.Media.Water;

  parameter Integer dis=100
    "Number of discretization layers for panel heating pipe";
    parameter Integer dis2=100;
  final parameter Modelica.SIunits.MassFlowRate m_flow_total=0.05
    "Total mass flow in the panel heating system";

  UnderfloorHeatingCircuit_reduced underfloorHeatingCircuit_reduced(
      redeclare package Medium = MediumWater,
    dis=dis,
    calculateVol=1,
    A=20,
    m_flow_Circuit=m_flow_total,
    Spacing=0.35,
    PipeMaterial=BaseClasses.PipeMaterials.PERTpipe(),
    PipeThickness=0.002,
    d_a=0.017,
    use_vmax=1)
    annotation (Placement(transformation(extent={{-78,-10},{-38,10}})));
  Modelica.Blocks.Sources.Constant const(each k=1)
    annotation (Placement(transformation(extent={{-110,22},{-96,36}})));
  Sources.MassFlowSource_T              boundary(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  MixingVolumes.MixingVolume              vol(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
  Sources.Boundary_pT              bou(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{-4,-10},{-24,10}})));
  Sources.MassFlowSource_T              boundary1(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{8,-10},{28,10}})));
  MixingVolumes.MixingVolume              vol1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{62,20},{82,40}})));
  Sources.Boundary_pT              bou1(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{98,-10},{78,10}})));
  UnderfloorHeatingElement_reduced underfloorHeatingElement_reduced(
    redeclare package Medium = MediumWater,
    n_pipe=underfloorHeatingCircuit_reduced.n_pipe,
    d_a={underfloorHeatingCircuit_reduced.d_a},
    d_i={underfloorHeatingCircuit_reduced.d_i},
    lambda_pipe=underfloorHeatingCircuit_reduced.lambda_pipe,
        dis=1,
    calculateVol=1,
    T0=293.15,
    m_flow_Circuit=m_flow_total,
    use_vmax=1,
    PipeLength=underfloorHeatingCircuit_reduced.PipeLength)
    annotation (Placement(transformation(extent={{42,-6},{64,6}})));
  UnderfloorHeatingCircuit_reduced_without_R
                                   underfloorHeatingCircuit_reduced_without_R(
    redeclare package Medium = MediumWater,
    dis=dis,
    calculateVol=1,
    A=20,
    m_flow_Circuit=m_flow_total,
    Spacing=0.35,
    PipeMaterial=BaseClasses.PipeMaterials.PERTpipe(),
    PipeThickness=0.002,
    d_a=0.017,
    use_vmax=1)
    annotation (Placement(transformation(extent={{142,-10},{182,10}})));
  Modelica.Blocks.Sources.Constant const1(each k=1)
    annotation (Placement(transformation(extent={{110,22},{124,36}})));
  Sources.MassFlowSource_T              boundary2(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{108,-10},{128,10}})));
  MixingVolumes.MixingVolume              vol2(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{170,20},{190,40}})));
  Sources.Boundary_pT              bou2(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{216,-10},{196,10}})));
  Sources.MassFlowSource_T              boundary3(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,-92},{-92,-72}})));
  MixingVolumes.MixingVolume              vol3(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{-26,-58},{-6,-38}})));
  Sources.Boundary_pT              bou3(redeclare package Medium = MediumWater,
      nPorts=1)
    annotation (Placement(transformation(extent={{-22,-92},{-42,-72}})));
  UnderfloorHeatingElement_reduced2 underfloorHeatingElement_reduced2_1(
    redeclare package Medium = MediumWater,
    n_pipe=underfloorHeatingCircuit_reduced.n_pipe,
    d_a={underfloorHeatingCircuit_reduced.d_a},
    d_i={underfloorHeatingCircuit_reduced.d_i},
    lambda_pipe=underfloorHeatingCircuit_reduced.lambda_pipe,
    dis=100,
    calculateVol=1,
    T0=293.15,
    m_flow_Circuit=m_flow_total,
    use_vmax=1,
    PipeLength=underfloorHeatingCircuit_reduced.PipeLength)
    annotation (Placement(transformation(extent={{-78,-88},{-56,-76}})));
  Reduced.RCTABS thermalUFH(
    External=false,
    RCond_up=0.005,
    CTabs_up=100000,
    CTabs_lo=100000)
    annotation (Placement(transformation(extent={{48,-106},{72,-82}})));
  MixingVolumes.MixingVolume              vol4(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{64,-66},{84,-46}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow=1000)
    annotation (Placement(transformation(extent={{6,-104},{26,-84}})));
  Reduced.RCTABS thermalUFH1(
    External=true,
    RCond_up=0.005,
    CTabs_up=100000,
    RCond_lo=0.005,
    CTabs_lo=100000)
    annotation (Placement(transformation(extent={{144,-104},{168,-80}})));
  MixingVolumes.MixingVolume              vol5(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{160,-64},{180,-44}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=1000)
    annotation (Placement(transformation(extent={{102,-102},{122,-82}})));
  Reduced.RCTABS thermalUFH2[100](
    External=false,
    RCond_up=0.005*100,
    CTabs_up=100000/100,
    CTabs_lo=100000/100)
    annotation (Placement(transformation(extent={{-56,-180},{-32,-156}})));
  MixingVolumes.MixingVolume              vol6(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{-22,-136},{-2,-116}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2[dis](Q_flow=
        10)
    annotation (Placement(transformation(extent={{-110,-178},{-90,-158}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=
       100) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-44,-134})));
  MixingVolumes.MixingVolume              vol7(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{82,-138},{102,-118}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=dis)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={60,-136})));
  Reduced.TABSElement underfloorHeatingElement_reduced_without_R[dis](
    redeclare package Medium = MediumWater,
    each d_i={0.013},
    each PipeLength=120/dis,
    each dis=dis,
    each calculateVol=1,
    each T0=293.15,
    each m_flow_Circuit=m_flow_total,
    each use_vmax=1)
    annotation (Placement(transformation(extent={{48,-186},{68,-178}})));
  Sources.MassFlowSource_T              boundary4(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{12,-192},{32,-172}})));
  Sources.Boundary_pT              bou4(redeclare package Medium = MediumWater,

    T=303.15,
      nPorts=1)
    annotation (Placement(transformation(extent={{110,-192},{90,-172}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor
             thermalResistor2[dis](R=0.005*dis)
    annotation (Placement(transformation(extent={{78,-168},{98,-148}})));
  MixingVolumes.MixingVolume              vol8(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.1,
    V=20*3)
    annotation (Placement(transformation(extent={{188,-138},{208,-118}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector3(m=dis2)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={164,-152})));
  Reduced.TABSElement underfloorHeatingElement_reduced_without_R1[dis2](
    redeclare package Medium = MediumWater,
    each d_i={0.013},
    each PipeLength=120/dis2,
    each dis=dis2,
    each calculateVol=1,
    each T0=293.15,
    each m_flow_Circuit=m_flow_total,
    each use_vmax=1)
    annotation (Placement(transformation(extent={{156,-186},{176,-178}})));
  Sources.MassFlowSource_T              boundary5(
    redeclare package Medium = MediumWater,
    use_m_flow_in=false,
    m_flow=m_flow_total,
    use_T_in=false,
    T=313.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{118,-192},{138,-172}})));
  Sources.Boundary_pT              bou5(redeclare package Medium = MediumWater,

    T=303.15,
      nPorts=1)
    annotation (Placement(transformation(extent={{216,-192},{196,-172}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor1(R=0.005)
    annotation (Placement(transformation(extent={{132,-132},{152,-112}})));
  BaseClasses.SumT_F sumT_F(dis=dis2)
    annotation (Placement(transformation(extent={{236,-166},{256,-146}})));
  BaseClasses.SumT_F sumT_F1(dis=dis)
    annotation (Placement(transformation(extent={{116,-166},{136,-146}})));
equation
  connect(const.y, underfloorHeatingCircuit_reduced.valveInput) annotation (Line(
        points={{-95.3,29},{-72.8,29},{-72.8,14.5}}, color={0,0,127}));
  connect(boundary.ports[1], underfloorHeatingCircuit_reduced.port_a)
    annotation (Line(points={{-92,0},{-78,0}}, color={0,127,255}));
  connect(underfloorHeatingCircuit_reduced.heatUFH, vol.heatPort)
    annotation (Line(points={{-58,9.5},{-58,30},{-50,30}},
                                                      color={191,0,0}));
  connect(bou.ports[1], underfloorHeatingCircuit_reduced.port_b)
    annotation (Line(points={{-24,0},{-38,0}}, color={0,127,255}));
  connect(underfloorHeatingElement_reduced.heatUFH, vol1.heatPort) annotation (
      Line(points={{53,6.3},{53,30.15},{62,30.15},{62,30}}, color={191,0,0}));
  connect(boundary1.ports[1], underfloorHeatingElement_reduced.port_a)
    annotation (Line(points={{28,0},{42,0}},color={0,127,255}));
  connect(underfloorHeatingElement_reduced.port_b, bou1.ports[1])
    annotation (Line(points={{64,0},{78,0}}, color={0,127,255}));
  connect(const1.y, underfloorHeatingCircuit_reduced_without_R.valveInput)
    annotation (Line(points={{124.7,29},{147.2,29},{147.2,14.5}}, color={0,0,
          127}));
  connect(boundary2.ports[1], underfloorHeatingCircuit_reduced_without_R.port_a)
    annotation (Line(points={{128,0},{142,0}}, color={0,127,255}));
  connect(underfloorHeatingCircuit_reduced_without_R.heatTABS, vol2.heatPort)
    annotation (Line(points={{162,9.5},{162,30},{170,30}}, color={191,0,0}));
  connect(bou2.ports[1], underfloorHeatingCircuit_reduced_without_R.port_b)
    annotation (Line(points={{196,0},{182,0}}, color={0,127,255}));
  connect(underfloorHeatingElement_reduced2_1.heatUFH, vol3.heatPort)
    annotation (Line(points={{-67,-75.7},{-67,-47.85},{-26,-47.85},{-26,-48}},
        color={191,0,0}));
  connect(boundary3.ports[1], underfloorHeatingElement_reduced2_1.port_a)
    annotation (Line(points={{-92,-82},{-78,-82}}, color={0,127,255}));
  connect(underfloorHeatingElement_reduced2_1.port_b, bou3.ports[1])
    annotation (Line(points={{-56,-82},{-42,-82}}, color={0,127,255}));
  connect(vol4.heatPort, thermalUFH.port_int)
    annotation (Line(points={{64,-56},{60,-56},{60,-82}}, color={191,0,0}));
  connect(fixedHeatFlow.port, thermalUFH.port_heat)
    annotation (Line(points={{26,-94},{48,-94}}, color={191,0,0}));
  connect(vol5.heatPort, thermalUFH1.port_int)
    annotation (Line(points={{160,-54},{156,-54},{156,-80}}, color={191,0,0}));
  connect(fixedHeatFlow1.port, thermalUFH1.port_heat)
    annotation (Line(points={{122,-92},{144,-92}}, color={191,0,0}));
  connect(thermalCollector1.port_b, vol6.heatPort) annotation (Line(points={{-44,
    -124},{-34,-124},{-34,-126},{-22,-126}}, color={191,0,0}));

  for i in 1:dis loop
    connect(thermalUFH2[i].port_int, thermalCollector1.port_a[i])
        annotation (Line(points={{-44,-156},{-44,-144}},    color={191,0,0}));
    connect(fixedHeatFlow2[i].port, thermalUFH2[i].port_heat) annotation (Line(
        points={{-90,-168},{-74,-168},{-74,-168},{-56,-168}}, color={191,0,0}));
    connect(thermalResistor2[i].port_b, thermalCollector2.port_a[i])
      annotation (Line(points={{98,-158},{98,-146},{60,-146}},
          color={191,0,0}));
    connect(thermalResistor2[i].port_a,
      underfloorHeatingElement_reduced_without_R[i].heatTabs) annotation (Line(
          points={{78,-158},{58,-158},{58,-177.8}}, color={191,0,0}));
    connect(sumT_F1.port_a[i], underfloorHeatingElement_reduced_without_R[i].heatTabs)
      annotation (Line(points={{116,-156},{88,-156},{88,-177.8},{58,-177.8}},
          color={191,0,0}));
  end for;
  for i in 1:dis2 loop
    connect(underfloorHeatingElement_reduced_without_R1[i].heatTabs,
      thermalCollector3.port_a[i]) annotation (Line(points={{166,-177.8},{166,-170},
            {164,-170},{164,-162}}, color={191,0,0}));
    connect(sumT_F.port_a[i], underfloorHeatingElement_reduced_without_R1[i].heatTabs)
      annotation (Line(points={{236,-156},{202,-156},{202,-177.8},{166,-177.8}},
          color={191,0,0}));
  end for;
  for i in 2:dis loop
    connect(underfloorHeatingElement_reduced_without_R[i-1].port_b,
    underfloorHeatingElement_reduced_without_R[i].port_a);
  end for;
  for i in 2:dis2 loop
      connect(underfloorHeatingElement_reduced_without_R1[i-1].port_b,
    underfloorHeatingElement_reduced_without_R1[i].port_a);
  end for;
  connect(thermalCollector2.port_b,vol7. heatPort) annotation (Line(points={{60,-126},
          {70,-126},{70,-128},{82,-128}},    color={191,0,0}));
  connect(boundary4.ports[1], underfloorHeatingElement_reduced_without_R[1].port_a)
    annotation (Line(points={{32,-182},{38,-182},{38,-182},{48,-182}},
        color={0,127,255}));
  connect(underfloorHeatingElement_reduced_without_R[dis].port_b, bou4.ports[1])
    annotation (Line(points={{68,-182},{80,-182},{80,-182},{90,-182}},
        color={0,127,255}));
  connect(boundary5.ports[1], underfloorHeatingElement_reduced_without_R1[1].port_a)
    annotation (Line(points={{138,-182},{156,-182}},
        color={0,127,255}));
  connect(underfloorHeatingElement_reduced_without_R1[dis2].port_b, bou5.ports[1])
    annotation (Line(points={{176,-182},{196,-182}},
        color={0,127,255}));
  connect(thermalResistor1.port_b, vol8.heatPort) annotation (Line(points={{152,
          -122},{170,-122},{170,-128},{188,-128}}, color={191,0,0}));
  connect(thermalResistor1.port_a, thermalCollector3.port_b) annotation (Line(
        points={{132,-122},{122,-122},{122,-124},{120,-124},{120,-142},{164,-142}},
        color={191,0,0}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-200},
            {220,60}})),  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-120,-200},{220,60}})));
end Reduced_comparison_pipe_heat;
