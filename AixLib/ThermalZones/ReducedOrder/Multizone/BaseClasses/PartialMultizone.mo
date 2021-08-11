within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
partial model PartialMultizone "Partial model for multizone models"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer buildingID
    "Unique identifier of the building";
  parameter Modelica.SIunits.Volume VAir(min=0)
    "Indoor air volume of building";
  parameter Modelica.SIunits.Area ABuilding(min=0)
    "Net floor area of building";
  parameter Modelica.SIunits.Area ASurTot(min=0)
    "Total surface area of building walls and windows (including interior walls)";
  parameter Integer numZones(min=1)
    "Number of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[:]
    "Setup for zones" annotation (choicesAllMatching=false);
  parameter Integer nPorts=0
    "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  parameter Boolean use_AirExchange=true
    "Consider infiltration and ventilation by setting true";
  parameter Boolean use_C_flow=false
    "Set to true to enable input connector for trace substance"
    annotation (Dialog(tab="CO2"));
  parameter Modelica.SIunits.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.SIunits.Area areaBod=1.8
    "Body surface area source SIA 2024:2015"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.SIunits.DensityOfHeatFlowRate metOnePerSit=58
    "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Boolean use_moisture_balance=false
    "If true, input connector QLat_flow is enabled and room air computes moisture balance"
    annotation (Dialog(tab="Moisture"));

  replaceable model corG = SolarGain.CorrectionGDoublePane
    constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission"
    annotation(choicesAllMatching=true);

  Modelica.Blocks.Interfaces.RealInput intGains[3*numZones]
    "Input profiles for internal gains persons, machines, light"
    annotation (
    Placement(transformation(
    extent={{20,-20},{-20,20}},
    rotation=-90,
    origin={76,-100}), iconTransformation(
    extent={{-10,-10},{10,10}},
    rotation=90,
    origin={60,-110})));
  Modelica.Blocks.Interfaces.RealOutput TAir[size(zone, 1)](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ASurTot > 0 or VAir > 0
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,71},{120,91}}),
        iconTransformation(extent={{80,19},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput TRad[size(zone, 1)](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ASurTot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{100,49},{120,69}}),
        iconTransformation(extent={{80,0},{100,20}})));
   Modelica.Blocks.Interfaces.RealOutput TOpe[size(zone, 1)](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ASurTot > 0 "Indoor operative temperature"
    annotation (Placement(transformation(extent={{100,86},{120,106}})));

  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,53},{-83,85}}), iconTransformation(
    extent={{-90,30},{-70,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv[size(zone, 1)] if
       ASurTot > 0 or VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
        iconTransformation(extent={{-90,-92},{-70,-72}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad[size(zone, 1)] if
       ASurTot > 0 "Radiative internal gains"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-50}}),
        iconTransformation(extent={{-90,-60},{-70,-40}})));
  ThermalZone.ThermalZone_TABS_Sprungantwort               zone[numZones](
    each recOrSep=recOrSep,
    each Heater_on=Heater_on,
    each Cooler_on=Cooler_on,
    each h_heater_Panel=h_heater_Panel,
    each l_heater_Panel=l_heater_Panel,
    each h_heater_Rem=h_heater_Rem,
    each l_heater_Rem=l_heater_Rem,
    each h_heater_TABS=h_heater_TABS,
    each l_heater_TABS=l_heater_TABS,
    each KR_heater_Panel=KR_heater_Panel,
    each TN_heater_Panel=TN_heater_Panel,
    each KR_heater_Rem=KR_heater_Rem,
    each TN_heater_Rem=TN_heater_Rem,
    each KR_heater_TABS=KR_heater_TABS,
    each TN_heater_TABS=TN_heater_TABS,
    each share_Heater_TabsExt=share_Heater_TabsExt,
    each share_Heater_TabsInt=share_Heater_TabsInt,
    each share_Heater_PanelExt=share_Heater_PanelExt,
    each share_Heater_PanelInt=share_Heater_PanelInt,
    each share_Heater_Rad=share_Heater_Rad,
    each share_Heater_Conv=share_Heater_Conv,
    each h_cooler_Panel=h_cooler_Panel,
    each l_cooler_Panel=l_cooler_Panel,
    each h_cooler_Rem=h_cooler_Rem,
    each l_cooler_Rem=l_cooler_Rem,
    each h_cooler_TABS=h_cooler_TABS,
    each l_cooler_TABS=l_cooler_TABS,
    each KR_cooler_Panel=KR_cooler_Panel,
    each TN_cooler_Panel=TN_cooler_Panel,
    each KR_cooler_Rem=KR_cooler_Rem,
    each TN_cooler_Rem=TN_cooler_Rem,
    each KR_cooler_TABS=KR_cooler_TABS,
    each TN_cooler_TABS=TN_cooler_TABS,
    each share_Cooler_TabsExt=share_Cooler_TabsExt,
    each share_Cooler_TabsInt=share_Cooler_TabsInt,
    each share_Cooler_PanelExt=share_Cooler_PanelExt,
    each share_Cooler_PanelInt=share_Cooler_PanelInt,
    each share_Cooler_Rad=share_Cooler_Rad,
    each share_Cooler_Conv=share_Cooler_Conv,
    each heating_on=heating_on,
    each cooling_on=cooling_on,
    each tabs_on=tabs_on,
    each floor_on=floor_on,
    each radiator_on=radiator_on,
    each use_C_flow=use_C_flow,
    each use_moisture_balance=use_moisture_balance,
    each use_AirExchange=use_AirExchange,
    each XCO2_amb=XCO2_amb,
    each areaBod=areaBod,
    each metOnePerSit=metOnePerSit,
    final zoneParam=zoneParam,
    redeclare each final model corG = corG,
    each final internalGainsMode=internalGainsMode,
    each final nPorts=nPorts,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    redeclare each final package Medium = Medium) "Thermal zone model"
    annotation (Placement(transformation(extent={{38,49},{80,90}})));

  parameter Integer internalGainsMode
    "Decides which internal gains model for persons is used";
  //parameter Boolean recOrSep=true "Use record or seperate parameters"
  //  annotation (Dialog(tab="IdealHeaterCooler", group="Modes"), choices(choice =  false
  //      "Seperate",choice = true "Record",radioButtons = true));
  //parameter Boolean Heater_on=true "Activates the heater"
  //  annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real KR_heater=1000 "Gain of the heating controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater=1
    "Time constant of the heating controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  //parameter Boolean Cooler_on=true "Activates the cooler"
  //  annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler=1000 "Gain of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler=1
    "Time constant of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));

  // Heater/ cooler parameters
  parameter Boolean recOrSep=true "Use record or seperate parameters"
    annotation (Dialog(tab="HeaterCooler", group="Modes"), choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter Boolean Heater_on=true "Activates the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Boolean heating_on = true "Activates heating" annotation (Dialog(tab="HeaterCooler", group="Modes"));
  parameter Boolean cooling_on = true "Activates cooling" annotation (Dialog(tab="HeaterCooler", group="Modes"));
  parameter Boolean tabs_on = false "TABS is available" annotation (Dialog(tab="HeaterCooler", group="Modes"));
  parameter Boolean floor_on = false "Panel heating and/or cooling is available" annotation (Dialog(tab="HeaterCooler", group="Modes"));
  parameter Boolean radiator_on = true "Radiator heating or Convective heating and/or cooling is available" annotation (Dialog(tab="HeaterCooler", group="Modes"));
  parameter Real h_heater_Panel=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater_Panel=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater_Rem=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater_Rem=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater_TABS=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater_TABS=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real KR_heater_Panel = 18 "Gain of the panel heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Panel = 2300 "Time constant of the panel heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Real KR_heater_Rem = 1000 "Gain of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_Rem = 1 "Time constant of the heating controller for radiative and convective heating system" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Real KR_heater_TABS = 18 "Gain of the TABS heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_heater_TABS = 2300 "Time constant of the TABS heating controller" annotation(Dialog(tab = "HeaterCooler", group = "Heater",enable=not recOrSep));

  parameter Real share_Heater_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_PanelExt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_PanelInt(min=0, max=1) = 0
    "contribution from any heated surfaces of one or several interior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_Rad(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Real share_Heater_Conv(min=0, max=1) = 1
    "convective contribution to heating load" annotation(Dialog(tab = "HeaterCooler", group = "Heater"));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler_Panel=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler_Panel=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler_Rem=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler_Rem=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler_TABS=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler_TABS=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler_Panel = 18 "Gain of the panel cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Panel = 2300 "Time constant of the panel cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Real KR_cooler_Rem = 1000 "Gain of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_Rem = 1 "Time constant of the cooling controller for radiative and convective cooling system" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Real KR_cooler_TABS = 18 "Gain of the TABS cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler_TABS = 2300 "Time constant of the TABS cooling controller" annotation(Dialog(tab = "HeaterCooler", group = "Cooler",enable=not recOrSep));

  parameter Real share_Cooler_TabsExt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_TabsInt(min=0, max=1) = 0
    "contribution from a system installed in the core of one or several interior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_PanelExt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_PanelInt(min=0, max=1) = 0
    "contribution from any cooled surfaces of one or several interior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_Rad(min=0, max=1) = 0
    "radiant contribution of one or several exterior building components to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));
  parameter Real share_Cooler_Conv(min=0, max=1) = 1
    "convective contribution to cooling load" annotation(Dialog(tab = "HeaterCooler", group = "Cooler"));

  parameter Real power_Heater_Tabs = 0
    "Fixed available heating power of TABS"  annotation (Dialog(tab= "HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real power_Cooler_Tabs = 0
    "Fixed available cooling power of TABS"  annotation (Dialog(tab= "HeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real TThreshold_Heat_Tabs = 273.15 + 14
    "Threshold temperature below which heating is activated"  annotation (Dialog(tab= "HeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real TThreshold_Cool_Tabs = 273.15 + 16
    "Threshold temperature above which cooling is activated"  annotation (Dialog(tab= "HeaterCooler", group="Cooler", enable=not recOrSep));

  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for heater - used only if zoneParam[i].HeaterOn is true"
    annotation (Placement(transformation(
    extent={{20,-20},{-20,20}},
    rotation=270,
    origin={-40,-100}), iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=270,
    origin={-52,-110})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for cooler - used only if zoneParam[i].CoolerOn is true"
    annotation (Placement(transformation(
    extent={{20,-20},{-20,20}},
    rotation=270,
    origin={-80,-100}), iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=270,
    origin={-74,-110})));
  Modelica.Blocks.Interfaces.RealOutput PHeater[numZones](final quantity="HeatFlowRate",
      final unit="W")
    "Power for heating"
    annotation (
    Placement(transformation(extent={{100,-56},{120,-36}}),
    iconTransformation(extent={{80,-80},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler[numZones](final quantity="HeatFlowRate",
      final unit="W")
    "Power for cooling"
    annotation (
    Placement(transformation(extent={{100,-70},{120,-50}}),iconTransformation(
    extent={{80,-100},{100,-80}})));
equation
  // if ASurTot or VAir < 0 PHeater and PCooler are set to dummy value zero
  if not (ASurTot > 0 or VAir > 0) then
    PHeater[:] = fill(0, numZones);
    PCooler[:] = fill(0, numZones);
  end if;
  // if ideal heating and/or cooling is set by seperate values
  if (ASurTot > 0 or VAir > 0) and not recOrSep then
    if Heater_on then
      connect(zone.PHeater, PHeater);
    else
      PHeater[:] = fill(0, numZones);
    end if;
    if Cooler_on then
      connect(zone.PCooler, PCooler);
    else
      PCooler[:] = fill(0, numZones);
    end if;
  // if ideal heating or cooling is set by record
  elseif (ASurTot > 0 or VAir > 0) and recOrSep then
    for i in 1:numZones loop
      if zoneParam[i].heating then
        connect(zone[i].PHeater, PHeater[i]);
        connect(TSetHeat[i], zone[i].TSetHeat);
      else
        PHeater[i] = 0;
      end if;
      if zoneParam[i].cooling then
        connect(zone[i].PCooler, PCooler[i]);
        connect(TSetCool[i], zone[i].TSetCool);
      else
        PCooler[i] = 0;
      end if;
    end for;
  end if;




  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], zone[i].intGains[1]) annotation (Line(
        points={{76,-100},{76,50.64},{75.8,50.64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 1], zone[i].intGains[2]);
    connect(intGains[(i*3)], zone[i].intGains[3]);
    connect(zone[i].weaBus, weaBus) annotation (Line(
      points={{38,81.8},{-24,81.8},{-24,69},{-100,69}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end for;
  connect(zone.intGainsConv, intGainsConv) annotation (Line(points={{80.42,70.32},
          {86,70.32},{86,-78},{66,-78},{-100,-78},{-100,-70}},
                                         color={191,0,0}));
  connect(zone.TRad, TRad) annotation (Line(points={{82.1,81.8},{94,81.8},{94,60},
          {94,59},{110,59}},     color={0,0,127}));
  connect(zone.TAir, TAir) annotation (Line(points={{82.1,85.9},{98,85.9},{98,81},
          {110,81}},     color={0,0,127}));
  connect(zone.intGainsRad, intGainsRad) annotation (Line(points={{80.42,76.47},
          {90,76.47},{90,-76},{60,-76},{-90,-76},{-90,-40},{-100,-40}},
                                                                   color={191,0,
          0}));
  connect(zone.TOpe, TOpe) annotation (Line(points={{82.1,89.59},{93.05,89.59},
          {93.05,96},{110,96}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={                                                       Text(
          extent={{-90,96},{90,136}},
          lineColor={0,0,255},
          textString="%name%"),
        Rectangle(
          extent={{-80,-100},{80,52}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,52},{0,100},{100,52},{-100,52}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={217,72,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,22},{-20,-20}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-16,-48},{16,-100}},
          lineColor={95,95,95},
          fillColor={154,77,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-58,22},{-16,26}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,22},{54,-20}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,22},{58,26}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html><ul>
  <li>September 27, 2016, by Moritz Lauster:<br/>
    Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>June 22, 2015, by Moritz Lauster:<br/>
    Changed building physics to AixLib.
  </li>
  <li>April 25, 2014, by Ole Odendahl:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Partial for <a href=
  \"AixLib.ThermalZones.ReducedOrder.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone</a>
  models. It defines connectors and a replaceable vector of <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  models. Most connectors are conditional to allow conditional
  modifications according to parameters or to pass-through conditional
  removements in <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>
  and subsequently in <a href=
  \"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.
</p>
<h4>
  Typical use and important parameters
</h4>
<p>
  The model needs parameters describing general properties of the
  building (indoor air volume, net floor area, overall surface area)
  and a vector with length of number of zones containing <a href=
  \"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a>
  records to define zone properties. The user can redeclare the thermal
  zone model choosing from <a href=
  \"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>.
  Further parameters for medium, initialization and dynamics originate
  from <a href=
  \"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.
</p>
</html>"));
end PartialMultizone;
