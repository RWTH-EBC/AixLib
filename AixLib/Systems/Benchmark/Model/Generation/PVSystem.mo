within AixLib.Systems.Benchmark.Model.Generation;
model PVSystem

  Electrical.PVSystem.PVSystem pVSystem(
    NumberOfPanels=50*9,
    data=DataBase.SolarElectric.SymphonyEnergySE6M181(),
    MaxOutputPower=50*9*250)
    annotation (Placement(transformation(extent={{-26,66},{-6,86}})));
  Modelica.Blocks.Math.Gain gain2(k=-1)
    annotation (Placement(transformation(extent={{76,70},{88,82}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-52,-120},{-12,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput AirTemp
    annotation (Placement(transformation(extent={{-128,44},{-88,84}})));
  Utilities.Interfaces.SolarRad_in solarRad_in
    annotation (Placement(transformation(extent={{-116,-26},{-96,-6}})));
equation
  connect(pVSystem.PVPowerW,gain2. u)
    annotation (Line(points={{-5,76},{74.8,76}},   color={0,0,127}));
  connect(gain2.y,measureBus. PV_Power) annotation (Line(points={{88.6,76},{96,
          76},{96,-100},{-31.9,-100},{-31.9,-99.9}},
        color={0,0,127}));
  connect(AirTemp, pVSystem.TOutside) annotation (Line(points={{-108,64},{-70,
          64},{-70,83.6},{-28,83.6}}, color={0,0,127}));
  connect(solarRad_in, pVSystem.IcTotalRad) annotation (Line(points={{-106,-16},
          {-68,-16},{-68,75.5},{-27.8,75.5}}, color={255,128,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVSystem;
