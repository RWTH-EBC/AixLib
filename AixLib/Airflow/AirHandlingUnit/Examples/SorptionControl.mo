within AixLib.Airflow.AirHandlingUnit.Examples;
model SorptionControl "testing sorption module"

      //Medium models
  replaceable package MediumAir = AixLib.Media.Air;
  replaceable package MediumWater = AixLib.Media.Water;

  import SI = Modelica.SIunits;

  parameter SI.Temperature T_init = 293.15 "initialisation temperature";
  parameter SI.MassFlowRate mWat_mflow_nominal( min=0, max=1) = 0.2
                 "nominal mass flow of water in kg/s";
  parameter SI.MassFlowRate mWat_mflow_small(  min=0, max=1) = mWat_mflow_nominal / 10000
                 "leakage mass flow of water";

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  ComponentsAHU.sorptionPartialPressure sorptionPartialPressure(redeclare
      package Medium1 = MediumAir, redeclare package Medium2 = MediumAir)
    annotation (Placement(transformation(extent={{-14,-52},{26,32}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_after(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of air after dehumidification"
    annotation (Placement(transformation(extent={{-150,-48},{-170,-28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_before(redeclare package Medium =
        MediumAir, m_flow_nominal=5.1)
    "Relative Humidity of air before dehumidification"
    annotation (Placement(transformation(extent={{70,-48},{50,-28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_des_before(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Relative Humidity of air before humidification"
    annotation (Placement(transformation(extent={{88,8},{68,28}})));
  Fluid.Sensors.RelativeHumidityTwoPort phi_des_after(redeclare package Medium =
        MediumAir, m_flow_nominal=1)
    "Relative Humidity of air after humidification"
    annotation (Placement(transformation(extent={{-126,8},{-146,28}})));
  Fluid.Movers.FlowControlled_dp     regenerationAirFan_N03(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    T_start=T_init,
    nominalValuesDefineDefaultPressureCurve=true,
    m_flow_nominal=1)
    "provides pressure difference to deliver regeneration air"
    annotation (Placement(transformation(extent={{184,8},{164,28}})));
  Modelica.Fluid.Interfaces.FluidPort_a outsideAir(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for external Air (positive design flow direction is from outsideAir to SupplyAir)"
    annotation (Placement(transformation(extent={{208,56},{228,76}}),
        iconTransformation(extent={{208,56},{228,76}})));
  Modelica.Fluid.Interfaces.FluidPort_a outsideAir1(
    redeclare package Medium = MediumAir,
    m_flow(min=if allowFlowReversal then -Modelica.Constants.inf else 0),
    h_outflow(start=MediumAir.h_default))
    "Fluid connector for external Air (positive design flow direction is from outsideAir to SupplyAir)"
    annotation (Placement(transformation(extent={{210,-48},{230,-28}}),
        iconTransformation(extent={{212,-64},{232,-44}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for supply Air (positive design flow direction is from outsideAir to supplyAir)"
    annotation (Placement(transformation(extent={{-12,110},{8,130}}),
        iconTransformation(extent={{-12,110},{8,130}})));
  Modelica.Fluid.Interfaces.FluidPort_b supplyAir1(
     redeclare package Medium = MediumAir,
     m_flow(max=if allowFlowReversal then +Modelica.Constants.inf else 0),
     h_outflow(start = MediumAir.h_default))
    "Fluid connector for supply Air (positive design flow direction is from outsideAir to supplyAir)"
    annotation (Placement(transformation(extent={{-230,-48},{-210,-28}}),
        iconTransformation(extent={{-232,-72},{-212,-52}})));
  BaseClasses.BusSensors busSensors annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-36,82}),   iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-118,128})));
  BaseClasses.BusActors busActors "Bus connector for actor signals" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={34,82}),    iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={112,126})));
  Fluid.Movers.FlowControlled_dp     outsideAirFan(
    redeclare package Medium = MediumAir,
    addPowerToMedium=false,
    redeclare Fluid.Movers.Data.Generic per,
    T_start=T_init,
    nominalValuesDefineDefaultPressureCurve=true,
    dp_start=600,
    m_flow_nominal=5,
    init=Modelica.Blocks.Types.Init.InitialOutput)
    "Fan to provide mass flow in main supply air vent"
    annotation (Placement(transformation(extent={{166,-48},{146,-28}})));
  Fluid.Sensors.MassFlowRate outMasFlo(redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={106,-38})));
  Fluid.Sensors.MassFlowRate outMasFlo2(
                                       redeclare package Medium = MediumAir)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={120,18})));
  Modelica.Blocks.Sources.RealExpression const(y=1)
    "constant to recreate all other signals" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-104,80})));
  Modelica.Blocks.Sources.RealExpression const1(y=293.15)
    "constant to recreate all other signals" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-104,52})));
  Modelica.Blocks.Sources.RealExpression const2(y=200)
    "constant to recreate all other signals" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-104,96})));
