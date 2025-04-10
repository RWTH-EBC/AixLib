within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ModularAHU "model of a modular air handling unit"

  parameter Boolean humidifying = false
    "set to true if humidifying is implemented";
  parameter Boolean cooling = true
    "set to true if cooling is implemented";
  parameter Boolean dehumidifying = false
    "set to true if dehumidification by sub-cooling is implemented"
    annotation(Dialog(enable=cooling and heating));
  parameter Boolean heating = true
    "set to true if heating is used";
  parameter Boolean heatRecovery = true
    "set to true if heat recovery system is implemented";
  parameter Boolean usePhiSet = false
    "set to true if relative humidity is controlled, else absolute humidity is controlled";
  parameter Boolean limPhiOda = false
    "set to true if outdoor air humidity is limited to saturation";


  // Nominal values
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(start=3000/3600*1.2)
    "nominal mass flow rate in air handling unit"
    annotation(Dialog(group="Nominal values"));
  parameter Modelica.Units.SI.PressureDifference dpHrs_nominal(start=120)
    "nominal pressure drop of heat recovery system"
    annotation(Dialog(group="Nominal values", enable=heatRecovery));
  parameter Modelica.Units.SI.PressureDifference dpCoo_nominal(start=80)
    "nominal pressure drop of cooler"
    annotation(Dialog(group="Nominal values", enable=cooling or dehumidifying));
  parameter Modelica.Units.SI.PressureDifference dpHea_nominal(start=40)
    "nominal pressure drop of heater"
    annotation(Dialog(group="Nominal values", enable=heating or dehumidifying));
  parameter Modelica.Units.SI.PressureDifference dpHum_nominal(start=20)
    "nominal pressure drop of humidifier"
    annotation(Dialog(group="Nominal values", enable=humidifying));
  parameter Modelica.Units.SI.PressureDifference dpFanOda_nominal(start=800)
    "nominal pressure increase of outdoor air fan"
    annotation(Dialog(group="Nominal values"));
  parameter Modelica.Units.SI.PressureDifference dpFanEta_nominal(start=800)
    "nominal pressure increase of extract air fan"
    annotation(Dialog(group="Nominal values"));

  // Heat recovery system parameter
  parameter Real effHrsOn(
    min=0,
    max=1) = 0.8
    "efficiency of HRS in the AHU modes when HRS is enabled"
    annotation (Dialog(group="Settings AHU Value", enable=heatRecovery));
  parameter Real effHrsOff(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled 
    (in case that a HRS is physically installed in the AHU)"
    annotation (Dialog(group="Settings AHU Value", enable=heatReecovery));

  // fan parameter
  parameter Modelica.Units.SI.Pressure dpFanOda=800
    "pressure difference over supply fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.Units.SI.Pressure dpFanEta=800
    "pressure difference over extract fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  // assumed efficiencies of the ventilators
  parameter Modelica.Units.SI.Efficiency etaFanOda=0.7
    "efficiency of outdoor air fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.Units.SI.Efficiency etaFanEta=0.7
    "efficiency of extract air fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));

  // Humidifier parameter
  parameter Modelica.Units.SI.Temperature TWat=293.15
    "water temperature"
    annotation(Dialog(tab="Advanced", group="Humidifying",enable=humidifying));
  parameter Modelica.Units.SI.Temperature TSteam=373.15
    "steam temperature"
    annotation(Dialog(tab="Advanced", group="Humidifying",enable=humidifying));

  // Interfaces
  Modelica.Blocks.Interfaces.RealInput VOda_flow(unit="m3/s")
    "volume flow of outdoor air in m3/s"
    annotation (Placement(transformation(extent={{-174,66},{-146,94}}),
        iconTransformation(extent={{-168,56},{-160,64}})));
  Modelica.Blocks.Interfaces.RealInput TOda(unit="K", start=288.15)
    "Temperature of outdoor air in K"
    annotation (Placement(transformation(extent={{-174,26},{-146,54}}),
        iconTransformation(extent={{-168,36},{-160,44}})));
  Modelica.Blocks.Interfaces.RealInput phiOda(
    min=0,
    max=1,
    start=0.5)
    "relative humidity of outdoor air 0...1]"
    annotation (Placement(
        transformation(extent={{-174,-14},{-146,14}}), iconTransformation(
          extent={{-168,16},{-160,24}})));
  Modelica.Blocks.Interfaces.RealInput VEta_flow(unit="m3/s")
    "volume flow of extract air in m3/s"
    annotation (Placement(transformation(extent={{174,66},{146,94}}),
        iconTransformation(extent={{168,56},{160,64}})));
  Modelica.Blocks.Interfaces.RealInput TEta(unit="K", start=288.15)
    "Temperature of extract air in K"
    annotation (Placement(transformation(extent={{174,26},{146,54}}),
        iconTransformation(extent={{168,36},{160,44}})));
  Modelica.Blocks.Interfaces.RealInput phiEta(start=0.5)
    "relative humidity of extract air [0...1]"
    annotation (Placement(transformation(extent={{174,
            -14},{146,14}}), iconTransformation(extent={{168,16},{160,24}})));


  // Components
  Components.HeatRecoverySystem heaRecSys(
    final effOn=effHrsOn,
    final effOff=effHrsOff,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpHrs_nominal,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
      if heatRecovery "heat recovery system"
    annotation (Placement(transformation(extent={{-94,2},{-74,22}})));
  Components.FanSimple fanOda(
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpFanOda_nominal,
    final eta=etaFanOda) "outdoor air fan"
    annotation (Placement(transformation(extent={{8,-48},{28,-28}})));
  Components.FanSimple fanEta(
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpFanEta_nominal,
    final eta=etaFanEta) "extract air fan"
    annotation (Placement(transformation(extent={{-20,48},{-40,68}})));
  Components.Cooler coo(
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpCoo_nominal,
    final use_T_set=true,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple) if cooling "cooler"
    annotation (Placement(transformation(extent={{-32,-50},{-12,-30}})));
  replaceable model humidifier = Components.SteamHumidifier
    constrainedby Components.BaseClasses.PartialHumidifier
    "replaceable model for humidifier"
    annotation(choicesAllMatching=true);

  humidifier hum(
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpHum_nominal,
    final use_X_set=true,
    final TWatIn=TWat,
    final TSteam=TSteam,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple)
      if humidifying
    annotation (Placement(transformation(extent={{54,-64},{74,-44}})));
  Components.Heater hea(
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dpHea_nominal,
    use_T_set=true,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple) if heating
    annotation (Placement(transformation(extent={{96,-64},{116,-44}})));

  // Set values
  Modelica.Blocks.Interfaces.RealInput TSupSet(unit="K", start=295.15)
    "Set value for supply air temperature in K"
                        annotation (Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={100,-100}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={140,-104})));
  Modelica.Blocks.Interfaces.RealInput phiSupSet[2](start={0.4,0.6})
    "set value for supply air relative humidity [Range: 0...1] (Vector: [1] min, [2] max)"
                                                                 annotation (
      Placement(transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={72,-100}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={120,-104})));

  // Outputs
  Modelica.Blocks.Interfaces.RealOutput phiSup(start=0.8)
    "supply air relative humidity"    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={160,-60}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-40})));
  Modelica.Blocks.Interfaces.RealOutput TSup(unit="K", start=295.15)
    "supply air temperature in K"
                         annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={159,-27}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-20})));

  Modelica.Blocks.Interfaces.RealOutput QCoo_flow(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed cooling power supplied from a cooling circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-51,-105})));
  Modelica.Blocks.Interfaces.RealOutput QHea_flow(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed heating power supplied from a heating circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-120,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-11,-105})));
  Modelica.Blocks.Interfaces.RealOutput Pel(
    unit="W",
    min=0,
    start=1e-3)
    "The consumed electrical power supplied from the mains [W]" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-100}),
                          iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={9,-105})));
  Modelica.Blocks.Interfaces.RealOutput QHum_flow(
    unit="W",
    min=0,
    start=0.01) "The humidification power supplied from a humidifier [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-90,-100}), iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-31,-105})));

  // Controler
  Controler.ControlerHumidifier conHum(
    final use_PhiSet=true)
      if humidifying "Controler for Humidifier"
    annotation (Placement(transformation(extent={{46,-12},{54,-4}})));
  Controler.ControlerHeatRecovery conHeaRecSys(
    final dT_min=2)
       if heatRecovery "Controler for heat recovery system"
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));
  Controler.ControlerCooler conCoo(
    final activeDehumidifying=dehumidifying) if cooling "Controler for cooler"
    annotation (Placement(transformation(extent={{-36,-90},{-16,-70}})));
