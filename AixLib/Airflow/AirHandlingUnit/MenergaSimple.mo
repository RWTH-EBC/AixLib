within AixLib.Airflow.AirHandlingUnit;
model MenergaSimple "A first simple model of the Menerga SorpSolair"

    //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

    //parameter Modelica.SIunits.MassFlowRate mFlowNomOut=0.5
    //"Nominal mass flow rate OutgoingAir";
    //parameter Modelica.SIunits.MassFlowRate mFlowNomIn=0.5
    //"Nominal mass flow rate IntakeAir";


    parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);


  Modelica.Fluid.Interfaces.FluidPort_a externalAir(
     redeclare package Medium = MediumAir,
     m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for external Air (positive design flow direction is from externalAir to SupplyAir)"
    annotation (Placement(transformation(extent={{344,16},{364,36}})));
  Modelica.Fluid.Interfaces.FluidPort_b SupplyAir(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for supply Air (positive design flow direction is from externalAir to SupplyAir)"
    annotation (Placement(transformation(extent={{-634,16},{-614,36}})));

  Fluid.Movers.FlowControlled_m_flow outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
                        "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{96,16},{76,36}})));

  Modelica.Blocks.Sources.Constant InletFlow_mflow(k=5.1)
    "nominal mass flow rate in outside air fan"
    annotation (Placement(transformation(extent={{30,80},{50,100}})));
  Modelica.Fluid.Interfaces.FluidPort_b ExitAir(
    redeclare package Medium = MediumAir,
    m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-138,328},{-118,348}})));
  Modelica.Fluid.Interfaces.FluidPort_a exhaustAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for exhaust Air (positive design flow direction is from exhaustAir to exitAir)"
    annotation (Placement(transformation(extent={{-634,294},{-614,314}})));
  Fluid.Movers.FlowControlled_m_flow exhaustAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to transport the exhaust air"
    annotation (Placement(transformation(extent={{-370,294},{-350,314}})));
  Fluid.Movers.FlowControlled_m_flow regenerationAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    m_flow_nominal=5.1,
    redeclare Fluid.Movers.Data.Generic per)
    "provides pressure difference to deliver regeneration air"
    annotation (Placement(transformation(extent={{188,294},{168,314}})));
  Modelica.Blocks.Sources.Constant RegenAir_mflow(k=1)
    "nominal mass flow for regeneration air fan"
    annotation (Placement(transformation(extent={{96,328},{116,348}})));
  Modelica.Blocks.Sources.Constant exhaust_mflow(k=5.1)
    "nominal mass flow for exhaust air fan"
    annotation (Placement(transformation(extent={{-426,338},{-406,358}})));
  Fluid.MassExchangers.Humidifier_u Absorber(
    redeclare package Medium = MediumAir,
    mWat_flow_nominal=-0.0001,
    m_flow_nominal=5.1,
    dp_nominal=0)
    "dehumidifier to imitate the effect of the absorber module"
    annotation (Placement(transformation(extent={{-14,16},{-34,36}})));
  Fluid.HeatExchangers.ConstantEffectiveness HeatingCoil(redeclare package
      Medium1=MediumAir, redeclare package Medium2 = MediumWater,
    m1_flow_nominal=5.1,
    m2_flow_nominal=0.1,
    dp2_nominal=20,
    dp1_nominal=0)
    "Heating Coil after Recuperator for additional Heating"
    annotation (Placement(transformation(extent={{-400,10},{-420,30}})));
  Fluid.MassExchangers.Humidifier_u steamHumidifier(
    redeclare package Medium = MediumAir,
    dp_nominal=50,
    m_flow_nominal=5.1,
    mWat_flow_nominal=0.001)
                            "steam Humdifier outside of Menerga"
    annotation (Placement(transformation(extent={{-512,16},{-532,36}})));
  Fluid.Sources.Boundary_pT WaterInletCoil(
  redeclare package Medium = MediumWater,
    nPorts=1,
    p=101000,
    T=313.15)
    "Water Source for the Water circle in the heating Coil"
    annotation (Placement(transformation(extent={{-460,-40},{-440,-20}})));
  Fluid.Sources.Boundary_pT WaterOutletCoil(
  redeclare package Medium = MediumWater, nPorts=1,
    T=313.15)
    "Water Outlet for the Water Circle at the heating coil"
    annotation (Placement(transformation(extent={{-360,-40},{-380,-20}})));
  Modelica.Blocks.Sources.Constant InletFlow_mflow1(k=1)
    "nominal mass flow in steamHumidifier"
    annotation (Placement(transformation(extent={{-534,76},{-514,96}})));
  Modelica.Blocks.Sources.Constant InletFlow_mflow2(k=1)
    "water mass flow in absorber"
    annotation (Placement(transformation(extent={{-48,80},{-28,100}})));
  Fluid.Sensors.TemperatureTwoPort senTemReg(
  redeclare package Medium = MediumAir, m_flow_nominal=1)
    "Temperature of Outside Air in Regeneration Vent"
    annotation (Placement(transformation(extent={{300,294},{280,314}})));
  Fluid.Sensors.TemperatureTwoPort senTemExh(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of the Exhaust Air"
    annotation (Placement(transformation(extent={{-578,294},{-558,314}})));
  Fluid.Sensors.TemperatureTwoPort senTemAbs(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air before heating coil"
    annotation (Placement(transformation(extent={{-296,16},{-316,36}})));
  Fluid.Sensors.MassFlowRate senMasFloReg(
  redeclare package Medium = MediumAir) "Mass Flow Rate in Regeneration Vent"
    annotation (Placement(transformation(extent={{250,294},{230,314}})));
  Fluid.Sensors.MassFlowRate senMasFloExh(
  redeclare package Medium = MediumAir) "Mass Flow of moist Exhaust Air"
    annotation (Placement(transformation(extent={{-492,294},{-472,314}})));
  Fluid.Sensors.MassFlowRate senMasFloSup(
  redeclare package Medium = MediumAir) "Mass Flow in Supply Air"
    annotation (Placement(transformation(extent={{-172,16},{-192,36}})));
  Fluid.Sensors.TemperatureTwoPort senTemHea(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after heating coil"
    annotation (Placement(transformation(extent={{-434,16},{-454,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumExh(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Exhaust Air"
    annotation (Placement(transformation(extent={{-542,294},{-522,314}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumHea(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after heating coil"
    annotation (Placement(transformation(extent={{-478,16},{-498,36}})));
  Fluid.Sensors.TemperatureTwoPort senTemHeaSup(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Temperature of supply air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-542,16},{-562,36}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup(
  redeclare package Medium = MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of Supply Air after SteamHumidifier"
    annotation (Placement(transformation(extent={{-574,16},{-594,36}})));
  Fluid.HeatExchangers.ConstantEffectiveness recuperator(
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumAir,
    m1_flow_nominal=5.1,
    m2_flow_nominal=5.1,
    dp1_nominal=0,
    dp2_nominal=0)  "Adiabatic Recuperator between exhaust and supply air"
    annotation (Placement(transformation(extent={{-450,256},{-430,276}})));
  Fluid.MassExchangers.Humidifier_u Desorber(
    redeclare package Medium = MediumAir,
    m_flow_nominal=1,
    mWat_flow_nominal=0.0001,
    dp_nominal=0)
    "humidifier to imitate the effect of the desorber module"
    annotation (Placement(transformation(extent={{102,294},{82,314}})));
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
    dpValve_nominal=50,
    dpAdd=1) "damper at entry to supply air stream"
             annotation (Placement(transformation(extent={{224,16},{204,36}})));
  Modelica.Blocks.Sources.Constant valOpeningY05(k=1) "opening of damper Y05"
    annotation (Placement(transformation(extent={{160,72},{180,92}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{202,82},{212,92}})));
  TwoWayEqualPercentageAdd Y07(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=1,
    dpValve_nominal=20,
    A=1,
    dpAdd=1) "damper at entry of regeneration air" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={314,178})));
  Modelica.Blocks.Sources.Constant valOpeningY07(k=1) "opening of damper Y07"
    annotation (Placement(transformation(extent={{228,172},{248,192}})));
  TwoWayEqualPercentageAdd Y06(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at bypass of absorber"
    annotation (Placement(transformation(extent={{-8,-66},{-28,-46}})));
  Modelica.Blocks.Sources.Constant valOpeningY06(k=1) "opening of damper Y06"
    annotation (Placement(transformation(extent={{-82,-44},{-62,-24}})));
  TwoWayEqualPercentageAdd Y08(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at exit of regeneration air"
    annotation (Placement(transformation(extent={{-16,294},{-36,314}})));
  TwoWayEqualPercentageAdd Y04(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at exit of exhaust air side"
    annotation (Placement(transformation(extent={{-180,294},{-160,314}})));
  TwoWayEqualPercentageAdd Y03(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at bypass of recuperator on exhaust air side"
    annotation (Placement(transformation(extent={{-450,294},{-430,314}})));
  TwoWayEqualPercentageAdd Y02(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at bypass of recuperator"
    annotation (Placement(transformation(extent={{-360,16},{-380,36}})));
  TwoWayEqualPercentageAdd Y01(
    redeclare package Medium = MediumAir,
    l=0.001,
    m_flow_nominal=5.1,
    A=3.6,
    dpValve_nominal=50,
    dpAdd=1) "damper at entry of recuperator of supply air side" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-372,70})));
  Modelica.Blocks.Sources.Constant valOpeningY08(k=1) "opening of damper Y08"
    annotation (Placement(transformation(extent={{-58,328},{-38,348}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-108,268},{-98,278}})));
  Modelica.Blocks.Sources.Constant valOpeningY03(k=0) "opening of damper Y03"
    annotation (Placement(transformation(extent={{-478,332},{-458,352}})));
  Modelica.Blocks.Sources.Constant valOpeningY02(k=0) "opening of Y02"
    annotation (Placement(transformation(extent={{-434,46},{-414,66}})));
  Modelica.Blocks.Sources.Constant valOpeningY01(k=1) "opening of Y01"
    annotation (Placement(transformation(extent={{-318,80},{-338,100}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant2(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-496,320},{-486,330}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant3(
                                                          final k=false)
    "Only valRecupTop has conditional Kv value"
    annotation (Placement(transformation(extent={{-326,52},{-336,62}})));
  Modelica.Blocks.Sources.Constant valOpeningY04(k=1) "opening of damper Y04"
    annotation (Placement(transformation(extent={{-194,330},{-174,350}})));
  Fluid.FixedResistances.PressureDrop resSupAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=1157) "combined pressure loss of supply air side"
    annotation (Placement(transformation(extent={{-244,16},{-264,36}})));
  Fluid.FixedResistances.PressureDrop resExiAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=6.1,
    dp_nominal=100) "combined pressure loss of exit air" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-108,314})));
  Fluid.FixedResistances.PressureDrop resExhAir(
    redeclare package Medium = MediumAir,
    m_flow_nominal=5.1,
    dp_nominal=570) "combined pressure loss of exhaust air " annotation (
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
        origin={332,26})));
equation
  connect(InletFlow_mflow.y, outsideAirFan.m_flow_in) annotation (Line(points={{
          51,90},{51,90},{86.2,90},{86.2,38}}, color={0,0,127}));
  connect(RegenAir_mflow.y, regenerationAirFan.m_flow_in) annotation (Line(
        points={{117,338},{178.2,338},{178.2,316}}, color={0,0,127}));
  connect(exhaust_mflow.y, exhaustAirFan.m_flow_in) annotation (Line(points={{-405,
          348},{-360.2,348},{-360.2,316}}, color={0,0,127}));
  connect(outsideAirFan.port_b, Absorber.port_a)
    annotation (Line(points={{76,26},{32,26},{-14,26}}, color={0,127,255}));
  connect(WaterInletCoil.ports[1], HeatingCoil.port_a2) annotation (Line(points={{-440,
          -30},{-420,-30},{-420,14}},                             color={0,127,255}));
  connect(HeatingCoil.port_b2, WaterOutletCoil.ports[1]) annotation (Line(
        points={{-400,14},{-400,-30},{-380,-30}},                    color={0,127,
          255}));
  connect(InletFlow_mflow1.y, steamHumidifier.u)
    annotation (Line(points={{-513,86},{-510,86},{-510,32}}, color={0,0,127}));
  connect(InletFlow_mflow2.y, Absorber.u) annotation (Line(points={{-27,90},{
          -12,90},{-12,32}},               color={0,0,127}));
  connect(HeatingCoil.port_b1, senTemHea.port_a)
    annotation (Line(points={{-420,26},{-434,26}}, color={0,127,255}));
  connect(exhaustAir, senTemExh.port_a)
    annotation (Line(points={{-624,304},{-578,304}}, color={0,127,255}));
  connect(senTemExh.port_b, senRelHumExh.port_a)
    annotation (Line(points={{-558,304},{-542,304}}, color={0,127,255}));
  connect(senRelHumExh.port_b, senMasFloExh.port_a) annotation (Line(points={{-522,
          304},{-507,304},{-492,304}}, color={0,127,255}));
  connect(senTemReg.port_b, senMasFloReg.port_a)
    annotation (Line(points={{280,304},{250,304}}, color={0,127,255}));
  connect(senMasFloReg.port_b, regenerationAirFan.port_a) annotation (Line(
        points={{230,304},{212,304},{188,304}}, color={0,127,255}));
  connect(senTemHea.port_b, senRelHumHea.port_a)
    annotation (Line(points={{-454,26},{-478,26}}, color={0,127,255}));
  connect(senRelHumHea.port_b, steamHumidifier.port_a)
    annotation (Line(points={{-498,26},{-506,26},{-512,26}},
                                                   color={0,127,255}));
  connect(steamHumidifier.port_b, senTemHeaSup.port_a)
    annotation (Line(points={{-532,26},{-538,26},{-542,26}},
                                                   color={0,127,255}));
  connect(senTemHeaSup.port_b, senRelHumSup.port_a)
    annotation (Line(points={{-562,26},{-574,26}}, color={0,127,255}));
  connect(senRelHumSup.port_b, SupplyAir) annotation (Line(points={{-594,26},{-609,
          26},{-624,26}}, color={0,127,255}));
  connect(Absorber.port_b, senMasFloSup.port_a)
    annotation (Line(points={{-34,26},{-172,26}},          color={0,127,255}));
  connect(senMasFloExh.port_b, recuperator.port_a1)
    annotation (Line(points={{-472,304},{-458,304},{-458,272},{-450,272}},
                                                     color={0,127,255}));
  connect(recuperator.port_b1, exhaustAirFan.port_a) annotation (Line(points={{-430,
          272},{-430,304},{-370,304}},      color={0,127,255}));
  connect(recuperator.port_b2, HeatingCoil.port_a1) annotation (Line(points={{-450,
          260},{-450,246},{-400,246},{-400,26}},      color={0,127,255}));
  connect(Y05.port_b, outsideAirFan.port_a)
    annotation (Line(points={{204,26},{150,26},{96,26}}, color={0,127,255}));
  connect(valOpeningY05.y, Y05.y) annotation (Line(points={{181,82},{194,82},{
          194,76},{214,76},{214,38}}, color={0,0,127}));
  connect(booleanConstant.y,Y05. addPreDro) annotation (Line(points={{212.5,87},
          {218,87},{218,36.6}}, color={255,0,255}));
  connect(InletFlow_mflow2.y, Desorber.u) annotation (Line(points={{-27,90},{0,
          90},{0,310},{104,310}}, color={0,0,127}));
  connect(Y07.port_b, senTemReg.port_a) annotation (Line(points={{314,188},{314,
          188},{314,304},{300,304}}, color={0,127,255}));
  connect(Y07.y, valOpeningY07.y) annotation (Line(points={{302,178},{256,178},
          {256,182},{249,182}}, color={0,0,127}));
  connect(booleanConstant.y, Y07.addPreDro) annotation (Line(points={{212.5,87},
          {263.25,87},{263.25,174},{303.4,174}}, color={255,0,255}));
  connect(outsideAirFan.port_b, Y06.port_a) annotation (Line(points={{76,26},{
          32,26},{32,-56},{-8,-56}}, color={0,127,255}));
  connect(Y06.port_b, senMasFloSup.port_a) annotation (Line(points={{-28,-56},{
          -110,-56},{-110,26},{-172,26}}, color={0,127,255}));
  connect(valOpeningY06.y, Y06.y) annotation (Line(points={{-61,-34},{-40,-34},
          {-40,-44},{-18,-44}}, color={0,0,127}));
  connect(Y06.addPreDro, booleanConstant.y) annotation (Line(points={{-14,-45.4},
          {240,-45.4},{240,87},{212.5,87}}, color={255,0,255}));
  connect(Desorber.port_b, Y08.port_a)
    annotation (Line(points={{82,304},{34,304},{-16,304}}, color={0,127,255}));
  connect(Y08.y, valOpeningY08.y) annotation (Line(points={{-26,316},{-32,316},
          {-32,338},{-37,338}}, color={0,0,127}));
  connect(booleanConstant1.y, Y08.addPreDro) annotation (Line(points={{-97.5,
          273},{-20.75,273},{-20.75,314.6},{-22,314.6}}, color={255,0,255}));
  connect(senTemExi.port_b, Y04.port_a)
    annotation (Line(points={{-212,304},{-180,304}}, color={0,127,255}));
  connect(Y04.addPreDro, booleanConstant1.y) annotation (Line(points={{-174,
          314.6},{-154,314.6},{-154,273},{-97.5,273}}, color={255,0,255}));
  connect(senMasFloExh.port_b, Y03.port_a) annotation (Line(points={{-472,304},
          {-462,304},{-450,304}}, color={0,127,255}));
  connect(Y03.port_b, exhaustAirFan.port_a) annotation (Line(points={{-430,304},
          {-402,304},{-370,304}}, color={0,127,255}));
  connect(valOpeningY03.y, Y03.y) annotation (Line(points={{-457,342},{-440,342},
          {-440,316}}, color={0,0,127}));
  connect(senTemAbs.port_b, Y02.port_a)
    annotation (Line(points={{-316,26},{-360,26}}, color={0,127,255}));
  connect(Y02.port_b, HeatingCoil.port_a1) annotation (Line(points={{-380,26},{
          -380,26},{-400,26}}, color={0,127,255}));
  connect(recuperator.port_a2, Y01.port_b) annotation (Line(points={{-430,260},
          {-372,260},{-372,80}}, color={0,127,255}));
  connect(senTemAbs.port_b, Y01.port_a) annotation (Line(points={{-316,26},{
          -350,26},{-350,60},{-372,60}}, color={0,127,255}));
  connect(valOpeningY02.y, Y02.y) annotation (Line(points={{-413,56},{-392,56},
          {-392,38},{-370,38}}, color={0,0,127}));
  connect(Y01.y, valOpeningY01.y) annotation (Line(points={{-360,70},{-342,70},
          {-342,90},{-339,90}}, color={0,0,127}));
  connect(Y03.addPreDro, booleanConstant2.y) annotation (Line(points={{-444,
          314.6},{-470,314.6},{-470,325},{-485.5,325}}, color={255,0,255}));
  connect(booleanConstant3.y, Y01.addPreDro) annotation (Line(points={{-336.5,
          57},{-343.25,57},{-343.25,66},{-361.4,66}}, color={255,0,255}));
  connect(booleanConstant3.y, Y02.addPreDro) annotation (Line(points={{-336.5,
          57},{-345.25,57},{-345.25,36.6},{-366,36.6}}, color={255,0,255}));
  connect(Y04.y, valOpeningY04.y) annotation (Line(points={{-170,316},{-162,316},
          {-162,340},{-173,340}}, color={0,0,127}));
  connect(senMasFloSup.port_b, resSupAir.port_a)
    annotation (Line(points={{-192,26},{-244,26}}, color={0,127,255}));
  connect(resSupAir.port_b, senTemAbs.port_a) annotation (Line(points={{-264,26},
          {-280,26},{-296,26}}, color={0,127,255}));
  connect(Y08.port_b, resExiAir.port_a) annotation (Line(points={{-36,304},{-70,
          304},{-108,304}}, color={0,127,255}));
  connect(Y04.port_b, resExiAir.port_a) annotation (Line(points={{-160,304},{
          -160,304},{-108,304}}, color={0,127,255}));
  connect(resExiAir.port_b, ExitAir) annotation (Line(points={{-108,324},{-118,
          324},{-118,338},{-128,338}}, color={0,127,255}));
  connect(exhaustAirFan.port_b, resExhAir.port_a) annotation (Line(points={{
          -350,304},{-324,304},{-304,304}}, color={0,127,255}));
  connect(resExhAir.port_b, senTemExi.port_a) annotation (Line(points={{-284,
          304},{-258,304},{-232,304}}, color={0,127,255}));
  connect(regenerationAirFan.port_b, resRegAir.port_a) annotation (Line(points=
          {{168,304},{156,304},{144,304}}, color={0,127,255}));
  connect(resRegAir.port_b, Desorber.port_a) annotation (Line(points={{124,304},
          {113,304},{102,304}}, color={0,127,255}));
  connect(externalAir, resOutAir.port_a)
    annotation (Line(points={{354,26},{342,26}}, color={0,127,255}));
  connect(resOutAir.port_b, Y05.port_a)
    annotation (Line(points={{322,26},{322,26},{224,26}}, color={0,127,255}));
  connect(resOutAir.port_b, Y07.port_a)
    annotation (Line(points={{322,26},{314,26},{314,168}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},
            {360,360}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},{360,360}})));
end MenergaSimple;
