within AixLib.Airflow.AirHandlingUnit;
model MenergaSimple "A first simple model of the Menerga SorpSolair"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;
  import SI = Modelica.SIunits;

  parameter SI.MassFlowRate mWat_evap_nominal( min=0, max=2.77) = 0.05
                 "mass flow of water in evaporisation in kg/s";
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
    annotation (Placement(transformation(extent={{340,108},{360,128}}),
        iconTransformation(extent={{340,108},{360,128}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for supply Air (positive design flow direction is from outsideAir to supplyAir)"
    annotation (Placement(transformation(extent={{-638,-26},{-618,-6}}),
        iconTransformation(extent={{-638,-26},{-618,-6}})));

  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{96,16},{76,36}})));

  Modelica.Fluid.Interfaces.FluidPort_b ExitAir(
    redeclare package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-166,332},{-146,352}}),
        iconTransformation(extent={{-166,332},{-146,352}})));
  Modelica.Fluid.Interfaces.FluidPort_a exhaustAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust Air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-640,248},{-620,268}}),
        iconTransformation(extent={{-640,248},{-620,268}})));
  Fluid.Movers.FlowControlled_m_flow exhAirFan_N02(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to transport the exhaust air"
    annotation (Placement(transformation(extent={{-370,294},{-350,314}})));
  Fluid.Movers.FlowControlled_m_flow regenerationAirFan_N03(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to deliver regeneration air"
    annotation (Placement(transformation(extent={{188,294},{168,314}})));
  Fluid.HeatExchangers.ConstantEffectiveness HeatingCoil(redeclare package
      Medium1=MediumAir, redeclare package Medium2 = MediumWater,
    m1_flow_nominal=5.1,
    m2_flow_nominal=0.1,
    dp2_nominal=20,
    dp1_nominal=0)
    "Heating Coil after Recuperator for additional Heating"
    annotation (Placement(transformation(extent={{-400,10},{-420,30}})));
  Fluid.Sensors.TemperatureTwoPort T04_senTemOut(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Temperature of Outside Air in Regeneration Vent"
    annotation (Placement(transformation(extent={{334,16},{314,36}})));
  Fluid.Sensors.TemperatureTwoPort T02_senTemExh(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1) "Temperature of the Exhaust Air"
    annotation (Placement(transformation(extent={{-592,294},{-572,314}})));
  Fluid.Sensors.TemperatureTwoPort senTemAbs(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air before heating coil"
    annotation (Placement(transformation(extent={{-296,16},{-316,36}})));
  Fluid.Sensors.TemperatureTwoPort T03_senTemHea(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after heating coil"
    annotation (Placement(transformation(extent={{-434,16},{-454,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort T02_senRelHumExh(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Exhaust Air"
    annotation (Placement(transformation(extent={{-554,294},{-534,314}})));
  Fluid.Sensors.RelativeHumidityTwoPort T03_senRelHumHea(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after heating coil"
    annotation (Placement(transformation(extent={{-468,16},{-488,36}})));
  Fluid.Sensors.TemperatureTwoPort T01_senTemSup(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-558,16},{-578,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort T01_senRelHumSup(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-594,16},{-614,36}})));
  Fluid.HeatExchangers.ConstantEffectiveness recuperator(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=5.1,
    m2_flow_nominal=5.1,
    dp2_nominal=132,
    dp1_nominal=127)
                    "Adiabatic Recuperator between exhaust and supply air"
    annotation (Placement(transformation(extent={{-412,250},{-392,270}})));
  Fluid.Sensors.TemperatureTwoPort senTemExi(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Temperature of the exit air after recuperator"
    annotation (Placement(transformation(extent={{-232,294},{-212,314}})));
model TwoWayEqualPercentageAdd
    "Damper with possibility for adding fixed pressure drop using boolean input"
  extends IDEAS.Fluid.Actuators.BaseClasses.PartialTwoWayValveKv(
    dpValve_nominal= k1^2*m_flow_nominal^2/2/Medium.density(sta_default)/A^2,
    phi=sqrt(1/(1/((l+(1-l)*(c*{y_actual^3, y_actual^2, y_actual}))^2) + (if addPreDro then 1/yAdd^2 else 0))));
  parameter Modelica.SIunits.Pressure dpAdd
      "Additional pressure drop when addPreDro is true";
  parameter Real k1(min=0)= 0.45
      "Flow coefficient for y=1, k1 = pressure drop divided by dynamic pressure"
  annotation(Dialog(tab="Damper coefficients"));
  parameter Modelica.SIunits.Area A "Damper face area";
  Modelica.Blocks.Interfaces.BooleanInput addPreDro
      "Add additional pressure drop"
                                   annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,106})));
  protected
  constant Real[3] c= {0.582675,0.222823,0.192212}
      "Polynomial coefficients for pressure drop curve based on ASHRAE fundamentals, 2009, P134, fig 13B, A=1";
  parameter Medium.Density rho_default=Medium.density(sta_default)
      "Density, used to compute fluid volume";
  parameter Real yAdd(unit="", min=0) = if dpAdd > Modelica.Constants.eps
    then m_flow_nominal / sqrt(dpAdd)/Kv_SI else 9999999;
initial equation
  // Since the flow model IDEAS.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow computes
  // 1/k^2, the parameter l must not be zero.
  assert(l > 0, "Valve leakage parameter l must be bigger than zero.");
  annotation (
    defaultComponentName="val",
    Documentation(info=""), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-74,20},{-36,-24}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%")}));
end TwoWayEqualPercentageAdd;
  TwoWayEqualPercentageAdd Y05(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    dpAdd=1) "damper at entry to supply air stream"
             annotation (Placement(transformation(extent={{164,16},{144,36}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{248,82},{238,92}})));
  TwoWayEqualPercentageAdd Y07(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=1,
    A=1,
    dpValve_nominal=10,
    dpAdd=1) "damper at entry of regeneration air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={204,178})));
  TwoWayEqualPercentageAdd Y06(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    dpAdd=1) "damper at bypass of absorber"
    annotation (Placement(transformation(extent={{-8,-46},{-28,-66}})));
  TwoWayEqualPercentageAdd Y08(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    dpAdd=1) "damper at exit of regeneration air"
    annotation (Placement(transformation(extent={{-16,294},{-36,314}})));
  TwoWayEqualPercentageAdd Y04(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    dpAdd=1) "damper at exit of exhaust air side"
    annotation (Placement(transformation(extent={{-200,294},{-180,314}})));
  TwoWayEqualPercentageAdd Y03(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    y_start=0,
    dpAdd=1) "damper at bypass of recuperator on exhaust air side"
    annotation (Placement(transformation(extent={{-450,294},{-430,314}})));
  TwoWayEqualPercentageAdd Y02(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    y_start=0,
    dpAdd=1) "damper at bypass of recuperator"
    annotation (Placement(transformation(extent={{-360,16},{-380,36}})));
  TwoWayEqualPercentageAdd Y01(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=10,
    dpAdd=1) "damper at entry of recuperator of supply air side" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={-372,70})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-110,348},{-100,358}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-496,320},{-486,330}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-418,52},{-408,62}})));
  Fluid.FixedResistances.PressureDrop resSupAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=725)  "combined pressure loss of supply air side"
    annotation (Placement(transformation(extent={{-244,16},{-264,36}})));
  Fluid.FixedResistances.PressureDrop resExiAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=6.1,
    dp_nominal=100) "combined pressure loss of exit air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-128,314})));
  Fluid.FixedResistances.PressureDrop resExhAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=443) "combined pressure loss of exhaust air " annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-294,304})));
  Fluid.FixedResistances.PressureDrop resRegAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=250) "combined pressure loss of regeneration air" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={134,304})));
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
  Modelica.Blocks.Sources.BooleanConstant booleanConstant4(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{10,-86},{0,-76}})));
  Fluid.Sensors.RelativeHumidityTwoPort T04_senRelHumOut(redeclare package
      Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Outside Air"
    annotation (Placement(transformation(extent={{290,16},{270,36}})));
  Fluid.Sensors.Pressure p02_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for exhaust air inlet pressure"
    annotation (Placement(transformation(extent={{-540,326},{-520,346}})));
  Fluid.Sensors.Pressure p01_senPre(redeclare package Medium = MediumAir)
    "pressure sensor for supply air outlet"
    annotation (Placement(transformation(extent={{-510,8},{-490,-12}})));
  BaseClasses.BusSensors busSensors annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-316,370}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-322,360})));
  BaseClasses.evaporationHeatModel evaporationHeatModel
    annotation (Placement(transformation(extent={{-492,244},{-472,264}})));
  Modelica.Blocks.Math.Gain mWat_gain(k=mWat_evap_nominal)
    "calculates the mass flow of evaporated water"
    annotation (Placement(transformation(extent={{-524,244},{-504,264}})));
  Fluid.Movers.Pump pump(redeclare package Medium = MediumWater,
      MinMaxCharacteristics=DataBase.Pumps.Pump1(),
    m_flow_small=mWat_mflow_small,
    Head(start=0.4),
    ControlStrategy=1)                              annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-420,-20})));
  Modelica.Blocks.Sources.BooleanConstant isNight(final k=false)
    "boolean to activate the night modus for the pump"
    annotation (Placement(transformation(extent={{-462,-24},{-452,-14}})));
  Modelica.Fluid.Interfaces.FluidPort_a watInlHeaCoi(redeclare package Medium =
        MediumWater) "water inlet for the heating coil"
    annotation (Placement(transformation(extent={{-430,-110},{-410,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b watOutHeaCoi(redeclare package Medium =
        MediumWater) "water outlet in the heating coil outlet"
    annotation (Placement(transformation(extent={{-408,-110},{-388,-90}})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear threeWayValveHeaCoi(
    redeclare package Medium = MediumWater,
    m_flow_nominal=1,
    dpValve_nominal=500) "Three way valve in the heating coil water circuit"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-420,-54})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{-14,16},{-34,36}})));
  Fluid.Humidifiers.Humidifier_u Absorber(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=300,
    mWat_flow_nominal=-0.012806)
    "dehumidifier to imitate the effect of the absorber module"
    annotation (Placement(transformation(extent={{-82,16},{-102,36}})));
  Fluid.Humidifiers.Humidifier_u Desorber(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    dp_nominal=0,
    mWat_flow_nominal=0.01522)
    "humidifier to imitate the effect of the desorber module"
    annotation (Placement(transformation(extent={{76,294},{56,314}})));
  Fluid.Humidifiers.Humidifier_u evaporator(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=0,
    mWat_flow_nominal=mWat_evap_nominal)
    "humidifier to imitate the effect of the evaporation in the recuperator"
    annotation (Placement(transformation(extent={{-450,256},{-430,276}})));
  Fluid.Humidifiers.SteamHumidifier_X steamHumidifier(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=0,
    mWatMax_flow=0.001) "steam Humdifier outside of Menerga"
    annotation (Placement(transformation(extent={{-514,16},{-534,36}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-576,244},{-556,264}})));
