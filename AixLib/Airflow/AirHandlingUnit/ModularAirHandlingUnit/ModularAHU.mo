within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ModularAHU "model of a modular air handling unit"

  parameter Boolean humidifying = false;
  parameter Boolean cooling = false;
  parameter Boolean dehumidifying = false;
  parameter Boolean heating = false;
  parameter Boolean heatRecovery = false;
  parameter Boolean use_PhiSet = false;

  parameter Modelica.SIunits.Temperature Twat = 373.15
    "water or steam temperature"
    annotation(Dialog(group="Humidifying",enable=humidifying));
  parameter Modelica.SIunits.Temperature TcooSur = 373.15
    "temperature of cooling surface set to high value if no condensate should be considered"
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
  Modelica.Blocks.Interfaces.RealInput X_oda(start=0.007)
    "kg of water/kg of dry air" annotation (Placement(transformation(extent={{-174,
            -14},{-146,14}}), iconTransformation(extent={{-168,16},{-160,24}})));
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
    annotation (Placement(transformation(extent={{-38,-58},{-18,-38}})));
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
    use_X_set=dehumidifying,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple,
    use_constant_heatTransferCoefficient=true) if cooling or dehumidifying
    annotation (Placement(transformation(extent={{6,-66},{26,-46}})));
  replaceable Components.SteamHumidifier hum(
    rho_air=rho,                             use_X_set=true,
    redeclare model PartialPressureDrop =
      Components.PressureDrop.PressureDropSimple) if humidifying
    annotation (Dialog(enable=humidifying),choices(
      choice(humidifier = Components.SteamHumidifier "Steam Humidifier"),
      choice(humidifier = Components.SprayHumidifier "Spray Humidifier")),
      Placement(transformation(extent={{54,-64},{74,-44}})));
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
protected
  parameter Boolean use_X_set = dehumidifying "true if dehumidifying is chosen";
  // output of power
  Modelica.Blocks.Interfaces.RealInput QHeaIntern "internal connector for heating power";
  Modelica.Blocks.Interfaces.RealInput QCooIntern "internal connector for cooling power";
  Modelica.Blocks.Interfaces.RealInput QHumIntern "internal connector for humidification power";
  // PassTrhoughs
  Components.PassThrough passThroughHrs if not heatRecovery
    annotation (Placement(transformation(extent={{-94,-26},{-74,-6}})));
  Components.PassThrough passThroughCoo if not cooling and not dehumidifying
    annotation (Placement(transformation(extent={{6,-38},{26,-18}})));
  // Input for fans
  Modelica.Blocks.Sources.Constant dpEtaIn(k=dp_eta)
    annotation (Placement(transformation(extent={{-56,76},{-48,84}})));
  Modelica.Blocks.Sources.Constant dpSupIn(k=dp_sup)
    annotation (Placement(transformation(extent={{-46,-32},{-38,-24}})));

  Components.PassThrough passThroughHum if not humidifying
    annotation (Placement(transformation(extent={{54,-36},{74,-16}})));
  Components.PassThrough passThroughHea if not heating and not dehumidifying
    annotation (Placement(transformation(extent={{96,-36},{116,-16}})));
  // Controler
  Controler.ControlerCooler controlerCooler(
    use_PhiSet=true,
    dehumidifying=dehumidifying)
    annotation (Placement(transformation(extent={{-16,-86},{-4,-74}})));
  Controler.ControlerHumidifier controlerHumidifier(use_PhiSet=true)
    annotation (Placement(transformation(extent={{46,-12},{54,-4}})));
  // Utilities
  Modelica.Blocks.Sources.Constant p_atm(k=101325)
    annotation (Placement(transformation(extent={{126,-96},{134,-88}})));
  Utilities.Psychrometrics.Phi_pTX phi
    annotation (Placement(transformation(extent={{142,-84},{150,-76}})));
  Modelica.Blocks.Routing.RealPassThrough realPassThrough
    annotation (Placement(transformation(extent={{126,-84},{134,-76}})));
  Modelica.Blocks.Math.Add add annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-60,-80})));
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
  connect(X_oda, plateHeatExchangerFixedEfficiency.X_airInOda) annotation (Line(
        points={{-160,1.77636e-15},{-120,1.77636e-15},{-120,14},{-95,14}},
        color={0,0,127}));
  connect(gain.y, passThroughHrs.m_flow_airIn) annotation (Line(points={{-127.4,
          80},{-120,80},{-120,-11},{-95,-11}}, color={0,0,127}));
  connect(T_oda, passThroughHrs.T_airIn) annotation (Line(points={{-160,40},{-120,
          40},{-120,-16},{-95,-16}}, color={0,0,127}));
  connect(X_oda, passThroughHrs.X_airIn) annotation (Line(points={{-160,0},{-120,
          0},{-120,-21},{-95,-21}}, color={0,0,127}));
  connect(passThroughHrs.m_flow_airOut, fanSimple.m_flow_airIn) annotation (
      Line(points={{-73,-11},{-52,-11},{-52,-40},{-39,-40}}, color={0,0,127}));
  connect(passThroughHrs.T_airOut, fanSimple.T_airIn) annotation (Line(points={{
          -73,-16},{-52,-16},{-52,-43},{-39,-43}}, color={0,0,127}));
  connect(passThroughHrs.X_airOut, fanSimple.X_airIn) annotation (Line(points={{
          -73,-21},{-52,-21},{-52,-46},{-39,-46}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.m_flow_airOutOda, fanSimple.m_flow_airIn)
    annotation (Line(points={{-73,10},{-52,10},{-52,-40},{-39,-40}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.T_airOutOda, fanSimple.T_airIn)
    annotation (Line(points={{-73,7},{-52,7},{-52,-43},{-39,-43}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.X_airOutOda, fanSimple.X_airIn)
    annotation (Line(points={{-73,4},{-52,4},{-52,-46},{-39,-46}}, color={0,0,127}));
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
  connect(dpSupIn.y, fanSimple.dpIn) annotation (Line(points={{-37.6,-28},{-28,-28},
          {-28,-37}}, color={0,0,127}));
  connect(fanSimple.m_flow_airOut, coo.m_flow_airIn) annotation (Line(points={{-17,
          -40},{-4,-40},{-4,-48},{5,-48}}, color={0,0,127}));
  connect(fanSimple.T_airOut, coo.T_airIn) annotation (Line(points={{-17,-43},{-4,
          -43},{-4,-51},{5,-51}}, color={0,0,127}));
  connect(fanSimple.X_airOut, coo.X_airIn) annotation (Line(points={{-17,-46},{-4,
          -46},{-4,-54},{5,-54}}, color={0,0,127}));
  connect(fanSimple.m_flow_airOut, passThroughCoo.m_flow_airIn) annotation (
      Line(points={{-17,-40},{-4,-40},{-4,-23},{5,-23}}, color={0,0,127}));
  connect(fanSimple.T_airOut, passThroughCoo.T_airIn) annotation (Line(points={{
          -17,-43},{-4,-43},{-4,-28},{5,-28}}, color={0,0,127}));
  connect(fanSimple.X_airOut, passThroughCoo.X_airIn) annotation (Line(points={{
          -17,-46},{-4,-46},{-4,-33},{5,-33}}, color={0,0,127}));
  connect(coo.m_flow_airOut, hum.m_flow_airIn) annotation (Line(points={{27,-48},
          {40,-48},{40,-46},{53,-46}}, color={0,0,127}));
  connect(coo.X_airOut, hum.X_airIn) annotation (Line(points={{27,-54},{40,-54},
          {40,-52},{53,-52}}, color={0,0,127}));
  connect(passThroughCoo.m_flow_airOut, hum.m_flow_airIn) annotation (Line(
        points={{27,-23},{40,-23},{40,-46},{53,-46}}, color={0,0,127}));
  connect(passThroughCoo.T_airOut, hum.T_airIn) annotation (Line(points={{27,-28},
          {40,-28},{40,-49},{53,-49}}, color={0,0,127}));
  connect(passThroughCoo.X_airOut, hum.X_airIn) annotation (Line(points={{27,-33},
          {40,-33},{40,-52},{53,-52}}, color={0,0,127}));
  connect(coo.T_airOut, hum.T_airIn) annotation (Line(points={{27,-51},{40,-51},
          {40,-49},{53,-49}}, color={0,0,127}));
  connect(coo.X_airOut, passThroughHum.X_airIn) annotation (Line(points={{27,-54},
          {40,-54},{40,-31},{53,-31}}, color={0,0,127}));
  connect(coo.T_airOut, passThroughHum.T_airIn) annotation (Line(points={{27,-51},
          {40,-51},{40,-26},{53,-26}}, color={0,0,127}));
  connect(coo.m_flow_airOut, passThroughHum.m_flow_airIn) annotation (Line(
        points={{27,-48},{40,-48},{40,-21},{53,-21}}, color={0,0,127}));
  connect(passThroughCoo.m_flow_airOut, passThroughHum.m_flow_airIn)
    annotation (Line(points={{27,-23},{40,-23},{40,-21},{53,-21}}, color={0,0,127}));
  connect(passThroughCoo.T_airOut, passThroughHum.T_airIn) annotation (Line(
        points={{27,-28},{40,-28},{40,-26},{53,-26}}, color={0,0,127}));
  connect(passThroughCoo.X_airOut, passThroughHum.X_airIn) annotation (Line(
        points={{27,-33},{40,-33},{40,-31},{53,-31}}, color={0,0,127}));
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
  connect(controlerCooler.XCooSet, coo.X_set) annotation (Line(points={{-3.4,-82.4},
          {22,-82.4},{22,-46}}, color={0,0,127}));
  connect(controlerCooler.TCooSet, coo.T_set) annotation (Line(points={{-3.4,-77.6},
          {16,-77.6},{16,-46}}, color={0,0,127}));
  connect(fanSimple.X_airOut, controlerCooler.X_coolerIn) annotation (Line(
        points={{-17,-46},{-10,-46},{-10,-86.6}}, color={0,0,127}));
  connect(phi_supplyAir[2], controlerCooler.PhiSet) annotation (Line(points={{72,
          -93},{72,-92},{-20,-92},{-20,-83.6},{-16.6,-83.6}}, color={0,0,127}));
  connect(T_supplyAir, controlerCooler.Tset) annotation (Line(points={{100,-100},
          {100,-80},{34,-80},{34,-92},{-20,-92},{-20,-76.4},{-16.6,-76.4}},
        color={0,0,127}));
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
  connect(hea.T_airOut, phi.T) annotation (Line(points={{117,-49},{134,-49},{134,
          -70},{138,-70},{138,-76.8},{141.6,-76.8}}, color={0,0,127}));
  connect(p_atm.y, phi.p) annotation (Line(points={{134.4,-92},{138,-92},{138,-83.2},
          {141.6,-83.2}}, color={0,0,127}));
  connect(phi.phi, phi_supplyAirOut) annotation (Line(points={{150.4,-80},{156,-80},
          {156,-60},{160,-60}}, color={0,0,127}));
  connect(add.y, Pel)
    annotation (Line(points={{-60,-86.6},{-60,-100}}, color={0,0,127}));
  connect(fanSimple.PelFan, add.u1) annotation (Line(points={{-17,-56},{-16,-56},
          {-16,-68},{-56.4,-68},{-56.4,-72.8}}, color={0,0,127}));
  connect(fanSimple1.PelFan, add.u2) annotation (Line(points={{-41,50},{-63.6,50},
          {-63.6,-72.8}}, color={0,0,127}));
  connect(fanSimple1.m_flow_airOut, plateHeatExchangerFixedEfficiency.m_flow_airInEta)
    annotation (Line(points={{-41,66},{-66,66},{-66,20},{-73,20}}, color={0,0,
          127}));
  connect(fanSimple1.T_airOut, plateHeatExchangerFixedEfficiency.T_airInEta)
    annotation (Line(points={{-41,63},{-66,63},{-66,17},{-73,17}}, color={0,0,
          127}));
  connect(fanSimple1.X_airOut, plateHeatExchangerFixedEfficiency.X_airInEta)
    annotation (Line(points={{-41,60},{-66,60},{-66,14},{-73,14}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},
            {160,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-100},{160,100}})));
end ModularAHU;