protected
  constant Modelica.Units.SI.Density rho = 1.2
    "constant density of air";
  parameter Boolean use_X_set = dehumidifying "true if dehumidifying is chosen";

  Modelica.Blocks.Routing.RealPassThrough reaPasThrLimPhi if not limPhiOda
    "pass through for realtive humidity, if not limited"
    annotation (Placement(transformation(extent={{-150,-30},{-142,-22}})));
  Modelica.Blocks.Nonlinear.Limiter limPhi(uMax=1, uMin=0) if limPhiOda
    "limits relative humidity to saturation"
    annotation (Placement(transformation(extent={{-146,12},{-136,22}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{126,-84},{134,-76}})));
  Modelica.Blocks.Math.Add add "sums power of both fans"
                               annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,-74})));
  Modelica.Blocks.Math.Add add1(k2=-1)
                               annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={12,-82})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum
    relToAbsHum
    "Converter from relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{-136,-8},{-126,2}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum
    relToAbsHum1
    "Converter from relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{108,44},{98,34}})));
  ThermalZones.ReducedOrder.Multizone.BaseClasses.RelToAbsHum
    relToAbsHum2
    "Converter from relative humidity to absolute humidity"
    annotation (Placement(transformation(extent={{56,-86},{46,-96}})));
  Modelica.Blocks.Math.Gain toMasFloOda(k=rho)
    "converts volume flow to mass flow"
    annotation (Placement(transformation(extent={{-140,74},{-128,86}})));
  Modelica.Blocks.Math.Gain toMasFloEta(k=rho)
    "converts volume flow rate to mass flow rate"
    annotation (Placement(transformation(extent={{134,74},{122,86}})));
  // Utilities
  ThermalZones.ReducedOrder.Multizone.BaseClasses.AbsToRelHum absToRelHum
    "Converter from absolute humidity to relative humidity"
    annotation (Placement(transformation(extent={{142,-88},
            {152,-78}})));

  // output of power
  Modelica.Blocks.Interfaces.RealInput QHeaIntern
    "internal connector for heating power";
  Modelica.Blocks.Interfaces.RealInput QCooIntern
    "internal connector for cooling power";
  Modelica.Blocks.Interfaces.RealInput QHumIntern
    "internal connector for humidification power";

  // PassTroughs
  Components.PassThrough passThroughHrs if not heatRecovery
    "passes variables to next component if no heat recovery system is used"
    annotation (Placement(transformation(extent={{-94,-26},{-74,-6}})));
  Components.PassThrough passThroughCoo if not cooling
    "passes variables to next component if no cooling is implemented"
    annotation (Placement(transformation(extent={{-32,-26},{-12,-6}})));
  Components.PassThrough passThroughHum if not humidifying
    "passes variables to next component if no humidifying is implemented"
    annotation (Placement(transformation(extent={{54,-36},{74,-16}})));
  Components.PassThrough passThroughHea if not heating
    "passes variables to next component if no heating is implemented"
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));

  // Input for fans
  Modelica.Blocks.Sources.Constant dpEtaIn(k=dpFanEta)
    "pressure increase over fan"
    annotation (Placement(transformation(extent={{-56,76},{-48,84}})));
  Modelica.Blocks.Sources.Constant dpSupIn(k=dpFanOda)
    "pressure increase over fan"
    annotation (Placement(transformation(extent={{-2,2},{6,10}})));
