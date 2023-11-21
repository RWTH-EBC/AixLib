within AixLib.Systems.EONERC_Testhall.BaseClass.Distributor;
model Distributor_withoutReserve

   replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);
  HydraulicModules.Throttle                       dhs(
    redeclare package Medium = AixLib.Media.Water,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    Kv=2.5,
    m_flow_nominal=2.3,
    pipe1(length=14),
    pipe2(length=1),
    pipe3(length=6),
    T_amb=273.15 + 10,
    T_start=323.15) "distribute heating system"
    annotation (Placement(transformation(extent={{-10,-20},{90,80}})));

  AixLib.Fluid.Sources.Boundary_ph                FernwaermeAus(
    redeclare package Medium = MediumWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));

  AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
    redeclare package Medium = MediumWater,
    p=120000,
    T=403.15,
    nPorts=1) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-108,50},{-88,70}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe1(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=4.5,
    redeclare package Medium = MediumWater,
    m_flow_nominal=4.2) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={354,50})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=2.3,
    m2_flow_nominal=4.53,
    dp1_nominal=10,
    dp2_nominal=10,
    eps=0.95) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={154,32})));

  HydraulicModules.Pump                       pump(
    redeclare package Medium = MediumWater,
    pipeModel="SimplePipe",
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_64x2(),
    m_flow_nominal=4.2,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_PumpSpeedControlled
      PumpInterface(pumpParam=
          AixLib.DataBase.Pumps.PumpPolynomialBased.Pump_DN30_H1_12()),
    pipe1(length=3.5),
    pipe2(length=7),
    pipe3(length=10),
    T_amb=273.15 + 10,
    T_start=353.15)
    annotation (Placement(transformation(extent={{206,-8},{286,72}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe14(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_76_1x1_5(),
    length=1.5,
    redeclare package Medium = MediumWater,
    m_flow_nominal=4.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={350,-14})));

  AixLib.Fluid.FixedResistances.GenericPipe pipe15(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    length=12,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-52,0})));

  AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
    nPorts=5,
    redeclare package Medium = MediumWater,
    m_flow_nominal=4.2,
    V=0.1,
    p_start=120000,
    T_start=353.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={1110,-36})));

  Modelica.Fluid.Interfaces.FluidPort_b cid_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{1136,350},{
            1156,370}}),
                    iconTransformation(extent={{1144,270},{1164,290}})));
  Modelica.Fluid.Interfaces.FluidPort_a cid_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{1170,348},{
            1190,368}}), iconTransformation(extent={{1180,270},{1200,290}})));
  Modelica.Fluid.Interfaces.FluidPort_b cca_vl(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{1008,350},{1028,370}}),
        iconTransformation(extent={{956,274},{976,294}})));
  Modelica.Fluid.Interfaces.FluidPort_a cca_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{1048,348},{
            1068,368}}), iconTransformation(extent={{984,272},{1004,292}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe2(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=1.79)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1012,180})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe3(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=1.79)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={1066,180})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe4(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.15)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1144,178})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe5(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.15)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={1186,178})));
  Modelica.Fluid.Interfaces.FluidPort_a cph_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{878,348},{
            898,368}}), iconTransformation(extent={{652,270},{672,290}})));
  Modelica.Fluid.Interfaces.FluidPort_b cph_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{832,348},{
            852,368}}), iconTransformation(extent={{626,270},{646,290}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe6(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.54)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={844,196})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe7(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.54)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={890,192})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_h_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{560,350},{
            580,370}}), iconTransformation(extent={{1350,250},{1370,270}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_h_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{630,348},{
            650,368}}), iconTransformation(extent={{1352,224},{1372,244}})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{700,348},{
            720,368}}), iconTransformation(extent={{1352,156},{1372,176}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{730,350},{
            750,370}}), iconTransformation(extent={{1352,126},{1372,146}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe8(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.45)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={714,204})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe9(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_22x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=0.45)
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={750,204})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe10(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=1.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={574,142})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe11(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=1.2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={642,138})));
  AixLib.Fluid.Sources.Boundary_pT ret_c1(
    redeclare package Medium = AixLib.Media.Water,
    p=100000,
    use_T_in=false,
    nPorts=1) annotation (Placement(transformation(extent={{392,-44},{376,-28}})));
  DistributeBus distributeBus_DHS annotation (Placement(transformation(extent={
            {138,124},{174,162}}), iconTransformation(extent={{-112,-16},{-86,
            14}})));
  AixLib.Fluid.Sensors.MassFlowRate senMasFlo_hydraulics(redeclare package
      Medium = AixLib.Media.Water)
    annotation (Placement(transformation(extent={{316,40},{336,60}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        AixLib.Media.Water, m_flow_nominal=4.2)
    annotation (Placement(transformation(extent={{332,-24},{312,-4}})));
  Controller.ControlDHS_n_const controlDHS_n_const
    annotation (Placement(transformation(extent={{48,180},{104,232}})));
equation
  connect(FernwaermeEin.ports[1], dhs.port_a1)
    annotation (Line(points={{-88,60},{-10,60}}, color={0,127,255}));
  connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{90,60},{116,60},{
          116,60},{148,60},{148,42}}, color={0,127,255}));
  connect(hex.port_b1, dhs.port_a2)
    annotation (Line(points={{148,22},{148,0},{90,0}}, color={0,127,255}));

  connect(hex.port_b2, pump.port_a1)
    annotation (Line(points={{160,42},{160,56},{206,56}}, color={0,127,255}));
  connect(hex.port_a2, pump.port_b2)
    annotation (Line(points={{160,22},{160,8},{206,8}}, color={0,127,255}));

  connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-92,0},
          {-78,0},{-78,1.77636e-15},{-62,1.77636e-15}}, color={0,127,255}));
  connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-42,-8.88178e-16},
          {-26,-8.88178e-16},{-26,0},{-10,0}}, color={0,127,255}));

  connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{364,50},{364,48},
          {1012,48},{1012,170}}, color={0,127,255}));
  connect(pipe4.port_a, pipe1.port_b) annotation (Line(points={{1144,168},{1144,
          50},{364,50}}, color={0,127,255}));
  connect(pipe6.port_a, pipe1.port_b)
    annotation (Line(points={{844,186},{844,50},{364,50}}, color={0,127,255}));
  connect(pipe10.port_a, pipe1.port_b) annotation (Line(points={{574,132},{572,
          132},{572,50},{364,50}}, color={0,127,255}));
  connect(pipe8.port_a, pipe1.port_b) annotation (Line(points={{714,194},{712,
          194},{712,50},{364,50}}, color={0,127,255}));
  connect(pipe10.port_b, rlt_h_vl) annotation (Line(points={{574,152},{570,152},
          {570,360}}, color={0,127,255}));
  connect(pipe11.port_a, rlt_h_rl) annotation (Line(points={{642,148},{642,150},
          {640,150},{640,358}},
                      color={0,127,255}));
  connect(pipe11.port_b, vol1.ports[1]) annotation (Line(points={{642,128},{642,
          -12},{748,-12},{748,-26},{1111.6,-26}},
        color={0,127,255}));
  connect(pipe8.port_b, rlt_ph_vl) annotation (Line(points={{714,214},{710,214},
          {710,358}}, color={0,127,255}));
  connect(pipe9.port_a, rlt_ph_rl) annotation (Line(points={{750,214},{740,214},
          {740,360}}, color={0,127,255}));
  connect(pipe9.port_b, vol1.ports[1]) annotation (Line(points={{750,194},{750,
          -26},{1111.6,-26}},
                            color={0,127,255}));
  connect(pipe7.port_a, cph_rl) annotation (Line(points={{890,202},{888,202},{
          888,358}}, color={0,127,255}));
  connect(pipe6.port_b, cph_vl) annotation (Line(points={{844,206},{844,282},{
          842,282},{842,358}}, color={0,127,255}));
  connect(pipe7.port_b, vol1.ports[2]) annotation (Line(points={{890,182},{888,
          182},{888,-12},{1064,-12},{1064,-26},{1110.8,-26}},  color={0,127,255}));
  connect(pipe5.port_a, cid_rl) annotation (Line(points={{1186,188},{1184,188},
          {1184,340},{1180,340},{1180,358}}, color={0,127,255}));
  connect(pipe5.port_b, vol1.ports[3]) annotation (Line(points={{1186,168},{
          1184,168},{1184,-16},{1110,-16},{1110,-26}},       color={0,127,255}));
  connect(pipe4.port_b, cid_vl) annotation (Line(points={{1144,188},{1146,188},
          {1146,360}}, color={0,127,255}));
  connect(pipe2.port_b, cca_vl) annotation (Line(points={{1012,190},{1012,340},
          {1018,340},{1018,360}}, color={0,127,255}));
  connect(pipe3.port_a, cca_rl) annotation (Line(points={{1066,190},{1058,190},
          {1058,358}}, color={0,127,255}));
  connect(pipe3.port_b, vol1.ports[4]) annotation (Line(points={{1066,170},{
          1064,170},{1064,-26},{1109.2,-26}},  color={0,127,255}));
  connect(distributeBus_DHS.bus_dhs, dhs.hydraulicBus) annotation (Line(
      points={{156.09,143.095},{156.09,100},{40,100},{40,80}},
      color={255,204,51},
      thickness=0.5));
  connect(distributeBus_DHS.bus_dhs_pump, pump.hydraulicBus) annotation (Line(
      points={{156.09,143.095},{156.09,84},{246,84},{246,72}},
      color={255,204,51},
      thickness=0.5));
  connect(senMasFlo_hydraulics.port_b, pipe1.port_a)
    annotation (Line(points={{336,50},{344,50}}, color={0,127,255}));
  connect(senMasFlo_hydraulics.port_a, pump.port_b1)
    annotation (Line(points={{316,50},{316,56},{286,56}}, color={0,127,255}));
  connect(senMasFlo_hydraulics.m_flow, distributeBus_DHS.bus_dhs.mFlow)
    annotation (Line(points={{326,61},{324,61},{324,68},{336,68},{336,136},{184,
          136},{184,143.095},{156.09,143.095}}, color={0,0,127}));
  connect(ret_c1.ports[1], pipe14.port_a) annotation (Line(points={{376,-36},{370,
          -36},{370,-14},{360,-14}}, color={0,127,255}));
  connect(pipe14.port_b, senTem.port_a) annotation (Line(points={{340,-14},{336,
          -14},{336,-14},{332,-14}}, color={0,127,255}));
  connect(senTem.port_b, pump.port_a2) annotation (Line(points={{312,-14},{296,-14},
          {296,8},{286,8}}, color={0,127,255}));
  connect(vol1.ports[5], pipe14.port_a) annotation (Line(points={{1108.4,-26},{
          1064,-26},{1064,-14},{360,-14}}, color={0,127,255}));
  connect(senTem.T, distributeBus_DHS.bus_dhs.T_RL) annotation (Line(points={{322,-3},
          {322,14},{302,14},{302,122},{156.09,122},{156.09,143.095}},     color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(distributeBus_DHS, controlDHS_n_const.distributeBus_DHS) annotation (
      Line(
      points={{156,143},{156,205.74},{103.44,205.74}},
      color={255,204,51},
      thickness=0.5));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -100},{1460,360}}),
                          graphics={
        Rectangle(
          extent={{-160,360},{1460,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{104,124},{216,74}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{112,116},{198,100}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          fontSize=8,
          textString="Internal Control"),
        Rectangle(
          extent={{100,70},{60,274}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-151},{-20,151}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          origin={211,260},
          rotation=-90),
        Rectangle(
          extent={{20,-80},{-20,80}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,260},
          rotation=-90),
        Rectangle(
          extent={{40,70},{0,274}},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-151},{-20,151}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={513,260},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-151},{-20,151}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={211,50},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-151},{-20,151}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={513,50},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-80},{-20,80}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={-40,50},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-350},{-20,350}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={1014,260},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{20,-349},{-20,349}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={1011,50},
          rotation=-90,
          lineColor={0,0,0}),
        Rectangle(
          extent={{19.5,-124.5},{-19.5,124.5}},
          pattern=LinePattern.None,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          origin={1344.5,154.5},
          rotation=180,
          lineColor={0,0,0}),
        Ellipse(
          extent={{330,300},{406,232}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{42,280},{48,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{52,280},{58,30}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-160,-100},{1460,360}})),
    experiment(StopTime=10000, __Dymola_Algorithm="Dassl"));
end Distributor_withoutReserve;
