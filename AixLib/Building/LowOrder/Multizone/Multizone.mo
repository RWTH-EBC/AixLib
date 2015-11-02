within AixLib.Building.LowOrder.Multizone;
model Multizone
  "Multizone with an arbitrary number of thermal zones (vectorized)"
  extends AixLib.Building.LowOrder.Multizone.partialMultizone(redeclare
      ThermalZone.ThermalZone zone);

  Utilities.Interfaces.Star internalGainsRad[buildingParam.numZones]
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a internalGainsConv[
    buildingParam.numZones] annotation (Placement(transformation(extent={{6,-100},{26,-80}}),
        iconTransformation(extent={{6,-100},{26,-80}})));
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature[buildingParam.numZones]
    annotation (Placement(transformation(extent={{-128,-8},{-88,32}}),
        iconTransformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-94,16})));
  Modelica.Blocks.Interfaces.RealInput ventilationRate[buildingParam.numZones] annotation (
      Placement(transformation(extent={{-128,-48},{-88,-8}}),
        iconTransformation(extent={{-100,-20},{-88,-8}})));
equation
  connect(zone.internalGainsRad, internalGainsRad) annotation (Line(points={{68,
          37},{68,38},{68,-66},{50,-66},{50,-90}}, color={95,95,95}));
  connect(zone.internalGainsConv, internalGainsConv) annotation (Line(points={{
          60,37},{62,37},{62,-50},{62,-52},{16,-52},{16,-90}}, color={191,0,0}));
  connect(zone.ventilationRate, ventilationRate) annotation (Line(points={{52,
          37.4},{52,37.4},{52,-28},{-108,-28}}, color={0,0,127}));
  connect(ventilationTemperature, zone.ventilationTemperature) annotation (
      Line(points={{-108,12},{-34,12},{-34,47.2},{45,47.2}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end Multizone;
