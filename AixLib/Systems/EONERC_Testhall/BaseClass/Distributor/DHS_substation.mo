within AixLib.Systems.EONERC_Testhall.BaseClass.Distributor;
model DHS_substation "District heating substation"

  HydraulicModules.Throttle                       dhs(
    redeclare package Medium = AixLib.Media.Water,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    Kv=2.5,
    m_flow_nominal=2.3,
    pipe1(length=14),
    pipe2(length=1),
    pipe3(length=6),
    T_amb=273.15 + 10,
    T_start=323.15) "distribute heating system"
    annotation (Placement(transformation(extent={{-60,-20},{-20,20}})));

  AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
    redeclare package Medium = AixLib.Media.Water,
    p=750000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-142,-40},{-122,-20}})));

  AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
    redeclare package Medium = AixLib.Media.Water,
    p=1150000,
    T=373.15,
    nPorts=1) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe1(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=4.5,
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2)   annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={90,30})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
    redeclare package Medium1 = AixLib.Media.Water,
    redeclare package Medium2 = AixLib.Media.Water,
    m1_flow_nominal=2.3,
    m2_flow_nominal=2,
    dp1_nominal=10,
    dp2_nominal=10,
    eps=0.95) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90)));

  HydraulicModules.Pump                       pump(
    redeclare package Medium = AixLib.Media.Water,
    pipeModel="SimplePipe",
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_64x2(),
    m_flow_nominal=3,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
      PumpInterface(pumpParam=
          AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
    pipe1(length=3.5),
    pipe2(length=7),
    pipe3(length=10),
    T_amb=273.15 + 10,
    T_start=353.15)
    annotation (Placement(transformation(extent={{20,-20},{60,20}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe14(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=1.5,
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2)   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-30})));

  AixLib.Fluid.FixedResistances.GenericPipe pipe15(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    length=12,
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,-12})));

  AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=3,
    V=0.1,
    p_start=120000,
    T_start=353.15,
    nPorts=2)       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={140,-50})));

  AixLib.Fluid.Sources.Boundary_pT ret_c1(
    redeclare package Medium = AixLib.Media.Water,
    p=100000,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{8,-8},{-8,8}},
        rotation=270,
        origin={110,-70})));
  DistributeBus distributeBus_DHS annotation (Placement(transformation(extent={{-20,80},
            {16,118}}),            iconTransformation(extent={{-20,80},{20,120}})));
  Controller.ControlDHS controlDHS_n_const
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Fluid.Sensors.Pressure senPressure_sup(redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Fluid.Sensors.Pressure senPressure_ret(redeclare package Medium =
        AixLib.Media.Water)
    annotation (Placement(transformation(extent={{60,-40},{80,-60}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{150,20},{170,40}}),
        iconTransformation(extent={{148,60},{168,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{150,-40},{170,-20}}),
        iconTransformation(extent={{148,-80},{168,-60}})));
equation
  connect(FernwaermeEin.ports[1], dhs.port_a1)
    annotation (Line(points={{-120,30},{-108,30},{-108,12},{-60,12}},
                                                 color={0,127,255}));
  connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{-20,12},{-6,12},{
          -6,10}},                    color={0,127,255}));
  connect(hex.port_b1, dhs.port_a2)
    annotation (Line(points={{-6,-10},{-6,-12},{-20,-12}},
                                                       color={0,127,255}));

  connect(hex.port_b2, pump.port_a1)
    annotation (Line(points={{6,10},{6,12},{20,12}},      color={0,127,255}));
  connect(hex.port_a2, pump.port_b2)
    annotation (Line(points={{6,-10},{6,-12},{20,-12}}, color={0,127,255}));

  connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-122,
          -30},{-110,-30},{-110,-12},{-100,-12}},       color={0,127,255}));
  connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-80,-12},{-60,
          -12}},                               color={0,127,255}));

  connect(distributeBus_DHS.bus_dhs, dhs.hydraulicBus) annotation (Line(
      points={{-1.91,99.095},{-1.91,100},{-40,100},{-40,20}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_DHS.bus_dhs_pump, pump.hydraulicBus) annotation (Line(
      points={{-1.91,99.095},{-1.91,100},{40,100},{40,20}},
      color={255,204,51},
      thickness=0.5));
  connect(ret_c1.ports[1], pipe14.port_a) annotation (Line(points={{110,-62},{
          110,-30},{100,-30}},       color={0,127,255}));
  connect(distributeBus_DHS, controlDHS_n_const.distributeBus_DHS) annotation (
      Line(
      points={{-2,99},{-2,100},{-60,100},{-60,70},{-66,70},{-66,69.9},{-80.2,
          69.9}},
      color={255,204,51},
      thickness=0.5));
  connect(pump.port_b1, pipe1.port_a) annotation (Line(points={{60,12},{70,12},
          {70,30},{80,30}},            color={0,127,255}));
  connect(senPressure_sup.port, pump.port_b1) annotation (Line(points={{70,40},
          {70,12},{60,12}},            color={0,127,255}));
  connect(pipe14.port_b, pump.port_a2) annotation (Line(points={{80,-30},{70,
          -30},{70,-12},{60,-12}},   color={0,127,255}));
  connect(senPressure_ret.port, pump.port_a2) annotation (Line(points={{70,-40},
          {70,-12},{60,-12}},                 color={0,127,255}));
  connect(senPressure_sup.p, distributeBus_DHS.bus_dhs_pump.p_sup) annotation (
      Line(points={{81,50},{92,50},{92,100},{-1.91,100},{-1.91,99.095}},
        color={0,0,127}));
  connect(senPressure_ret.p, distributeBus_DHS.bus_dhs_pump.p_ret) annotation (
      Line(points={{81,-50},{120,-50},{120,100},{-1.91,100},{-1.91,99.095}},
                                                                    color={0,0,127}));
  connect(pipe1.port_b, port_b1)
    annotation (Line(points={{100,30},{160,30}}, color={0,127,255}));
  connect(port_a, vol1.ports[1]) annotation (Line(points={{160,-30},{141,-30},{
          141,-40}}, color={0,127,255}));
  connect(pipe14.port_a, vol1.ports[2]) annotation (Line(points={{100,-30},{139,
          -30},{139,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(                           extent={{-160,
            -100},{160,100}}),
                          graphics={
        Rectangle(
          extent={{-160,100},{160,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-122,20},{-42,-20}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,60},{-160,80}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,-75},{-10,75}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          origin={85,70},
          rotation=-90),
        Rectangle(
          extent={{-10,-60},{-28,60}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,-76},{-10,76}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={84,-70},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{10,-75},{-10,75}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-85,-70},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{4,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-83,20},{-43,0},{-83,-20}},
          color={95,95,95},
          thickness=0.5),
        Rectangle(
          extent={{-10,80},{-4,-80}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-60,-8},{60,8}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={18,0},
          rotation=-90,
          lineColor={0,0,0})}),             Diagram(coordinateSystem(
                                     extent={{-160,-100},{160,100}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
end DHS_substation;
