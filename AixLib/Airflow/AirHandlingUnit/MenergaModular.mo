within AixLib.Airflow.AirHandlingUnit;
model MenergaModular "A modular model of the Menerga SorpSolair"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;
  import SI = Modelica.SIunits;

  parameter SI.MassFlowRate mWat_mflow_nominal( min=0, max=1) = 0.2
                 "nominal mass flow of water in kg/s";
  parameter SI.MassFlowRate mWat_mflow_small(  min=0, max=1) = mWat_mflow_nominal / 10000
                 "leakage mass flow of water";

    //parameter Modelica.SIunits.MassFlowRate mFlowNomOut=0.5
    //"Nominal mass flow rate OutgoingAir";
    //parameter Modelica.SIunits.MassFlowRate mFlowNomIn=0.5
    //"Nominal mass flow rate IntakeAir";

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

  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{126,16},{106,36}})));

  Modelica.Fluid.Interfaces.FluidPort_b ExitAir(
    redeclare package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-38,350},{-18,370}}),
        iconTransformation(extent={{-38,350},{-18,370}})));
  Modelica.Fluid.Interfaces.FluidPort_a exhaustAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust Air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-650,292},{-630,312}}),
        iconTransformation(extent={{-650,292},{-630,312}})));
  Fluid.Movers.FlowControlled_m_flow exhAirFan_N02(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to transport the exhaust air"
    annotation (Placement(transformation(extent={{-250,292},{-230,312}})));
  Fluid.Movers.FlowControlled_m_flow regenerationAirFan_N03(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to deliver regeneration air"
    annotation (Placement(transformation(extent={{200,292},{180,312}})));
  Fluid.Sensors.TemperatureTwoPort T04_senTemOut(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Temperature of Outside Air in Regeneration Vent"
    annotation (Placement(transformation(extent={{334,16},{314,36}})));
  Fluid.Sensors.TemperatureTwoPort T02_senTemExh(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Temperature of the Exhaust Air"
    annotation (Placement(transformation(extent={{-598,292},{-578,312}})));
  Fluid.Sensors.TemperatureTwoPort senTemAbs(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air before heating coil"
    annotation (Placement(transformation(extent={{-138,136},{-158,156}})));
  Fluid.Sensors.RelativeHumidityTwoPort T02_senRelHumExh(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Exhaust Air"
    annotation (Placement(transformation(extent={{-554,292},{-534,312}})));
  Fluid.Sensors.RelativeHumidityTwoPort T03_senRelHumHea(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after heating coil"
    annotation (Placement(transformation(extent={{-486,16},{-506,36}})));
  Fluid.Sensors.TemperatureTwoPort T01_senTemSup(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-558,16},{-578,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort T01_senRelHumSup(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-594,16},{-614,36}})));
  Fluid.Sensors.TemperatureTwoPort senTemExi(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of the exit air after recuperator"
    annotation (Placement(transformation(extent={{-128,292},{-108,312}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y05(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    dpValve_nominal=10)
             "damper at entry to supply air stream"
             annotation (Placement(transformation(extent={{164,16},{144,36}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y07(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=1,
    dpValve_nominal=10)
             "damper at entry of regeneration air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={204,178})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y08(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    dpValve_nominal=10)
             "damper at exit of regeneration air"
    annotation (Placement(transformation(extent={{20,292},{0,312}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage
                           Y04(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    dpValve_nominal=10)
             "damper at exit of exhaust air side"
    annotation (Placement(transformation(extent={{-80,292},{-60,312}})));
  Fluid.FixedResistances.PressureDrop resSupAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=725)  "combined pressure loss of supply air side"
    annotation (Placement(transformation(extent={{-86,136},{-106,156}})));
  Fluid.FixedResistances.PressureDrop resExiAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=6.1,
    dp_nominal=100) "combined pressure loss of exit air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-28,328})));
  Fluid.FixedResistances.PressureDrop resExhAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=443) "combined pressure loss of exhaust air " annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-174,302})));
  Fluid.FixedResistances.PressureDrop resRegAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=250) "combined pressure loss of regeneration air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={152,302})));
  Fluid.FixedResistances.PressureDrop resOutAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=6.1,
    dp_nominal=258) "combined pressure loss of outside air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={236,26})));
  BaseClasses.BusActors busActors "Bus connector for actor signals" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-186,364}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={52,360})));
  Fluid.Sensors.RelativeHumidityTwoPort T04_senRelHumOut(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Outside Air"
    annotation (Placement(transformation(extent={{290,16},{270,36}})));
  Fluid.Sensors.Pressure p02_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for exhaust air inlet pressure"
    annotation (Placement(transformation(extent={{-508,326},{-488,346}})));
  Fluid.Sensors.Pressure p01_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for supply air outlet"
    annotation (Placement(transformation(extent={{-506,6},{-526,-14}})));
  BaseClasses.BusSensors busSensors annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-304,370}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-322,360})));
  Modelica.Fluid.Interfaces.FluidPort_a watInlHeaCoi(redeclare package Medium =
        MediumWater) "water inlet for the heating coil"
    annotation (Placement(transformation(extent={{-462,-110},{-442,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b watOutHeaCoi(redeclare package Medium =
        MediumWater) "water outlet in the heating coil outlet"
    annotation (Placement(transformation(extent={{-438,-110},{-418,-90}})));
  Fluid.Humidifiers.SteamHumidifier_X steamHumidifier(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=0,
    mWatMax_flow=0.01)  "steam Humdifier outside of Menerga"
    annotation (Placement(transformation(extent={{-528,16},{-548,36}})));
  ComponentsAHU.heatingRegister heatingRegister(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=5.1,
    m2_flow_nominal=0.1)
    annotation (Placement(transformation(extent={{-430,10},{-450,30}})));
  ComponentsAHU.Recuperator       recuperator(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=5.1,
    m2_flow_nominal=5.1)
    annotation (Placement(transformation(extent={{-388,132},{-312,202}})));
  ComponentsAHU.sorptionDehumidification sorptionDehumidification(redeclare
      package Medium1 = MediumAir, redeclare package Medium2 = MediumAir)
    annotation (Placement(transformation(extent={{48,132},{82,216}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression
    annotation (Placement(transformation(extent={{-220,164},{-240,184}})));
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
  connect(senTemExi.port_b, Y04.port_a)
    annotation (Line(points={{-108,302},{-80,302}},  color={162,29,33}));
  connect(resSupAir.port_b, senTemAbs.port_a) annotation (Line(points={{-106,
          146},{-138,146}},     color={0,127,255}));
  connect(resExiAir.port_b, ExitAir) annotation (Line(points={{-28,338},{-28,
          360}},                       color={0,127,255}));
  connect(exhAirFan_N02.port_b, resExhAir.port_a) annotation (Line(points={{-230,
          302},{-184,302}},            color={162,29,33}));
  connect(resExhAir.port_b, senTemExi.port_a) annotation (Line(points={{-164,
          302},{-128,302}},            color={162,29,33}));
  connect(regenerationAirFan_N03.port_b, resRegAir.port_a) annotation (Line(
        points={{180,302},{162,302}},           color={0,140,72}));
  connect(exhAirFan_N02.m_flow_in, busActors.exhaustFan) annotation (Line(
        points={{-240,314},{-240.1,314},{-240.1,364.1},{-186.1,364.1}},   color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y04.y, busActors.openingY04) annotation (Line(points={{-70,314},{-58,
          314},{-58,364.1},{-186.1,364.1}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y08.y, busActors.openingY08) annotation (Line(points={{10,314},{10,
          364.1},{-186.1,364.1}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.m_flow_in, busActors.regenerationFan)
    annotation (Line(points={{190,314},{190,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
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
  connect(outsideAirFan.m_flow_in, busActors.outsideFan) annotation (Line(
        points={{116,38},{116,56},{364,56},{364,364.1},{-186.1,364.1}},   color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y07.port_b, regenerationAirFan_N03.port_a) annotation (Line(points={{204,188},
          {204,302},{200,302}},                color={0,140,72}));
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
  connect(p02_senPre.p, busSensors.P02) annotation (Line(points={{-487,336},{
          -476,336},{-476,369.9},{-303.9,369.9}},
                                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p01_senPre.p, busSensors.P01) annotation (Line(points={{-527,-4},{
          -654,-4},{-654,369.9},{-303.9,369.9}},                  color={0,0,127}),
      Text(
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
  connect(T03_senRelHumHea.port_b, steamHumidifier.port_a)
    annotation (Line(points={{-506,26},{-528,26}}, color={0,127,255}));
  connect(steamHumidifier.port_b, T01_senTemSup.port_a)
    annotation (Line(points={{-548,26},{-558,26}}, color={0,127,255}));
  connect(steamHumidifier.X_w, busActors.mWatSteamHumid) annotation (Line(
        points={{-526,32},{-526,50},{-646,50},{-646,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(watInlHeaCoi, heatingRegister.port_a2)
    annotation (Line(points={{-452,-100},{-452,14},{-450,14}},
                                                      color={238,46,47}));
  connect(heatingRegister.port_b2, watOutHeaCoi) annotation (Line(points={{-430,14},
          {-428,14},{-428,-100}},                  color={162,29,33}));
  connect(heatingRegister.u, busActors.openValveHeatCoil) annotation (Line(
        points={{-450.8,18.4},{-450.8,18},{-472,18},{-472,-34},{-646,-34},{-646,
          364.1},{-186.1,364.1}},                                         color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y04.port_b, resExiAir.port_a) annotation (Line(points={{-60,302},{-28,
          302},{-28,318}},  color={162,29,33}));
  connect(Y08.port_b, resExiAir.port_a) annotation (Line(points={{0,302},{-28,
          302},{-28,318}},  color={0,140,72}));
  connect(resOutAir.port_b, Y05.port_a)
    annotation (Line(points={{226,26},{164,26}}, color={0,127,255}));
  connect(resOutAir.port_b, Y07.port_a)
    annotation (Line(points={{226,26},{204,26},{204,168}}, color={0,140,72}));
  connect(T02_senRelHumExh.port_b, recuperator.port_a1) annotation (Line(points={{-534,
          302},{-420,302},{-420,188},{-388,188}},           color={162,29,33}));
  connect(recuperator.port_b1, exhAirFan_N02.port_a) annotation (Line(points={{-312,
          188},{-284,188},{-284,302},{-250,302}},          color={162,29,33}));
  connect(senTemAbs.port_b, recuperator.port_a2) annotation (Line(points={{-158,
          146},{-312,146}},                         color={0,127,255}));
  connect(recuperator.port_b2, heatingRegister.port_a1) annotation (Line(points={{-388,
          146},{-408,146},{-408,26},{-430,26}},                      color={0,
          127,255}));
  connect(recuperator.Y03_opening, busActors.openingY03) annotation (Line(
        points={{-338.6,204.1},{-338.6,364.1},{-186.1,364.1}},    color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.Y02_opening, busActors.openingY02) annotation (Line(
        points={{-361.4,204.1},{-361.4,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(recuperator.Y01_opening, busActors.openingY01) annotation (Line(
        points={{-319.6,204.1},{-319.6,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.absInput, busActors.mWatAbsorber)
    annotation (Line(points={{61.6,216.6},{61.6,364.1},{-186.1,364.1}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.desInput, busActors.mWatDesorber)
    annotation (Line(points={{68.4,216.6},{68.4,364.1},{-186.1,364.1}},
                                                                    color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.Y06_opening, busActors.openingY06)
    annotation (Line(points={{52.25,216.6},{52.25,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionDehumidification.senMasFloAbs, busSensors.mFlowAbs)
    annotation (Line(points={{82.34,174},{88,174},{88,369.9},{-303.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(resRegAir.port_b, sorptionDehumidification.port_a1) annotation (Line(
        points={{142,302},{98,302},{98,202},{82,202}}, color={0,140,72}));
  connect(sorptionDehumidification.port_b1, Y08.port_a) annotation (Line(points={{48,202},
          {40,202},{40,302},{20,302}},                                color={0,140,72}));
  connect(outsideAirFan.port_b, sorptionDehumidification.port_a2) annotation (
      Line(points={{106,26},{92,26},{92,146},{82,146}}, color={0,127,255}));
  connect(sorptionDehumidification.port_b2, resSupAir.port_a) annotation (Line(
        points={{48,146},{-86,146}},                      color={0,127,255}));
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
  connect(booleanExpression.y, recuperator.adiCoo) annotation (Line(points={{
          -241,174},{-276,174},{-276,172.6},{-309.72,172.6}}, color={255,0,255}));
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
          extent={{-260,224},{-106,168}},
          lineColor={28,108,200},
          textString="Boole in den Bus integrieren")}));
end MenergaModular;
