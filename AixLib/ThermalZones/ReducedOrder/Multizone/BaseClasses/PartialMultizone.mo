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
  replaceable model corG = SolarGain.CorrectionGDoublePane
    constrainedby
    AixLib.ThermalZones.ReducedOrder.SolarGain.BaseClasses.PartialCorrectionG
    "Model for correction of solar transmission"
    annotation(choicesAllMatching=true);
  replaceable model thermalZone =
      AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneEquipped
    constrainedby
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone
    "Thermal zone model"
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
    iconTransformation(extent={{80,29},{100,48}})));
  Modelica.Blocks.Interfaces.RealOutput TRad[size(zone, 1)](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC") if ASurTot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{100,49},{120,69}}),
    iconTransformation(extent={{80,7},{100,26}})));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,53},{-83,85}}), iconTransformation(
    extent={{-90,30},{-70,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv[size(zone, 1)] if
       ASurTot > 0 or VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
    iconTransformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad[size(zone, 1)] if
       ASurTot > 0 "Radiative internal gains"
    annotation (Placement(transformation(extent={{-110,-30},{-90,-50}}),
    iconTransformation(extent={{-90,-46},{-70,-26}})));
  thermalZone zone[numZones](
    final zoneParam=zoneParam,
    redeclare each final model corG=corG,
    each final nPorts=nPorts,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    each final mSenFac=mSenFac,
    redeclare each final package Medium = Medium)
    "Thermal zone model"
    annotation (Placement(transformation(extent={{38,49},{
    80,90}})));

equation
  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], zone[i].intGains[1]) annotation (Line(
        points={{76,-100},{76,50.64},{75.8,50.64}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 1], zone[i].intGains[2]);
    connect(intGains[(i*3)], zone[i].intGains[3]);
    connect(zone[i].weaBus, weaBus) annotation (Line(
      points={{38,69.5},{-24,69.5},{-24,69},{-100,69}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end for;
  connect(zone.intGainsConv, intGainsConv) annotation (Line(points={{80,59.25},
          {86,59.25},{86,-78},{66,-78},{-100,-78},{-100,-70}},
                                         color={191,0,0}));
  connect(zone.TRad, TRad) annotation (Line(points={{82.1,77.29},{94,77.29},{94,
          60},{94,59},{110,59}}, color={0,0,127}));
  connect(zone.TAir, TAir) annotation (Line(points={{82.1,81.8},{98,81.8},{98,
          81},{110,81}}, color={0,0,127}));
  connect(zone.intGainsRad, intGainsRad) annotation (Line(points={{80,67.45},{
          90,67.45},{90,-76},{60,-76},{-90,-76},{-90,-40},{-100,-40}},
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
    Documentation(revisions="<html>
<ul>
  <li>
  September 27, 2016, by Moritz Lauster:<br/>
  Reimplementation based on Annex60 and AixLib models.
  </li>
  <li>
  June 22, 2015, by Moritz Lauster:<br/>
  Changed building physics to AixLib.
  </li>
  <li>
  April 25, 2014, by Ole Odendahl:<br/>
  Implemented.
  </li>
</ul>
</html>", info="<html>
<p>Partial for <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone\">AixLib.ThermalZones.ReducedOrder.Multizone</a> models. It defines connectors and a replaceable vector of <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> models. Most connectors are conditional to allow conditional modifications according to parameters or to pass-through conditional removements in <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a> and subsequently in <a href=\"AixLib.ThermalZones.ReducedOrder.RC.FourElements\">AixLib.ThermalZones.ReducedOrder.RC.FourElements</a>.</p>
<h4>Typical use and important parameters</h4>
<p>The model needs parameters describing general properties of the building (indoor air volume, net floor area, overall surface area) and a vector with length of number of zones containing <a href=\"AixLib.DataBase.ThermalZones.ZoneBaseRecord\">AixLib.DataBase.ThermalZones.ZoneBaseRecord</a> records to define zone properties. The user can redeclare the thermal zone model choosing from <a href=\"AixLib.ThermalZones.ReducedOrder.ThermalZone\">AixLib.ThermalZones.ReducedOrder.ThermalZone</a>. Further parameters for medium, initialization and dynamics originate from <a href=\"AixLib.Fluid.Interfaces.LumpedVolumeDeclarations\">AixLib.Fluid.Interfaces.LumpedVolumeDeclarations</a>.</p>
</html>"));
end PartialMultizone;
