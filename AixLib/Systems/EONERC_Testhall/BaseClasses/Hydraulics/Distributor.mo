within AixLib.Systems.EONERC_Testhall.BaseClasses.Hydraulics;
model Distributor

   replaceable package MediumWater =
      AixLib.Media.Water
    "Medium in the heatingsystem/hydraulic" annotation(choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);
  AixLib.Systems.HydraulicModules.Throttle dhs(
    redeclare package Medium = AixLib.Media.Water,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    Kv=5,
    m_flow_nominal=2.3,
    valve(dpFixed_nominal=10),
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

  Modelica.Blocks.Sources.Constant valve_set(k=1)   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-34,146})));
  AixLib.Fluid.Sources.Boundary_pT                FernwaermeEin(
    redeclare package Medium = MediumWater,
    p=120000,
    T=403.15,
    nPorts=1) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-108,50},{-88,70}})));
  Modelica.Blocks.Sources.Constant n(k=1700)
    annotation (Placement(transformation(extent={{184,154},{204,174}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe1(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
    length=5,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={354,50})));

  AixLib.Fluid.HeatExchangers.ConstantEffectiveness     hex(
    redeclare package Medium1 = MediumWater,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=2.3,
    m2_flow_nominal=2.3,
    dp1_nominal=10,
    dp2_nominal=10,
    eps=0.95) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={154,32})));

  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus2
    annotation (Placement(transformation(extent={{248,98},{268,118}}), iconTransformation(
          extent={{0,0},{0,0}})));
  AixLib.Systems.HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
    annotation (Placement(transformation(extent={{32,114},
            {52,134}}),                                                iconTransformation(extent=
           {{0,0},{0,0}})));
  AixLib.Systems.HydraulicModules.Pump
                           pump(
    redeclare package Medium = MediumWater,
    length=1,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    m_flow_nominal=2.3,
    redeclare
      AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per)),
    pipe1(length=3.5),
    pipe2(length=7),
    pipe3(length=10),
    T_amb=273.15 + 10,
    T_start=353.15)
    annotation (Placement(transformation(extent={{210,-8},{290,72}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow reserve(alpha=0.02)
                                                                   annotation (
      Placement(transformation(
        extent={{-15,-15},{15,15}},
        rotation=270,
        origin={1339,325})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe14(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_66_7x1_2(),
    length=2,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={318,-12})));

  AixLib.Fluid.FixedResistances.GenericPipe pipe15(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_42x1(),
    length=12,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-52,0})));

  AixLib.Fluid.FixedResistances.GenericPipe reserve_rl(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_16x1(),
    length=1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={1338,144})));

  AixLib.Fluid.MixingVolumes.MixingVolume reserve_volume(
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3,
    V=0.012,
    nPorts=2,
    T_start=323.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={1364,198})));
  AixLib.Fluid.FixedResistances.GenericPipe reserve_vl(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_16x1(),
    length=1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1398,148})));

  Modelica.Blocks.Interfaces.RealInput heatflow_reserve annotation (Placement(
        transformation(
        extent={{-17,-17},{17,17}},
        rotation=270,
        origin={1339,381}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={520,300})));
  AixLib.Fluid.MixingVolumes.MixingVolume     vol1(
    nPorts=7,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3,
    V=0.012,
    p_start=120000,
    T_start=353.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={1250,-36})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{178,112},{198,132}})));
  Modelica.Fluid.Interfaces.FluidPort_b cid_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{1176,346},{
            1196,366}}),
                    iconTransformation(extent={{1144,270},{1164,290}})));
  Modelica.Fluid.Interfaces.FluidPort_a cid_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{1132,346},{
            1152,366}}),
                    iconTransformation(extent={{1180,270},{1200,290}})));
  Modelica.Fluid.Interfaces.FluidPort_b cca_rl(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{1064,348},{1084,368}}),
        iconTransformation(extent={{1012,272},{1032,292}})));
  Modelica.Fluid.Interfaces.FluidPort_a cca_vl(redeclare package Medium =
        MediumWater)
    annotation (Placement(transformation(extent={{1004,348},{1024,368}}),
        iconTransformation(extent={{984,272},{1004,292}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe2(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1012,180})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe3(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_54x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1066,180})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe4(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1144,178})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe5(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_28x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={1186,178})));
  Modelica.Fluid.Interfaces.FluidPort_a cph_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{834,348},{
            854,368}}), iconTransformation(extent={{652,270},{672,290}})));
  Modelica.Fluid.Interfaces.FluidPort_b cph_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{880,348},{
            900,368}}), iconTransformation(extent={{686,270},{706,290}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe6(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={844,196})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe7(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={890,194})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_h_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{626,348},{
            646,368}}), iconTransformation(extent={{1354,198},{1374,218}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_h_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{594,348},{
            614,368}}), iconTransformation(extent={{1352,224},{1372,244}})));
  Modelica.Fluid.Interfaces.FluidPort_b rlt_ph_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{736,348},{
            756,368}}), iconTransformation(extent={{1354,98},{1374,118}})));
  Modelica.Fluid.Interfaces.FluidPort_a rlt_ph_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{700,348},{
            720,368}}), iconTransformation(extent={{1352,126},{1372,146}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe8(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={714,204})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe9(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={750,204})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe10(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={606,208})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe11(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=0.1,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={642,208})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe12(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=5.2,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) "jn"
                        annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={416,278})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe13(
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_35x1(),
    length=5.2,
    redeclare package Medium = MediumWater,
    m_flow_nominal=2.3) "jn"
                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={486,282})));
  Modelica.Fluid.Interfaces.FluidPort_b jn_rl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{474,354},{
            494,374}}), iconTransformation(extent={{816,270},{836,290}})));
  Modelica.Fluid.Interfaces.FluidPort_a jn_vl(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{406,356},{
            426,376}}), iconTransformation(extent={{850,270},{870,290}})));
