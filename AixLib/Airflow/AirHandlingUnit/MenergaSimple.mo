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
    annotation (Placement(transformation(extent={{-378,294},{-358,314}})));
  Modelica.Fluid.Interfaces.FluidPort_a RegenerationAirInlet(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for Regeneration Air (positive design flow direction is from RegenerationAirInlet to ExitAir)"
    annotation (Placement(transformation(extent={{326,294},{346,314}})));
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
    m_flow_nominal=0.01,
    dp_nominal=50,
    mWat_flow_nominal=0.01)
    "dehumidifier to imitate the effect of the absorber module"
    annotation (Placement(transformation(extent={{-14,16},{-34,36}})));
  Fluid.HeatExchangers.ConstantEffectiveness HeatingCoil(redeclare package
    Medium1 = MediumAir, redeclare package Medium2 = MediumWater,
    m1_flow_nominal=5.1,
    m2_flow_nominal=0.1,
    dp1_nominal=50,
    dp2_nominal=20)
    "Heating Coil after Recuperator for additional Heating"
    annotation (Placement(transformation(extent={{-400,10},{-420,30}})));
  Fluid.MassExchangers.Humidifier_u steamHumidifier(
    redeclare package Medium = MediumAir,
    m_flow_nominal=0.01,
    dp_nominal=50,
    mWat_flow_nominal=0.01) "steam Humdifier outside of Menerga"
    annotation (Placement(transformation(extent={{-512,16},{-532,36}})));
  Fluid.Sources.Boundary_pT WaterInletCoil(
  redeclare package Medium = MediumWater,
    nPorts=1,
    p=105000)
    "Water Source for the Water circle in the heating Coil"
    annotation (Placement(transformation(extent={{-460,-40},{-440,-20}})));
  Fluid.Sources.Boundary_pT WaterOutletCoil(
  redeclare package Medium = MediumWater, nPorts=1)
    "Water Outlet for the Water Circle at the heating coil"
    annotation (Placement(transformation(extent={{-360,-40},{-380,-20}})));
  Modelica.Blocks.Sources.Constant InletFlow_mflow1(k=0.01)
    "nominal mass flow in steamHumidifier"
    annotation (Placement(transformation(extent={{-534,76},{-514,96}})));
  Modelica.Blocks.Sources.Constant InletFlow_mflow2(k=-0.01)
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
    annotation (Placement(transformation(extent={{-290,16},{-310,36}})));
  Fluid.Sensors.MassFlowRate senMasFloReg(
  redeclare package Medium = MediumAir) "Mass Flow Rate in Regeneration Vent"
    annotation (Placement(transformation(extent={{250,294},{230,314}})));
  Fluid.Sensors.MassFlowRate senMasFloExh(
  redeclare package Medium = MediumAir) "Mass Flow of moist Exhaust Air"
    annotation (Placement(transformation(extent={{-492,294},{-472,314}})));
  Fluid.Sensors.MassFlowRate senMasFloSup(
  redeclare package Medium = MediumAir) "Mass Flow in Supply Air"
    annotation (Placement(transformation(extent={{-184,16},{-204,36}})));
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
equation
  connect(externalAir, outsideAirFan.port_a) annotation (Line(points={{354,26},
          {96,26}},                          color={0,127,255}));
  connect(InletFlow_mflow.y, outsideAirFan.m_flow_in) annotation (Line(points={{
          51,90},{51,90},{86.2,90},{86.2,38}}, color={0,0,127}));
  connect(RegenAir_mflow.y, regenerationAirFan.m_flow_in) annotation (Line(
        points={{117,338},{178.2,338},{178.2,316}}, color={0,0,127}));
  connect(exhaust_mflow.y, exhaustAirFan.m_flow_in) annotation (Line(points={{-405,
          348},{-368.2,348},{-368.2,316}}, color={0,0,127}));
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
  connect(senMasFloSup.port_b, senTemAbs.port_a) annotation (Line(points={{-204,
          26},{-246,26},{-290,26}}, color={0,127,255}));
  connect(senTemAbs.port_b, HeatingCoil.port_a1) annotation (Line(points={{-310,
          26},{-356,26},{-400,26}}, color={0,127,255}));
  connect(HeatingCoil.port_b1, senTemHea.port_a)
    annotation (Line(points={{-420,26},{-434,26}}, color={0,127,255}));
  connect(exhaustAir, senTemExh.port_a)
    annotation (Line(points={{-624,304},{-578,304}}, color={0,127,255}));
  connect(senTemExh.port_b, senRelHumExh.port_a)
    annotation (Line(points={{-558,304},{-542,304}}, color={0,127,255}));
  connect(senRelHumExh.port_b, senMasFloExh.port_a) annotation (Line(points={{-522,
          304},{-507,304},{-492,304}}, color={0,127,255}));
  connect(exhaustAirFan.port_b, ExitAir) annotation (Line(points={{-358,304},{-128,
          304},{-128,338}}, color={0,127,255}));
  connect(RegenerationAirInlet, senTemReg.port_a) annotation (Line(points={{336,
          304},{316,304},{300,304}}, color={0,127,255}));
  connect(senTemReg.port_b, senMasFloReg.port_a)
    annotation (Line(points={{280,304},{250,304}}, color={0,127,255}));
  connect(senMasFloReg.port_b, regenerationAirFan.port_a) annotation (Line(
        points={{230,304},{212,304},{188,304}}, color={0,127,255}));
  connect(senTemHea.port_b, senRelHumHea.port_a)
    annotation (Line(points={{-454,26},{-478,26}}, color={0,127,255}));
  connect(senRelHumHea.port_b, steamHumidifier.port_a)
    annotation (Line(points={{-498,26},{-512,26}}, color={0,127,255}));
  connect(steamHumidifier.port_b, senTemHeaSup.port_a)
    annotation (Line(points={{-532,26},{-542,26}}, color={0,127,255}));
  connect(senTemHeaSup.port_b, senRelHumSup.port_a)
    annotation (Line(points={{-562,26},{-574,26}}, color={0,127,255}));
  connect(senRelHumSup.port_b, SupplyAir) annotation (Line(points={{-594,26},{-609,
          26},{-624,26}}, color={0,127,255}));
  connect(senMasFloExh.port_b, exhaustAirFan.port_a)
    annotation (Line(points={{-472,304},{-378,304}}, color={0,127,255}));
  connect(regenerationAirFan.port_b, ExitAir) annotation (Line(points={{168,304},
          {88,304},{-128,304},{-128,338}}, color={0,127,255}));
  connect(Absorber.port_b, senMasFloSup.port_a)
    annotation (Line(points={{-34,26},{-72,26},{-184,26}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},
            {360,360}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-640,-100},{360,360}})));
end MenergaSimple;
