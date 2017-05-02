within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model GeothermalHeatPumpBase
  "Base class of the geothermal heat pump system"

  replaceable package Medium = AixLib.Media.Water;

  parameter Modelica.SIunits.Temperature T_start_cold[5] = 300*ones(5);

  parameter Modelica.SIunits.Temperature T_start_warm[5] = 300*ones(5);

  parameter Modelica.SIunits.Temperature T_start_hot = 300;


  HeatPumps.HeatPumpSimple         heatPumpTab(volumeEvaporator(T_start = T_start_cold[1]), volumeCondenser(T_start = T_start_warm[5]), redeclare
      package Medium =
        Medium,
    tablePower=[0,266.15,275.15,280.15,283.15,293.15; 308.15,3300,3400,
        3500,3700,3800; 323.15,4500,4400,4600,5000,5100],
    tableHeatFlowCondenser=[0,266.16,275.15,280.15,283.15,293.15; 308.15,
        9700,11600,13000,14800,16300; 323.15,10000,11200,12900,16700,
        17500]) "\"Stiebel Eltron WPL 18\""
    annotation (Placement(transformation(extent={{-40,-14},{-4,20}})));
  Storage.Storage bufferStorageHeatingcoils(
    layer_HE(T_start=T_start_cold),
    layer(T_start=T_start_cold),
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    alpha_in=100,
    alpha_out=10,
    k_HE=300,
    h=1.5,
    V_HE=0.02,
    A_HE=7,
    d=1) annotation (Placement(transformation(extent={{52,-14},{24,20}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=180,
        origin={-34,38})));
  AixLib.Fluid.Sources.Boundary_pT geothField_source(
    redeclare package Medium = Medium,
    T=284.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-158,-60},{-146,-48}})));
  AixLib.Fluid.Movers.Pump pumpGeothermalField(
    redeclare package Medium = Medium,
    V_flow_max=1.5,
    m_flow_small=1E-4*0.5,
    ControlStrategy=1,
    Head_max=10)
    annotation (Placement(transformation(extent={{-90,-58},{-80,-49}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice2(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=0,
        origin={-70,-54})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice1(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={87,-20})));
  inner Utilities.Sources.BaseParameters
                                   baseParameters
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve
                                 valveColdSource(redeclare package Medium =
        Medium, m_flow_small=1E-4*0.5)
    annotation (Placement(transformation(extent={{-36,-61},{-24,-47}})));
  AixLib.Fluid.Actuators.Valves.SimpleValve
                                 valveHeatSource(redeclare package Medium =
        Medium, m_flow_small=1E-4*0.5)                                              annotation (Placement(
        transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-60,1})));
  Storage.Storage bufferStorageHeatingcoils1(
    layer_HE(T_start=T_start_warm),
    layer(T_start=T_start_warm),
    redeclare package Medium = Medium,
    n=5,
    lambda_ins=0.075,
    s_ins=0.2,
    alpha_in=100,
    alpha_out=10,
    k_HE=300,
    A_HE=3,
    h=1,
    V_HE=0.01,
    d=1) annotation (Placement(transformation(extent={{52,-96},{24,-62}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice3(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-18,-78})));
  AixLib.Fluid.Sources.Boundary_pT geothField_sink1(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-158,20},{-146,32}})));
  AixLib.Fluid.Sources.Boundary_pT geothField_sink2(redeclare package Medium =
        Medium, nPorts=1)
    annotation (Placement(transformation(extent={{-158,-15},{-146,-3}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice4(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    zeta=2,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={83,-50})));
  AixLib.Fluid.Actuators.Valves.SimpleValve
                                 valveColdStorage(redeclare package Medium =
        Medium, m_flow_small=1E-4*0.5)                                               annotation (Placement(
        transformation(
        extent={{-6,7},{6,-7}},
        rotation=180,
        origin={-52,38})));
  AixLib.Fluid.Actuators.Valves.SimpleValve
                                 valveHeatStorage(redeclare package Medium =
        Medium, m_flow_small=1E-4*0.5)                                               annotation (Placement(
        transformation(
        extent={{-6,-7},{6,7}},
        rotation=90,
        origin={-18,-63})));

  AixLib.Fluid.Movers.FlowControlled_dp pumpColdConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1])
    annotation (Placement(transformation(extent={{58,-27},{72,-13}})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpHeatConsumer(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_warm[5])
    annotation (Placement(transformation(extent={{56,-57},{70,-43}})));
  Modelica.Blocks.Sources.RealExpression realExpression
    annotation (Placement(transformation(extent={{-28,-144},{-8,-124}})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice5(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={87,32})));
  AixLib.Fluid.FixedResistances.HydraulicResistance orifice6(redeclare package
      Medium =
        Medium,
    m_flow_small=1E-4*0.5,
    zeta=2,
    D=0.05)
           annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=180,
        origin={89,-106})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpCondenser(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1]) annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={-1,-98})));
  AixLib.Fluid.Movers.FlowControlled_dp pumpEvaporator(
    m_flow_nominal=0.05,
    redeclare package Medium = Medium,
    addPowerToMedium=false,
    T_start=T_start_cold[1]) annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=180,
        origin={7,38})));
