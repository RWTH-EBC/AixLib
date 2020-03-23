within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ExampleAHU3 "Model of an examplary air handling unit"

  // Heat Capacities
  parameter Modelica.SIunits.SpecificHeatCapacity cp_air = 1005 "specific heat capacity of dry air";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_steam = 1860 "specific heat capacity of steam";
  parameter Modelica.SIunits.SpecificHeatCapacity c_water = 4180 "specific heat capacity of water";
  parameter Modelica.SIunits.SpecificHeatCapacity c_steel = 920 "specific heat capacity of steel";

  //Heat Recovery System
  parameter Real efficiencyHRS = 0.8 "fixed efficiency of heat recovery system (0...1)" annotation(Dialog(tab="heat recovery"));

  //preheater
  parameter Modelica.SIunits.Mass m_steel_preh = 3 "mass of steel plates and pipes in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.Length length_preh = 0.3 "length of single exchange surface in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.Length width_preh = 0.8 "width of single exchange surface in preheater" annotation(Dialog(tab="preheater"));
  parameter Integer nFins_preh = 120 "number of parallel exchange surfaces (fins) in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.Length delta_preh = 0.0025 "thickness of single exchange surface in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.Length heightDuct_preh = 0.003 "distance between parallel exchange surfaces in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.ThermalConductivity lambda_preh = 670 "thermal conductivity of exchange plates in preheater" annotation(Dialog(tab="preheater"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal_preh = 10000 "nominal heating power of preheater" annotation(Dialog(tab="preheater"));

  //Reheater
  parameter Modelica.SIunits.Mass m_steel_reh = 3 "mass of steel plates and pipes in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.Length length_reh = 0.6 "length of single exchange surface in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.Length width_reh = 0.8 "width of single exchange surface in reheater" annotation(Dialog(tab="reheater"));
  parameter Integer nFins_reh = 120 "number of parallel exchange surfaces (fins) in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.Length delta_reh = 0.0025 "thickness of single exchange surface in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.Length heightDuct_reh = 0.003 "distance between parallel exchange surfaces in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.ThermalConductivity lambda_reh = 670 "thermal conductivity of exchange plates in reheater" annotation(Dialog(tab="reheater"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal_reh = 45000 "nominal heating power of reheater" annotation(Dialog(tab="reheater"));

  //Cooler
  parameter Modelica.SIunits.Mass m_steel_co = 3 "mass of steel plates and pipes in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.Length length_co = 1.2 "length of single exchange surface in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.Length width_co = 0.8 "width of single exchange surface in cooler" annotation(Dialog(tab="cooler"));
  parameter Integer nFins_co = 160 "number of parallel exchange surfaces (fins) in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.Length delta_co = 0.0025 "thickness of single exchange surface in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.Length heightDuct_co = 0.003 "distance between parallel exchange surfaces in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.ThermalConductivity lambda_co = 670 "thermal conductivity of exchange plates in cooler" annotation(Dialog(tab="cooler"));
  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal_co = 120000 "nominal heating power of cooler" annotation(Dialog(tab="cooler"));

  Modelica.SIunits.Temperature TsetCoo "set temperature for cooler";

  Components.PlateHeatExchangerFixedEfficiency
    plateHeatExchangerFixedEfficiency(cp_air=cp_air, cp_steam=cp_steam,
    epsilon=efficiencyHRS,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple (a=0.5, b=1.8))
    annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
  Components.Heater preheater(
    final use_T_set=true,
    cp_air=cp_air,
    cp_steam=cp_steam,
    c_steel=c_steel,
    c_wat=c_water,
    m_steel=m_steel_preh,
    length=length_preh,
    width=width_preh,
    nFins=nFins_preh,
    delta=delta_preh,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple (a=0.3, b=1.6),
    s=heightDuct_preh,
    lambda=lambda_preh,
    Q_flow_nominal=Q_flow_nominal_preh)
    annotation (Placement(transformation(extent={{-34,-12},{-14,8}})));
  Components.Cooler cooler(
    final use_T_set=true,
    final use_X_set=true,
    cp_air=cp_air,
    cp_steam=cp_steam,
    c_steel=c_steel,
    c_wat=c_water,
    m_steel=m_steel_co,
    length=length_co,
    width=width_co,
    nFins=nFins_co,
    delta=delta_co,
    lambda=lambda_co,
    Q_flow_nominal=Q_flow_nominal_co,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple (a=0.5, b=1.9),
    s=heightDuct_co)
    annotation (Placement(transformation(extent={{0,-12},{20,8}})));
  Components.Heater reheater(
    final use_T_set=true,
    cp_air=cp_air,
    cp_steam=cp_steam,
    c_steel=c_steel,
    c_wat=c_water,
    m_steel=m_steel_reh,
    length=length_reh,
    width=width_reh,
    nFins=nFins_reh,
    delta=delta_reh,
    lambda=lambda_reh,
    Q_flow_nominal=Q_flow_nominal_reh,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple (a=0.3, b=1.7),
    s=heightDuct_reh)
    annotation (Placement(transformation(extent={{64,-12},{84,8}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInOda
    "mass flow rate of incoming outdoor air" annotation (Placement(
        transformation(extent={{-220,60},{-180,100}}), iconTransformation(
          extent={{-200,70},{-180,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInOda
    "temperature of incoming otudoor air" annotation (Placement(transformation(
          extent={{-220,30},{-180,70}}), iconTransformation(extent={{-200,40},{
            -180,60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInOda
    "absolute humidity of incoming outdoor air" annotation (Placement(
        transformation(extent={{-220,0},{-180,40}}), iconTransformation(extent=
            {{-200,10},{-180,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutSup
    "mass flow rate of outgoing supply air" annotation (Placement(
        transformation(extent={{180,-30},{200,-10}}), iconTransformation(extent=
           {{180,-30},{200,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutSup
    "temperature of outgoing supply air" annotation (Placement(transformation(
          extent={{180,-60},{200,-40}}), iconTransformation(extent={{180,-60},{
            200,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutSup
    "absolute humidity of outgoing supply air" annotation (Placement(
        transformation(extent={{180,-90},{200,-70}}), iconTransformation(extent=
           {{180,-90},{200,-70}})));
  Modelica.Blocks.Interfaces.RealInput m_flow_airInEta
    "mass flow rate of incoming exhaust air" annotation (Placement(
        transformation(extent={{220,60},{180,100}}), iconTransformation(extent=
            {{200,70},{180,90}})));
  Modelica.Blocks.Interfaces.RealInput T_airInEta
    "temperature of incoming exhaust air" annotation (Placement(transformation(
          extent={{220,30},{180,70}}), iconTransformation(extent={{200,40},{180,
            60}})));
  Modelica.Blocks.Interfaces.RealInput X_airInEta
    "absolute humidity of incoming exhaust air" annotation (Placement(
        transformation(extent={{220,0},{180,40}}), iconTransformation(extent={{
            200,10},{180,30}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_airOutEha
    "mass flow rate of outgoing exhaust air" annotation (Placement(
        transformation(extent={{-180,-30},{-200,-10}}), iconTransformation(
          extent={{-180,-30},{-200,-10}})));
  Modelica.Blocks.Interfaces.RealOutput T_airOutEha
    "temperature of outgoing exhaust air" annotation (Placement(transformation(
          extent={{-180,-60},{-200,-40}}), iconTransformation(extent={{-180,-60},
            {-200,-40}})));
  Modelica.Blocks.Interfaces.RealOutput X_airOutEha
    "absolute humidity of outgoing exhaust air" annotation (Placement(
        transformation(extent={{-180,-90},{-200,-70}}), iconTransformation(
          extent={{-180,-90},{-200,-70}})));
  Components.SprayHumidifier sprayHumidifier(use_X_set=true, redeclare model
            PartialPressureDrop =
                            Components.PressureDrop.PressureDropSimple)
    annotation (Placement(transformation(extent={{32,-12},{52,8}})));
  Components.FlowControlled_dp supVentilator_dp(m_flow_nominal=100*1.2,
      redeclare Fluid.Movers.Data.Generic per(hydraulicEfficiency(eta={1}),
        motorEfficiency(eta={0.7})))
    "supply air ventilator"
    annotation (Placement(transformation(extent={{104,-12},{124,8}})));
  Components.FlowControlled_dp etaVentilator_dp(m_flow_nominal=100*1.2,
      redeclare Fluid.Movers.Data.Generic per(hydraulicEfficiency(eta={1}),
        motorEfficiency(eta={0.7})))
    "extracted air ventilator"
    annotation (Placement(transformation(extent={{122,26},{102,46}})));
  Modelica.Blocks.Interfaces.RealInput dp_supVent "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={168,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={158,-100})));
  Modelica.Blocks.Interfaces.RealInput dp_etaVent "Prescribed pressure rise"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={130,100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={120,110})));
  Modelica.Blocks.Interfaces.RealOutput Pel_eta
    "Electrical power consumed by the extract air ventilator" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,110})));
  Modelica.Blocks.Interfaces.RealOutput Pel_sup
    "Electrical power consumed by the supply air ventilator"
    annotation (Placement(transformation(extent={{180,-8},{200,12}})));
  Modelica.Blocks.Math.MultiSum sumDpSup(nu=5)
    annotation (Placement(transformation(extent={{42,-60},{54,-48}})));
  Modelica.Blocks.Sources.Constant TWatIn(k=273.15)
    annotation (Placement(transformation(extent={{26,-34},{36,-24}})));
  Modelica.Blocks.Interfaces.RealInput phiSet[2] annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={60,-110})));
  Controls.Continuous.LimPID conHumMin(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=100,
    Ti=60,
    yMax=0.012,
    yMin=0.005)
           annotation (Placement(transformation(extent={{14,44},{34,64}})));
  Utilities.Psychrometrics.Phi_pTX phiMin
    annotation (Placement(transformation(extent={{34,70},{14,90}})));
  Modelica.Blocks.Interfaces.RealInput TSupSet annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-110})));
  Modelica.Blocks.Sources.Constant pAtm(k=101325)
    annotation (Placement(transformation(extent={{72,64},{62,74}})));
  Controls.Continuous.LimPID conHumMax(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=100,
    Ti=60,
    yMax=0.01,
    yMin=0.005)
    annotation (Placement(transformation(extent={{-72,54},{-52,74}})));
  Utilities.Psychrometrics.Phi_pTX phiMax
    annotation (Placement(transformation(extent={{-52,80},{-72,100}})));
  Modelica.Blocks.Sources.Constant TCooSur(k=293.15)
    annotation (Placement(transformation(extent={{18,-36},{8,-26}})));
  Modelica.Blocks.Sources.RealExpression setValTemCoo(y=TsetCoo)
    annotation (Placement(transformation(extent={{-22,8},{-10,22}})));
  Utilities.Psychrometrics.TDewPoi_pW dewPoi
    annotation (Placement(transformation(extent={{-16,72},{-6,82}})));
  Utilities.Psychrometrics.pW_X pWat
    annotation (Placement(transformation(extent={{-34,72},{-24,82}})));
  Modelica.Blocks.Sources.Constant TsetPreHe(k=273.15)
    annotation (Placement(transformation(extent={{-74,-34},{-64,-24}})));
  Modelica.Blocks.Sources.Constant TsetHRS(k=293.15)
    annotation (Placement(transformation(extent={{-88,26},{-78,36}})));
equation

  TsetCoo = smooth(1, if conHumMax.y < cooler.X_airIn then dewPoi.T else TSupSet);

  connect(plateHeatExchangerFixedEfficiency.m_flow_airInOda, m_flow_airInOda)
    annotation (Line(points={{-73,18},{-92,18},{-92,80},{-200,80}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.T_airInOda, T_airInOda) annotation (
     Line(points={{-73,15},{-96,15},{-96,50},{-200,50}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.X_airInOda, X_airInOda) annotation (
     Line(points={{-73,12},{-100,12},{-100,20},{-200,20}},
                                                         color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.m_flow_airOutOda, preheater.m_flow_airIn)
    annotation (Line(points={{-51,8},{-42,8},{-42,6},{-35,6}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.T_airOutOda, preheater.T_airIn)
    annotation (Line(points={{-51,5},{-43.5,5},{-43.5,3},{-35,3}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.X_airOutOda, preheater.X_airIn)
    annotation (Line(points={{-51,2},{-42,2},{-42,0},{-35,0}}, color={0,0,127}));
  connect(preheater.m_flow_airOut, cooler.m_flow_airIn)
    annotation (Line(points={{-13,6},{-1,6}}, color={0,0,127}));
  connect(preheater.T_airOut, cooler.T_airIn) annotation (Line(points={{-13,3},
          {-6.5,3},{-6.5,3},{-1,3}}, color={0,0,127}));
  connect(preheater.X_airOut, cooler.X_airIn)
    annotation (Line(points={{-13,0},{-1,0}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.m_flow_airOutEta, m_flow_airOutEha)
    annotation (Line(points={{-73,8},{-100,8},{-100,-20},{-190,-20}},
                                                                    color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.X_airOutEta, X_airOutEha)
    annotation (Line(points={{-73,2},{-92,2},{-92,-80},{-190,-80}}, color={0,0,
          127}));

  connect(sprayHumidifier.m_flow_airOut, reheater.m_flow_airIn)
    annotation (Line(points={{53,6},{63,6}}, color={0,0,127}));
  connect(sprayHumidifier.T_airOut, reheater.T_airIn) annotation (Line(points={
          {53,3},{57.5,3},{57.5,3},{63,3}}, color={0,0,127}));
  connect(sprayHumidifier.X_airOut, reheater.X_airIn)
    annotation (Line(points={{53,0},{63,0}}, color={0,0,127}));
  connect(sprayHumidifier.m_flow_airIn, cooler.m_flow_airOut)
    annotation (Line(points={{31,6},{21,6}}, color={0,0,127}));
  connect(sprayHumidifier.T_airIn, cooler.T_airOut) annotation (Line(points={{
          31,3},{26.5,3},{26.5,3},{21,3}}, color={0,0,127}));
  connect(sprayHumidifier.X_airIn, cooler.X_airOut)
    annotation (Line(points={{31,0},{21,0}}, color={0,0,127}));
  connect(reheater.m_flow_airOut, supVentilator_dp.m_flow_in) annotation (Line(
        points={{85,6},{94,6},{94,-2},{102.6,-2}}, color={0,0,127}));
  connect(reheater.T_airOut, supVentilator_dp.T_airIn) annotation (Line(points=
          {{85,3},{92,3},{92,-6},{102.6,-6}}, color={0,0,127}));
  connect(reheater.X_airOut, supVentilator_dp.X_airIn) annotation (Line(points=
          {{85,0},{90,0},{90,-10},{102.6,-10}}, color={0,0,127}));
  connect(supVentilator_dp.m_flow_out, m_flow_airOutSup) annotation (Line(
        points={{125,-2},{152,-2},{152,-20},{190,-20}}, color={0,0,127}));
  connect(supVentilator_dp.T_airOut, T_airOutSup) annotation (Line(points={{125,
          -6},{148,-6},{148,-50},{190,-50}}, color={0,0,127}));
  connect(supVentilator_dp.X_airOut, X_airOutSup) annotation (Line(points={{125,
          -10},{144,-10},{144,-80},{190,-80}}, color={0,0,127}));
  connect(m_flow_airInEta, etaVentilator_dp.m_flow_in) annotation (Line(points=
          {{200,80},{140,80},{140,36},{123.4,36}}, color={0,0,127}));
  connect(T_airInEta, etaVentilator_dp.T_airIn) annotation (Line(points={{200,
          50},{146,50},{146,32},{123.4,32}}, color={0,0,127}));
  connect(X_airInEta, etaVentilator_dp.X_airIn) annotation (Line(points={{200,
          20},{146,20},{146,28},{123.4,28}}, color={0,0,127}));
  connect(etaVentilator_dp.m_flow_out, plateHeatExchangerFixedEfficiency.m_flow_airInEta)
    annotation (Line(points={{101,36},{-44,36},{-44,18},{-51,18}}, color={0,0,
          127}));
  connect(etaVentilator_dp.T_airOut, plateHeatExchangerFixedEfficiency.T_airInEta)
    annotation (Line(points={{101,32},{-42,32},{-42,14},{-51,14},{-51,15}},
        color={0,0,127}));
  connect(etaVentilator_dp.X_airOut, plateHeatExchangerFixedEfficiency.X_airInEta)
    annotation (Line(points={{101,28},{-40,28},{-40,12},{-51,12}}, color={0,0,
          127}));
  connect(plateHeatExchangerFixedEfficiency.T_airOutEta, T_airOutEha)
    annotation (Line(points={{-73,5},{-96,5},{-96,-50},{-190,-50}}, color={0,0,
          127}));
  connect(supVentilator_dp.dp_in, dp_supVent) annotation (Line(points={{102.6,2},
          {98,2},{98,-84},{168,-84},{168,-110}}, color={0,0,127}));
  connect(etaVentilator_dp.dp_in, dp_etaVent)
    annotation (Line(points={{123.4,40},{130,40},{130,100}}, color={0,0,127}));
  connect(etaVentilator_dp.P, Pel_eta)
    annotation (Line(points={{101,40},{80,40},{80,110}}, color={0,0,127}));
  connect(supVentilator_dp.P, Pel_sup)
    annotation (Line(points={{125,2},{190,2}}, color={0,0,127}));
  connect(preheater.dp, sumDpSup.u[1]) annotation (Line(points={{-13,-4},{-10,
          -4},{-10,-42},{-24,-42},{-24,-50.64},{42,-50.64}}, color={0,0,127}));
  connect(cooler.dp, sumDpSup.u[2]) annotation (Line(points={{21,-4},{24,-4},
          {24,-42},{-24,-42},{-24,-52.32},{42,-52.32}}, color={0,0,127}));
  connect(sprayHumidifier.dp, sumDpSup.u[3]) annotation (Line(points={{53,-4},
          {58,-4},{58,-42},{-24,-42},{-24,-54},{42,-54}}, color={0,0,127}));
  connect(reheater.dp, sumDpSup.u[4]) annotation (Line(points={{85,-4},{86,-4},
          {86,-42},{-24,-42},{-24,-55.68},{42,-55.68}}, color={0,0,127}));
  connect(plateHeatExchangerFixedEfficiency.dp, sumDpSup.u[5]) annotation (
      Line(points={{-51,-0.2},{-51,-57.36},{42,-57.36}}, color={0,0,127}));
  connect(TWatIn.y, sprayHumidifier.T_watIn) annotation (Line(points={{36.5,
          -29},{39,-29},{39,-13}}, color={0,0,127}));
  connect(phiSet[1], conHumMin.u_s) annotation (Line(points={{60,-120},{60,-80},
          {-40,-80},{-40,54},{12,54}}, color={0,0,127}));
  connect(sprayHumidifier.X_airOut, phiMin.X_w) annotation (Line(points={{53,
          0},{58,0},{58,80},{35,80}}, color={0,0,127}));
  connect(TSupSet, phiMin.T) annotation (Line(points={{0,-110},{0,-80},{-40,
          -80},{-40,100},{48,100},{48,88},{35,88}}, color={0,0,127}));
  connect(pAtm.y, phiMin.p) annotation (Line(points={{61.5,69},{48.75,69},{48.75,
          72},{35,72}}, color={0,0,127}));
  connect(phiMin.phi, conHumMin.u_m) annotation (Line(points={{13,80},{0,80},
          {0,38},{24,38},{24,42}}, color={0,0,127}));
  connect(conHumMin.y, sprayHumidifier.X_set)
    annotation (Line(points={{35,54},{42,54},{42,9}}, color={0,0,127}));
  connect(pAtm.y, phiMax.p) annotation (Line(points={{61.5,69},{58,69},{58,100},
          {-40,100},{-40,82},{-51,82}}, color={0,0,127}));
  connect(cooler.X_airOut, phiMax.X_w) annotation (Line(points={{21,0},{24,0},
          {24,22},{-40,22},{-40,90},{-51,90}}, color={0,0,127}));
  connect(TSupSet, phiMax.T) annotation (Line(points={{0,-110},{0,-80},{-40,
          -80},{-40,98},{-51,98}}, color={0,0,127}));
  connect(phiMax.phi, conHumMax.u_m) annotation (Line(points={{-73,90},{-84,
          90},{-84,42},{-62,42},{-62,52}}, color={0,0,127}));
  connect(phiSet[2], conHumMax.u_s) annotation (Line(points={{60,-100},{60,-80},
          {-40,-80},{-40,42},{-84,42},{-84,64},{-74,64}}, color={0,0,127}));
  connect(conHumMax.y, cooler.X_set) annotation (Line(points={{-51,64},{0,64},
          {0,16},{16,16},{16,8}}, color={0,0,127}));
  connect(TCooSur.y, cooler.T_coolingSurf) annotation (Line(points={{7.5,-31},
          {5.1,-31},{5.1,-11.9}}, color={0,0,127}));
  connect(setValTemCoo.y, cooler.T_set) annotation (Line(points={{-9.4,15},{
          -2,15},{-2,12},{10,12},{10,8}}, color={0,0,127}));
  connect(dewPoi.p_w, pWat.p_w)
    annotation (Line(points={{-16.5,77},{-23.5,77}}, color={0,0,127}));
  connect(pAtm.y, pWat.p_in) annotation (Line(points={{61.5,69},{58,69},{58,
          100},{-40,100},{-40,80},{-35,80}}, color={0,0,127}));
  connect(conHumMax.y, pWat.X_w) annotation (Line(points={{-51,64},{-40,64},
          {-40,78},{-36,78},{-36,77},{-34.5,77}}, color={0,0,127}));
  connect(TSupSet, reheater.T_set) annotation (Line(points={{0,-110},{0,-80},
          {98,-80},{98,16},{74,16},{74,8}}, color={0,0,127}));
  connect(TsetPreHe.y, preheater.T_set) annotation (Line(points={{-63.5,-29},
          {-52,-29},{-52,-30},{-40,-30},{-40,14},{-24,14},{-24,8}}, color={0,
          0,127}));
  connect(TsetHRS.y, plateHeatExchangerFixedEfficiency.T_set) annotation (
      Line(points={{-77.5,31},{-62,31},{-62,21}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -100},{180,100}}), graphics={
        Bitmap(
          extent={{-152,-84},{150,82}},
          imageSource=
              "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"
               +
              "7cSCNcthdd/ivibN9ZvdknajhBYtkeZ+TRFX8zvbtnzN6e8oYbGIaqcbrFnO8yFGcV87GloajhJaNEUWdDWvs23M16S/48uXq/A1W1Xh7ckFaxbR0XxKVd7X5PrUGlpKoIQWDZHG1XKWnA/wVcvZNuZr5r0wu7EqX3PeiTwl+FAj0dckU6/V94aWpJTQwhVS2NXsqjHctJySr5kXnt2P1NpIf2fnuV6TrzmP2U6LJ5imaARf2xtaklJCC0dIcVdrO9vWfM3cOsffNfmabJ1gsGYRe/waY4xDY7zDontm9TweCCCX3eaPJKWEFrVTB91ZYVdrOdvp+Nq7d9JHVk/6TCD9FxbJWZGvOe9EnhyiptiEOoc52FnSEx4IIELNB12SjhJa1CSM4mpNZzsdX5MtC/dDHPo7Slgse1WcdyJPj8+VWeqZOodp27nP0JeQQtJRQoujBONqo8yX9Lpeze35miS0/R0lLBaqcsLBmsVMszaGr0nKS0hOCS0OEkZzNdfZNuhr+/6OEhYLVZE/JxusWcw3w9Q5zMGusfHabve9ydMhey/ScbU/7+ypv56bT83ZTsfXIuM1gf0dJSwW0WY7UOcw9RPFZOBmJ8bQHbIpxKz5cxzVMA0c8C3ykcHR2U7H1yLvQwq/mDzqa4uCOoepnygmAzc7EUObW/mU0MIKcV2tvK8dnW1EXzt3bsCrDmP6mgh/q762LKhzmPTzTxBDd8iGSONq9UkVy/va7icRZv6O6GuDGLVeH+NuMysLIuv8E0MLlNDCiGy62iiY4AaTELDgHiQ1M07DuPWqqqfqa+si7/yT06PT1yZxtb2zbdPXLks29bVVkXf+4YqQElpUlZkPeAJXo7Nt09fQ31GCsgoyz78uQ5vfpnE162wb9TXT31GCsgoyzz9zE5ASWshP1W2mGx0s4MSCe5CEzDQNY9crWnFlGZhTNRNKaMGfJ4QF98DEE8KCe2DiHChBWQU0Wg6U0II/TwgL7oGJJ4QF98DEOVDCKUINlZODBlYURdkY7ASVk4MGVhRF2RjsBM+fyAJSW8W+m3mc0VSggRVFUTYGukDDySzXtkFuXzEWvPmcuzquKYqyZdAFgksasq0UN1gTsE8DK4qibAx0gRdf4M99dovKmmgGawKsSQMriqJsDHSB+4+mrpuVYJRVYYO1x9yz4BANrCiKsjHQBUpXePEptn61HaOyEmywduURdwlMSQMriqJsDHSB6AwxWX71QEO2FeEL1gQcpYEVRVE2BrpA2xt+Rsj26aXdUxaPP1gTzGEd1xRF2SjoAtkd7r7F3jMN2VbBY1irFawJ+IEGVhRF2RjoAtkd7nbvzWKC1aeJZvhVBvAoFKwxjNNxTVGUjYIukB2i4QsOvOKeslTCwZp95qbjmqIoWwVdIHtE8Ps9c0RDtkXTG6wJNLCiKMrGQBfIPpGYxZGq6iP3lOXRH6wJNLCiKMrGQBfITnHP85vm4KdvuKssCwZrnrUX91OPmH91XFMUZaOgC2S3eMQGBJe5pywJa5s73Ktz+JoNf2lgRVGUjYEukP1iDRsTXLjBXWUp9AVreOZmNnRcUxRlo6ALtB2jSzgsUOYjIlgTsEkDK4qibAx0gegMm/D63xMZKDPxPCZYE8y2jmuKomwUdIG2N2wRmH1QmQn7oqovWGu8IIk9GlhRFGVjoAtkd9jixgXzq+8zKWVy7FuqvmCt9TWb2dVxTVGUjYIukN2hh8v4/TfuKfMRHawJOEADK4qibAx0gewOfXzzySRwVmNWpscGa773U31Tj5gjOq4pirJR0AWyO/TzEUlec0+ZAxus+b4nbAdrAo7RwIqiKBsDXSC7wwAfELLd+527ytT0BmvNZ27moI5riqJsFHSB7A6DvEKqL9xTpqUvWGs/c8NhGlhRFGVjoAtkdxjmHUK2h++5q0xHcrAmmOM6rimKslHQBbI77ODsGRJ+y11lKtKDNQG/0MCKoigbA10gu8NOXiJke/qZu8oU2MXwfMFaeOoRwfyk45qiKBsFXSC7w27OHiDtXe4q42MXL/cFa+Gv2Qz4kQZWFEXZGOgC2R328SsSP73IXWVcOoK14NQjFvOrjmuKomwUdIHsDns5u47kT7irjIkN1nzLlncHawJ+p4EVRVE2BrpAdocR3Ef6FxqyjY0N1nxrlodfkDxgEui4pijKRkEXyO4whluXkOMNd5Vx6AvWupcyRxIaWFEUZWOgC2R3GMc1ZHl7lbtKeQYFa4JJo+OaoigbBV0gu8NIbp1HpnPcVUozLFgTkIoGVhRFmY93c4AukN1hNOeQ67yGbGMwNFgTTLKKBlYURZmNFY1ru6t/Id817irlGBysCUhIAyuKoszGmsa13e4NMl66xV2lDO8fmmb1BWvhr9namJQ6rimKMjvrGtd2V98i63fcVUrwLdr0D+7VCU894gFpaWBFUZTZWNm4tts9Qd7rZ9xVhsJg7QN3a6QEa4JJrOOaoiizs7pxbXfxBXLf564yDBusveJenfAzNz9ITgMriqLMxvrGtd3uLrI/0JBtOH3Bmu+ZWwiTXsc1RVFmZ43j2u7zUwj4lbtKLuWCNQE5aGBFUZTZWOW4ttv9ExKeacg2hJLBmmCy6LimKMrsrHRc2/fJL7mrpFM0WBOQiQZWFEWZjbWOa7vd1xDi65aVCAoHa4LJpeOaoiizs95xbd//enpmpRf77k25YE1APhpYURRlNlY8rg3ogreOffHGdxeXYVxysCaYjDquKYoyO6se1zgnb1YvvGVssOZ76yY89Ug/yEoDK4qizMa6x7X9tLxfcU+JoDdYy7yza/LquKYoyuysfVzbPbpiZEVP9qT0BWvZb+IgNw2sKIoyG6sf13a7x5AWOTnv1hkrWBNMdh3XFEWZnRMY13Y/IGS7cpu7SpjRgjUBAmhgRVGU2TiFcW23uwOBd7inBBgxWBOMBB3XFEWZnf+YBXSB7A6LcPuCkXjlEXcVH2MGawJk0MCKoigbA10gu8NCXIbMx9xTWowbrAlGiI5riqJsFHSB7A5LcQMh283n3FVc7HqsvsV9wlOPpAExNLCiKMrGQBfI7rAcHyH2NfeUGlyM1bOyTziMSwUl0MCKoigbA10gu8OCfPPJyL35O3eVPX3BWpEFfyCJBlYURdkY6ALZHRblFSR/4Z4CpgjWBBRCAyuKomwMdIHsDsvyASHbPQ3ZjkwSrAkQRgMriqJsDHSB7A5L8wzCv+Xe5pkoWBNQDg2sKIqyMdAFsjsszkuEbA/fc3fbTBWsCZBHAyuKomwMdIHsDstz9gvk3+XuhpkuWBNQFA2sKIqyMdAFsjscg19RwNPP3N0qNlj7fopgTYBIGlhRFGVjoAtkdzgKZw9QxBPubpKrb9EG97lbY4RgTUBpNLCiKMrGQBfI7nAk7qOMFxe5uz3eoAGue0Ky8DO3QUAqDawoirIx0AWyOxyLs+so5V/c3RjhYC38zG0gEEsDK4qibAx0gewOx+Mainl7lbtbYvJgTYBgGlhRFGVjoAtkdzgity6hoDfc3QwzBGsCJNPAiqIoGwNdILvDUTmHks5vK2SbI1gTIJsGVhRF2RjoAtkdjsvV8yjrHHc3wDzBmgDhNLCiKMrGQBfI7nBs/kRhl25x99SZKVgTIJ4GVhRF2RjoAtkdjg4DmGvcPWnCuo4crAmQTwMriqJsDHSB7A4nIBzDnBhWUV9sGp56pBgogQZWFEXZGOgC2R1OAYMVzzOnU4LPEj3BWviZW0FQBA2sKIqyMdAFsjuchgnilbmx7376grVp4lUUQgMriqJsDHSB7A4nws6JOObzpXmZOVgTUAoNrCiKsjHQBbI7nAw7h/147wPOytzBmoByaGBFUZSNgS6Q3eF0vH9oii09jf0SmD9YE1AQDawoirIx0AWyO5ySb1Fw2WXHFsACgjUBRdHAiqIoGwNdILvDSXl/z5T86QN3T4JFBGsCyqKBFUVRNga6QHaHE/MFZb/i3gkQngJz4s/2UBoNrCiKsjHQBbI7nJrfbcj2DXdXTnj+y/DUIyOB4mhgRVGUjYEukN3h9LxG8R+5t2rsEnPhYG3KaTFRIA2sKIqyMdAFsjucgec3TfkXbnB3tXB9OV+wFnzmNh4okQZWFEXZGOgC2R3OwmPU4DL3Vko4WAu/IDkiKJMGVhRF2RjoAtkdzsOjK6YKF25zd4UsK1gTUCgNrCiKsjHQBbI7nIs7qMQd7q2OhQVrAoqlgRVFUTYGukB2h7NxGyHblVWGbIsL1gSUSwMriqJsDHSB7A5n5DLq8Zh7K8IGa28XFKwJKJkGVhRF2RjoAtkdzsmNC6YiVx5xdyUwWHvD3RrzBWsCiqaBFUVRNga6QHaH82JDttfcWwV9wZrvmdsUoHAaWFEUZWOgC2R3ODPffDJ1ufmcu4unN1jzPHObBpROAyuKomwMdIHsDmfnI2rzhXsL5z4q6wvWwi9ITgTKp4EVRVE2BrpAdofz8wEh273fubtgzq6j5TzBWvgFyclABWhgRVGUjYEukN3hEniFCn3NvcWy4GBNQBVoYEVRlI2BLpDd4SJ4iZDt4XvuLpJFB2sC6kADK4qibAx0gewOl8HZM9Tpn9xdIMsO1gTUggZWFEXZGOgC2R0uhV9RqaefubswGKw94W6NZQRrAqpBAyuKomwMdIHsDhfD2QNU6y53F4UN1l5c5G6N8NdsU4OK0MCKoigbA10gu8MF8TPq5Rs95qU3WPM8c5se1IQGVhRF2RjoAtkdLonwADInawjWBNSFBlYURdkY6ALZHS6L8NsZc3H2Paq08GBNQGVoYEVRlI2BLpDd4cJY2GDB11l8wdrShmBUhwZWFEXZGOgC2R0uDntz769FjBd8l8UTrIW/ZpsL1IcGVhRF2RjoAtkdLo+5JxA+sp5gTUCNaGBFUZSNgS6Q3eES4YIvc6zOWYPB2k/crbG8YE1AlWhgRVGUjYEukN3hIrn6FlWcZ4FOEv5QfIHBmoBK0cCKoigbA10gu8OF8gZ1vDRbyBb+SnyZHyPouKYoyqZBF8jucKlcfYFa3ufuxPQFa8v7eFzHNUVRtgy6QHaHy+UJqnn9jLsTsr5gTUDFaGBFUZSNgS6Q3eGCuWhDtl+5OxkrDNYEVI0GVhRF2RjoAtkdLpq7qOmDSUM2LpnjC9aCU48sAdSNBlYURdkY6ALZHS6bz09R15fcnQC7xKkvWAt/zbYIUDsaWFEUZWOgC2R3uHS+RWWfTRSydQRrwalHFgKqRwMriqJsDHSB7A4Xz/uHpraf3nF3VGyw9vA9d2ssPFgTUEEaWFEUZWOgC2R3uAK+oL6vuDceDNa+5W6N8NQjywE1pIEVRVE2BrpAdodr4Pd7psKfPnB3JPqCNd8ztwWBOtLAiqIoGwNdILvDdfBvVPkj98agN1jzPHNbFKgkDawoirIx0AWyO1wJz2+aOn/6hrvFWXmwJqCaNLCiKMrGQBfI7nA1vEatL3OvLKsP1gTUkwZWFEXZGOgC2R2uh0dXTLUv3OBuQd6tPlgTUFMaWFEUZWOgC2R3uCYeo+J3uFeMVxDrC9aCX7MtEFSVBlYURdkY6ALZHa6K2wjZrtzmbhE+BIO18NQjS8TUVcc1RVE2CrpAdocr4w7q/ph7BbDB2hfu1VhVsCagtjSwoijKxkAXyO5wbdy4YCp/5RF3B2KDtXu/c7dG+AXJhWKqq+OaoigbBV0gu8P1cRnVLxKy9QVrnmduiwUVpoEVRVE2BrpAdocr5AZCqZvPuZvNCQVrgqmxjmuKomwUdIHsDlfJR2jwmnuZnFKwJqDONLCiKMrGQBfI7nCdfBMMtWI5rWBNMJXWcU1RlI2CLpDd4VoJRltxnFiwJqDaNLCiKMrGQBfI7nC1hL876ycc7oWnHlk6pt46rimKslHQBbI7XC/5kZV9PPdv7tWxYdz6gjUBNaeBFUVRNga6QHaHayZvQhAbrPlepxwSAs6OqbqOa4qibBR0gewOV03ObPvhdykHPrKbGVSeBlYURdkY6ALZHa4cTrh/kbu99AVrQ16xnBdTex3XFEXZKOgC2R2unbPvoc0T7vZwqsGagPrTwIqiKBsDXSC7w/VzH+q8iAjZTjdYE4wCOq4pirJR0AWyOzwBzq5DoTfcDXLCwZoAFWhgRVGUjYEukN3hSXANGr29yl0vJx2sCUYHHdcURdko6ALZHZ4Gty5Bp3Pc9XDawZoALWhgRVGUjYEukN3hqXAOSp0PhGzhVdvCU4+sDKOGjmuKomwUdIHsDk+Gq+eh1jXuOoSXbAtPPbI2oAgNrCiKsjHQBbI7PCHeQK9IkCP8zG19QCsaWFEUZWOgC2R3eEpchWJxmPThZ24rBLrQwIqiKBsDXSC7w5MiTjGmOqVgTYBWNLCiKMrGQBfI7vCkiFPMpjqpYE2AOjSwoijKxkAXyO7wpIhTDKlOK1gToBUNrCiKsjHQBbI7PCniFEMqw+kEawI0ooEVRVE2BrpAdocnRZxiSHVawZoAnWhgRVGUjYEukN3hSRGnGFKdVrAmQCkaWFEUZWOgC2R3eFLEKYZUnqlH1g20ooEVRVE2BrpAdocnRZxicanWBrSigRVFUTYGukB2hydFnGJxqdYGtKKBFUVRNga6QHaHJ0WcYnGp1ga0ooEVRVE2BrpAdocnRZxicanWBrSigRVFUTYGukB2hydFnGJxqdYGtKKBFUVRNga6QHaHJ0WcYnGp1ga0ooEVRVE2BrpAdocnRZxicanWBrSigRVFUTYGukB2hyfE7StxisWlWhvQigZWFEXZGOgC2R2eDo+hlo5riqIo2wNdILvDU+GRDdYEHggTl2ptQCsaWFEUZWOgC2R3eCLsgzWBR8LEpVob0IoGVhRF2RjoAtkdngQ2WLtwI06xuFRrA1rRwIqiKBsDXSC7w1PABmuXY0esuFRrA1rRwIqiKBsDXSC7w/WzD9ZkM06xuFRrA1rRwIqiKBsDXSC7w9VzCNYEbGKri7hUawNa0cCKoigbA10gu8OVY4O1T9/YvTjF4lKtDWhFAyuKomwMdIHsDteNDdY+cs/27XEwx+kArWhgRVGUjYEukN3hmnnuBGsCFIvjLrOcDNCKBlYURdkY6ALZHa6Y19DjEKwJOBDJ08/MdCJAKRpYURRlY6ALZHe4Wp7fNFrUgrUDtRck/Zw9MAmqJ9w9DaASDawoirIx0AWyO1wr7WBtT/0FyRD3kebFRe6eAtCIBlYURdkY6ALZHa6TAcGa5ey6SVb9i7snAPShgRVFUTYGukB2h6tkWLBm+Q4p317l7uqBOjSwoijKxkAXyO5whTBY+xt3a0QGa5Zbl0zi6g131w6UoYEVRVE2BrpAdofrwwZrr7hXJz5Ys1xD+vOnEbJBFxpYURRlY6ALZHe4NhisfeBuDXfqkSiunjdZqnPcXTXQhAZWFEXZGOgC2R2ujL5gzffMrYtzyHXpFndXDBShgRVFUTYGukB2h6vi93um5r5grTX1SCxX35qM1TXurheoQQMriqJsDHSB7A7XxBdU3BeshV+Q7OcN8l4/4+5agRY0sKIoysZAF8jucD10BGvBr9miuPjCZK/uc3elQAcaWFEUZWOgC2R3uBrGCdYsTyDh+1WHbFCBBlYURdkY6ALZHa6E0YI1y8WnRkj1K3fXCBSggRVFUTYGukB2h+vABmvPPAHV8GDNchdyHqw3ZEP9aWBFUZSNgS6Q3eEaYLD2krs1wlOPJPMZIZuvkHVgaq/jmqIoGwVdILvDFdAXrPmeueXwLaT5ylkDqDwNrCiKsjHQBbI7XDy9wZrnmVsm7x8WFjglpuo6rimKslHQBbI7XDpTBWuW8EuXiwc1p4EVRVE2BrpAdofLhhGUJ1gLvyA5CIod9nblLJh667imKMpGQRfI7nDRhJ94jRdYlXrBcmpQbRpYURRlY6ALZHe4YCYP1ix8bBe3iNtyMJXWcU1RlI2CLpDd4XKZI1iz/Ab58eu4LQLUmQZWFEXZGOgC2R0uFRus+WYAGTVYsyStu70QTI11XFMUZaOgC2R3uFBssOab/iP8gmRJ7Gpud7i3BlBhGlhRFGVjoAtkd7hIeoO18WcFuY2Q7cpt7i4fU10d1xRF2SjoAtkdLpG5gzXLHZT1mHuLB7WlgRVFUTYGukB2h8tjAcGa5cYFU9yVR9xdOKauOq4pirJR0AWyO1wc4Yn1pwzWLJdR4mvuLRtUlQZWFEXZGOgC2R0uDDurvi9YC3/NNiLffDKF3nzO3SVjKqrjmqIoGwVdILvDZREO1uaabP8jyv3CvQWDetLAiqIoGwNdILvDJcFg7Wfu1pglWLP8DSHbvd+5u1hMLXVcUxRlo6ALZHe4IGywdn1BwZrlFUr/mntLBZWkgRVFUTYGukB2h4uBwdp97tYIvyA5ER8Qsj18z91lgjaigRVFUTYGukB2h0uhL1jzPXObjLNnqMO33F0kqCENrCiKsjHQBbI7XAYLDtYsLxGyPf3M3QWCZqKBFUVRNga6QHaHi2DRwZrl7AFqcpe7ywPVo4EVRVE2BrpAdocLYPHBmuVX1OXFRe4uDdSOBlYURdkY6ALZHc7PE1THF6yFv2abhbPrqM8T7i4M1I0GVhRF2RjoAtkdzs3FF6iNJ1gLTz0yG/dRo7dXubsoUDUaWFEUZWOgC2R3ODM2WLt0i7s1FhasWW5dQq3ecHdJoGI0cD6QMjksPBpmO22oaxEo8qShqkWgyIlh4UomaER2h7PCYO0ad2uEpx6ZmWuo11/LC9lQLxo4H0iZHBYeDbOdNtS1CBR50lDVIlDkxLBwJRM0IrvDOekL1nzP3GaHIds57i4G1IoGzgdSqrfTNTzKY+HRIJPwcD3Lvsbyd3xQYqCuRYBAlnCCQD2qWgQIXLwbKC5oRDbofPQGa55nbovgHGp33jMczwkqRQPnAylTejSKY+HRIBO48oFyTgN7pWehrkWAQJZxgkA9qloECFy8GyguaEQ26GysMlizXD2PGnpG5BlBlWjgfCBFeDjVqI3SWHg0yPToL/w5oZGNo9pXZ/hDXYsAgSzlBIF6VLUIECgs2w0UFzQiG3QmVhusWd6gjr5BeTZQIxo4H0gxTOXRKIyFR4NMu937kxrZDqPaWP00yzlBoB5VLQIEGhbtBooLGpENOg8rDtYsV9+ingsafVEfGjgfSPnK/DORR6NAFh4NMpncpzOy1UY1HddSgXpUtQgQuHg3UFzQiGzQOeCgsNZgzWI7ouUMwKgODZwPpOzumH9vTjKzCgpk4dEgk81/GiPbT1Cies1d7FDXIkAghZ8gUI+qFgECF+8GigsakQ06A+GbeEsbKzrhrdSlfDeOytDA+UDKbkKPRoEsPBpkooD9yPbpO+6vj9dQ4DCq6biWCtSjqkWAwMW7geKCRmSDTg6DNc978uGpRxbKoj4dR11o4HwgRaShq70ywYpzKJCFR4NMFCC8t3NSr3Rka41qOq6lAvWoahEgUAQv2w0UFzQiG3RqbLB23vNdc/iZ22LhbdOX3J0V1IQGzgdSjDh49IXxPRoFsvBokIkCwNXVjmyeUU3HtVSgHlUtAgQayYt2A8UFjcgGnZbeYG1Z787380/U+tkCQjZUhAbOB1Ig799ma3yPRoEsPBpkogCyzpHNO6rpuJYK1KOqRYBAiF6yGyguaEQ26KScVLBmsUvpfHrH3flAA9LA+UCKFYil7z49sjujgQJZeDTIRAEHVjeynXFUay8QgcPUtQgQSOEnCNSjqkWAQCt7wW6guKAR2aATcnLBmsUuffqKe7OBWtDA+UAKJU7i0SiQhUeDTBRQgyPbUlcScjnDa+T+yuIH6loECKTwEwTqUdUiQCCFL9cNFBc0Iht0Ok4wWLP8fs9U/9PMb5qjDWngfCCFEq1dPt3g3jigQBYeDTJRgMPVj/hp+SNb16im41oqUI+qFgECKXy5bqC4oBHZoFNxosGa5Qs0+Mi9eUAVaOB8IIUS9xcco3o0SmDh0SATBTToHjAWQl8l8SN1LQIEUvgJAvWoahEgkMKX6waKCxqRDToRJxusWZ7fNEp8+oa7c4BmpIHzgRRKFP6F/TE9GgWw8GiQiQJaLH5k668gfqauRYBACj9BoB5VLQIEUriwUDdQXNCIbNBJ4ETBnuU4w1OPrAz7DsBl7s0AyqeB84EUSjTYtQtGfCsG8ll4NMhEAR4WPbLdspX71HXKIwV1LQIEUvgJAvWoahEgkMINy3QDxQWNyAadAntWvPUEa+GpR1bHoytGlQvj3obvAC1JA+cDKZQIxvZoiGfh0SATBXjZj2zNF+hnJ+6lTaShrkWAQAo/QaAeVS0CBFI4WKQbKC5oRDbo+PQGa4tbojOTx9DmH9ybGhROA+cDKZRouY9Do80WBuksPBpkooAAZz8i0bJGtthPEZCKuhYBAin8BIF6VLUIEEjhliW6geKCRmSDjk5fsOZ75rZSfkDIdmWeRZzRmDRwPpBCicR69Fizm0E4C48GmSggTOCj59mI/8AO6ahrESCQwk8QqEdViwCBFE4W6AaKCxqRDToymwnWLJgotfqRe5OCkmngfCCFEvf8jIMjeTRks/BokIkCuljSyJby2ThSUtciQCCFnyBQj6oWAQIpfM/y3EBxQSOyQcdlQ8Ga5fYFo9aVsacn8ID2pIHzgRRKPPAOR8e5AoFoFh4NMlFAN0sZ2TiqXYm7kYW01LUIEEjhJwjUo6pFgEAKP7A4N1Bc0Ihs0DHZWLBmuQzNHnNvOlAsDZwPpFDikRE9GpJZeDTIRAF9cGSzC3bOROoicUhNXYsAgRR+gkA9qloECKTwI0tzA8UFjcgGHZHNBWuWGwjZbj7n7lSgSWngfCCFEmvcwPE/uVcSCGbh0SATBfRjJzqbb2RLX/oU6alrESCQwk8QqEdViwCBFF5jYW6guKAR2aCjsclgzWInc5r43hfKpIHzgRRKrGM9eoQPwiCXhUeDTBQQg/32f56RLWdBb+SgrkWAQAo/QaAeVS0CBFJ4nWW5geKCRmSDjsU1FPLCs9bsSQdrlm8+GRXv/c7dSUCr0sD5QAolOtyASuU9GgWy8GiQiQLimGtkyxnVdFxLBepR1SJAIIU7LMoNFBc0Iht0HG5dQhke+4fDuJPiFbT8wr0pQIE0cD6QQokuj+DR33KvGCiQhUeDTBQQyxwjG0e1e6lTYiMXdS0CBFL4CQL1qGoRIJDCXZbkBooLGpENOgrhYC38zO3E+IDz/+EES8gTNCwNnA+kUGKDcTwaBbLwaJCJAuLhyPZsqpPvByzNVz38gfvxIB91LQIEUvgJAvWoahEgkMIbLMgNFBc0Iht0BDYfrFmeQdfiV3YhUBoNnA+kUGKT93gh5mvuFQIFsvBokIkCUvgTfVL1YIqRLX9U03EtFahHVYsAgRTeZDluoLigEdmg5dFgjbxEL/r0M3dHBm1LA+cDKZTYwnp02fdhUCALjwaZKCCN7yYa2YaMajqupQL1qGoRIJDCWyzGDRQXNCIbtDQarB05+wUa3+XuuKAoGjgfSKHENu8xUVhRj0aBLDwaZKKAVKYY2YaNajqupQL1qGoRIJDC2yzFDRQXNCIbtDAarDn8CqUnCdlQEg2cD6RQooeLWGfuDvdKgAJZeDTIRAHpjD2yDR3VdFxLBepR1SJAIIV7WIgbKC5oRDZoUTRYa3Jm508q/2JwC5RDA+cDKZToo7hHo0AWHg0yUUAOHNm+H+Otng+4mK/+GiIbEqhrESCQwovwLn4J3ZcdSzfdelv9I+5rmB9eVb9wsw3Uo6pFgEAK97EMN1Bc0Ihs0JLYYO2pBmt17Dzgvgi2LCiGBs4HUijRyy0EI+U8GgWy8GiQiQLyuF9g9PFRYlRbwbj2k4i78HX/Of3+sbmCCE71/BnDQ/Xwz+6PL27dtenehtZpxK9UtQgQSOFeFuEGigsakQ1aDgZrnqdJWw3WLGfXJ9EehdDA+UAKJfqxHv2Re4NBgSw8GmSigFzKjEAupWRCCnUtAgRSeAH+CXnC+Zc84uPaC6YKL4f/96dMUb0K3bX92/dMUf0VnDQaP1PVIkAghftZghsoLmhENmgxbFzie5QUfua2EWwDjBytogwaOB9IocQAZT0aBbLwaJCJAvIpPbKVkwc51LUIEEjhRbj1T6tsVX167Ht6/NxO/y3ce9MdjL2/Y28KV9XNu8147OIXvHooXPh3V/eBJFS1CBBI4QEW4AaKCxqRDVoIBiWeYC38zG07sA1GnRETJdDA+UAKJYY4w/ye4acdSaBAFh4NMlHAEEqObCVlQRJ1LQIEUngxbtjXfYUXTkB29uYej1dfxS3Y9LOdMVb4/m88tNv9aidrEa73zdeCVFS1CBBI4SHmdwPFBY3IBi2DBms9/B3NMOakmCiABs4HUigxSEmPRoEsPBpkooBh7EejoVN5ln3HErKoaxEgkMJLcvbEPvkSLtsFLG7b6QiEp0mXcRd/24dtF75c3L3/8bD3beihWg2kpKpFgEAKDzK7GyguaEQ2aAk0WOuHzxiDTxoGA/E0cD6QQokdwKxFPBoFsvBokIkChvIB95OGvJVf/ssBSKOuRYBACi/Noz8gXXj45TDK3ckJW9/Z3qK68L/t3+qXjlcp6yAxVS0CBFJ4BzO7geKCRmSDFkCDtSj+RGNcirj8zALSaeB8IIUSu4BHX+LOEFAgC48GmShgOEO/Nyv/PRzkUdciQCCFj8DZ//mfpoD/++3/Mn/+6z95OJlz1hJ73v7M430gNVUtAgRSeBfzuoHigkZkgw5Gg7VYuO5c8K3nYUA2DZwPpFBiJ6U8GgWy8GiQiQJKMGRkG+Mrb0ikrkWAQAovzvGNxQPBtxvDvP+ReavDO5LCpy8xF8VISlWLAIEU3smsbqC4oBHZoEPRYC0Bu/Tc9VGWSoFoGjgfSKHEbvDSwNvBqqBAFh4NMlFAGXJHtjFGtTWNa2c/7W89Xvj6Fv7uH4w9THm8dnxH5ONzqn/bzmgg1N4lCYBkVLUIEEjh3czpBooLGpENOgwGa55J6zVY83HRftJzn7slgWAaOB9IocQeyng0CmTh0SATBZQiZ2Qba003SKWuRYBACi/H8cnaX/iODZtyQXsIuKKesl09vMx/84ltSOzI31tfH36529nESENViwCBFN7DjG6guKAR2aCDsMGab5ExG6z5ph7ZOLYrfFC6JyzlGZBCiX18NGmHejQKZOHRIBMFlOMHe584em3r8VYqhVzqWgQIpPBC/H3/LOzTj/ubNdjF1vOvsC28DX5MDb45RGUPjjNzYZ/bL+37VsIf4W8G8DtVLQIEUngf87mB4oJGZIMO4MzeVw8Ha9NMZL8yPtur2W53zwBSaeB8IIUSe4FHPxz2IgwKZOHRIBMFlITrW0eNbGOuvw3J1LUIEEjhBfh8eA3/4d95yIAj3K59AnDhS+gu7df+FDjGbeFY2p880gQ/UtUiQCCF9zKbGyyYd3OARmSD5mPnqvcFa+FnbopwF83zrHCHCKE0cD6QQon9FPBoFMjCo0EmCihL7Mg25qhWypY1IJDCC3DVXps1Iygc5DZgNBZ+oGxu67Snx0ImbhNMuBV8zoYMVLUIEEjh/czlBstlveMaJ6r3BGvhFyQVy2fcwvnUNbdeOmh0GjgfSKHECO6Y5PeG3G1GgSw8GmSigNLEjGzjjmqz99MRPLv5U1t5XylXv77wIzd9PPc9gfPJ2e0eha+TkYGqFgECKTyCmdxguax2XNNgbRDfopFeca8IkEgD5wMplBgDPPrmAI9GgSw8GmSigPL0jWyv8XPhBZMdIJ+6FgECKXw8SpWSLAcZqGoRIJDCY5jHDZbLSsc1DdaG8h5T6H2KfUUhArQ7DZwPpFBiFL+ZDAM8GgWy8GiQiQLG4L19PvzJ96nh+KPaAvrpPEqVkiwHGahqESCQwqOYxQ2WyzrHNQ3WCvAFTfUH94YDcTRwPpBCiXGgn7/gu50UBQpk4dEgEwWMw1V75dYa2aYY1ZbQT2dRqpRkOchAVYsAgRQexxxusFzWOK5psFaG323IFr/wcDdoeho4H0ihxEiGeTQKZOHRIBMFjIVvZJtmVFtEP51DqVKS5SADVS0CBFJ4JDO4wXJZ4bhmg7V7ngnQNVhLxHaThZZwgiwaOB9IocRY8LDwgp3OPRkUyMKjQSYKGI/myDbVqLaMfjqDUqUky0EGqloECKTwWKZ3g+WyunGNwdoX7tYITz2ihHiOT3wuRM5a3g1anwbOB1IoMRp49Ke4pbaaoEAWHg0yUcCY1Ea2M35p/BN/GhWURF2LAIEUPh6lSkmWgwxUtQgQSOHRTO4Gy2Vt41pfsOZ75qZ08BjNdpl7Q4AgGjgfSKHEeH4yufI8GgWy8GiQiQLG5SqXE/sf9s9E08KhLOpaBAik8PEIlPIy9botWQ4yUNUiQCCFxzO1GyyXdY1rZ9bJfcFacOoRpZtHWNjyym3u5gMD0MD5QAolJmA/6MqJO5GRhUeDTBQwNvtATZhsslOURl2LAIEUXoJbb6t/tC9uPaW8f2zmCvG9VwoKyUEGqloECKTwBCZ2g+WyqnHtJaaz8QVr4RcklV7s+hx3uJcNpNDA+UAKJaaQ7dHIx8KjQSYKGJ2z/4bippzDG8VR1yJAIIUX4LOdIuvhn+632TjIbcM1O8u3EFhOt5Qc/EZViwCBFJ7CtG6wXFY0rnUEa8EXJJUYbtuQLe/G/AHYgAbOB1IoMYlzyNm7okgLZGPh0SATBYxMLVybbmRDYdS1CBBI4SXAtFagvtIaDnD7+WXsCffehKdlKSQHv1PVIkAghScxqRssl/WMaxqsjcg/0ISPuZcHRNDA+UAKJaZhPfod96KxuRJBJgoYlf2LI+f2w9s0IxuKoq5FgEAKL8T7O/vZiG/e5dSI2JO/Z2/wCYvhq96rtRJykISqFgECKTyNKd1guaxlXNNgbVxuYKGpK5kvCQOYgQbOB1IoMZHvkDfVo22mRJCJAkbEedH/zF58TPGa/5L66U5+tiv7CFj7E1u3+aZNVT2NXll0qBwko6pFgEAKT2RCN1guKxnXbLB2U4O18bC3WwZ0mshPA+cDKZSYin0lNnHNVORh4dEgEwWMRvvD7Mk+YEMx1LUIEEjhZbn42z7cumBn0CFRS4rWGCQHKalqESCQwlOZzg2WyyrGNQZrHnfWYK0c39hrh+yQDZaggfOBFEpMJsejkYWFR4NMFDAS7VHNMNHIhkKoaxEgkMLL885Op3ngbfD9x26acv7rP/lDH0hNVYsAgRSezGRusFzWMK4xWPN0uOGv2ZQMsIyT715vFMhMA+cDKZSYjs2e1KshBwuPBpkoYBT8o5phkpENRVDXIkAghY/Auf3a2eTtz/whkaYc93WSMEhKVYsAgRSezlRusFyWP671Bmu5/bDS4gOuIDKvE2AMGjgfSKHEDGz+6OcqAjKw8GiQiQJGYL9Qjf+Se4KRDQVQ1yJAIIUX5r39TkU4vNto+PQlcXL7phx8sGZ42H86IR1VLQIEUngGE7nBcln8uPZOg7UpeYVGzbqvi5w0cD6QQok5fAMBCR6N9Cw8GmSigOL0Lyz6bySo/hF+f30gEE9diwCBFF6SX21bCR+li8DG7ra93hXwEkgUPjm73bXDSNnzlA1pqGoRIJDCc5jGDZbL0sc128/6grXgC5LKEOxN35z3cGAPGjgfSKHELG5AQvzr8EjOwqNBJgooTMxy2aMvmA3h1LUIEEjhpbj6BS/xCjef2HbAjtm49fXhp7u9TdQhZ7d7fvh88O2v9ogPJKCqRYBACs9iEjdYLv8xC2hENmgX9r6YL1gLf82mDIMXDOlr/SAbDZwPpFBiHokejdQsPBpkooCixI1qhlFHNoimrkWAQAovwjeHoOzBcaEl7HN79/I8doU/Or4965ezO3tiZyUxb0pe5bEG+JWqFgECKTyPKdxAcUEjskE70GBtFl6icZOX+0EuGjgfSKHETB7hmifWo1EgC48GmSigIPGjmmHEkQ2CqWsRIJDCC/A15LUGGhzjtuHzjzgVhD95pEGknMPwdz3Q1viRqhYBAik8kwncQHFBI7JBg2iwNhd8ISf+JgZAHho4H0ihxFysR0c+JESBLDwaZKKAYvxgX8a7GTeqGUYb2SCWuhYBAim8BNdE3F+tG4O+UjBTVvA5W7yc3dWvL/zIzRbIQFWLAIEUnsv4bqC4oBHZoCFssOaZ2kmDtfGx7+S8SHqjDFlo4HwghRKz+R0PTOI8GgWy8GiQiQIKwVHtYdR75QeeoO+q/gjcH8sFQqlrESCQwovw3PcEOFDKo45bDylywiADVS0CBFJ4NqO7geKCRmSD+rHBmm8q3vDUI0o5uEjrv7gbAzLQwPlACiXm8x4eHfUmPApk4dEgEwUUIW9UM3xnR7YHRUc2iKSuRYBACh+PUqUky0EGqloECKTwfMZ2A8UFjcgG9dIXrI357Y4C7KQFb+O7S6SngfOBFEocQLxHo0AWHg0yUUAB8kc1wwgjGwRS1yJAIIWPR6lSkuUgA1UtAgRS+ABGdgPFBY3IBvXQG6x5nrkppbllJxV6w91ekJoGzgdSKHEIF/EOW4RHo0AWHg0yUcBgho1qhuIjG8RR1yJAIIWPR6lSkuUgA1UtAgRS+BDGdQPFBY3IBm2jwdpCMA/Vq+p8ZG+JxDRwPpBCiYOwHt2/WioKZOHRIBMFDOQDFr8bMqoZCo9sEEZdiwCBFD4epUpJloMMVLUIEEjhgxjVDRQXNCIbtImdftcXrIWnHlHG4ar9BChu2gIkpYHzgRRKHMZVhEG9Ho0CWXg0yEQBg+Co9lfGd/ANvsMtp+pB6ucZXiCKuhYBAil8PEqVkiwHGahqESCQwocxphsoLmhENmgDO/eub4XL4NdsynjYVQovcb3FTpCSBs4HUihxILfg0V9xLwQKZOHRIBMFDKDcqGYoKA2CqGsRIJDCx6NUKclykIGqFgECKXwgI7qB4oJGZIM6hIO18NdsyphctSsuXuNuB0hHA+cDKZQ4FOvRH7kXAAWy8GiQiQKyKTuqGYpJhBjqWgQIpPAivDvODnIkUMrLG9xoc+tt9Y/2q9VeOT+8qn7hZgtkoKpFgEAKH8p4bqC4oBHZoHU0WFsgb9D0oZkWjiAZDZwPpFDiYM4wKHd7NApk4dEgEwVkUn5UMxSSCiHUtQgQSOEl+EnEXfi6+X2lp5T3mJY/tGTLZztD1sM/3bMbB7kNbt21Cd8GblzgR6paBAik8MGM5gaKCxqRDXqEwdpt7tbQYG1OGLL1rVOIRDRwPpBCicOxHh28zDagQBYeDTJRQBZ8z6PwqGYoMrJBBHUtAgRSeAH+CXnC+Zc8AnCI24ZrL3BECN1vwGwkoL7QGg5we7f72/fYF9ozkxD8SlWLAIEUPpyx3EBxQSOyQQ/YYM33gDP4gqQyDXa+pu+7QzakoYHzgRRKLMAZPlbo8mgUyMKjQSYKyGCUb6kPFBjZIIC6FgECKbwIt/5ptayqT48Pr8pgn9vPL2NPuPem88R9f8daQy6c7zIcwx62Lh7m+r/w747Zd5CCqhYBAim8ACO5geKCRmSDkr5gzffMTZmKi/bCt2OljlKeASmUWAR49Pfc8YACWXg0yEQByYw7qhkGfxGH7NS1CBBI4cW48QvECi9sPIZt+Xv25h42ha+i+o2f7S0JAUu2Yau+KNv1njk7kYiqFgECKbwIo7iB4oJGZINaNFhbOHdhhgcdV75IQAPnAymUWAZ49CXutEGBLDwaZKKARMYf1QwDRzZkpq5FgEAKL8lxDZnq8nNb7dv2K1fhacqC0Rd/24dtF77gz2H32/63gZGQqhYBAim8DGO4geKCRmSDGjRYWz6f8STik/M8w8H8vMRxbYer+qBHo0AWHg0yUUAS04xqhkEjG7JS1yJAIIWX5tEfkN6gZ4VrL+/Q+df5JfwqZR2kpapFgEAKL8QIbqC4oBHZoIIGa6vgWxjjWShkw680cD6QQomlgEe/DdQbBbLwaJCJAhLgujITjGqGASMbMlLXIkAghY/A2f/5nyiB/Nd/8ngyF//f/48yhP/+/8R8t2lAcqpaBAik8FKUdwPFBY3IBt3dwJNZX7AW/ppNmYP36Cg/BZ41mN+WOa7Zy6OAR6NAFh4NMlFANKOucO0le2RDNupaBAik8OIcX1g8Un+9MZZ8OUhKVYsAgRRejOJuoLigEdmg9rUlX7AW/ppNmQn75OEV91zwEw2cD6RQYjlwKr3wXn2jQBYeDTJRQCTTj2qGtBW4DyATdS0CBFJ4Uc5+2j9gu/D1LfzFB2uGhymP14bJQTqqWgQIpPBylHYDxQWNiOa0wdoFz11sDdaWyO940exTcLIHGjgfSKHEgsCjH/o8GgWy8GiQiQKimGdUM2SNbMhCXYsAgRRejuOTtb/w3Beb8vfa4au0uKdsg+UgDVUtAgRSeEEKu4HigkY0rWmDtctoWRcN1hbKv2EYz+QFOE4D5wMplFiSO0auz6NRIAuPBpkoIIL5RjVDxsiGDNS1CBBI4YX4u73JKldZP+4/YMOu3Xz+FXaEt51fp5SRgwRUtQgQSOElKesGigsaMSJY8zxzU+bmOW7YfGpZzRxd7rhmPfpm+9taFMjCo0EmCujlNVLPNaoZkkc2JKeuRYBACi/A5x8PNwn/zkMGHOF2/RuAC18Cb+qUkoNfqWoRIJDCi1LUDRQXNGJvsNa7toIyD7ajbhoOB2ngfCCFEsvy2EhuezQKZOHRIBMF9MBRbeapTRNHNiSmrkWAQAovwFV7g/CPxlMKHOS25ZsHOBaa3bSUHPxIVYsAgRRelpJuoLigETVYWy2PMIdRw3bm0JLHNTvC3GyuT4YCWXg0yEQBnSxjVDNctT3zp9AUwA5ISl2LAIEUXoRnN39qjzHeUq5+feFHbnooIwcZqGoRIJDCC1PQDRQXNKJBg7WVgqs+10g4QgPnAymUWBp49IXGGwAokIVHg0wU0MFyRjVDwsiGhNS1CBBI4eNRqpRkOchAVYsAgRRemnJuoLigETVYWzO3EbLV7WT2lz2u2S/LGx6NAll4NMhEAUGWNaoZokc2JKOuRYBACh+PUqUky0EGqloECKTw4hRzA8UFjajB2rrBE+jaG6vYpYHzgRRKLA88+pPzNAUFsvBokIkC/JzxPbqFLRkYObIhEXUtAgRS+HiUKiVZDjJQ1SJAIIWXp5QbKC5oRE+wFp56RFketNbePczO0sc1O32z49EokIVHg0wU4GM/qt3l/oKIGtmQhLoWAQIpfDxKlZIsBxmoahEgkMJHoJAbKC5oRDZojfDUI8oisQZjSIJtGjgfSLECHd7hh6p6x/1c8ClZ3aMhlYVHg0wU0GY/qj3h/sKIqB5+p65FgEAKH49SpSTLQQaqWgQIpPA6y3IDxQWNyAY9EP6aTVkqN/A01C5kbraWP67xG+njWYZdFh4NMlFAk4WPaobeKuJX6loECKTw8ShVSrIcZKCqRYBACq+zLDdQXNCIbNA94a/ZlAVjH4j+W7awQQPnAylWtEMxh96dg5yDR2OPhUeDTBTgsoJRzdBTTfxGXYsAgRQ+HqVKSZaDDFS1CBBI4XWW5QaKCxqRDWrRYG2t2BdY7/1eyDMghaIJDrnwlzysR+97Buyw8GiQiQLq8OHV0kc1Q+fIhl+oaxEgkMLHo1QpyXKQgaoWAQIpnOCQC3/Jo4AbKC5oRDYo0GBtxdhF8uxU/zRwPpBCwQSHXPhLJtcggx6NbRYeDTLZ/DX2r2T8yf2F0zGy4Th1LQIEUvh4lColWQ4yUNUiQCCFExxy4S+ZDHcDxQWNaNvToMHaurGLmgMaOB9IoVyCQy78JZf7EGI9GpssPBpkQvYj0R+HLQh+YmduIzvgKHUtAgRS+HiUKiVZDjJQ1SJAIIUTHHLhL7kMdgPFBY2I5jRosLZ2zp7BhAINnA+kUCzBIRf+ko316PtmE1ssPBpkgqQ9axzVDP6Px3GMuhYBAil8PEqVkiwHGahqESCQwgkOufCXbIa6geKCRkTLarB2GrxkyEYD5wMpFFqn3ANzYMUZj8YGC48Gmawk0DGq2c/XXRb1KYtvZMMR6loECKTw8ShVSrIcZKCqRYBACq+zLDdQXNCIyglCA+cDKdbpHAo7NOWdy3RoZKKkw2T5/lht8eOab2TDPnUtAgRS+HiUKuWcgdtRoGCqWgQIpPA6y3IDxQWNqJwgNHA+kEKnq1PaoXd/g7hzw8c1jmoXAncgVzCutUc27FHXIkAghZ8gUI+qFgECKbzOstxAUZQo4F/0uXG5gaLs284sPBpkgpTehc3+vNNmgS9McknvO3bRFmxT1yJAIESfJFCPqhYBAil8XIa4gaIoUcC/6HIjYz0asPBokElEJC9EvWA4smFZb2xR1yJAoC3nFIF6VLUIEEjhIzPADRRFiQL+RY8bm0eH7xNYeDTIdFKjmuE4suEvdS0CBLKYEwTqUdUiQCCFj02+GyiKEgX8iw43OgePZuHRINND/Hsyo5phP7LhX+paBAhkIScI1KOqRYBACh+dbDdQFCUK+Bf9bXye4yOTzHHNcFKjmoEjm4G6FgECWcQJAvWoahEgkMLHJ9cNFEWJwjrY1LDwaJjttKGuRaDIk4aqFoEiJ4aFK4pSFnrYxLDwaJjttKGuRaDIk4aqFoEiJ4aFK4pSFnrYxLDwaJjttKGuRaDIk4aqFoEiJ4aFr57/+I//HyxiYzCEDp3iAAAAAElFTkSuQmCC",
          fileName="modelica://SimpleAHU/Resources/ExampleAHU.png"),
        Text(
          extent={{-124,82},{-58,64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Heat Recovery System"),
        Text(
          extent={{-40,0},{-12,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Preheater"),
        Text(
          extent={{94,-2},{120,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Reheater"),
        Text(
          extent={{-2,-2},{24,-10}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Cooler"),
        Text(
          extent={{42,6},{86,-18}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Spray Humidifier"),
        Text(
          extent={{124,-2},{150,-12}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="SupVent"),
        Text(
          extent={{124,56},{150,46}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="EtaVent")}),                                     Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-180,-100},{180,
            100}})),
    experiment(
      StopTime=86400,
      Interval=3600,
      __Dymola_Algorithm="Dassl"));
end ExampleAHU3;
