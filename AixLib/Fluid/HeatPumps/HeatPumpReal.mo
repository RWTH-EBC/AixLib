within AixLib.Fluid.HeatPumps;
model HeatPumpReal
  "Model containing the basic heat pump block and different control blocks(optional)"

  HeatPump heatPump(
    redeclare final package Medium_con = Medium_con,
    redeclare final package Medium_eva = Medium_eva,
    final allowFlowReversalEva=allowFlowReversalEva,
    final allowFlowReversalCon=allowFlowReversalCon,
    final mFlow_conNominal=mFlow_conNominal,
    final mFlow_evaNominal=mFlow_evaNominal,
    final VCon=VCon,
    final VEva=VEva,
    final dpEva_nominal=dpEva_nominal,
    final dpCon_nominal=dpCon_nominal,
    final perData=perData,
    final comIneTime_constant=comIneTime_constant,
    useComIne=useComIne,
    final CEva=CEva,
    final GEva=GEva,
    final CCon=CCon,
    final GCon=GCon)
    annotation (Placement(transformation(extent={{84,-38},{160,38}})));
  BaseClasses.SecurityControls.SecurityControl securityControl(
    final useMinRunTime=useMinRunTime,
    final minRunTime(displayUnit="min") = minRunTime,
    final minLocTime(displayUnit="min") = minLocTime,
    final useRunPerHou=useRunPerHou,
    final maxRunPerHou=maxRunPerHou,
    final useOpeEnv=useOpeEnv,
    final tableLow=tableLow,
    final tableUpp=tableUpp,
    final useMinLocTime=useMinLocTime) if useSec
    annotation (Placement(transformation(extent={{-10,-28},{54,28}})));
  BaseClasses.HeatPumpControlls.DefrostControl defrostControl if useDeFro
    annotation (Placement(transformation(extent={{-104,-26},{-44,26}})));
  BaseClasses.HeatPumpControlls.HPControl hPControls(final useAntilegionella=
        useAntLeg)
    annotation (Placement(transformation(extent={{-186,-26},{-134,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                     redeclare final package Medium = Medium1,
                     m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{74,90},{94,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                     redeclare final package Medium = Medium1,
                     m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{170,90},{150,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                     redeclare final package Medium = Medium2,
                     m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium2.h_default))
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{150,-110},{170,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                     redeclare final package Medium = Medium2,
                     m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium2.h_default))
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{94,-110},{74,-90}})));
  parameter Boolean useDeFro=false "False if defrost in not considered"
                                    annotation (choices(checkBox=true), Dialog(
        tab="Defrost Control", group="General", descriptionLabel = true));
  parameter Boolean useSec=true
    "False if the Security block should be disabled"
                                     annotation (choices(checkBox=true), Dialog(
        tab="Security Control", group="General", descriptionLabel = true));
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient temperature"
    annotation (Placement(transformation(extent={{-240,20},{-200,60}})));
  parameter Boolean useMinRunTime=true
    "False if minimal runtime of HP is not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true), choices(checkBox=true));
  parameter Modelica.SIunits.Time minRunTime(displayUnit="min")
    "Mimimum runtime of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=useSec and useMinRunTime));
  parameter Boolean useMinLocTime=true
    "False if minimal locktime of HP is not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true), choices(checkBox=true));
  parameter Modelica.SIunits.Time minLocTime(displayUnit="min")
    "Minimum lock time of heat pump"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=useSec and useMinLocTime));
  parameter Boolean useRunPerHou=true
    "False if maximal runs per hour of HP are not considered"
    annotation (Dialog(tab="Security Control", group="On-/Off Control", descriptionLabel = true), choices(checkBox=true));
  parameter Real maxRunPerHou "Maximal number of on/off cycles in one hour"
    annotation (Dialog(tab="Security Control", group="On-/Off Control",
      enable=useSec and useRunPerHou));
  parameter Boolean useOpeEnv=true
    "False to allow HP to run out of operational envelope"
    annotation (Dialog(tab="Security Control", group="Operational Envelope",
      enable=useSecurity, descriptionLabel = true),                                                   choices(checkBox=true));
  parameter Boolean useAntLeg=false
    "True if Anti-Legionella control is considered"
    annotation (Dialog(tab="HP Control", group="Anti Legionella", descriptionLabel = true),choices(checkBox=true));
  Movers.SpeedControlled_Nrpm pumSin(
    redeclare final package Medium = Medium_con,
    final allowFlowReversal=allowFlowReversalCon,
    final per=perEva,
    final addPowerToMedium=addPowerToMediumEva) if useConPum
    "Fan or pump at sink side of HP" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={84,66})));
  parameter Real tableUpp[:,2] "Upper boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=useSec and useOpeEnv));
  parameter Real tableLow[:,2] "Lower boundary of envelope" annotation (Dialog(
      tab="Security Control",
      group="Operational Envelope",
      enable=useSec and useOpeEnv));
  Movers.SpeedControlled_Nrpm pumSou(
    redeclare final package Medium = Medium_eva,
    final allowFlowReversal=allowFlowReversalEva,
    final per=perCon,
    final addPowerToMedium=addPowerToMediumCon) if useEvaPum
    "Fan or pump at source side of HP" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={160,-60})));
  replaceable package Medium_con = Modelica.Media.Interfaces.PartialMedium "Medium at sink side"
    annotation (__Dymola_choicesAllMatching=true);
  replaceable package Medium_eva = Modelica.Media.Interfaces.PartialMedium "Medium at source side"
    annotation (__Dymola_choicesAllMatching=true);
  parameter Modelica.SIunits.MassFlowRate mFlow_conNominal
    "Nominal mass flow rate, used for regularization near zero flow"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.MassFlowRate mFlow_evaNominal
    "Nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.Volume VCon "Volume in condenser"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.Volume VEva "Volume in evaporator"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpEva_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.PressureDifference dpCon_nominal
    "Pressure drop at nominal mass flow rate"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Boolean allowFlowReversalEva=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Assumptions"),
                                                                        choices(checkBox=true));
  parameter Boolean allowFlowReversalCon=false
    "= false to simplify equations, assuming, but not enforcing, no flow reversal"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Assumptions"),
                                                                       choices(checkBox=true));
  Boolean useConPum=true
    "True if pump or fan at condenser side are included into this model"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"),choices(checkBox=true));
  Boolean useEvaPum=true
    "True if pump or fan at evaporator side are included into this model"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"),choices(checkBox=true));
  parameter Movers.Data.Generic perEva=AixLib.Fluid.Movers.Data.Generic
    "Record with performance data"
    annotation (choicesAllMatching=true,Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=useEvaPum));
  parameter Boolean addPowerToMediumEva=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator",
      enable=useEvaPum));
  parameter Movers.Data.Generic perCon=AixLib.Fluid.Movers.Data.Generic
    "Record with performance data"
    annotation (choicesAllMatching=true,Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=useConPum));
  parameter Boolean addPowerToMediumCon=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser",
      enable=useConPum));
  replaceable parameter BaseClasses.PerformanceData.LookUpTable2D perData=
      BaseClasses.PerformanceData.LookUpTable2D constrainedby
    BaseClasses.PerformanceData.BaseClasses.PartialPerformanceData
    "replaceable model for performance data of HP" annotation (choicesAllMatching=true);
  parameter Boolean useComIne=false
                                   "Consider the inertia of the compressor"
    annotation (Dialog(group="Compressor Inertia"), choices(checkBox=true));
  constant Modelica.SIunits.Time comIneTime_constant
    "Time constant representing inertia of compressor"
    annotation (Dialog(group="Compressor Inertia", enable=useComIne));

  parameter Modelica.SIunits.HeatCapacity CEva
    "Heat capacity of Evaporator (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.ThermalConductance GEva
    "Constant thermal conductance of Evaporator material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Evaporator"));
  parameter Modelica.SIunits.HeatCapacity CCon
    "Heat capacity of Condenser (= cp*m)"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  parameter Modelica.SIunits.ThermalConductance GCon
    "Constant thermal conductance of condenser material"
    annotation (Dialog(tab="Evaporator/ Condenser", group="Condenser"));
  Modelica.Blocks.Interfaces.RealInput T_ambInternal "Ambient temperature"
    annotation (Placement(transformation(extent={{240,20},{200,60}})));