equation
  connect(HeatingCoil.port_b1, T03_senTemHea.port_a)
    annotation (Line(points={{-420,26},{-434,26}}, color={0,127,255}));
  connect(exhaustAir, T02_senTemExh.port_a) annotation (Line(points={{-630,258},
          {-592,258},{-592,304}}, color={0,127,255}));
  connect(T02_senTemExh.port_b, T02_senRelHumExh.port_a)
    annotation (Line(points={{-572,304},{-554,304}}, color={0,127,255}));
  connect(T03_senTemHea.port_b, T03_senRelHumHea.port_a)
    annotation (Line(points={{-454,26},{-468,26}}, color={0,127,255}));
  connect(T01_senTemSup.port_b, T01_senRelHumSup.port_a) annotation (Line(
        points={{-578,26},{-588,26},{-594,26}}, color={0,127,255}));
  connect(T01_senRelHumSup.port_b, supplyAir) annotation (Line(points={{-614,26},
          {-628,26},{-628,-16}}, color={0,127,255}));
  connect(recuperator.port_b1, exhAirFan_N02.port_a) annotation (Line(points={{-392,
          266},{-392,304},{-370,304}}, color={0,127,255}));
  connect(recuperator.port_b2, HeatingCoil.port_a1) annotation (Line(points={{-412,
          254},{-412,246},{-400,246},{-400,26}},      color={0,127,255}));
  connect(Y05.port_b, outsideAirFan.port_a)
    annotation (Line(points={{144,26},{144,26},{96,26}}, color={0,127,255}));
  connect(booleanConstant.y,Y05. addPreDro) annotation (Line(points={{237.5,87},
          {158,87},{158,36.6}}, color={255,0,255}));
  connect(booleanConstant.y, Y07.addPreDro) annotation (Line(points={{237.5,87},
          {230,87},{230,150},{230,174},{214.6,174}},
                                                 color={255,0,255}));
  connect(outsideAirFan.port_b, Y06.port_a) annotation (Line(points={{76,26},{
          32,26},{32,-56},{-8,-56}}, color={0,127,255}));
  connect(booleanConstant1.y, Y08.addPreDro) annotation (Line(points={{-99.5,
          353},{-20.75,353},{-20.75,314.6},{-22,314.6}}, color={255,0,255}));
  connect(senTemExi.port_b, Y04.port_a)
    annotation (Line(points={{-212,304},{-198,304},{-200,304}},
                                                     color={0,127,255}));
  connect(Y04.addPreDro, booleanConstant1.y) annotation (Line(points={{-194,
          314.6},{-160,314.6},{-160,353},{-99.5,353}}, color={255,0,255}));
  connect(Y03.port_b, exhAirFan_N02.port_a) annotation (Line(points={{-430,304},
          {-402,304},{-370,304}}, color={0,127,255}));
  connect(senTemAbs.port_b, Y02.port_a)
    annotation (Line(points={{-316,26},{-360,26}}, color={0,127,255}));
  connect(Y02.port_b, HeatingCoil.port_a1) annotation (Line(points={{-380,26},{
          -380,26},{-400,26}}, color={0,127,255}));
  connect(recuperator.port_a2, Y01.port_b) annotation (Line(points={{-392,254},
          {-372,254},{-372,80}}, color={0,127,255}));
  connect(senTemAbs.port_b, Y01.port_a) annotation (Line(points={{-316,26},{
          -350,26},{-350,60},{-372,60}}, color={0,127,255}));
  connect(Y03.addPreDro, booleanConstant2.y) annotation (Line(points={{-444,
          314.6},{-470,314.6},{-470,325},{-485.5,325}}, color={255,0,255}));
  connect(booleanConstant3.y, Y01.addPreDro) annotation (Line(points={{-407.5,57},
          {-384,57},{-384,58},{-384,66},{-382.6,66}}, color={255,0,255}));
  connect(booleanConstant3.y, Y02.addPreDro) annotation (Line(points={{-407.5,57},
          {-367.25,57},{-367.25,36.6},{-366,36.6}},     color={255,0,255}));
  connect(resSupAir.port_b, senTemAbs.port_a) annotation (Line(points={{-264,26},
          {-280,26},{-296,26}}, color={0,127,255}));
  connect(Y08.port_b, resExiAir.port_a) annotation (Line(points={{-36,304},{
          -128,304}},       color={0,127,255}));
  connect(Y04.port_b, resExiAir.port_a) annotation (Line(points={{-180,304},{
          -180,304},{-128,304}}, color={0,127,255}));
  connect(resExiAir.port_b, ExitAir) annotation (Line(points={{-128,324},{-128,342},
          {-156,342}},                 color={0,127,255}));
  connect(exhAirFan_N02.port_b, resExhAir.port_a) annotation (Line(points={{-350,
          304},{-324,304},{-304,304}}, color={0,127,255}));
  connect(resExhAir.port_b, senTemExi.port_a) annotation (Line(points={{-284,
          304},{-258,304},{-232,304}}, color={0,127,255}));
  connect(regenerationAirFan_N03.port_b, resRegAir.port_a) annotation (Line(
        points={{168,304},{156,304},{144,304}}, color={0,127,255}));
  connect(resOutAir.port_b, Y05.port_a)
    annotation (Line(points={{226,26},{226,26},{164,26}}, color={0,127,255}));
  connect(resOutAir.port_b, Y07.port_a)
    annotation (Line(points={{226,26},{204,26},{204,168}}, color={0,127,255}));
  connect(Y03.y, busActors.openingY03) annotation (Line(points={{-440,316},{-358,
          316},{-358,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(exhAirFan_N02.m_flow_in, busActors.exhaustFan) annotation (Line(
        points={{-360,316},{-358.1,316},{-358.1,364.1},{-186.1,364.1}},   color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y04.y, busActors.openingY04) annotation (Line(points={{-190,316},{-178,
          316},{-178,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y08.y, busActors.openingY08) annotation (Line(points={{-26,316},{-26,316},
          {-26,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.m_flow_in, busActors.regenerationFan)
    annotation (Line(points={{178,316},{178,316},{178,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y06.y, busActors.openingY06) annotation (Line(points={{-18,-68},{-20,-68},
          {-20,-106},{364,-106},{364,364.1},{-186.1,364.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y02.y, busActors.openingY02) annotation (Line(points={{-370,38},{-372,
          38},{-372,50},{-646,50},{-646,364.1},{-186.1,364.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y01.y, busActors.openingY01) annotation (Line(points={{-384,70},{-402,
          70},{-426,70},{-426,50},{-646,50},{-646,364.1},{-186.1,364.1}}, color=
         {0,0,127}), Text(
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
        points={{86,38},{86,48},{86,48},{86,56},{364,56},{364,364.1},{-186.1,364.1}},
                                                                          color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Y06.addPreDro, booleanConstant4.y) annotation (Line(points={{-14,-66.6},
          {-14,-66.6},{-14,-81},{-0.5,-81}},         color={255,0,255}));
  connect(Y07.port_b, regenerationAirFan_N03.port_a) annotation (Line(points={{204,
          188},{204,188},{204,304},{188,304}}, color={0,127,255}));
  connect(outsideAir, T04_senTemOut.port_a) annotation (Line(points={{350,118},{
          344,118},{344,26},{334,26}}, color={0,127,255}));
  connect(T04_senTemOut.port_b, T04_senRelHumOut.port_a)
    annotation (Line(points={{314,26},{302,26},{290,26}}, color={0,127,255}));
  connect(resOutAir.port_a, T04_senRelHumOut.port_b)
    annotation (Line(points={{246,26},{258,26},{270,26}}, color={0,127,255}));
  connect(T02_senRelHumExh.port_b, p02_senPre.port) annotation (Line(points={{-534,
          304},{-530,304},{-530,326}}, color={0,127,255}));
  connect(T03_senRelHumHea.port_b, p01_senPre.port) annotation (Line(points={{-488,
          26},{-500,26},{-500,8}}, color={0,127,255}));
  connect(T01_senTemSup.T, busSensors.T01) annotation (Line(points={{-568,37},{-552,
          37},{-552,58},{-654,58},{-654,369.9},{-315.9,369.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T01_senRelHumSup.phi, busSensors.T01_RelHum) annotation (Line(points={
          {-604.1,37},{-604.1,58},{-654,58},{-654,369.9},{-315.9,369.9}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senTemExh.T, busSensors.T02) annotation (Line(points={{-582,315},{
          -582,315},{-582,369.9},{-315.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senRelHumExh.phi, busSensors.T02_RelHum) annotation (Line(points={
          {-543.9,315},{-543.9,369.9},{-315.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p02_senPre.p, busSensors.P02) annotation (Line(points={{-519,336},{-520,
          336},{-520,369.9},{-315.9,369.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p01_senPre.p, busSensors.P01) annotation (Line(points={{-489,-2},{-490,
          -2},{-490,-30},{-654,-30},{-654,369.9},{-315.9,369.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T03_senTemHea.T, busSensors.T03) annotation (Line(points={{-444,37},{-444,
          37},{-444,58},{-654,58},{-654,132},{-654,369.9},{-315.9,369.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T03_senRelHumHea.phi, busSensors.T03_RelHum) annotation (Line(points={
          {-478.1,37},{-478.1,58},{-654,58},{-654,369.9},{-315.9,369.9}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T04_senTemOut.T, busSensors.T04) annotation (Line(points={{324,37},{
          324,50},{368,50},{368,369.9},{-315.9,369.9}},
                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T04_senRelHumOut.phi, busSensors.T04_RelHum) annotation (Line(points={{279.9,
          37},{279.9,50},{368,50},{368,369.9},{-315.9,369.9}},        color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAir, outsideAir) annotation (Line(points={{350,118},{350,118},{
          350,118}}, color={0,127,255}));
  connect(mWat_gain.y, evaporationHeatModel.u) annotation (Line(points={{-503,
          254},{-492.4,254}},       color={0,0,127}));
  connect(pump.port_b, HeatingCoil.port_a2) annotation (Line(points={{-420,-10},
          {-420,14}},                    color={0,127,255}));
  connect(isNight.y,pump. IsNight) annotation (Line(points={{-451.5,-19},{
          -430.2,-20}},                     color={255,0,255}));
  connect(HeatingCoil.port_b2, watOutHeaCoi) annotation (Line(points={{-400,14},
          {-400,14},{-400,-100},{-398,-100}}, color={0,127,255}));
  connect(watInlHeaCoi, threeWayValveHeaCoi.port_1) annotation (Line(points={{-420,
          -100},{-420,-82},{-420,-64}}, color={0,127,255}));
  connect(threeWayValveHeaCoi.port_2, pump.port_a) annotation (Line(points={{-420,
          -44},{-420,-37},{-420,-30}}, color={0,127,255}));
  connect(HeatingCoil.port_b2, threeWayValveHeaCoi.port_3) annotation (Line(
        points={{-400,14},{-400,14},{-400,-54},{-410,-54}}, color={0,127,255}));
  connect(threeWayValveHeaCoi.y, busActors.openValveHeatCoil) annotation (Line(
        points={{-432,-54},{-538,-54},{-646,-54},{-646,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senRelHumExh.port_b, Y03.port_a)
    annotation (Line(points={{-534,304},{-450,304}}, color={0,127,255}));
  connect(Y06.port_b, resSupAir.port_a) annotation (Line(points={{-28,-56},{
          -140,-56},{-140,26},{-244,26}}, color={0,127,255}));
  connect(senMasFlo.m_flow, busSensors.mFlowAbs) annotation (Line(points={{-24,
          37},{-24,50},{368,50},{368,369.9},{-315.9,369.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAirFan.port_b, senMasFlo.port_a)
    annotation (Line(points={{76,26},{32,26},{-14,26}}, color={0,127,255}));
  connect(senMasFlo.port_b,Absorber. port_a)
    annotation (Line(points={{-34,26},{-82,26}}, color={0,127,255}));
  connect(Absorber.port_b, resSupAir.port_a)
    annotation (Line(points={{-102,26},{-244,26}}, color={0,127,255}));
  connect(T03_senRelHumHea.port_b, steamHumidifier.port_a)
    annotation (Line(points={{-488,26},{-514,26}}, color={0,127,255}));
  connect(steamHumidifier.port_b, T01_senTemSup.port_a)
    annotation (Line(points={{-534,26},{-558,26}}, color={0,127,255}));
  connect(steamHumidifier.X_w, busActors.mWatSteamHumid) annotation (Line(
        points={{-512,32},{-512,50},{-646,50},{-646,364.1},{-186.1,364.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T02_senRelHumExh.port_b, evaporator.port_a) annotation (Line(points={
          {-534,304},{-496,304},{-496,266},{-450,266}}, color={0,127,255}));
  connect(evaporator.port_b, recuperator.port_a1)
    annotation (Line(points={{-430,266},{-412,266}}, color={0,127,255}));
  connect(evaporationHeatModel.port_a, evaporator.heatPort) annotation (Line(
        points={{-472.2,254},{-462,254},{-462,260},{-450,260}}, color={191,0,0}));
  connect(evaporator.u, busActors.mWatEvaporator) annotation (Line(points={{
          -451,272},{-646,272},{-646,364.1},{-186.1,364.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(resRegAir.port_b, Desorber.port_a)
    annotation (Line(points={{124,304},{76,304}}, color={0,127,255}));
  connect(Desorber.port_b, Y08.port_a)
    annotation (Line(points={{56,304},{-16,304}}, color={0,127,255}));
  connect(Absorber.u, busActors.mWatAbsorber) annotation (Line(points={{-81,32},
          {-81,56},{364,56},{364,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Desorber.u, busActors.mWatDesorber) annotation (Line(points={{77,310},
          {78,310},{78,364.1},{-186.1,364.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, mWat_gain.u)
    annotation (Line(points={{-555,254},{-526,254}}, color={0,0,127}));
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
          extent={{-224,170},{-88,136}},
          lineColor={28,108,200},
          textString="Volumina an den Knoten einfügen"), Text(
          extent={{-226,84},{-136,52}},
          lineColor={28,108,200},
          textString="Mehr Module: 
Heizregister
Rekuperator
Sorption?"),
        Text(
          extent={{-560,76},{-496,52}},
          lineColor={28,108,200},
          textString="Set Point für steam Humidifier muss noch von
phi zu X umgerechnet werden, 
damit das neue Modell funktioniert
"),     Text(
          extent={{-558,252},{-478,200}},
          lineColor={28,108,200},
          textString="Warum ist dieser gain hier?
Konstante nur zu debug-zwecken eingeführt")}));
end MenergaSimple;