equation
  connect(FernwaermeEin.ports[1], dhs.port_a1)
    annotation (Line(points={{-88,60},{-10,60}}, color={0,127,255}));
  connect(dhs.port_b1, hex.port_a1) annotation (Line(points={{90,60},{116,60},{
          116,60},{148,60},{148,42}}, color={0,127,255}));
  connect(hex.port_b1, dhs.port_a2)
    annotation (Line(points={{148,22},{148,0},{90,0}}, color={0,127,255}));

  connect(n.y, hydraulicBus2.pumpBus.rpmSet) annotation (Line(points={{205,164},
          {232.5,164},{232.5,108.05},{258.05,108.05}}, color={0,0,127}));
  connect(hex.port_b2, pump.port_a1)
    annotation (Line(points={{160,42},{160,56},{210,56}}, color={0,127,255}));
  connect(hex.port_a2, pump.port_b2)
    annotation (Line(points={{160,22},{160,8},{210,8}}, color={0,127,255}));
  connect(pump.port_b1, pipe1.port_a) annotation (Line(points={{290,56},{316,
          56},{316,50},{344,50}}, color={0,127,255}));
  connect(hydraulicBus1, dhs.hydraulicBus) annotation (Line(
      points={{42,124},{42,80},{40,80}},
      color={255,204,51},
      thickness=0.5));

  connect(pump.hydraulicBus, hydraulicBus2) annotation (Line(
      points={{250,72},{258,72},{258,108}},
      color={255,204,51},
      thickness=0.5));

  connect(pump.port_a2, pipe14.port_a) annotation (Line(points={{290,8},{299,8},
          {299,-12},{308,-12}},
                              color={0,127,255}));
  connect(FernwaermeAus.ports[1], pipe15.port_a) annotation (Line(points={{-92,0},
          {-78,0},{-78,1.77636e-15},{-62,1.77636e-15}}, color={0,127,255}));
  connect(pipe15.port_b, dhs.port_b2) annotation (Line(points={{-42,-8.88178e-16},
          {-26,-8.88178e-16},{-26,0},{-10,0}}, color={0,127,255}));

  connect(reserve_volume.heatPort, reserve.port) annotation (Line(points={{1354,
          198},{1339,198},{1339,310}}, color={191,0,0}));
  connect(reserve.Q_flow, heatflow_reserve) annotation (Line(points={{1339,340},
          {1339,381}},                       color={0,0,127}));

  connect(vol1.ports[1], pipe14.port_b) annotation (Line(points={{1251.71,-26},
          {376,-26},{376,-12},{328,-12}},color={0,127,255}));

  connect(valve_set.y, hydraulicBus1.valveSet) annotation (Line(points={{-23,
          146},{42.05,146},{42.05,124.05}}, color={0,0,127}));
  connect(booleanExpression.y, hydraulicBus2.pumpBus.onSet) annotation (Line(
        points={{199,122},{199,120},{228,120},{228,108.05},{258.05,108.05}},
        color={255,0,255}));
  connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{364,50},{364,48},
          {1012,48},{1012,170}}, color={0,127,255}));
  connect(pipe2.port_b, cca_vl) annotation (Line(points={{1012,190},{1014,190},
          {1014,358}}, color={0,127,255}));
  connect(pipe3.port_b, cca_rl) annotation (Line(points={{1066,190},{1074,190},
          {1074,358}}, color={0,127,255}));
  connect(pipe3.port_a, vol1.ports[1]) annotation (Line(points={{1066,170},{
          1064,170},{1064,-26},{1251.71,-26}}, color={0,127,255}));
  connect(pipe4.port_b, cid_vl) annotation (Line(points={{1144,188},{1144,272},
          {1142,272},{1142,356}}, color={0,127,255}));
  connect(pipe5.port_b, cid_rl)
    annotation (Line(points={{1186,188},{1186,356}}, color={0,127,255}));
  connect(pipe4.port_a, pipe1.port_b) annotation (Line(points={{1144,168},{1144,
          50},{364,50}}, color={0,127,255}));
  connect(pipe5.port_a, vol1.ports[2]) annotation (Line(points={{1186,168},{
          1184,168},{1184,-26},{1251.14,-26}}, color={0,127,255}));
  connect(pipe6.port_a, pipe1.port_b)
    annotation (Line(points={{844,186},{844,50},{364,50}}, color={0,127,255}));
  connect(pipe6.port_b, cph_vl)
    annotation (Line(points={{844,206},{844,358}}, color={0,127,255}));
  connect(pipe7.port_b, cph_rl)
    annotation (Line(points={{890,204},{890,358}}, color={0,127,255}));
  connect(pipe7.port_a, vol1.ports[3]) annotation (Line(points={{890,184},{888,
          184},{888,-26},{1250.57,-26}},
                                      color={0,127,255}));
  connect(pipe10.port_a, pipe1.port_b) annotation (Line(points={{606,198},{604,
          198},{604,50},{364,50}}, color={0,127,255}));
  connect(pipe8.port_a, pipe1.port_b) annotation (Line(points={{714,194},{712,
          194},{712,50},{364,50}}, color={0,127,255}));
  connect(pipe10.port_b, rlt_h_vl) annotation (Line(points={{606,218},{604,218},
          {604,358}}, color={0,127,255}));
  connect(pipe8.port_b, rlt_ph_vl) annotation (Line(points={{714,214},{710,214},
          {710,358}}, color={0,127,255}));
  connect(pipe11.port_b, rlt_h_rl) annotation (Line(points={{642,218},{640,218},
          {640,340},{636,340},{636,358}}, color={0,127,255}));
  connect(pipe9.port_b, rlt_ph_rl) annotation (Line(points={{750,214},{746,214},
          {746,358}}, color={0,127,255}));
  connect(pipe11.port_a, vol1.ports[4]) annotation (Line(points={{642,198},{640,
          198},{640,-26},{1250,-26}},    color={0,127,255}));
  connect(pipe9.port_a, vol1.ports[5]) annotation (Line(points={{750,194},{748,
          194},{748,-26},{1249.43,-26}}, color={0,127,255}));
  connect(pipe12.port_b, jn_vl)
    annotation (Line(points={{416,288},{416,366}}, color={0,127,255}));
  connect(pipe13.port_a, jn_rl) annotation (Line(points={{486,292},{484,292},{
          484,364}}, color={0,127,255}));
  connect(pipe12.port_a, pipe1.port_b)
    annotation (Line(points={{416,268},{416,50},{364,50}}, color={0,127,255}));
  connect(pipe13.port_b, vol1.ports[6]) annotation (Line(points={{486,272},{484,
          272},{484,-26},{1248.86,-26}}, color={0,127,255}));
  connect(reserve_rl.port_a, reserve_volume.ports[1]) annotation (Line(points={
          {1338,154},{1363,154},{1363,188}}, color={0,127,255}));
  connect(reserve_vl.port_b, reserve_volume.ports[2]) annotation (Line(points={
          {1398,158},{1365,158},{1365,188}}, color={0,127,255}));
  connect(reserve_rl.port_b, vol1.ports[7]) annotation (Line(points={{1338,134},
          {1336,134},{1336,-26},{1248.29,-26}}, color={0,127,255}));
  connect(pipe1.port_b, reserve_vl.port_a) annotation (Line(points={{364,50},{
          1400,50},{1400,138},{1398,138}}, color={0,127,255}));
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
end Distributor;
