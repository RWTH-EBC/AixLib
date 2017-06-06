within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model Boiler "Contains the simple boiler model as peak load device"
  extends Interfaces.PartialTwoPort;


  BoilerCHP.Boiler                   boiler(                                redeclare
      final package
              Medium =
        Medium,                                                               m_flow_nominal=0.5,
    paramHC=AixLib.DataBase.Boiler.DayNightMode.HeatingCurves_Vitotronic_Day23_Night10(),
    paramBoiler=AixLib.DataBase.Boiler.General.Boiler_Vitogas200F_11kW())
    "Peak load energy conversion unit"
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,0})));
  Modelica.Blocks.Sources.BooleanConstant falseSource(k=false)
    "Outputs a false signal"
    annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-94,34})));
  Modelica.Blocks.Sources.BooleanConstant trueSource "Outputs a true signal"
    annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=180,
        origin={94,-40})));
  Modelica.Blocks.Sources.Constant ambientTemperature(k=273.15 + 10)
    "Dummy for ambient temperature"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-94,60})));
  Modelica.Blocks.Interfaces.RealOutput chemicalEnergyFlowRate(final unit="W")
    "Flow of primary (chemical) energy into boiler " annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-19.5,-109.5}), iconTransformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20.5,-109})));
  Modelica.Blocks.Sources.RealExpression chemicalEnergyFlowRateSource(y=boiler.internalControl.ControlerHeater.y)
    "Outputs the chemical energy flow rate of the boiler"
    annotation (Placement(transformation(extent={{-60,-72},{-40,-52}})));
equation
  connect(port_a, boiler.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(boiler.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  connect(ambientTemperature.y, boiler.TAmbient) annotation (Line(points={{-87.4,
          60},{-74,60},{-60,60},{-60,7},{-7,7}}, color={0,0,127}));
  connect(trueSource.y, boiler.isOn)
    annotation (Line(points={{87.4,-40},{5,-40},{5,-9}}, color={255,0,255}));
  connect(falseSource.y, boiler.switchToNightMode) annotation (Line(points={{-87.4,
          34},{-66,34},{-66,4},{-7,4}}, color={255,0,255}));
  connect(chemicalEnergyFlowRateSource.y, chemicalEnergyFlowRate) annotation (
      Line(points={{-39,-62},{-19.5,-62},{-19.5,-109.5}}, color={0,0,127}));
end Boiler;
