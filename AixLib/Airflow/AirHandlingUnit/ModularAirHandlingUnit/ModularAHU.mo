within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ModularAHU "model of a modular air handling unit"

  parameter Boolean humidifying = false;
  parameter Boolean cooling = false;
  parameter Boolean dehumidifying = false;
  parameter Boolean heating = false;
  parameter Boolean heatRecovery = false;
  parameter Boolean use_PhiSet = false;

  parameter Modelica.SIunits.Temperature Twat=373.15
    "water or steam temperature"
    annotation(Dialog(group="Humidifying",enable=humidifying));
  parameter Modelica.SIunits.Temperature TcooSur=373.15
    "temperature of cooling surface (set to high value if no condensate should 
    be considered)"
    annotation(Dialog(group="Cooling",enable=cooling or dehumidifying));
  constant Modelica.SIunits.Density rho = 1.2 "constant density of air";

  // Efficiency of HRS
  parameter Real efficiencyHRS_enabled(
    min=0,
    max=1) = 0.8 "efficiency of HRS in the AHU modes when HRS is enabled"
    annotation (Dialog(group="Settings AHU Value", enable=HRS));
  parameter Real efficiencyHRS_disabled(
    min=0,
    max=1) = 0.2
    "taking a little heat transfer into account although HRS is disabled 
    (in case that a HRS is physically installed in the AHU)"
    annotation (Dialog(group="Settings AHU Value", enable=heatReecovery));
  // assumed increase in ventilator pressure
  parameter Modelica.SIunits.Pressure dp_sup=800
    "pressure difference over supply fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.SIunits.Pressure dp_eta=800
    "pressure difference over extract fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  // assumed efficiencies of the ventilators
  parameter Modelica.SIunits.Efficiency eta_sup=0.7 "efficiency of supply fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));
  parameter Modelica.SIunits.Efficiency eta_eta=0.7 "efficiency of extract fan"
    annotation (Dialog(tab="Fans", group="Constant Assumptions"));

  Modelica.Blocks.Interfaces.RealInput VflowOda(unit="m3/s") "m3/s"
                                                annotation (Placement(
        transformation(extent={{-174,66},{-146,94}}), iconTransformation(extent={{-168,56},
            {-160,64}})));
  Modelica.Blocks.Interfaces.RealInput T_oda(unit="K", start=288.15) "K"
    annotation (Placement(transformation(extent={{-174,26},{-146,54}}),
        iconTransformation(extent={{-168,36},{-160,44}})));
  Modelica.Blocks.Interfaces.RealInput phi_oda(start=0.5)
    "relative humidity of outdoor air" annotation (Placement(transformation(
          extent={{-174,-14},{-146,14}}), iconTransformation(extent={{-168,16},
            {-160,24}})));
  Components.PlateHeatExchangerFixedEfficiency
    plateHeatExchangerFixedEfficiency(
    rho_air=rho,
    epsEnabled=efficiencyHRS_enabled,
    epsDisabled=efficiencyHRS_disabled,
                                      redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple) if
                                         heatRecovery
    annotation (Placement(transformation(extent={{-94,2},{-74,22}})));
  Components.FanSimple fanSimple(rho_air=rho, eta=eta_sup)
    annotation (Placement(transformation(extent={{8,-48},{28,-28}})));
  Components.FanSimple fanSimple1(rho_air=rho, eta=eta_eta)
    annotation (Placement(transformation(extent={{-20,48},{-40,68}})));
  Modelica.Blocks.Math.Gain gain(k=rho)
    annotation (Placement(transformation(extent={{-140,74},{-128,86}})));

  Modelica.Blocks.Interfaces.RealInput VflowEta(unit="m3/s") "m3/s" annotation (
     Placement(transformation(extent={{174,66},{146,94}}), iconTransformation(
          extent={{168,56},{160,64}})));
  Modelica.Blocks.Math.Gain gain1(k=rho)
    annotation (Placement(transformation(extent={{134,74},{122,86}})));
  Modelica.Blocks.Interfaces.RealInput T_eta(unit="K", start=288.15) "K"
    annotation (Placement(transformation(extent={{174,26},{146,54}}),
        iconTransformation(extent={{168,36},{160,44}})));
  Modelica.Blocks.Interfaces.RealInput X_eta(start=0.007)
    "kg of water/kg of dry air" annotation (Placement(transformation(extent={{174,
            -14},{146,14}}), iconTransformation(extent={{168,16},{160,24}})));

  Components.Cooler coo(
    rho_air(displayUnit="kg/m3") = rho,
    use_T_set=true,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple) if
                                                  cooling or dehumidifying
    annotation (Placement(transformation(extent={{-32,-50},{-12,-30}})));

  replaceable model humidifier = Components.SteamHumidifier
    constrainedby Components.BaseClasses.PartialHumidifier
    "replaceable model for humidifier"
    annotation(choicesAllMatching=true);

  humidifier hum(
    rho_air=rho,
    use_X_set=true,
    redeclare model PartialPressureDrop =
      Components.PressureDrop.PressureDropSimple) if humidifying
    annotation (Placement(transformation(extent={{54,-64},{74,-44}})));
  Components.Heater hea(
    rho_air=rho,
    use_T_set=true,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple,
    use_constant_heatTransferCoefficient=true) if heating or dehumidifying
    annotation (Placement(transformation(extent={{96,-64},{116,-44}})));
  Modelica.Blocks.Interfaces.RealInput T_supplyAir(unit="K", start=295.15)
    "K (use as PortIn)"
    annotation (Placement(transformation(extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={100,-100}),
        iconTransformation(extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={140,-104})));
  Modelica.Blocks.Interfaces.RealInput phi_supplyAir[2](start={0.4,0.6})
    "relativ Humidity [Range: 0...1] (Vector: [1] min, [2] max)" annotation (Placement(
        transformation(
        extent={{14,-14},{-14,14}},
        rotation=-90,
        origin={72,-100}), iconTransformation(
        extent={{-4,-4},{4,4}},
        rotation=90,
        origin={120,-104})));
  Modelica.Blocks.Interfaces.RealOutput phi_supplyAirOut(start=0.8)
    "relativ Humidity [Range: 0...1]" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={160,-60}), iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-40})));
  Modelica.Blocks.Interfaces.RealOutput T_supplyAirOut(unit="K", start=295.15)
    "K (use as PortOut)" annotation (Placement(transformation(
        extent={{-9,-9},{9,9}},
        rotation=0,
        origin={159,-27}),
                         iconTransformation(
        extent={{4,-4},{-4,4}},
        rotation=180,
        origin={164,-20})));

  Modelica.Blocks.Interfaces.RealOutput QflowC(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed cooling power supplied from a cooling circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-150,-100}),
                           iconTransformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-51,-105})));
  Modelica.Blocks.Interfaces.RealOutput QflowH(
    unit="W",
    min=0,
    start=0.01)
    "The absorbed heating power supplied from a heating circuit [W]"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-120,-100}),
                           iconTransformation(
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
  Modelica.Blocks.Interfaces.RealOutput QflowHum(
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
  Controler.ControlerHeatRecovery controlerHeatRecovery(
    eps=plateHeatExchangerFixedEfficiency.epsEnabled,
    dT_min=2) if heatRecovery
    annotation (Placement(transformation(extent={{-110,34},{-90,54}})));
  Modelica.Blocks.Sources.Constant watIn(k=Twat) if humidifying
    annotation (Placement(transformation(extent={{42,-76},{50,-68}})));
protected
  parameter Boolean use_X_set = dehumidifying "true if dehumidifying is chosen";
  // output of power
  Modelica.Blocks.Interfaces.RealInput QHeaIntern
    "internal connector for heating power";
  Modelica.Blocks.Interfaces.RealInput QCooIntern
    "internal connector for cooling power";
  Modelica.Blocks.Interfaces.RealInput QHumIntern
    "internal connector for humidification power";
  // PassTrhoughs
  Components.PassThrough passThroughHrs if not heatRecovery
    annotation (Placement(transformation(extent={{-94,-26},{-74,-6}})));
  Components.PassThrough passThroughCoo if not cooling and not dehumidifying
    annotation (Placement(transformation(extent={{-32,-26},{-12,-6}})));
  // Input for fans
  Modelica.Blocks.Sources.Constant dpEtaIn(k=dp_eta)
    annotation (Placement(transformation(extent={{-56,76},{-48,84}})));
  Modelica.Blocks.Sources.Constant dpSupIn(k=dp_sup)
    annotation (Placement(transformation(extent={{-2,2},{6,10}})));

  Components.PassThrough passThroughHum if not humidifying
    annotation (Placement(transformation(extent={{54,-36},{74,-16}})));
  Components.PassThrough passThroughHea if not heating and not dehumidifying
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));
  // Controler
