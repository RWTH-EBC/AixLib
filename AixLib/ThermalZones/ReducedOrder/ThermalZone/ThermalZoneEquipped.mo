within AixLib.ThermalZones.ReducedOrder.ThermalZone;
model ThermalZoneEquipped
  "Thermal zone model with ventilation, infiltration and internal gains"
  extends AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone;

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
  parameter Modelica.SIunits.Time TN_heater=1
    "Time constant of the heating controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Heater", enable=not recOrSep));
  parameter Boolean Cooler_on=true "Activates the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real h_cooler=0 "Upper limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real l_cooler=0 "Lower limit controller output of the cooler"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Real KR_cooler=1000 "Gain of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  parameter Modelica.SIunits.Time TN_cooler=1
    "Time constant of the cooling controller"
    annotation (Dialog(tab="IdealHeaterCooler", group="Cooler", enable=not recOrSep));
  Controls.VentilationController.VentilationController ventCont(
    final useConstantOutput=zoneParam.useConstantACHrate,
    final baseACH=zoneParam.baseACH,
    final maxUserACH=zoneParam.maxUserACH,
    final maxOverheatingACH=zoneParam.maxOverheatingACH,
    final maxSummerACH=zoneParam.maxSummerACH,
    final winterReduction=zoneParam.winterReduction,
    final Tmean_start=zoneParam.T_start) if ATot > 0 or zoneParam.VAir > 0
    "Calculates natural venitlation and infiltration"
    annotation (Placement(transformation(extent={{-72,-72},{-52,-52}})));
  Utilities.Psychrometrics.MixedTemperature mixedTemp if
    ATot > 0 or zoneParam.VAir > 0
    "Mixes temperature of infiltration flow and mechanical ventilation flow"
    annotation (Placement(transformation(extent={{-68,-28},{-48,-8}})));
  HighOrder.Components.DryAir.VarAirExchange airExc(final V=zoneParam.VAir) if
    ATot > 0 or zoneParam.VAir > 0 "Heat flow due to ventilation"
    annotation (Placement(transformation(extent={{-24,-26},{-8,-10}})));

  redeclare Utilities.Sources.InternalGains.Humans.HumanSensibleHeatAreaSpecific
    humanSenHea(
    final T0=zoneParam.T_start,
    final InternalGainsPeopleSpecific=zoneParam.internalGainsPeopleSpecific,
    final RatioConvectiveHeat=zoneParam.ratioConvectiveHeatPeople,
    final RoomArea=zoneParam.AZone) if ATot > 0
    "Internal gains from persons" annotation (choicesAllMatching=true,
      Placement(transformation(extent={{64,-36},{84,-16}})));

  redeclare Utilities.Sources.InternalGains.Machines.MachinesAreaSpecific
    machinesSenHea(
    final ratioConv=zoneParam.ratioConvectiveHeatMachines,
    final T0=zoneParam.T_start,
    final InternalGainsMachinesSpecific=zoneParam.internalGainsMachinesSpecific,
    final RoomArea=zoneParam.AZone) if ATot > 0
    "Internal gains from machines"
    annotation (Placement(transformation(extent={{64,-56},{84,-37}})));
  redeclare Utilities.Sources.InternalGains.Lights.LightsAreaSpecific lights(
    final ratioConv=zoneParam.ratioConvectiveHeatLighting,
    final T0=zoneParam.T_start,
    final LightingPower=zoneParam.lightingPowerSpecific,
    final RoomArea=zoneParam.AZone) if ATot > 0 "Internal gains from light"
    annotation (Placement(transformation(extent={{64,-76},{84,-57}})));

  Utilities.Sources.HeaterCooler.HeaterCoolerPI heaterCooler(
    each h_heater=h_heater,
    each l_heater=l_heater,
    each KR_heater=KR_heater,
    each TN_heater=TN_heater,
    each h_cooler=h_cooler,
    each l_cooler=l_cooler,
    each KR_cooler=KR_cooler,
    each TN_cooler=TN_cooler,
    final zoneParam=zoneParam,
    each recOrSep=recOrSep,
    each Heater_on=Heater_on,
    each Cooler_on=Cooler_on,
    each staOrDyn=zoneParam.withIdealThresholds) if
       ATot > 0 or zoneParam.VAir > 0 "Heater Cooler with PI control"
    annotation (Placement(transformation(extent={{20,-44},{46,-18}})));
  Utilities.Sources.HeaterCooler.HeaterCoolerController heaterCoolerController(zoneParam=
       zoneParam) if         not zoneParam.withIdealThresholds
    annotation (Placement(transformation(extent={{-6,-42},{14,-22}})));
  Modelica.Blocks.Interfaces.RealOutput PHeater(final quantity="HeatFlowRate",
      final unit="W") if                        ATot > 0 or zoneParam.VAir > 0
    "Power for heating" annotation (Placement(transformation(extent={{100,-88},{
            120,-68}}), iconTransformation(extent={{80,-80},{100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput PCooler(final quantity="HeatFlowRate",
      final unit="W") if                        ATot > 0 or zoneParam.VAir > 0
    "Power for cooling" annotation (Placement(transformation(extent={{100,-102},
            {120,-82}}), iconTransformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Interfaces.RealInput TSetCool(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for cooler" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={6,-100}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={28,-90})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Set point for heater" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={32,-100}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={50,-90})));
protected
  Modelica.Blocks.Math.Add addInfVen if ATot > 0 or zoneParam.VAir > 0
    "Combines infiltration and ventilation"
    annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-36,-38})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature preTemVen if
    ATot > 0 or zoneParam.VAir > 0
    "Prescribed temperature for ventilation"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-34,-18})));

