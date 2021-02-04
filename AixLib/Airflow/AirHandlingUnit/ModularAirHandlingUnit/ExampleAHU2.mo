within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit;
model ExampleAHU2 "Model of an examplary air handling unit"
  parameter Boolean use_T_set = true "use set temperatures to calculate heater and cooler";
  parameter Boolean use_X_set = true "use set humidity to calculate cooler";

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

  Components.PlateHeatExchangerFixedEfficiency
    plateHeatExchangerFixedEfficiency(cp_air=cp_air, cp_steam=cp_steam,
    epsilon=efficiencyHRS,
    redeclare model PartialPressureDrop =
        Components.PressureDrop.PressureDropSimple (a=0.5, b=1.8))
    annotation (Placement(transformation(extent={{-72,0},{-52,20}})));
  Components.Heater preheater(
    final use_T_set=use_T_set,
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
    final use_T_set=use_T_set,
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
    final use_T_set=use_T_set,
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_Preheater if not use_T_set
    annotation (Placement(transformation(extent={{-130,-110},{-110,-90}}),
        iconTransformation(extent={{-130,-110},{-110,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_Cooler if not use_T_set
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}}),
        iconTransformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_Reheater if not use_T_set
    annotation (Placement(transformation(extent={{120,-110},{140,-90}}),
        iconTransformation(extent={{120,-110},{140,-90}})));
  Modelica.Blocks.Interfaces.RealInput T_waterIn annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={68,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={58,-100})));
  Modelica.Blocks.Interfaces.RealInput X_set_Humidifier
    "set value for humidity" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={40,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-100})));
  Modelica.Blocks.Interfaces.RealInput T_set_HRS
    "Set temperature of supply air. Is used to limit heat recovery."
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-160,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-160,-100})));
  Modelica.Blocks.Interfaces.RealInput T_set_preheater
    "Set temperature of preheater" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-120,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-120,-100})));
  Modelica.Blocks.Interfaces.RealInput T_set_cooler "Set temperature of cooler"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-20,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-100})));
  Modelica.Blocks.Interfaces.RealInput T_set_reheater
    "Set temperature of reheater" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={130,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-100})));
  Components.SprayHumidifier sprayHumidifier(use_X_set=true, redeclare model
      PartialPressureDrop = Components.PressureDrop.PressureDropSimple)
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
  Modelica.Blocks.Interfaces.RealInput X_set_cooler annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={10,-112}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={6,-100})));
  Modelica.Blocks.Interfaces.RealInput T_coolingSurf1
                        "temperature of cooling Surface" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-66,-110}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-76,-100})));
equation
  if use_T_set then
    connect(preheater.T_set, T_set_preheater) annotation (Line(points={{-24,8},
            {-24,34},{-86,34},{-86,-80},{-120,-80},{-120,-110}},
        color={0,0,127}));
    connect(T_set_cooler, cooler.T_set) annotation (Line(points={{-20,-110},{
            -20,-80},{-86,-80},{-86,34},{10,34},{10,8}},        color={0,0,127}));
    connect(T_set_reheater, reheater.T_set) annotation (Line(points={{130,-110},
            {130,-86},{88,-86},{88,14},{74,14},{74,8}},
                                                 color={0,0,127}));
  else
    connect(preheater.heatPort, heatPort_Preheater) annotation (Line(points={{-24,
          -12},{-24,-80},{-120,-80},{-120,-100}}, color={191,0,0}));
    connect(cooler.heatPort, heatPort_Cooler) annotation (Line(points={{10,-12},{
          10,-80},{10,-100},{-20,-100}}, color={191,0,0}));
    connect(reheater.heatPort, heatPort_Reheater) annotation (Line(points={{74,-12},
            {74,-56},{74,-100},{130,-100}},  color={191,0,0}));
  end if;

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
  connect(plateHeatExchangerFixedEfficiency.T_set, T_set_HRS) annotation (Line(
        points={{-62,20},{-62,26},{-90,26},{-90,-82},{-160,-82},{-160,-110}},
        color={0,0,127}));

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
  connect(sprayHumidifier.T_watIn, T_waterIn) annotation (Line(points={{39,
          -11.4},{39,-76},{68,-76},{68,-110}},
                                        color={0,0,127}));
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
  connect(sprayHumidifier.X_set, X_set_Humidifier) annotation (Line(points={{42,8.2},
          {42,18},{26,18},{26,-80},{40,-80},{40,-110}},    color={0,0,127}));
  connect(cooler.X_set, X_set_cooler) annotation (Line(points={{16,8},{16,42},{-40,
          42},{-40,-80},{10,-80},{10,-112}}, color={0,0,127}));
  connect(cooler.T_coolingSurf, T_coolingSurf1) annotation (Line(points={{5.1,
          -11.9},{5.1,-46},{6,-46},{6,-80},{-66,-80},{-66,-110}}, color={0,0,
          127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
            -100},{180,100}}), graphics={
        Bitmap(
          extent={{-152,-84},{150,82}}, fileName=
              "modelica://AixLib/Resources/Images/Airflow/AirHandlingUnit/ExampleAHU.png"),
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
end ExampleAHU2;
