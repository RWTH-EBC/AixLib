within AixLib.FastHVAC.Examples.HeatGenerators.HeatPump;
model WasteWaterHeatPumpTest
  extends Modelica.Icons.Example;
  Components.HeatGenerators.HeatPump.HeatPumpWasteWater_driven
    heatPumpWasteWater_driven(n_HeatingWater_layers=10)
    annotation (Placement(transformation(extent={{40,-72},{76,-38}})));
  Components.Storage.HeatStorage heatStorage(
    n=10,
    use_heatingCoil2=false,
    use_heatingRod=false)
    annotation (Placement(transformation(extent={{-24,-80},{-72,-34}})));
equation
  connect(heatStorage.T_layers, heatPumpWasteWater_driven.T_HeatingWaterStorage)
    annotation (Line(points={{-26.4,-57},{0,-57},{0,-70.47},{39.28,-70.47}},
        color={0,0,127}));
  connect(heatStorage.port_HC1_out, heatPumpWasteWater_driven.toHeatPump)
    annotation (Line(points={{-28.32,-52.4},{12,-52.4},{12,-63.84},{40,-63.84}},
        color={176,0,0}));
  connect(heatPumpWasteWater_driven.fromHeatPump, heatStorage.port_HC1_in)
    annotation (Line(points={{39.64,-43.1},{-16,-43.1},{-16,-43.2},{-28.8,-43.2}},
        color={176,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end WasteWaterHeatPumpTest;
