within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
partial model PartialMultizone "Partial model for multizone models"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer buildingID
    "Unique identifier of the building";
  parameter Modelica.Units.SI.Volume VAir(min=0)
    "Indoor air volume of building";
  parameter Modelica.Units.SI.Area ABuilding(min=0)
    "Net floor area of building";
  parameter Modelica.Units.SI.Area ASurTot(min=0)
    "Total surface area of building walls and windows (including interior walls)";
  parameter Integer numZones(min=1)
    "Number of zones";
  parameter Integer nZonCon(min=0) = 1
    "Actual number of adjacent zone connectors";
  parameter Integer zonConPaiArr[max(nZonCon, 1),2]=fill(1, max(nZonCon, 1), 2)
    "List of pairs of interzonal element indices to connect, each index pointing to a concatenated array of all ThermalZones' interzonal element ports";
  replaceable parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Setup for zones" annotation (choicesAllMatching=false);

  parameter Integer nPorts = 0
    "Number of fluid ports"  annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));

  parameter Boolean use_izeCon=false
    "Consider heat flow connection between interzonal elements of thermal zones by setting true";
  parameter Boolean use_MechanicalAirExchange=true
    "Consider mechanical ventilation by setting true";
  parameter Boolean use_NaturalAirExchange=use_MechanicalAirExchange
    "Consider natural ventilation and infiltration by setting true";
  parameter Boolean use_C_flow=false
    "Set to true to enable input connector for trace substance"
    annotation (Dialog(tab="CO2"));
  parameter Modelica.Units.SI.MassFraction XCO2_amb=6.12157E-4
    "Massfraction of CO2 in atmosphere (equals 403ppm)"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.Units.SI.Area areaBod=1.8
    "Body surface area source SIA 2024:2015"
    annotation (Dialog(tab="CO2", enable=use_C_flow));
  parameter Modelica.Units.SI.DensityOfHeatFlowRate metOnePerSit=58
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
  Modelica.Blocks.Interfaces.RealOutput TAir[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC") if ASurTot > 0 or VAir > 0
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,71},{120,91}}),
        iconTransformation(extent={{80,19},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput TRad[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC") if ASurTot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{100,49},{120,69}}),
        iconTransformation(extent={{80,0},{100,20}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,53},{-83,85}}), iconTransformation(
    extent={{-90,30},{-70,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv[size(zone, 1)]
    if ASurTot > 0 or VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
        iconTransformation(extent={{-90,-92},{-70,-72}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad[size(zone, 1)]
    if ASurTot > 0 "Radiative internal gains"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-50}}),
        iconTransformation(extent={{-90,-60},{-70,-40}})));
  AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone zone[numZones](
    each use_NaturalAirExchange=use_NaturalAirExchange,
    each use_MechanicalAirExchange=use_MechanicalAirExchange,
    each recOrSep=recOrSep,
    each Heater_on=Heater_on,
    each h_heater=h_heater,
    each l_heater=l_heater,
    each KR_heater=KR_heater,
    each TN_heater=TN_heater,
    each Cooler_on=Cooler_on,
    each h_cooler=h_cooler,
    each l_cooler=l_cooler,
    each KR_cooler=KR_cooler,
    each TN_cooler=TN_cooler,
    each use_C_flow=use_C_flow,
    each use_moisture_balance=use_moisture_balance,
    each XCO2_amb=XCO2_amb,
    each areaBod=areaBod,
    each metOnePerSit=metOnePerSit,
    final zoneParam=zoneParam,
    redeclare each final model corG = corG,
    each final internalGainsMode=internalGainsMode,
    redeclare package MediumPoolWater = MediumPoolWater,
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
  parameter Boolean recOrSep=true "Use record or seperate parameters"
    annotation (Dialog(tab="IdealHeaterCooler", group="Modes"), choices(choice =  false
        "Seperate",choice = true "Record",radioButtons = true));
  parameter Boolean Heater_on=true "Activates the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real h_heater=0 "Upper limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real l_heater=0 "Lower limit controller output of the heater"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Real KR_heater=1000 "Gain of the heating controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_heater=1
    "Time constant of the heating controller" annotation (Dialog(
      tab="IdealHeaterCooler",
      group="Heater",
      enable=not recOrSep));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler=1000 "Gain of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Modelica.Units.SI.Time TN_cooler=1
    "Time constant of the cooling controller" annotation (Dialog(
      tab="IdealHeaterCooler",
      group="Cooler",
      enable=not recOrSep));

  //Swimming pool params
  parameter Boolean use_pools_tot = false "use swimming pools within at least one zone of the multizone" annotation(Dialog(tab="Moisture", group="Pools"));
  replaceable package MediumPoolWater = Media.Water annotation (choices(choice(redeclare
          package Medium =
            AixLib.Media.Water
              "Water")), Dialog(enable=use_pools_tot,tab="Moisture", group="Pools"));

  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0) "Set point for heater - used only if zoneParam[i].HeaterOn is true"
    annotation (Placement(transformation(
    extent={{20,-20},{-20,20}},
    rotation=270,
    origin={-40,-100}), iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=270,
    origin={-52,-110})));


  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0) "Set point for cooler - used only if zoneParam[i].CoolerOn is true"
    annotation (Placement(transformation(
    extent={{20,-20},{-20,20}},
    rotation=270,
    origin={-80,-100}), iconTransformation(
    extent={{10,-10},{-10,10}},
    rotation=270,
    origin={-74,-110})));
  Modelica.Blocks.Interfaces.RealOutput PHeater[numZones](each final quantity="HeatFlowRate",
      each final unit="W")
    "Power for heating"
    annotation (
    Placement(transformation(extent={{100,-56},{120,-36}}),
    iconTransformation(extent={{80,-80},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler[numZones](each final quantity="HeatFlowRate",
      each final unit="W")
    "Power for cooling"
    annotation (
    Placement(transformation(extent={{100,-70},{120,-50}}),iconTransformation(
    extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Interfaces.RealOutput QIntGains_flow[numZones,3](each final
      quantity="HeatFlowRate", each final unit="W") if ASurTot > 0 or VAir > 0
    "Heat flow based on internal gains for each zone from lights[1], machines[2], and persons[3]"
                        annotation (Placement(transformation(extent={{100,-90},{
            120,-70}}), iconTransformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Interfaces.RealInput timeOpe
    if use_moisture_balance and use_pools_tot
    "Input profiles for opening hours for pools" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={42,-102}),
        iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={38,-110})));
  AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.FlowArrayRearranging
    izeArrCon(nCon=max(nZonCon, 1), conPaiArr=zonConPaiArr)
    if numZones > 1 and use_izeCon and nZonCon > 0
    "Distributor for connection between adjacent zones" annotation (Placement(
        transformation(extent={{-4,-4},{4,4}})));
equation
  // if ASurTot or VAir < 0 PHeater and PCooler are set to dummy value zero
  if not (ASurTot > 0 or VAir > 0) then
    PHeater[:] = fill(0, numZones);
    PCooler[:] = fill(0, numZones);
  else
    for i in 1:numZones loop
      connect(zone[i].QIntGains_flow, QIntGains_flow[i, :]);
    end for;
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
      if zoneParam[i].HeaterOn then
        connect(zone[i].PHeater, PHeater[i]);
        connect(TSetHeat[i], zone[i].TSetHeat);
      else
        PHeater[i] = 0;
      end if;
      if zoneParam[i].CoolerOn then
        connect(zone[i].PCooler, PCooler[i]);
        connect(TSetCool[i], zone[i].TSetCool);
      else
        PCooler[i] = 0;
      end if;
    end for;
  end if;

  // connect heat flow between zones
  if numZones > 1 and use_izeCon and nZonCon > 0 then
    for i in 1:numZones loop
      connect(zone[i].izeHeaFlow[1:zoneParam[i].nIze], izeArrCon.splPor[
        sum(zoneParam[1:i - 1].nIze) + 1:(sum(zoneParam[1:i - 1].nIze) +
        zoneParam[i].nIze)]);
    end for;
  end if;

  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], zone[i].intGains[1]) annotation (Line(
        points={{76,-100},{76,51.46},{75.8,51.46}},
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
    if zone[i].use_pools then
      connect(timeOpe,zone[i].timeOpe) annotation (Line(
        points={{42,-102},{42,52.28},{44.3,52.28}},
        color={0,0,127},
        smooth=Smooth.None));
    end if;
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
  <li>November 3, 2024, by Philip Groesdonk:<br/>
    Added interzonal connections. This is for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1080\">issue 1080</a>.
  </li>
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
