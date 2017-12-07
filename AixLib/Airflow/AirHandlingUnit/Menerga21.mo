within AixLib.Airflow.AirHandlingUnit;
model Menerga21 "A modular model of the Menerga SorpSolair"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;
  import SI = Modelica.SIunits;

  parameter SI.Temperature T_init = 293.15 "initialisation temperature";
  parameter SI.MassFlowRate mWat_mflow_nominal( min=0, max=1) = 0.2
                 "nominal mass flow of water in kg/s";
  parameter SI.MassFlowRate mWat_mflow_small(  min=0, max=1) = mWat_mflow_nominal / 10000
                 "leakage mass flow of water";

  parameter SI.MassFlowRate mFlowSup=5
  "Nominal mass flow rate of supply air";
  parameter SI.MassFlowRate mFlowReg=1
  "Nominal mass flow rate regeneration air";

    parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  Modelica.Fluid.Interfaces.FluidPort_a outsideAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for external Air (positive design flow direction is from outsideAir to SupplyAir)"
    annotation (Placement(transformation(extent={{350,16},{370,36}}),
        iconTransformation(extent={{350,16},{370,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for supply Air (positive design flow direction is from outsideAir to supplyAir)"
    annotation (Placement(transformation(extent={{-650,16},{-630,36}}),
        iconTransformation(extent={{-650,16},{-630,36}})));

  Fluid.Movers.FlowControlled_dp     outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    T_start=T_init,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_start=600,
    init=Modelica.Blocks.Types.Init.InitialOutput,
    m_flow_nominal=mFlowSup)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{126,16},{106,36}})));

  Modelica.Fluid.Interfaces.FluidPort_b ExitAir(
    redeclare package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-60,350},{-40,370}}),
        iconTransformation(extent={{-60,350},{-40,370}})));
  Modelica.Fluid.Interfaces.FluidPort_a exhaustAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust Air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-650,292},{-630,312}}),
        iconTransformation(extent={{-650,292},{-630,312}})));
  Fluid.Movers.FlowControlled_dp     exhAirFan_N02(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    T_start=T_init,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_start=1000,
    init=Modelica.Blocks.Types.Init.InitialOutput,
    m_flow_nominal=mFlowSup)
    "provides pressure difference to transport the exhaust air"
    annotation (Placement(transformation(extent={{-442,292},{-422,312}})));
  Fluid.Movers.FlowControlled_dp     regenerationAirFan_N03(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    T_start=T_init,
    nominalValuesDefineDefaultPressureCurve=true,
    m_flow_nominal=mFlowReg)
    "provides pressure difference to deliver regeneration air"
    annotation (Placement(transformation(extent={{200,290},{180,310}})));
  Fluid.Sensors.TemperatureTwoPort T01_senTemSup(redeclare package Medium =
        MediumAir,
        T_start=T_init,
    m_flow_nominal=mFlowSup)
                        "Temperature of supply air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-558,16},{-578,36}})));
  Fluid.Sensors.TemperatureTwoPort sen_TRek(redeclare package Medium =
        MediumAir,
        T_start=T_init,
    m_flow_nominal=mFlowSup)
    "Temperature of supply air before recuperator"
    annotation (Placement(transformation(extent={{-148,18},{-168,38}})));
  Fluid.Sensors.TemperatureTwoPort sen_TMix(
    redeclare package Medium = MediumAir,
    T_start=T_init,
    m_flow_nominal=mFlowSup)
                    "Temperature of supply air after SteamHumidifier"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-412,84})));
  Fluid.Sensors.TemperatureTwoPort T02_senTemExh(redeclare package Medium =
        MediumAir,
        T_start=T_init,
    m_flow_nominal=mFlowSup)
                        "Temperature of the Exhaust Air"
    annotation (Placement(transformation(extent={{-598,292},{-578,312}})));
  Fluid.Sensors.TemperatureTwoPort sen_TFo(
    redeclare package Medium = MediumAir,
    T_start=T_init,
    m_flow_nominal=mFlowSup)
                    "Temperature of the exit air after recuperator"
    annotation (Placement(transformation(extent={{-148,292},{-128,312}})));
  Fluid.Sensors.TemperatureTwoPort T04_senTemOut(redeclare package Medium =
        MediumAir,
        T_start=T_init,
    m_flow_nominal=mFlowSup + mFlowReg)
                        "Temperature of Outside Air"
    annotation (Placement(transformation(extent={{334,16},{314,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort T01_senRelHumSup(redeclare package
      Medium = MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of Supply Air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-594,16},{-614,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort T03_senRelHumHea(redeclare package
      Medium = MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of Supply Air after heating coil"
    annotation (Placement(transformation(extent={{-486,16},{-506,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rhMix(redeclare package Medium =
        MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of Supply Air after heating coil" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-412,44})));
  Fluid.Sensors.RelativeHumidityTwoPort T02_senRelHumExh(redeclare package
      Medium = MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of Exhaust Air"
    annotation (Placement(transformation(extent={{-554,292},{-534,312}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rhFo(redeclare package Medium =
        MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of exit air after recuperator"
    annotation (Placement(transformation(extent={{-112,292},{-92,312}})));
  Fluid.Sensors.RelativeHumidityTwoPort T04_senRelHumOut(redeclare package
      Medium = MediumAir, m_flow_nominal=mFlowSup + mFlowReg)
    "Relative Humidity of Outside Air"
    annotation (Placement(transformation(extent={{290,16},{270,36}})));
  Fluid.Sensors.TemperatureTwoPort senTemReg(redeclare package Medium =
        MediumAir,
        T_start=T_init,
    m_flow_nominal=mFlowReg)
    "Temperature of Outside Air in Regeneration Vent" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={204,254})));
  ComponentsAHU.Recuperator       recuperator(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=mFlowSup,
    m2_flow_nominal=mFlowSup)
    annotation (Placement(transformation(extent={{-396,132},{-320,202}})));
  ComponentsAHU.heatingRegister heatingRegister(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    T_init=T_init,
    m2_flow_nominal=2,
    m1_flow_nominal=mFlowSup)
    annotation (Placement(transformation(extent={{-430,10},{-450,30}})));
  BaseClasses.BusActors busActors "Bus connector for actor signals" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-186,364}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={52,360})));
  BaseClasses.BusSensors busSensors annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-304,370}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-322,360})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y05(
    redeclare package Medium = MediumAir,
    dpValve_nominal=10,
    m_flow_nominal=mFlowSup)
                        "damper at entry to supply air stream"
             annotation (Placement(transformation(extent={{164,16},{144,36}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y07(
    redeclare package Medium = MediumAir,
    dpValve_nominal=10,
    m_flow_nominal=mFlowReg)
             "damper at entry of regeneration air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={204,178})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y08(
    redeclare package Medium = MediumAir,
    dpValve_nominal=10,
    m_flow_nominal=mFlowReg)
             "damper at exit of regeneration air"
    annotation (Placement(transformation(extent={{20,292},{0,312}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y04(
    redeclare package Medium = MediumAir,
    dpValve_nominal=10,
    m_flow_nominal=mFlowSup)
             "damper at exit of exhaust air side"
    annotation (Placement(transformation(extent={{-80,292},{-60,312}})));
  Fluid.FixedResistances.PressureDrop resSupAir(
    redeclare package Medium = MediumAir,
    dp_nominal=1025,
    m_flow_nominal=mFlowSup)
                     "combined pressure loss of supply air side"
    annotation (Placement(transformation(extent={{-94,18},{-114,38}})));
  Fluid.FixedResistances.PressureDrop resExhAir(
    redeclare package Medium = MediumAir,
    dp_nominal=85 + 443,
    m_flow_nominal=mFlowSup)
                    "combined pressure loss of exhaust air " annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-174,302})));
  Fluid.FixedResistances.PressureDrop resRegAir(
    redeclare package Medium = MediumAir,
    dp_nominal=15 + 250,
    m_flow_nominal=mFlowReg)
                    "combined pressure loss of regeneration air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={116,300})));
  Fluid.FixedResistances.PressureDrop resOutAir(
    redeclare package Medium = MediumAir,
    dp_nominal=258,
    m_flow_nominal=mFlowSup + mFlowReg)
                    "combined pressure loss of outside air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={236,26})));
  Fluid.Sensors.Pressure p02_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for exhaust air inlet pressure"
    annotation (Placement(transformation(extent={{-508,326},{-488,346}})));
  Fluid.Sensors.Pressure p01_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for supply air outlet"
    annotation (Placement(transformation(extent={{-506,6},{-526,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_a watInlHeaCoi(redeclare package Medium =
        MediumWater) "water inlet for the heating coil"
    annotation (Placement(transformation(extent={{-462,-110},{-442,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b watOutHeaCoi(redeclare package Medium =
        MediumWater) "water outlet in the heating coil outlet"
    annotation (Placement(transformation(extent={{-438,-110},{-418,-90}})));
  ComponentsAHU.sorptionPartialPressure sorptionDehumidification(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    T_init=T_init)
    annotation (Placement(transformation(extent={{48,132},{82,216}})));
  Fluid.Humidifiers.Humidifier_u steamHumidifier(
    dp_nominal=0,
    redeclare package Medium = MediumAir,
    T_start=T_init,
    mWat_flow_nominal=0.0167,
    m_flow_nominal=mFlowSup)
    "simple model for steam humidifier to create valve signal between 0 and 1"
    annotation (Placement(transformation(extent={{-526,16},{-546,36}})));
  BaseClasses.steamHumidHeatModel steamHumidHeatModel(T_wat=45 + 273.15)
    annotation (Placement(transformation(extent={{-550,74},{-530,94}})));
  Fluid.Sensors.MassFlowRate outMasFlo(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={92,88})));
  Fluid.Sensors.MassFlowRate exhMasFlo(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-476,302})));
  Fluid.Sensors.MassFlowRate regMasFlo(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={154,300})));
  Modelica.Fluid.Interfaces.FluidPort_b ExitAir1(
    redeclare package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-20,350},{0,370}}),
        iconTransformation(extent={{-38,350},{-18,370}})));
  Fluid.Sensors.RelativeHumidityTwoPort sen_rhRek(redeclare package Medium =
        MediumAir, m_flow_nominal=mFlowSup)
    "Relative Humidity of Supply Air before recuperator" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-218,28})));
equation
  connect(exhaustAir, T02_senTemExh.port_a) annotation (Line(points={{-640,302},
          {-598,302}},            color={162,29,33}));
  connect(T02_senTemExh.port_b, T02_senRelHumExh.port_a)
    annotation (Line(points={{-578,302},{-554,302}}, color={162,29,33}));
  connect(T01_senTemSup.port_b, T01_senRelHumSup.port_a) annotation (Line(
        points={{-578,26},{-588,26},{-594,26}}, color={0,127,255}));
  connect(T01_senRelHumSup.port_b, supplyAir) annotation (Line(points={{-614,26},
          {-640,26}},            color={0,127,255}));
  connect(Y05.port_b, outsideAirFan.port_a)
    annotation (Line(points={{144,26},{126,26}},         color={0,127,255}));
  connect(resSupAir.port_b, sen_TRek.port_a)
    annotation (Line(points={{-114,28},{-148,28}}, color={0,127,255}));
  connect(resExhAir.port_b, sen_TFo.port_a)
    annotation (Line(points={{-164,302},{-148,302}}, color={162,29,33}));
  connect(Y04.y, busActors.openingY04) annotation (Line(points={{-70,314},{-70,
          364.1},{-186.1,364.1}},            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y08.y, busActors.openingY08) annotation (Line(points={{10,314},{10,
          364.1},{-186.1,364.1}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y05.y, busActors.openingY05) annotation (Line(points={{154,38},{154,
          56},{364,56},{364,364.1},{-186.1,364.1}},
                                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y07.y, busActors.openingY07) annotation (Line(points={{216,178},{364,178},
          {364,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAir, T04_senTemOut.port_a) annotation (Line(points={{360,26},{
          334,26}},                    color={0,127,255}));
  connect(T04_senTemOut.port_b, T04_senRelHumOut.port_a)
    annotation (Line(points={{314,26},{302,26},{290,26}}, color={0,127,255}));
  connect(resOutAir.port_a, T04_senRelHumOut.port_b)
    annotation (Line(points={{246,26},{258,26},{270,26}}, color={0,127,255}));
  connect(T02_senRelHumExh.port_b, p02_senPre.port) annotation (Line(points={{-534,
          302},{-498,302},{-498,326}}, color={0,127,255}));
  connect(T03_senRelHumHea.port_b, p01_senPre.port) annotation (Line(points={{-506,26},
          {-516,26},{-516,6}},     color={0,127,255}));
  connect(T01_senTemSup.T, busSensors.T01) annotation (Line(points={{-568,37},{
          -568,58},{-654,58},{-654,369.9},{-303.9,369.9}},      color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T01_senRelHumSup.phi, busSensors.T01_RelHum) annotation (Line(points={{-604.1,
          37},{-604.1,58},{-654,58},{-654,369.9},{-303.9,369.9}},         color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senTemExh.T, busSensors.T02) annotation (Line(points={{-588,313},
          {-588,369.9},{-303.9,369.9}},           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senRelHumExh.phi, busSensors.T02_RelHum) annotation (Line(points={{-543.9,
          313},{-543.9,369.9},{-303.9,369.9}},         color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T03_senRelHumHea.phi, busSensors.T03_RelHum) annotation (Line(points={{-496.1,
          37},{-496.1,58},{-654,58},{-654,369.9},{-303.9,369.9}},         color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T04_senTemOut.T, busSensors.T04) annotation (Line(points={{324,37},{
          324,50},{368,50},{368,369.9},{-303.9,369.9}},
                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T04_senRelHumOut.phi, busSensors.T04_RelHum) annotation (Line(points={{279.9,
          37},{279.9,50},{368,50},{368,369.9},{-303.9,369.9}},        color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAir, outsideAir) annotation (Line(points={{360,26},{360,26}},
                     color={0,127,255}));
  connect(heatingRegister.port_b2, watOutHeaCoi) annotation (Line(points={{-430,14},
          {-428,14},{-428,-100}},                  color={162,29,33}));
  connect(resOutAir.port_b, Y05.port_a)
    annotation (Line(points={{226,26},{164,26}}, color={0,127,255}));
  connect(resOutAir.port_b, Y07.port_a)
    annotation (Line(points={{226,26},{204,26},{204,168}}, color={0,140,72}));
  connect(recuperator.Y03_opening, busActors.openingY03) annotation (Line(
        points={{-346.22,203.05},{-346.22,364.1},{-186.1,364.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.Y02_opening, busActors.openingY02) annotation (Line(
        points={{-369.02,203.05},{-369.02,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.Y01_opening, busActors.openingY01) annotation (Line(
        points={{-331.02,203.05},{-331.02,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(resRegAir.port_b, sorptionDehumidification.port_a1) annotation (Line(
        points={{106,300},{98,300},{98,202},{82,202}}, color={0,140,72}));
  connect(sorptionDehumidification.port_b1, Y08.port_a) annotation (Line(points={{48,202},
          {40,202},{40,302},{20,302}},                                color={0,140,72}));
  connect(sorptionDehumidification.port_b2, resSupAir.port_a) annotation (Line(
        points={{48,146},{28,146},{28,28},{-94,28}},      color={0,127,255}));
  connect(heatingRegister.T03_senTemHeaCoi, busSensors.T03) annotation (Line(
        points={{-445,30.6},{-445,58},{-654,58},{-654,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingRegister.port_b1, T03_senRelHumHea.port_a)
    annotation (Line(points={{-450,26},{-486,26}}, color={0,127,255}));
  connect(watOutHeaCoi, watOutHeaCoi)
    annotation (Line(points={{-428,-100},{-428,-100}}, color={0,127,255}));
  connect(T03_senRelHumHea.port_b, steamHumidifier.port_a)
    annotation (Line(points={{-506,26},{-526,26}}, color={0,127,255}));
  connect(steamHumidifier.port_b, T01_senTemSup.port_a)
    annotation (Line(points={{-546,26},{-558,26}}, color={0,127,255}));
  connect(steamHumidifier.u, busActors.openingY11) annotation (Line(points={{
          -525,32},{-524,32},{-524,70},{-646,70},{-646,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingRegister.port_a2, watInlHeaCoi) annotation (Line(points={{-450,
          14},{-452,14},{-452,-100}}, color={238,46,47}));
  connect(heatingRegister.pumpN04, busActors.pumpN04) annotation (Line(points={
          {-450.8,22},{-466,22},{-466,-42},{-646,-42},{-646,364.1},{-186.1,
          364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingRegister.u, busActors.openingY09) annotation (Line(points={{
          -450.8,18.4},{-466,18.4},{-466,-42},{-646,-42},{-646,364.1},{-186.1,
          364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.adiCoo, busActors.pumpN06) annotation (Line(points={{
          -317.72,172.6},{-288,172.6},{-288,364.1},{-186.1,364.1}}, color={255,
          0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(heatingRegister.y09_actual, busSensors.Y09_actual) annotation (Line(
        points={{-447,30.6},{-447,58},{-654,58},{-654,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.Y02_actual, busSensors.Y02_actual) annotation (Line(
        points={{-398.28,167},{-654,167},{-654,369.9},{-303.9,369.9}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sen_TRek.T, busSensors.T_Rek) annotation (Line(points={{-158,39},{
          -158,58},{-654,58},{-654,369.9},{-303.9,369.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p02_senPre.p, busSensors.P02) annotation (Line(points={{-487,336},{
          -466,336},{-466,369.9},{-303.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p01_senPre.p, busSensors.P01) annotation (Line(points={{-527,-4},{
          -654,-4},{-654,369.9},{-303.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y07.port_b, senTemReg.port_a)
    annotation (Line(points={{204,188},{204,244}}, color={0,127,255}));
  connect(senTemReg.port_b, regenerationAirFan_N03.port_a) annotation (Line(
        points={{204,264},{204,300},{200,300}}, color={0,127,255}));
  connect(steamHumidifier.mWat_flow, steamHumidHeatModel.u) annotation (Line(
        points={{-547,32},{-560,32},{-560,84},{-550.4,84}}, color={0,0,127}));
  connect(steamHumidHeatModel.port_a, steamHumidifier.heatPort) annotation (
      Line(points={{-530.2,84},{-520,84},{-520,20},{-526,20}}, color={191,0,0}));
  connect(recuperator.port_b2, sen_TMix.port_a) annotation (Line(points={{-396,
          146},{-412,146},{-412,94}}, color={0,127,255}));
  connect(sen_TMix.port_b, sen_rhMix.port_a)
    annotation (Line(points={{-412,74},{-412,54}}, color={0,127,255}));
  connect(sen_rhMix.port_b, heatingRegister.port_a1) annotation (Line(points={{
          -412,34},{-412,26},{-430,26}}, color={0,127,255}));
  connect(sen_TFo.port_b, sen_rhFo.port_a)
    annotation (Line(points={{-128,302},{-112,302}}, color={0,127,255}));
  connect(sen_rhFo.port_b, Y04.port_a)
    annotation (Line(points={{-92,302},{-80,302}}, color={0,127,255}));
  connect(outsideAirFan.port_b, outMasFlo.port_a)
    annotation (Line(points={{106,26},{92,26},{92,78}}, color={0,127,255}));
  connect(outMasFlo.port_b, sorptionDehumidification.port_a2)
    annotation (Line(points={{92,98},{92,146},{82,146}}, color={0,127,255}));
  connect(outMasFlo.m_flow, busSensors.mFlowOut) annotation (Line(points={{103,
          88},{116,88},{116,50},{368,50},{368,369.9},{-303.9,369.9}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAirFan.dp_in, busActors.outsideFan_dp) annotation (Line(points=
         {{116,38},{116,56},{364,56},{364,364.1},{-186.1,364.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(exhMasFlo.m_flow, busSensors.mFlowExh) annotation (Line(points={{-476,
          313},{-476,369.9},{-303.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.port_b, regMasFlo.port_a)
    annotation (Line(points={{180,300},{164,300}}, color={0,127,255}));
  connect(regMasFlo.port_b, resRegAir.port_a)
    annotation (Line(points={{144,300},{126,300}}, color={0,127,255}));
  connect(regMasFlo.m_flow, busSensors.mFlowReg) annotation (Line(points={{154,
          311},{154,369.9},{-303.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.dp_in, busActors.regenerationFan_dp)
    annotation (Line(points={{190,312},{190,364.1},{-186.1,364.1}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(exhAirFan_N02.dp_in, busActors.exhaustFan_dp) annotation (Line(points=
         {{-432,314},{-432,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(exhAirFan_N02.port_b, recuperator.port_a1) annotation (Line(points={{
          -422,302},{-406,302},{-406,188},{-396,188}}, color={0,127,255}));
  connect(T02_senRelHumExh.port_b, exhMasFlo.port_a)
    annotation (Line(points={{-534,302},{-486,302}}, color={0,127,255}));
  connect(exhMasFlo.port_b, exhAirFan_N02.port_a)
    annotation (Line(points={{-466,302},{-442,302}}, color={0,127,255}));
  connect(recuperator.port_b1, resExhAir.port_a) annotation (Line(points={{-320,
          188},{-272,188},{-272,302},{-184,302}}, color={0,127,255}));
  connect(sorptionDehumidification.Y06_opening, busActors.openingY06)
    annotation (Line(points={{49.7,216.8},{49.7,364.1},{-186.1,364.1}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.Y10_opening, busActors.openingY10)
    annotation (Line(points={{54.12,216.8},{54.12,364.1},{-186.1,364.1}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.Y15_opening, busActors.openingY15)
    annotation (Line(points={{58.54,216.8},{58.54,364.1},{-186.1,364.1}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.Y16_opening, busActors.openingY16)
    annotation (Line(points={{63.3,216.8},{63.3,364.1},{-186.1,364.1}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.P05, busActors.pumpN05) annotation (Line(
        points={{68.4,216.8},{68.4,364.1},{-186.1,364.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.P07, busActors.pumpN07) annotation (Line(
        points={{74.35,216.8},{74.35,364.1},{-186.1,364.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.P08, busActors.pumpN08) annotation (Line(
        points={{80.3,216.8},{80.3,364.1},{-186.1,364.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.TDes, busSensors.TDes) annotation (Line(
        points={{82.68,198},{86,198},{86,369.9},{-303.9,369.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.xDes, busSensors.xDes) annotation (Line(
        points={{82.68,193.2},{86,193.2},{86,369.9},{-303.9,369.9}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.xAbs, busSensors.xAbs) annotation (Line(
        points={{82.68,188.4},{86,188.4},{86,369.9},{-303.9,369.9}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.massDesorberTank, busSensors.mTankDes)
    annotation (Line(points={{82.68,183.2},{86,183.2},{86,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.massAbsorberTank, busSensors.mTankAbs)
    annotation (Line(points={{82.68,179},{86,179},{86,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.senMasFloAbs, busSensors.mFlowAbs)
    annotation (Line(points={{82.68,174.4},{86,174.4},{86,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.Y06_actual, busSensors.Y06_actual)
    annotation (Line(points={{82.68,170},{86,170},{86,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y04.port_b, ExitAir) annotation (Line(points={{-60,302},{-50,302},{
          -50,360}}, color={0,127,255}));
  connect(Y08.port_b, ExitAir1)
    annotation (Line(points={{0,302},{-10,302},{-10,360}}, color={0,127,255}));
  connect(sen_TRek.port_b, sen_rhRek.port_a) annotation (Line(points={{-168,28},
          {-188,28},{-188,28},{-208,28}}, color={0,127,255}));
  connect(sen_rhRek.port_b, recuperator.port_a2) annotation (Line(points={{-228,
          28},{-288,28},{-288,146},{-320,146}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},
            {360,360}}), graphics={Rectangle(
          extent={{-638,358},{360,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-492,274},{224,-12}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Menerga 
SorpSolair")}),                                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},{360,360}}),
        graphics={Text(
          extent={{-588,150},{-468,76}},
          lineColor={28,108,200},
          textString="maybe later steam 
humidifier model instead
 of simple humidifier
")}));
end Menerga21;