equation
  connect(sorptionPartialPressure.port_b2, phi_after.port_a)
    annotation (Line(points={{-14,-38},{-150,-38}}, color={0,127,255}));
  connect(phi_before.port_b, sorptionPartialPressure.port_a2)
    annotation (Line(points={{50,-38},{26,-38}}, color={0,127,255}));
  connect(phi_des_before.port_b, sorptionPartialPressure.port_a1)
    annotation (Line(points={{68,18},{26,18}}, color={0,127,255}));
  connect(sorptionPartialPressure.port_b1, phi_des_after.port_a)
    annotation (Line(points={{-14,18},{-126,18}},color={0,127,255}));
  connect(outsideAir, regenerationAirFan_N03.port_a)
    annotation (Line(points={{218,66},{202,66},{202,18},{184,18}},
                                                 color={0,127,255}));
  connect(phi_des_after.port_b, supplyAir)
    annotation (Line(points={{-146,18},{-182,18},{-182,120},{-2,120}},
                                                   color={0,127,255}));
  connect(phi_after.port_b, supplyAir1)
    annotation (Line(points={{-170,-38},{-220,-38}}, color={0,127,255}));
  connect(outsideAir1, outsideAirFan.port_a)
    annotation (Line(points={{220,-38},{166,-38}}, color={0,127,255}));
  connect(sorptionPartialPressure.Y06_opening, busActors.openingY06)
    annotation (Line(points={{-12,32.8},{-12,82},{10,82},{10,82.1},{33.9,82.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.Y10_opening, busActors.openingY10)
    annotation (Line(points={{-6.8,32.8},{-6.8,64.4},{33.9,64.4},{33.9,82.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.Y15_opening, busActors.openingY15)
    annotation (Line(points={{-1.6,32.8},{-1.6,64.4},{33.9,64.4},{33.9,82.1}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.Y16_opening, busActors.openingY16)
    annotation (Line(points={{4,32.8},{4,82.1},{33.9,82.1}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.P05, busActors.pumpN05) annotation (Line(
        points={{10,32.8},{10,63.4},{33.9,63.4},{33.9,82.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.P07, busActors.pumpN07) annotation (Line(
        points={{17,32.8},{17,64.4},{33.9,64.4},{33.9,82.1}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.P08, busActors.pumpN08) annotation (Line(
        points={{24,32.8},{24,82.1},{33.9,82.1}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.TDes, busSensors.TDes) annotation (Line(
        points={{26.8,14},{26,14},{26,81.9},{-35.9,81.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.xDes, busSensors.xDes) annotation (Line(
        points={{26.8,9.2},{26.8,64.6},{-35.9,64.6},{-35.9,81.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.xAbs, busSensors.xAbs) annotation (Line(
        points={{26.8,4.4},{26.8,64.2},{-35.9,64.2},{-35.9,81.9}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.massDesorberTank, busSensors.mTankDes)
    annotation (Line(points={{26.8,-0.8},{26.8,64.6},{-35.9,64.6},{-35.9,81.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.massAbsorberTank, busSensors.mTankAbs)
    annotation (Line(points={{26.8,-5},{26.8,64.5},{-35.9,64.5},{-35.9,81.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.senMasFloAbs, busSensors.mFlowAbs)
    annotation (Line(points={{26.8,-9.6},{26.8,65.2},{-35.9,65.2},{-35.9,81.9}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sorptionPartialPressure.Y06_actual, busSensors.Y06_actual)
    annotation (Line(points={{26.8,-14},{26,-14},{26,81.9},{-35.9,81.9}}, color=
         {0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.dp_in, busActors.regenerationFan_dp)
    annotation (Line(points={{174,30},{174,64},{33.9,64},{33.9,82.1}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outsideAirFan.dp_in, busActors.outsideFan_dp) annotation (Line(points=
         {{156,-26},{156,82.1},{33.9,82.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(phi_after.phi, busSensors.T01_RelHum) annotation (Line(points={{-160.1,
          -27},{-160.1,63.5},{-35.9,63.5},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(regenerationAirFan_N03.port_b, outMasFlo2.port_a)
    annotation (Line(points={{164,18},{130,18}}, color={0,127,255}));
  connect(outMasFlo2.port_b, phi_des_before.port_a)
    annotation (Line(points={{110,18},{88,18}}, color={0,127,255}));
  connect(outsideAirFan.port_b, outMasFlo.port_a)
    annotation (Line(points={{146,-38},{116,-38}}, color={0,127,255}));
  connect(outMasFlo.port_b, phi_before.port_a)
    annotation (Line(points={{96,-38},{70,-38}}, color={0,127,255}));
  connect(phi_after.phi, busSensors.T03_RelHum) annotation (Line(points={{-160.1,
          -27},{-160.1,64.5},{-35.9,64.5},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(phi_before.phi, busSensors.T04_RelHum) annotation (Line(points={{59.9,
          -27},{59.9,64.5},{-35.9,64.5},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outMasFlo.m_flow, busSensors.mFlowOut) annotation (Line(points={{106,-27},
          {106,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(outMasFlo2.m_flow, busSensors.mFlowReg) annotation (Line(points={{120,
          29},{120,82},{82,82},{82,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, busSensors.Y02_actual) annotation (Line(points={{-93,80},{-64,
          80},{-64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, busSensors.Y09_actual) annotation (Line(points={{-93,80},{-64,
          80},{-64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, busSensors.mFlowExh) annotation (Line(points={{-93,80},{-64,80},
          {-64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const.y, busSensors.T02_RelHum) annotation (Line(points={{-93,80},{-64,
          80},{-64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const1.y, busSensors.T01) annotation (Line(points={{-93,52},{-64,52},{
          -64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const1.y, busSensors.T02) annotation (Line(points={{-93,52},{-65.5,52},
          {-65.5,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const1.y, busSensors.T03) annotation (Line(points={{-93,52},{-64,52},{
          -64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const1.y, busSensors.T04) annotation (Line(points={{-93,52},{-66,52},{
          -66,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const1.y, busSensors.T_Rek) annotation (Line(points={{-93,52},{-66,52},
          {-66,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const2.y, busSensors.P01) annotation (Line(points={{-93,96},{-62,96},
          {-62,98},{-35.9,98},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(const2.y, busSensors.P02) annotation (Line(points={{-93,96},{-64,96},
          {-64,81.9},{-35.9,81.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (experiment(StopTime=18000, Interval=10),
    Diagram(coordinateSystem(extent={{-220,-120},{220,120}})),
    Icon(coordinateSystem(extent={{-220,-120},{220,120}})));
end SorptionControl;
