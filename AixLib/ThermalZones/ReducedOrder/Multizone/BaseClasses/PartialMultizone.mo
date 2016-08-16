within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
partial model PartialMultizone "Partial model for multizone models"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Integer buildingID "Unique identifier of the building";
  parameter Modelica.SIunits.Volume VAir(min=0) "Indoor air volume of building";
  parameter Modelica.SIunits.Area ABuilding(min=0) "Net floor area of building";
  parameter Modelica.SIunits.Area ASurTot(min=0) "Total surface area of building walls and windows (including interior walls)";
  parameter Integer numZones(min=1)
    "Number of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[:]
    "Setup for zones" annotation (choicesAllMatching=false);
  parameter Integer nPorts=0
    "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,53},{-83,85}}), iconTransformation(
    extent={{-110,44},{-90,64}})));
  Modelica.Blocks.Interfaces.RealInput intGains[3*numZones]
    "Input profiles for internal gains persons, machines, light" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={76,-100}), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={53,-99})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts*numZones]
    "Auxilliary fluid inlets and outlets to indoor air volume"
    annotation (Placement(transformation(extent={{-40,-109},{38,-91}}),
        iconTransformation(extent={{-24,-105},{38,-91}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv[size(zone, 1)] if ASurTot > 0 or VAir > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-110,-80},{-90,-60}}),
        iconTransformation(extent={{-110,-80},{-90,-60}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad[size(zone, 1)] if ASurTot > 0
    "Convective internal gains"
    annotation (Placement(transformation(extent={{-110,-26},{-90,-46}}),
        iconTransformation(extent={{-110,-46},{-90,-26}})));
  Modelica.Blocks.Interfaces.RealOutput TAir[size(zone, 1)] if ASurTot > 0 or VAir > 0
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,57},{120,77}})));
  Modelica.Blocks.Interfaces.RealOutput TRad[size(zone, 1)] if ASurTot > 0
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{100,29},{120,49}})));
  replaceable AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneEquipped zone[numZones] constrainedby
    AixLib.ThermalZones.ReducedOrder.ThermalZone.BaseClasses.PartialThermalZone(
                                                                    zoneParam=zoneParam, each nPorts=nPorts)
    "Thermal zone model" annotation (Placement(transformation(extent={{38,49},{
            80,90}})), choicesAllMatching=true);

equation
  for i in 1:numZones loop
    connect(intGains[(i*3) - 2], zone[i].intGains[1]) annotation (Line(
        points={{76,-100},{76,55.56},{75.8,55.56}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 1], zone[i].intGains[2]);
    connect(intGains[(i*3)], zone[i].intGains[3]);
    connect(zone[i].weaBus, weaBus) annotation (Line(
      points={{46.4,69.09},{-24,69.09},{-24,69},{-100,69}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
    if nPorts > 0 then
      connect(zone[i].ports[nPorts], ports[nPorts*(i-1)+1:nPorts*i]) annotation (Line(points={{62.99,
              57.2},{62.99,-46},{-1,-46},{-1,-100}},
                           color={0,127,255}));
    end if;
  end for;
  connect(zone.intGainsConv, intGainsConv) annotation (Line(points={{80,62.94},
          {86,62.94},{86,-78},{66,-78},{-92,-78},{-92,-70},{-100,-70}},
                                         color={191,0,0}));
  connect(zone.TRad, TRad) annotation (Line(points={{82.1,75.24},{94,75.24},{94,
          60},{94,39},{110,39}}, color={0,0,127}));
  connect(zone.TAir, TAir) annotation (Line(points={{82.1,80.98},{98,80.98},{98,
          67},{110,67}}, color={0,0,127}));
  connect(zone.intGainsRad, intGainsRad) annotation (Line(points={{80,69.5},{90,
          69.5},{90,-76},{60,-76},{-90,-76},{-90,-36},{-100,-36}}, color={191,0,
          0}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}})),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
         graphics={                                                       Text(
          extent={{-80,-150},{100,-110}},
          lineColor={0,0,255},
          textString="%name%"),
        Rectangle(
          extent={{-60,-80},{60,40}},
          lineColor={95,95,95},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-80,40},{0,80},{80,40},{-80,40}},
          lineColor={95,95,95},
          smooth=Smooth.None,
          fillColor={217,72,72},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-38,20},{-8,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,20},{40,-16}},
          lineColor={95,95,95},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-12,-44},{12,-80}},
          lineColor={95,95,95},
          fillColor={154,77,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,20},{-4,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,20},{44,24}},
          lineColor={95,95,95},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid)}),
    Documentation(revisions="<html>
<ul>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br/>Changed building physics to AixLib</li>
<li><i>April 25, 2014&nbsp;</i> by Ole Odendahl:<br/>Implemented</li>
</ul>
</html>", info="<html>
<p>This is a partial model for multi-zone models. It defines connectors and a replaceable thermal zone model.</p>
</html>"));
end PartialMultizone;