equation

  if not cooling and not dehumidifying then
    QCooIntern = 0;
  end if;

  if not heating and not dehumidifying then
    QHeaIntern = 0;
  end if;

  if not humidifying then
    QHumIntern = 0;
  end if;

  connect(hea.Q_flow, QHeaIntern);
  connect(coo.Q_flow, QCooIntern);
  connect(hum.Q_flow, QHumIntern);

  connect(QHeaIntern, QHea_flow);
  connect(QCooIntern, QCoo_flow);
  connect(QHumIntern, QHum_flow);

  connect(VOda_flow, toMasFloOda.u)
    annotation (Line(points={{-160,80},{-141.2,80}}, color={0,0,127}));
  connect(toMasFloOda.y, heaRecSys.mAirInOda_flow) annotation (Line(points={{-127.4,
          80},{-120,80},{-120,20},{-95,20}}, color={0,0,127}));
  connect(TOda, heaRecSys.TAirInOda) annotation (Line(points={{-160,40},{-120,40},
          {-120,17},{-95,17}}, color={0,0,127}));
  connect(toMasFloOda.y, passThroughHrs.m_flow_airIn) annotation (Line(points={{
          -127.4,80},{-120,80},{-120,-11},{-95,-11}}, color={0,0,127}));
  connect(TOda, passThroughHrs.T_airIn) annotation (Line(points={{-160,40},{-120,
          40},{-120,-16},{-95,-16}}, color={0,0,127}));
  connect(VEta_flow, toMasFloEta.u)
    annotation (Line(points={{160,80},{135.2,80}}, color={0,0,127}));
  connect(toMasFloEta.y, fanEta.mAirIn_flow) annotation (Line(points={{121.4,80},
          {-6,80},{-6,66},{-19,66}}, color={0,0,127}));
  connect(TEta, fanEta.TAirIn) annotation (Line(points={{160,40},{126,40},{126,63},
          {-19,63}}, color={0,0,127}));
  connect(dpEtaIn.y, fanEta.dpIn)
    annotation (Line(points={{-47.6,80},{-30,80},{-30,69}}, color={0,0,127}));
  connect(dpSupIn.y, fanOda.dpIn)
    annotation (Line(points={{6.4,6},{18,6},{18,-27}}, color={0,0,127}));
  connect(hum.mAirOut_flow, hea.mAirIn_flow)
    annotation (Line(points={{75,-46},{95,-46}}, color={0,0,127}));
  connect(hum.TAirOut, hea.TAirIn) annotation (Line(points={{75,-49},{84.5,-49},
          {84.5,-49},{95,-49}}, color={0,0,127}));
  connect(hum.XAirOut, hea.XAirIn)
    annotation (Line(points={{75,-52},{95,-52}}, color={0,0,127}));
  connect(passThroughHum.m_flow_airOut, passThroughHea.m_flow_airIn)
    annotation (Line(points={{75,-21},{84.5,-21},{84.5,-21},{95,-21}}, color={0,
          0,127}));
  connect(passThroughHum.T_airOut, passThroughHea.T_airIn)
    annotation (Line(points={{75,-26},{95,-26}}, color={0,0,127}));
  connect(passThroughHum.X_airOut, passThroughHea.X_airIn) annotation (Line(
        points={{75,-31},{84.5,-31},{84.5,-31},{95,-31}}, color={0,0,127}));
  connect(passThroughHum.m_flow_airOut, hea.mAirIn_flow) annotation (Line(
        points={{75,-21},{84,-21},{84,-46},{95,-46}}, color={0,0,127}));
  connect(passThroughHum.T_airOut, hea.TAirIn) annotation (Line(points={{75,-26},
          {84,-26},{84,-49},{95,-49}}, color={0,0,127}));
  connect(passThroughHum.X_airOut, hea.XAirIn) annotation (Line(points={{75,-31},
          {84,-31},{84,-52},{95,-52}}, color={0,0,127}));
  connect(hum.mAirOut_flow, passThroughHea.m_flow_airIn) annotation (Line(
        points={{75,-46},{84,-46},{84,-21},{95,-21}}, color={0,0,127}));
  connect(hum.TAirOut, passThroughHea.T_airIn) annotation (Line(points={{75,-49},
          {84,-49},{84,-26},{95,-26}}, color={0,0,127}));
  connect(hum.XAirOut, passThroughHea.X_airIn) annotation (Line(points={{75,-52},
          {84,-52},{84,-31},{95,-31}}, color={0,0,127}));
  connect(TSupSet, hea.T_set) annotation (Line(points={{100,-100},{100,-80},{106,
          -80},{106,-44}}, color={0,0,127}));
  connect(phiSupSet[1], conHum.PhiSet) annotation (Line(points={{72,-103.5},{72,
          -80},{40,-80},{40,-10.4},{45.6,-10.4}}, color={0,0,127}));
  connect(TSupSet, conHum.Tset) annotation (Line(points={{100,-100},{100,-80},{40,
          -80},{40,-5.6},{45.6,-5.6}}, color={0,0,127}));
  connect(conHum.XHumSet, hum.X_set)
    annotation (Line(points={{54.4,-8},{64,-8},{64,-43.8}}, color={0,0,127}));
  connect(hea.TAirOut, TSup) annotation (Line(points={{117,-49},{136,-49},{136,-27},
          {159,-27}}, color={0,0,127}));
  connect(passThroughHea.T_airOut, TSup) annotation (Line(points={{117,-26},{134,
          -26},{134,-27},{159,-27}}, color={0,0,127}));
  connect(hea.XAirOut, realPassThrough.u) annotation (Line(points={{117,-52},{122,
          -52},{122,-80},{125.2,-80}}, color={0,0,127}));
  connect(passThroughHea.X_airOut, realPassThrough.u) annotation (Line(points={{
          117,-31},{122,-31},{122,-80},{125.2,-80}}, color={0,0,127}));
  connect(add.y, Pel)
    annotation (Line(points={{-60,-80.6},{-60,-100}}, color={0,0,127}));
  connect(fanEta.PelFan, add.u2) annotation (Line(points={{-41,50},{-63.6,50},{-63.6,
          -66.8}}, color={0,0,127}));
  connect(fanEta.mAirOut_flow, heaRecSys.mAirInEta_flow) annotation (Line(
        points={{-41,66},{-66,66},{-66,20},{-73,20}}, color={0,0,127}));
  connect(fanEta.TAirOut, heaRecSys.TAirInEta) annotation (Line(points={{-41,63},
          {-66,63},{-66,17},{-73,17}}, color={0,0,127}));
  connect(fanEta.XAirOut, heaRecSys.XAirInEta) annotation (Line(points={{-41,60},
          {-66,60},{-66,14},{-73,14}}, color={0,0,127}));
  connect(fanEta.TAirOut, conHeaRecSys.TAirInEta) annotation (Line(points={{-41,
          63},{-114,63},{-114,50},{-111,50}}, color={0,0,127}));
  connect(TOda, conHeaRecSys.TAirInOda) annotation (Line(points={{-160,40},{-116,
          40},{-116,38},{-111,38}}, color={0,0,127}));
  connect(TSupSet, conHeaRecSys.TSet) annotation (Line(points={{100,-100},{100,
          -80},{34,-80},{34,-100},{-160,-100},{-160,56},{-136,56},{-136,44},{-111,
          44}}, color={0,0,127}));
  connect(heaRecSys.mAirOutOda_flow, passThroughCoo.m_flow_airIn) annotation (
      Line(points={{-73,10},{-56,10},{-56,-11},{-33,-11}}, color={0,0,127}));
  connect(heaRecSys.TAirOutOda, passThroughCoo.T_airIn) annotation (Line(points
        ={{-73,7},{-56,7},{-56,-16},{-33,-16}}, color={0,0,127}));
  connect(heaRecSys.XAirOutOda, passThroughCoo.X_airIn) annotation (Line(points
        ={{-73,4},{-56,4},{-56,-21},{-33,-21}}, color={0,0,127}));
  connect(heaRecSys.mAirOutOda_flow, coo.mAirIn_flow) annotation (Line(points={{
          -73,10},{-56,10},{-56,-32},{-33,-32}}, color={0,0,127}));
  connect(heaRecSys.TAirOutOda, coo.TAirIn) annotation (Line(points={{-73,7},{-56,
          7},{-56,-35},{-33,-35}}, color={0,0,127}));
  connect(heaRecSys.XAirOutOda, coo.XAirIn) annotation (Line(points={{-73,4},{-56,
          4},{-56,-38},{-33,-38}}, color={0,0,127}));
  connect(passThroughHrs.m_flow_airOut, passThroughCoo.m_flow_airIn)
    annotation (Line(points={{-73,-11},{-52.5,-11},{-52.5,-11},{-33,-11}},
        color={0,0,127}));
  connect(passThroughHrs.T_airOut, passThroughCoo.T_airIn)
    annotation (Line(points={{-73,-16},{-33,-16}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, passThroughCoo.X_airIn) annotation (Line(
        points={{-73,-21},{-52.5,-21},{-52.5,-21},{-33,-21}}, color={0,0,127}));
  connect(passThroughHrs.m_flow_airOut, coo.mAirIn_flow) annotation (Line(
        points={{-73,-11},{-56,-11},{-56,-32},{-33,-32}}, color={0,0,127}));
  connect(passThroughHrs.T_airOut, coo.TAirIn) annotation (Line(points={{-73,-16},
          {-56,-16},{-56,-35},{-33,-35}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, coo.XAirIn) annotation (Line(points={{-73,-21},
          {-56,-21},{-56,-38},{-33,-38}}, color={0,0,127}));
  connect(passThroughCoo.m_flow_airOut, fanOda.mAirIn_flow) annotation (Line(
        points={{-11,-11},{0,-11},{0,-30},{7,-30}}, color={0,0,127}));
  connect(passThroughCoo.T_airOut, fanOda.TAirIn) annotation (Line(points={{-11,
          -16},{0,-16},{0,-33},{7,-33}}, color={0,0,127}));
  connect(passThroughCoo.X_airOut, fanOda.XAirIn) annotation (Line(points={{-11,
          -21},{0,-21},{0,-36},{7,-36}}, color={0,0,127}));
  connect(coo.mAirOut_flow, fanOda.mAirIn_flow) annotation (Line(points={{-11,-32},
          {0,-32},{0,-30},{7,-30}}, color={0,0,127}));
  connect(coo.TAirOut, fanOda.TAirIn) annotation (Line(points={{-11,-35},{0,-35},
          {0,-33},{7,-33}}, color={0,0,127}));
  connect(coo.XAirOut, fanOda.XAirIn) annotation (Line(points={{-11,-38},{0,-38},
          {0,-36},{7,-36}}, color={0,0,127}));
  connect(fanOda.mAirOut_flow, passThroughHum.m_flow_airIn) annotation (Line(
        points={{29,-30},{36,-30},{36,-21},{53,-21}}, color={0,0,127}));
  connect(fanOda.TAirOut, passThroughHum.T_airIn) annotation (Line(points={{29,-33},
          {36,-33},{36,-26},{53,-26}}, color={0,0,127}));
  connect(fanOda.XAirOut, passThroughHum.X_airIn) annotation (Line(points={{29,-36},
          {36,-36},{36,-31},{53,-31}}, color={0,0,127}));
  connect(fanOda.mAirOut_flow, hum.mAirIn_flow) annotation (Line(points={{29,-30},
          {36,-30},{36,-46},{53,-46}}, color={0,0,127}));
  connect(fanOda.TAirOut, hum.TAirIn) annotation (Line(points={{29,-33},{36,-33},
          {36,-49},{53,-49}}, color={0,0,127}));
  connect(fanOda.XAirOut, hum.XAirIn) annotation (Line(points={{29,-36},{36,-36},
          {36,-52},{53,-52}}, color={0,0,127}));
  connect(fanOda.PelFan, add.u1) annotation (Line(points={{29,-46},{32,-46},{32,
          -66.8},{-56.4,-66.8}}, color={0,0,127}));
  connect(fanOda.temIncFan, add1.u2) annotation (Line(points={{29,-43},{32,-43},
          {32,-78.4},{19.2,-78.4}}, color={0,0,127}));
  connect(TSupSet, add1.u1) annotation (Line(points={{100,-100},{100,-80},{34,-80},
          {34,-85.6},{19.2,-85.6}}, color={0,0,127}));
  connect(relToAbsHum.absHum, passThroughHrs.X_airIn) annotation (Line(points={
          {-125,-3},{-120,-3},{-120,-21},{-95,-21}}, color={0,0,127}));
  connect(relToAbsHum.absHum, heaRecSys.XAirInOda) annotation (Line(points={{-125,
          -3},{-120,-3},{-120,14},{-95,14}}, color={0,0,127}));
  connect(TOda, relToAbsHum.TDryBul) annotation (Line(points={{-160,40},{-120,40},
          {-120,-12},{-142,-12},{-142,-5.8},{-137,-5.8}}, color={0,0,127}));
  connect(phiEta, relToAbsHum1.relHum) annotation (Line(points={{160,0},{122,0},
          {122,36.4},{109,36.4}}, color={0,0,127}));
  connect(TEta, relToAbsHum1.TDryBul) annotation (Line(points={{160,40},{126,40},{126,41.8},{109,41.8}}, color={0,0,127}));
  connect(relToAbsHum1.absHum, fanEta.XAirIn) annotation (Line(points={{97,39},{
          84,39},{84,60},{-19,60}}, color={0,0,127}));
  connect(phiSupSet[2], relToAbsHum2.relHum) annotation (Line(points={{72,-96.5},
          {64,-96.5},{64,-93.6},{57,-93.6}}, color={0,0,127}));
  connect(TSupSet, relToAbsHum2.TDryBul) annotation (Line(points={{100,-100},{100,
          -88.2},{57,-88.2}}, color={0,0,127}));
  connect(absToRelHum.absHum, realPassThrough.y) annotation (Line(points={{141,
          -80.4},{138.5,-80.4},{138.5,-80},{134.4,-80}}, color={0,0,127}));
  connect(absToRelHum.relHum, phiSup) annotation (Line(points={{153,-83},{153,-72.5},
          {160,-72.5},{160,-60}}, color={0,0,127}));
  connect(hea.TAirOut, absToRelHum.TDryBul) annotation (Line(points={{117,-49},{
          136,-49},{136,-85.8},{141,-85.8}}, color={0,0,127}));
  connect(passThroughHea.T_airOut, absToRelHum.TDryBul) annotation (Line(points=
         {{117,-26},{136,-26},{136,-85.8},{141,-85.8}}, color={0,0,127}));
  connect(conCoo.TcoolerSet, coo.T_set) annotation (Line(points={{-15,-80},{-8,-80},
          {-8,-30},{-22,-30}}, color={0,0,127}));
  connect(relToAbsHum2.absHum, conCoo.xSupSet) annotation (Line(points={{45,-91},
          {-48,-91},{-48,-74},{-37,-74}}, color={0,0,127}));
  connect(add1.y, conCoo.TsupSet) annotation (Line(points={{5.4,-82},{-6,-82},{-6,
          -96},{-44,-96},{-44,-82},{-37,-82}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, conCoo.XIn) annotation (Line(points={{-73,-21},
          {-40,-21},{-40,-86},{-37,-86}}, color={0,0,127}));
  connect(heaRecSys.XAirOutOda, conCoo.XIn) annotation (Line(points={{-73,4},{-40,
          4},{-40,-86},{-37,-86}}, color={0,0,127}));
  connect(phiOda, reaPasThrLimPhi.u) annotation (Line(points={{-160,1.77636e-15},
          {-154,1.77636e-15},{-154,-26},{-150.8,-26}}, color={0,0,127}));
  connect(reaPasThrLimPhi.y, relToAbsHum.relHum) annotation (Line(points={{-141.6,
          -26},{-140,-26},{-140,0},{-138,0},{-138,-0.4},{-137,-0.4}}, color={0,0,
          127}));
  connect(phiOda, limPhi.u) annotation (Line(points={{-160,0},{-154,0},{-154,17},
          {-147,17}}, color={0,0,127}));
  connect(limPhi.y, relToAbsHum.relHum) annotation (Line(points={{-135.5,17},{-130,
          17},{-130,6},{-142,6},{-142,-0.4},{-137,-0.4}}, color={0,0,127}));
  connect(conHeaRecSys.bypOpe, heaRecSys.bypOpe)
    annotation (Line(points={{-89,44},{-84,44},{-84,24}}, color={0,0,127}));
  connect(heaRecSys.TAirOutOda, conHeaRecSys.TAirOut) annotation (Line(points={{
          -73,7},{-64,7},{-64,28},{-101.6,28},{-101.6,32}}, color={0,0,127}));
  connect(fanOda.temIncFan, conHeaRecSys.dTFan) annotation (Line(points={{29,-43},
          {32,-43},{32,-56},{-108.6,-56},{-108.6,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}}), graphics={
        Rectangle(
          extent={{-160,100},{160,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-160,0},{160,0}}, color={0,0,0}),
        Rectangle(
          extent={{-136,100},{-70,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-136,-96},{-74,100}}, color={0,0,0}),
        Line(points={{-132,-100},{-70,96}}, color={0,0,0}),
        Rectangle(
          extent={{-110,6},{-98,-8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-8,-28},{36,-72}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-34},{34,-42}}, color={0,0,0}),
        Line(points={{34,-58},{0,-66}}, color={0,0,0}),
        Ellipse(
          extent={{48,68},{4,24}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{6,38},{40,30}}, color={0,0,0}),
        Line(points={{40,62},{6,54}}, color={0,0,0}),
        Rectangle(
          extent={{-58,0},{-18,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-58,0},{-18,-100}}, color={0,0,0}),
        Line(points={{-58,-100},{-18,0}}, color={0,0,0}),
        Rectangle(
          extent={{50,0},{94,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{112,0},{140,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{112,0},{140,-100}}, color={0,0,0}),
        Line(points={{72,-100},{72,-24}}, color={0,0,0}),
        Line(points={{80,-20},{72,-24},{80,-28}}, color={0,0,0}),
        Line(points={{64,-20},{72,-24},{64,-28}}, color={0,0,0}),
        Line(points={{80,-40},{72,-44},{80,-48}}, color={0,0,0}),
        Line(points={{64,-40},{72,-44},{64,-48}}, color={0,0,0})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})),
    Documentation(info="<html><p>
  This model represnts a central air handling unit.
  It can be configured in modular way. Depending on the desired functionalities it will inherit a heat recovery system, a heater, a cooler and a humidifier.
  The type of hmumidifier can be chosen by the user. It will be either steam or adiabatic humidification.
  Dehumidification is realized by sub-cooling only. Hence, if no cooling and heating is implemented, dehumidification will be disabled.
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2020 by Martin Kremer:<br/>
    First Implementation.
  </li>
  <li>February, 2025 by Martin Kremer:<br/>
    Impleted some controler and minor bug fixes.
  </li>
</ul>
</html>"));
end ModularAHU;