equation
  connect(ventCont.y, addInfVen.u1) annotation (Line(
      points={{-53,-62},{-39.6,-62},{-39.6,-45.2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(intGains[1], ventCont.relOccupation) annotation (Line(points={{80,
          -113.333},{80,-78},{-72,-78},{-72,-68}},                       color=
          {0,0,127}));
  connect(ventRate, addInfVen.u2) annotation (Line(points={{-72,-100},{-72,-76},
          {-32.4,-76},{-32.4,-45.2}}, color={0,0,127}));
  connect(ventCont.y, mixedTemp.flowRate_flow2) annotation (Line(points={{-53,-62},
          {-51,-62},{-51,-30},{-72,-30},{-72,-25},{-67.6,-25}}, color={0,0,127}));
  connect(ventRate, mixedTemp.flowRate_flow1) annotation (Line(points={{-72,-100},
          {-76,-100},{-76,-15},{-67.6,-15}}, color={0,0,127}));
  connect(ventTemp, mixedTemp.temperature_flow1) annotation (Line(points={{-100,
          -40},{-78,-40},{-78,-10.2},{-67.6,-10.2}}, color={0,0,127}));
  connect(ROM.TAir, ventCont.Tzone) annotation (Line(points={{87,62},{88,62},{88,
          -6},{50,-6},{50,-50},{-72,-50},{-72,-56}},              color={0,0,
          127}));
  connect(preTemVen.port, airExc.port_a)
    annotation (Line(points={{-28,-18},{-24,-18}},           color={191,0,0}));
  connect(mixedTemp.mixedTemperatureOut, preTemVen.T)
    annotation (Line(points={{-48,-18},{-41.2,-18}}, color={0,0,127}));
  connect(addInfVen.y, airExc.InPort1) annotation (Line(points={{-36,-31.4},{-36,
          -28},{-26,-28},{-26,-23.12},{-23.2,-23.12}},             color={0,0,
          127}));
  connect(airExc.port_b, ROM.intGainsConv) annotation (Line(points={{-8,-18},{42,
          -18},{42,-2},{90,-2},{90,50},{86,50}},
                                               color={191,0,0}));
  connect(weaBus.TDryBul, mixedTemp.temperature_flow2) annotation (Line(
      points={{-100,34},{-88,34},{-88,-20},{-67.6,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(weaBus.TDryBul, ventCont.Tambient) annotation (Line(
      points={{-100,34},{-88,34},{-88,-20},{-80,-20},{-80,-62},{-72,-62}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heaterCoolerController.heaterActive,heaterCooler. heaterActive)
    annotation (Line(points={{12.2,-30},{14,-30},{14,-42},{41.84,-42},{41.84,-40.36}},
                           color={255,0,255}));
  connect(heaterCoolerController.coolerActive,heaterCooler. coolerActive)
    annotation (Line(points={{12.2,-34},{12,-34},{12,-42},{23.9,-42},{23.9,-40.36}},
                    color={255,0,255}));
  connect(heaterCooler.coolingPower, PCooler) annotation (Line(points={{46,-31.78},
          {46,-84},{98,-84},{98,-92},{110,-92}}, color={0,0,127}));
  connect(heaterCooler.heatingPower, PHeater) annotation (Line(points={{46,-25.8},
          {46,-84},{98,-84},{98,-78},{110,-78}}, color={0,0,127}));
  connect(weaBus, heaterCoolerController.weaBus) annotation (Line(
      points={{-100,34},{-100,-82},{-8,-82},{-8,-27.7},{-3.7,-27.7}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(heaterCooler.heatCoolRoom, intGainsConv) annotation (Line(points={{44.7,
          -36.2},{46,-36.2},{46,-2},{104,-2}}, color={191,0,0}));
  connect(TSetHeat, heaterCooler.setPointHeat) annotation (Line(points={{32,-100},
          {32,-71},{35.86,-71},{35.86,-40.36}}, color={0,0,127}));
  connect(TSetCool, heaterCooler.setPointCool) annotation (Line(points={{6,-100},
          {6,-70},{29.88,-70},{29.88,-40.36}}, color={0,0,127}));
  annotation(Documentation(info="<html>
<p>Comprehensive ready-to-use model for thermal zones, combining caclulation core, handling of solar radiation, internal gains and in addition to <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZone</a> models for infiltration and natural ventilation. Core model is a <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a> model. Conditional removements of the core model are passed-through and related models on thermal zone level are as well conditional. All models for solar radiation are part of Annex60 library. Internal gains are part of AixLib.</p>
<h4>Typical use and important parameters</h4>
<p>All parameters are collected in one <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> record. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>. A typical use case is a single thermal zone including infiltration and vnetilation connected via heat ports and fluid ports to a heating system. The thermal zone model serves as boundary condition for the heating system and calculates the room&apos;s reaction to external and internal heat sources. The model is used as thermal zone core model in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone\">AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses.PartialMultizone</a></p>
<h4>References</h4>
<p>For automatic generation of thermal zone and multizone models as well as for datasets, see <a href=\"https://github.com/RWTH-EBC/TEASER\">https://github.com/RWTH-EBC/TEASER</a></p>
<ul>
<li>German Association of Engineers: Guideline VDI 6007-1, March 2012: Calculation of transient thermal response of rooms and buildings - Modelling of rooms. </li>
<li>Lauster, M.; Teichmann, J.; Fuchs, M.; Streblow, R.; Mueller, D. (2014): Low order thermal network models for dynamic simulations of buildings on city district scale. In: Building and Environment 73, p. 223&ndash;231. DOI: <a href=\"http://dx.doi.org/10.1016/j.buildenv.2013.12.016\">10.1016/j.buildenv.2013.12.016</a>. </li>
</ul>
<h4>Examples</h4>
<p>See <a href=\"AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneEquipped\">AixLib.ThermalZones.ReducedOrder.Examples.ThermalZoneEquipped</a>. </p>
</html>",  revisions="<html>
<ul>
  <li>
  March 01, 2019, by Niklas Huelsenbeck:<br/>
  Changes due to integration of new Internal Gains models in ThermalZone.
  </li>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation based on Annex60 and MSL models.
  </li>
  <li>
  March, 2012, by Moritz Lauster:<br/>
  First implementation.
  </li>
</ul>
</html>"), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
  Rectangle(
    extent={{-81,-8},{-8,-80}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid),
  Text(
    extent={{-30,-69},{-7,-80}},
    lineColor={0,0,255},
    fillColor={215,215,215},
    fillPattern=FillPattern.Solid,
          textString="Ventilation
Infiltration
"),     Rectangle(
          extent={{-6,-20},{52,-42}},
          lineColor={0,0,255},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{6,-20},{30,-28}},
          lineColor={0,0,255},
          fillColor={212,221,253},
          fillPattern=FillPattern.Solid,
          textString="Heating
Cooling")}));
end ThermalZoneEquipped;