public
  Controler.ControlerHumidifier controlerHumidifier(use_PhiSet=true)
    annotation (Placement(transformation(extent={{46,-12},{54,-4}})));
  // Utilities
  Controler.ControlerCoolerPID controlerCoolerPID(activeDehumidifying=dehumidifying) if cooling or dehumidifying annotation (Placement(transformation(extent={{-34,-90},{-14,-70}})));
protected
  Modelica.Blocks.Sources.Constant p_atm(k=101325)
    annotation (Placement(transformation(extent={{126,-96},{134,-88}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{142,-84},{150,-76}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{126,-84},{134,-76}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
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
equation

  if phi_oda > 1 or phi_oda < 0 then
    Modelica.Utilities.Streams.print("Warning: The relative humidity of outdoor air is not in the range [0, 1]");
  end if;

  if not cooling and not dehumidifying then
    QCooIntern = 0;
  end if;

  if not heating and not dehumidifying then
    QHeaIntern = 0;
  end if;

  if not humidifying then
    QHumIntern = 0;
  end if;

  connect(hea.Q,QHeaIntern);
  connect(coo.Q,QCooIntern);
  connect(hum.Q,QHumIntern);

  connect(QHeaIntern,QflowH);
  connect(QCooIntern,QflowC);
  connect(QHumIntern,QflowHum);

  connect(VflowOda, gain.u)
    annotation (Line(points={{-160,80},{-141.2,80}}, color={0,0,127}));
  connect(gain.y, plateHeatExchangerFixedEfficiency.m_flow_airInOda)
    annotation (Line(points={{-127.4,80},{-120,80},{-120,20},{-95,20}}, color={0,
          0,127}));
  connect(T_oda, plateHeatExchangerFixedEfficiency.T_airInOda) annotation (Line(
        points={{-160,40},{-120,40},{-120,17},{-95,17}}, color={0,0,127}));
  connect(gain.y, passThroughHrs.m_flow_airIn) annotation (Line(points={{-127.4,
          80},{-120,80},{-120,-11},{-95,-11}}, color={0,0,127}));
  connect(T_oda, passThroughHrs.T_airIn) annotation (Line(points={{-160,40},{-120,
          40},{-120,-16},{-95,-16}}, color={0,0,127}));
  connect(VflowEta, gain1.u)
    annotation (Line(points={{160,80},{135.2,80}}, color={0,0,127}));
  connect(gain1.y, fanSimple1.m_flow_airIn) annotation (Line(points={{121.4,80},
          {-6,80},{-6,66},{-19,66}}, color={0,0,127}));
  connect(T_eta, fanSimple1.T_airIn) annotation (Line(points={{160,40},{126,40},
          {126,63},{-19,63}}, color={0,0,127}));
  connect(X_eta, fanSimple1.X_airIn) annotation (Line(points={{160,0},{126,0},{126,
          60},{-19,60}}, color={0,0,127}));
  connect(dpEtaIn.y, fanSimple1.dpIn)
    annotation (Line(points={{-47.6,80},{-30,80},{-30,69}}, color={0,0,127}));
  connect(dpSupIn.y, fanSimple.dpIn) annotation (Line(points={{6.4,6},{18,6},{
          18,-27}},   color={0,0,127}));
  connect(hum.m_flow_airOut, hea.m_flow_airIn)
    annotation (Line(points={{75,-46},{95,-46}}, color={0,0,127}));
  connect(hum.T_airOut, hea.T_airIn) annotation (Line(points={{75,-49},{84.5,-49},
          {84.5,-49},{95,-49}}, color={0,0,127}));
  connect(hum.X_airOut, hea.X_airIn)
    annotation (Line(points={{75,-52},{95,-52}}, color={0,0,127}));
  connect(passThroughHum.m_flow_airOut, passThroughHea.m_flow_airIn)
    annotation (Line(points={{75,-21},{84.5,-21},{84.5,-21},{95,-21}}, color={0,
          0,127}));
  connect(passThroughHum.T_airOut, passThroughHea.T_airIn)
    annotation (Line(points={{75,-26},{95,-26}}, color={0,0,127}));
  connect(passThroughHum.X_airOut, passThroughHea.X_airIn) annotation (Line(
        points={{75,-31},{84.5,-31},{84.5,-31},{95,-31}}, color={0,0,127}));
  connect(passThroughHum.m_flow_airOut, hea.m_flow_airIn) annotation (Line(
        points={{75,-21},{84,-21},{84,-46},{95,-46}}, color={0,0,127}));
  connect(passThroughHum.T_airOut, hea.T_airIn) annotation (Line(points={{75,-26},
          {84,-26},{84,-49},{95,-49}}, color={0,0,127}));
  connect(passThroughHum.X_airOut, hea.X_airIn) annotation (Line(points={{75,-31},
          {84,-31},{84,-52},{95,-52}}, color={0,0,127}));
  connect(hum.m_flow_airOut, passThroughHea.m_flow_airIn) annotation (Line(
        points={{75,-46},{84,-46},{84,-21},{95,-21}}, color={0,0,127}));
  connect(hum.T_airOut, passThroughHea.T_airIn) annotation (Line(points={{75,-49},
          {84,-49},{84,-26},{95,-26}}, color={0,0,127}));
  connect(hum.X_airOut, passThroughHea.X_airIn) annotation (Line(points={{75,-52},
          {84,-52},{84,-31},{95,-31}}, color={0,0,127}));
  connect(T_supplyAir, hea.T_set) annotation (Line(points={{100,-100},{100,-80},
          {106,-80},{106,-44}}, color={0,0,127}));
  connect(phi_supplyAir[1], controlerHumidifier.PhiSet) annotation (Line(points=
         {{72,-107},{72,-80},{40,-80},{40,-10.4},{45.6,-10.4}}, color={0,0,127}));
  connect(T_supplyAir, controlerHumidifier.Tset) annotation (Line(points={{100,-100},
          {100,-80},{40,-80},{40,-5.6},{45.6,-5.6}}, color={0,0,127}));
  connect(controlerHumidifier.XHumSet, hum.X_set)
    annotation (Line(points={{54.4,-8},{64,-8},{64,-43.8}}, color={0,0,127}));
  connect(hea.T_airOut, T_supplyAirOut) annotation (Line(points={{117,-49},{134,
          -49},{134,-27},{159,-27}}, color={0,0,127}));
  connect(passThroughHea.T_airOut, T_supplyAirOut) annotation (Line(points={{117,
          -26},{134,-26},{134,-27},{159,-27}}, color={0,0,127}));
  connect(hea.X_airOut, realPassThrough.u) annotation (Line(points={{117,-52},{122,
          -52},{122,-80},{125.2,-80}}, color={0,0,127}));
  connect(passThroughHea.X_airOut, realPassThrough.u) annotation (Line(points={{
          117,-31},{122,-31},{122,-80},{125.2,-80}}, color={0,0,127}));
  connect(realPassThrough.y, phi.X_w)
    annotation (Line(points={{134.4,-80},{141.6,-80}}, color={0,0,127}));
  connect(passThroughHea.T_airOut, phi.T) annotation (Line(points={{117,-26},{134,
          -26},{134,-70},{138,-70},{138,-76.8},{141.6,-76.8}}, color={0,0,127}));
  connect(hea.T_airOut, phi.T) annotation (Line(points={{117,-49},{134,-49},{
          134,-70},{138,-70},{138,-76.8},{141.6,-76.8}},
                                                     color={0,0,127}));
  connect(p_atm.y, phi.p) annotation (Line(points={{134.4,-92},{138,-92},{138,-83.2},
          {141.6,-83.2}}, color={0,0,127}));
  connect(phi.phi, phi_supplyAirOut) annotation (Line(points={{150.4,-80},{156,-80},
          {156,-60},{160,-60}}, color={0,0,127}));
  connect(add.y, Pel)
    annotation (Line(points={{-60,-80.6},{-60,-100}}, color={0,0,127}));
  connect(fanSimple1.PelFan, add.u2) annotation (Line(points={{-41,50},{-63.6,
          50},{-63.6,-66.8}},
                          color={0,0,127}));
  connect(fanSimple1.m_flow_airOut, plateHeatExchangerFixedEfficiency.m_flow_airInEta)
    annotation (Line(points={{-41,66},{-66,66},{-66,20},{-73,20}}, color={0,0,
          127}));
  connect(fanSimple1.T_airOut, plateHeatExchangerFixedEfficiency.T_airInEta)
    annotation (Line(points={{-41,63},{-66,63},{-66,17},{-73,17}}, color={0,0,
          127}));
  connect(fanSimple1.X_airOut, plateHeatExchangerFixedEfficiency.X_airInEta)
    annotation (Line(points={{-41,60},{-66,60},{-66,14},{-73,14}}, color={0,0,
          127}));
  connect(fanSimple1.T_airOut, controlerHeatRecovery.T_airInEta) annotation (
      Line(points={{-41,63},{-114,63},{-114,50},{-111,50}}, color={0,0,127}));
  connect(T_oda, controlerHeatRecovery.T_airInOda) annotation (Line(points={{-160,
          40},{-116,40},{-116,38},{-111,38}}, color={0,0,127}));
  connect(T_supplyAir, controlerHeatRecovery.T_set) annotation (Line(points={{100,
          -100},{100,-80},{34,-80},{34,-100},{-160,-100},{-160,56},{-136,56},{-136,
          44},{-111,44}}, color={0,0,127}));
  connect(watIn.y, hum.T_watIn) annotation (Line(points={{50.4,-72},{61,-72},{
          61,-63.4}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.m_flow_airOutOda, passThroughCoo.m_flow_airIn)
    annotation (Line(points={{-73,10},{-56,10},{-56,-11},{-33,-11}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.T_airOutOda, passThroughCoo.T_airIn)
    annotation (Line(points={{-73,7},{-56,7},{-56,-16},{-33,-16}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.X_airOutOda, passThroughCoo.X_airIn)
    annotation (Line(points={{-73,4},{-56,4},{-56,-21},{-33,-21}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.m_flow_airOutOda, coo.m_flow_airIn)
    annotation (Line(points={{-73,10},{-56,10},{-56,-32},{-33,-32}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.T_airOutOda, coo.T_airIn)
    annotation (Line(points={{-73,7},{-56,7},{-56,-35},{-33,-35}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.X_airOutOda, coo.X_airIn)
    annotation (Line(points={{-73,4},{-56,4},{-56,-38},{-33,-38}}, color={0,0,
          127}));
  connect(passThroughHrs.m_flow_airOut, passThroughCoo.m_flow_airIn)
    annotation (Line(points={{-73,-11},{-52.5,-11},{-52.5,-11},{-33,-11}},
        color={0,0,127}));
  connect(passThroughHrs.T_airOut, passThroughCoo.T_airIn)
    annotation (Line(points={{-73,-16},{-33,-16}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, passThroughCoo.X_airIn) annotation (Line(
        points={{-73,-21},{-52.5,-21},{-52.5,-21},{-33,-21}}, color={0,0,127}));
  connect(passThroughHrs.m_flow_airOut, coo.m_flow_airIn) annotation (Line(
        points={{-73,-11},{-56,-11},{-56,-32},{-33,-32}}, color={0,0,127}));
  connect(passThroughHrs.T_airOut, coo.T_airIn) annotation (Line(points={{-73,
          -16},{-56,-16},{-56,-35},{-33,-35}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, coo.X_airIn) annotation (Line(points={{-73,
          -21},{-56,-21},{-56,-38},{-33,-38}}, color={0,0,127}));
  connect(passThroughCoo.m_flow_airOut, fanSimple.m_flow_airIn) annotation (
      Line(points={{-11,-11},{0,-11},{0,-30},{7,-30}}, color={0,0,127}));
  connect(passThroughCoo.T_airOut, fanSimple.T_airIn) annotation (Line(points={
          {-11,-16},{0,-16},{0,-33},{7,-33}}, color={0,0,127}));
  connect(passThroughCoo.X_airOut, fanSimple.X_airIn) annotation (Line(points={
          {-11,-21},{0,-21},{0,-36},{7,-36}}, color={0,0,127}));
  connect(coo.m_flow_airOut, fanSimple.m_flow_airIn) annotation (Line(points={{
          -11,-32},{0,-32},{0,-30},{7,-30}}, color={0,0,127}));
  connect(coo.T_airOut, fanSimple.T_airIn) annotation (Line(points={{-11,-35},{
          0,-35},{0,-33},{7,-33}}, color={0,0,127}));
  connect(coo.X_airOut, fanSimple.X_airIn) annotation (Line(points={{-11,-38},{
          0,-38},{0,-36},{7,-36}}, color={0,0,127}));
  connect(fanSimple.m_flow_airOut, passThroughHum.m_flow_airIn) annotation (
      Line(points={{29,-30},{36,-30},{36,-21},{53,-21}}, color={0,0,127}));
  connect(fanSimple.T_airOut, passThroughHum.T_airIn) annotation (Line(points={
          {29,-33},{36,-33},{36,-26},{53,-26}}, color={0,0,127}));
  connect(fanSimple.X_airOut, passThroughHum.X_airIn) annotation (Line(points={
          {29,-36},{36,-36},{36,-31},{53,-31}}, color={0,0,127}));
  connect(fanSimple.m_flow_airOut, hum.m_flow_airIn) annotation (Line(points={{
          29,-30},{36,-30},{36,-46},{53,-46}}, color={0,0,127}));
  connect(fanSimple.T_airOut, hum.T_airIn) annotation (Line(points={{29,-33},{
          36,-33},{36,-49},{53,-49}}, color={0,0,127}));
  connect(fanSimple.X_airOut, hum.X_airIn) annotation (Line(points={{29,-36},{
          36,-36},{36,-52},{53,-52}}, color={0,0,127}));
  connect(fanSimple.PelFan, add.u1) annotation (Line(points={{29,-46},{32,-46},
          {32,-66.8},{-56.4,-66.8}}, color={0,0,127}));
  connect(fanSimple.dT_fan, add1.u2) annotation (Line(points={{29,-43},{32,-43},
          {32,-78.4},{19.2,-78.4}}, color={0,0,127}));
  connect(T_supplyAir, add1.u1) annotation (Line(points={{100,-100},{100,-80},{
          34,-80},{34,-85.6},{19.2,-85.6}}, color={0,0,127}));
  connect(controlerHeatRecovery.hrsOn, plateHeatExchangerFixedEfficiency.hrsOn)
    annotation (Line(points={{-89,44},{-84,44},{-84,24}}, color={255,0,255}));
  connect(relToAbsHum.absHum, passThroughHrs.X_airIn) annotation (Line(points={
          {-125,-3},{-120,-3},{-120,-21},{-95,-21}}, color={0,0,127}));
  connect(phi_oda, relToAbsHum.relHum)
    annotation (Line(points={{-160,0},{-137,0},{-137,-0.4}}, color={0,0,127}));
  connect(relToAbsHum.absHum, plateHeatExchangerFixedEfficiency.X_airInOda)
    annotation (Line(points={{-125,-3},{-120,-3},{-120,14},{-95,14}}, color={0,
          0,127}));
  connect(T_oda, relToAbsHum.TDryBul) annotation (Line(points={{-160,40},{-120,
          40},{-120,-12},{-142,-12},{-142,-5.8},{-137,-5.8}}, color={0,0,127}));
  connect(phi_supplyAir[2], controlerCoolerPID.phiSup) annotation (Line(points={{72,-93},{-40,-93},{-40,-74},{-35,-74}}, color={0,0,127}));
  connect(T_supplyAir, controlerCoolerPID.TsupSet) annotation (Line(points={{100,-100},{-40,-100},{-40,-82},{-35,-82}}, color={0,0,127}));
  connect(coo.X_airOut, controlerCoolerPID.Xout) annotation (Line(points={{-11,-38},{0,-38},{0,-70},{-40,-70},{-40,-86},{-35,-86}}, color={0,0,127}));
  connect(controlerCoolerPID.TcoolerSet, coo.T_set) annotation (Line(points={{-13,-80},{-6,-80},{-6,-58},{-42,-58},{-42,-26},{-22,-26},{-22,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})));
end ModularAHU;