equation
  connect(heatPump.sigBusHP, securityControl.heatPumpControlBus) annotation (
      Line(
      points={{80.58,-8.55},{76,-8.55},{76,-48},{-26.675,-48},{-26.675,-19.32},
          {-14,-19.32}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPump.sigBusHP, hPControl.heaPumControlBus) annotation (Line(
      points={{80.58,-10.26},{76,-10.26},{76,-48},{-192,-48},{-192,-14},{-192,
          -14},{-192,-13.44},{-183.04,-13.44}},
      color={255,204,51},
      thickness=0.5));
  connect(defrostControl.heaPumControlBus, heatPump.sigBusHP) annotation (Line(
      points={{-106.4,-21.32},{-106.4,-48},{76,-48},{76,-8.55},{80.58,-8.55}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPump.port_b2, port_b2)
    annotation (Line(points={{84,-19},{84,-100}},   color={0,127,255}));
  connect(T_amb, hPControls.T_amb) annotation (Line(points={{-220,40},{-206,40},
          {-206,4},{-191.72,4}},     color={0,0,127}));
  if not useSec and not useDeFro then
    connect(hPControls.nOut, heatPump.nSet) annotation (Line(
      points={{-130.36,-1},{-112,-1},{-112,-86},{68,-86},{68,0},{76.4,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  elseif not useSec and useDeFro then
    connect(defrostControl.nOut, heatPump.nSet) annotation (Line(
      points={{-40.4,0},{-24,0},{-24,-66},{68,-66},{68,0},{76.4,0}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  elseif not useDeFro and useSec then
    connect(hPControls.nOut, securityControl.nSet) annotation (Line(
      points={{-130.36,-1},{-112,-1},{-112,-66},{-36,-66},{-36,3.55271e-015},{
            -14.2667,3.55271e-015}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  else
  end if;
  connect(securityControl.nOut, heatPump.nSet)
                                              annotation (Line(points={{56.6667,
          0},{76.4,0}},                                                                        color={0,0,127}));
  connect(defrostControl.nOut, securityControl.nSet) annotation (Line(points={{-40.4,0},
          {-28,0},{-28,3.55271e-015},{-14.2667,3.55271e-015}},    color={0,0,127}));
  connect(hPControls.nOut, defrostControl.nSet) annotation (Line(points={{-130.36,
          -1},{-118,-1},{-118,0},{-110,0}},                                                     color={0,0,127}));
  connect(heatPump.port_b1, port_b1) annotation (Line(points={{160,19},{160,100},
          {160,100}}, color={0,127,255}));
  if not useConPum then
    connect(port_a1, heatPump.port_a1) annotation (Line(
      points={{84,100},{84,88},{64,88},{64,38},{84,38},{84,19}},
      color={0,127,255},
      pattern=LinePattern.Dash));
  end if;
  connect(pumSin.port_b, heatPump.port_a1)
    annotation (Line(points={{84,56},{84,19}},   color={0,127,255}));
  connect(pumSin.port_a, port_a1)
    annotation (Line(points={{84,76},{84,100}}, color={0,127,255}));
  if not useEvaPum then
    connect(port_a2, heatPump.port_a2) annotation (Line(
      points={{160,-100},{160,-80},{182,-80},{182,-36.8},{160,-36.8},{160,-19}},
      color={0,127,255},
      pattern=LinePattern.Dash));

  end if;
  connect(port_a2, pumSou.port_a)
    annotation (Line(points={{160,-100},{160,-70}}, color={0,127,255}));
  connect(pumSou.port_b, heatPump.port_a2)
    annotation (Line(points={{160,-50},{160,-19}},   color={0,127,255}));
  connect(T_ambInternal, heatPump.T_ambInternal) annotation (Line(points={{220,
          40},{198,40},{198,0},{167.6,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics={
        Text(
          extent={{-180,42},{-132,28}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="3. Layer"),
        Text(
          extent={{-100,48},{-52,34}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="2. Layer"),
        Text(
          extent={{-4,48},{44,34}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="1. Layer"),
        Line(
          points={{-32,100},{-32,-100}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{58,96},{58,-104}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-122,100},{-122,-100}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash)}));
end HeatPumpReal;
