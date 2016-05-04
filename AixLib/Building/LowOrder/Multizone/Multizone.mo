within AixLib.Building.LowOrder.Multizone;
model Multizone
  "Multizone with an arbitrary number of thermal zones (vectorized)"
  extends AixLib.Building.LowOrder.Multizone.PartialMultizone;
  Utilities.Interfaces.Star internalGainsRad[buildingParam.numZones]
    "Radiative internal gains"
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv[
    buildingParam.numZones] "Convective internal gains" annotation (Placement(transformation(extent={{6,-100},{26,-80}}),
        iconTransformation(extent={{6,-100},{26,-80}})));
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature[buildingParam.numZones](
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0) "Ventilation and infiltration temperature"
    annotation (Placement(transformation(extent={{-128,-8},{-88,32}}),
        iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-94,16})));
  Modelica.Blocks.Interfaces.RealInput ventilationRate[buildingParam.numZones](
  final quantity="VolumeFlowRate",
  final unit="1/h") "Ventilation and infiltration rate" annotation (
      Placement(transformation(extent={{-128,-48},{-88,-8}}),
        iconTransformation(extent={{-100,-20},{-88,-8}})));
equation
  connect(zone.internalGainsRad, internalGainsRad) annotation (Line(points={{68,43.4},
          {68,43.4},{68,-66},{50,-66},{50,-90}},   color={95,95,95}));
  connect(zone.internalGainsConv, internalGainsConv) annotation (Line(points={{60,43.4},
          {62,43.4},{62,-50},{62,-52},{16,-52},{16,-90}},      color={191,0,0}));
  connect(zone.ventilationRate, ventilationRate) annotation (Line(points={{52,43},
          {52,43},{52,-28},{-108,-28}},         color={0,0,127}));
  connect(ventilationTemperature, zone.ventilationTemperature) annotation (
      Line(points={{-108,12},{-34,12},{-34,47.2},{45,47.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})),
    Documentation(revisions="<html>
<ul>
<li><i>June 22, 2015&nbsp;</i> by Moritz Lauster:<br/>Implemented</li>
</ul>
</html>",
        info="<html>
<p>This is a multizone model with a variable number of thermal zones. It adds no further functionalities. The<a href=\"AixLib.Building.LowOrder.Multizone.partialMultizone\"> partial class</a> has a replaceable<a href=\"AixLib.Building.LowOrder.ThermalZone\"> thermal zone</a> model, due to the functionalities, <a href=\"AixLib.Building.LowOrder.ThermalZone.ThermalZone\">ThermalZone</a> is the most suitable recommendation.</p>
</html>"));
end Multizone;