equation



  connect(pumpGeothermalField.port_b, orifice2.port_a) annotation (Line(
      points={{-80,-53.5},{-78,-53.5},{-78,-54},{-76,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(orifice2.port_b, valveColdSource.port_a) annotation (Line(
      points={{-64,-54},{-36,-54}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveHeatSource.port_a, valveColdSource.port_a) annotation (
      Line(
      points={{-60,-5},{-60,-54},{-36,-54}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(orifice.port_b, valveColdStorage.port_a) annotation (Line(
      points={{-40,38},{-46,38}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(orifice3.port_b, valveHeatStorage.port_a) annotation (Line(
      points={{-18,-72},{-18,-69}},
      color={0,127,255},
      smooth=Smooth.None));

  connect(bufferStorageHeatingcoils.port_a_consumer, pumpColdConsumer.port_a)
    annotation (Line(points={{38,-14},{38,-14},{38,-20},{58,-20}}, color={0,127,
          255}));
  connect(pumpColdConsumer.port_b, orifice1.port_a)
    annotation (Line(points={{72,-20},{80,-20}}, color={0,127,255}));
  connect(pumpHeatConsumer.port_b, orifice4.port_a)
    annotation (Line(points={{70,-50},{73,-50},{76,-50}}, color={0,127,255}));
  connect(valveHeatSource.port_b, heatPumpTab.port_a_source) annotation (Line(
        points={{-60,7},{-60,14.9},{-38.2,14.9}}, color={0,127,255}));
  connect(valveColdStorage.port_b, heatPumpTab.port_a_source) annotation (Line(
        points={{-58,38},{-62,38},{-62,14.9},{-38.2,14.9}}, color={0,127,255}));
  connect(valveColdSource.port_b, heatPumpTab.port_a_sink) annotation (Line(
        points={{-24,-54},{-16,-54},{-5.8,-54},{-5.8,-8.9}}, color={0,127,255}));
  connect(valveHeatStorage.port_b, heatPumpTab.port_a_sink) annotation (Line(
        points={{-18,-57},{-18,-54},{-5.8,-54},{-5.8,-8.9}}, color={0,127,255}));
  connect(heatPumpTab.port_b_sink, geothField_sink1.ports[1]) annotation (Line(
        points={{-5.8,14.9},{2,14.9},{2,26},{-146,26}}, color={0,127,255}));
  connect(geothField_sink2.ports[1], heatPumpTab.port_b_source) annotation (
      Line(points={{-146,-9},{-92,-9},{-92,-8.9},{-38.2,-8.9}},     color={0,127,
          255}));
  connect(geothField_source.ports[1], pumpGeothermalField.port_a) annotation (
      Line(points={{-146,-54},{-90,-54},{-90,-53.5}}, color={0,127,255}));
  connect(bufferStorageHeatingcoils1.port_a_heatGenerator, heatPumpTab.port_b_sink)
    annotation (Line(points={{26.24,-64.04},{10,-64.04},{10,14.9},{-5.8,14.9}},
        color={0,127,255}));
  connect(bufferStorageHeatingcoils1.port_b_consumer, pumpHeatConsumer.port_a)
    annotation (Line(points={{38,-62},{38,-62},{38,-50},{56,-50}}, color={0,127,
          255}));
  connect(orifice5.port_b, bufferStorageHeatingcoils.port_b_consumer)
    annotation (Line(points={{80,32},{38,32},{38,20}}, color={0,127,255}));
  connect(orifice6.port_b, bufferStorageHeatingcoils1.port_a_consumer)
    annotation (Line(points={{82,-106},{72,-106},{38,-106},{38,-96}}, color={0,
          127,255}));
  connect(heatPumpTab.port_b_source, bufferStorageHeatingcoils.port_b_heatGenerator)
    annotation (Line(points={{-38.2,-8.9},{-38.2,-24},{18,-24},{18,-10.6},{
          26.24,-10.6}}, color={0,127,255}));
  connect(pumpEvaporator.port_b, orifice.port_a) annotation (Line(points={{
          -8.88178e-016,38},{-8.88178e-016,38},{-28,38}}, color={0,127,255}));
  connect(bufferStorageHeatingcoils.port_a_heatGenerator, pumpEvaporator.port_a)
    annotation (Line(points={{26.24,17.96},{20,17.96},{20,38},{14,38}}, color={
          0,127,255}));
  connect(bufferStorageHeatingcoils1.port_b_heatGenerator, pumpCondenser.port_a)
    annotation (Line(points={{26.24,-92.6},{16,-92.6},{16,-98},{6,-98}}, color=
          {0,127,255}));
  connect(pumpCondenser.port_b, orifice3.port_a) annotation (Line(points={{-8,
          -98},{-18,-98},{-18,-84}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,
          -120},{160,80}})),              Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-120},{160,80}}),
        graphics={Rectangle(
          extent={{-160,80},{160,-120}},
          lineColor={0,0,255},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid), Text(
          extent={{-10,-6},{32,-26}},
          lineColor={0,0,0},
          fillColor={255,170,85},
          fillPattern=FillPattern.Solid,
          textStyle={TextStyle.Bold},
          textString="Heat
Pump")}),
    experiment(StopTime=3600, Interval=10),
    __Dymola_experimentSetupOutput(
      states=false,
      derivatives=false,
      inputs=false,
      auxiliaries=false),
    Documentation(info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 10pt;\">Information</b> </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Simple model of a combined heat and cold supply system. The geothermal heat pump can either transport heat </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold storage to the geothermal field (heat storage disconnected)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the geothermal field to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">depending on the state of charge of the storages. The three modes are switched automatically by actuating the four valves. All the pumps continuously generate a constant pressure difference. In the flow line of the heating circuit a boiler is switched on if the flow temperature drops below a threshold. Alternatively, a heating rod in the heat storage can be used.</span></p>
<p><br><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Level of Development</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://AixLib/Images/stars3.png\"/> </span></p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Example Results</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem</a> </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><a href=\"AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem2\">AixLib.HVAC.HeatGeneration.Examples.HeatPumpSystem2</a> </p><p></span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"></p><p></span></p>
</html>"));
end GeothermalHeatPumpBase;
