within AixLib.Fluid.Examples.GeothermalHeatPump.Components;
model BoilerStandAlone
  "Model containing the simple boiler model and all required inputs as dummies"
  extends BaseClasses.BoilerBase;
  Modelica.Blocks.Sources.BooleanConstant falseSource(k=false)
    "Outputs a false signal"
    annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-94,40})));
  Modelica.Blocks.Sources.Constant ambientTemperature(k=273.15 + 10)
    "Dummy for ambient temperature"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-94,66})));
  Modelica.Blocks.Sources.BooleanConstant trueSource "Outputs a true signal"
    annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=180,
        origin={94,-34})));
  Modelica.Blocks.Interfaces.RealOutput chemicalEnergyFlowRate(final unit="W")
    "Flow of primary (chemical) energy into boiler " annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0.5,-109.5}),   iconTransformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20.5,-109})));
equation
  connect(ambientTemperature.y, boiler.TAmbient) annotation (Line(points={{-87.4,
          66},{-74,66},{-60,66},{-60,7},{-7,7}}, color={0,0,127}));
  connect(falseSource.y, boiler.switchToNightMode) annotation (Line(points={{-87.4,
          40},{-66,40},{-66,4},{-7,4}}, color={255,0,255}));
  connect(trueSource.y, boiler.isOn)
    annotation (Line(points={{87.4,-34},{5,-34},{5,-9}}, color={255,0,255}));
  connect(chemicalEnergyFlowRateSource.y,chemicalEnergyFlowRate)  annotation (
      Line(points={{-39,-56},{0.5,-56},{0.5,-109.5}},     color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Model containing the simple boiler model <a href=
  \"modelica://AixLib.Fluid.BoilerCHP.Boiler\">AixLib.Fluid.BoilerCHP.Boiler</a>
  and dummy inputs.
</p>
</html>"));
end BoilerStandAlone;
