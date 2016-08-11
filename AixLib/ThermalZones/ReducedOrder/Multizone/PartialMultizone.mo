within AixLib.ThermalZones.ReducedOrder.Multizone;
partial model PartialMultizone "Partial class for multizone models"
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter AixLib.DataBase.Buildings.BuildingBaseRecordNew buildingParam
    "Choose setup for the building" annotation (choicesAllMatching = false);
  parameter Integer nPorts=0
    "Number of fluid ports"
    annotation(Evaluate=true,
    Dialog(connectorSizing=true, tab="General",group="Ports"));
  BoundaryConditions.WeatherData.Bus weaBus
    "Weather data bus"
    annotation (Placement(
    transformation(extent={{-117,39},{-83,71}}), iconTransformation(
    extent={{-70,-12},{-50,8}})));
  Modelica.Blocks.Interfaces.RealInput intGains[3*buildingParam.numZones]
    "Input profiles for internal gains persons, machines, light" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=-90,
        origin={76,-100}), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=90,
        origin={87,-97})));
  Modelica.Fluid.Vessels.BaseClasses.VesselFluidPorts_b ports[nPorts]
    annotation (Placement(transformation(extent={{-52,-106},{52,-82}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsConv[size(zone, 1)]
    "Convective internal gains"
    annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a intGainsRad[size(zone, 1)]
    "Convective internal gains"
    annotation (Placement(transformation(extent={{90,-26},{110,-6}})));
  Modelica.Blocks.Interfaces.RealOutput TAir[size(zone, 1)]
    "Indoor air temperature"
    annotation (Placement(transformation(extent={{100,57},{120,77}})));
  Modelica.Blocks.Interfaces.RealOutput TRad[size(zone, 1)]
    "Mean indoor radiation temperature"
    annotation (Placement(transformation(extent={{100,5},{120,25}})));
  replaceable AixLib.ThermalZones.ReducedOrder.ThermalZone.ThermalZoneEquipped zone[buildingParam.numZones](nPorts=
        nPorts)                                                                                             constrainedby
    AixLib.ThermalZones.ReducedOrder.ThermalZone.PartialThermalZone(zoneParam=zoneParam)
    "Choose thermal zone model" annotation (Placement(transformation(extent={{38,35},
            {80,76}})),choicesAllMatching=true);

protected
  parameter AixLib.DataBase.Buildings.ZoneBaseRecordNew zoneParam[:]=buildingParam.zoneSetup
    "Choose setup for zones" annotation (choicesAllMatching=false);

equation
  for i in 1:buildingParam.numZones loop
    connect(intGains[(i*3) - 2], zone[i].internalGains[1]) annotation (Line(
        points={{76,-100},{76,41.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(intGains[(i*3) - 1], zone[i].internalGains[2]);
    connect(intGains[(i*3)], zone[i].internalGains[3]);
    connect(zone[i].weaBus, weaBus) annotation (Line(
      points={{46.4,55.09},{-24,55.09},{-24,55},{-100,55}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  end for;
  connect(zone.ports, ports) annotation (Line(points={{62.99,43.2},{62.99,-46},{
          0,-46},{0,-94}}, color={0,127,255}));
  connect(zone.intGainsConv, intGainsConv) annotation (Line(points={{80,48.94},{
          86,48.94},{86,-50},{100,-50}}, color={191,0,0}));
  connect(zone.intGainsRad, intGainsRad) annotation (Line(points={{80,55.5},{90,
          55.5},{90,-16},{100,-16}}, color={191,0,0}));
  connect(zone.TAir, TAir) annotation (Line(points={{82.1,66.98},{89.05,66.98},{
          89.05,67},{110,67}}, color={0,0,127}));
  connect(zone.TRad, TRad) annotation (Line(points={{82.1,61.24},{94,61.24},{94,
          60},{94,15},{110,15}}, color={0,0,127}));
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
