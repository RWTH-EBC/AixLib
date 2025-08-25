within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
partial model GeothermalHeatPumpControlledBase
  "Example of a geothermal heat pump system with controllers"
  extends BaseClasses.GeothermalHeatPumpBase;
  Modelica.Blocks.Sources.RealExpression getTStorageUpper(y=heatStorage.layer[
        heatStorage.n].T) "Gets the temperature of upper heat storage layer"
    annotation (Placement(transformation(extent={{-160,58},{-140,78}})));
  Modelica.Blocks.Sources.RealExpression getTStorageLower(y=coldStorage.layer[1].T)
    "Gets the temperature of lower cold storage layer"
    annotation (Placement(transformation(extent={{-160,42},{-140,62}})));
  Modelica.Blocks.Interfaces.RealOutput coldStorageTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0,
    start=T_start_cold) "Temperature in the cold storage" annotation (
      Placement(transformation(
        origin={-134,-120},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-100,-110})));
  Modelica.Blocks.Interfaces.RealOutput heatStorageTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0,
    start=T_start_hot) "Temperature in the heat storage" annotation (Placement(
        transformation(
        origin={-100,-120},
        extent={{10,-10},{-10,10}},
        rotation=90), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-140,-110})));
  Modelica.Blocks.Interfaces.RealOutput chemicalEnergyFlowRate(final unit="W")
    "Flow of primary (chemical) energy into boiler " annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-71.5,-119.5}), iconTransformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-20.5,-109})));
  Modelica.Blocks.Interfaces.RealOutput heatPumpPower(final unit="W")
    "Electrical power of the heat pump" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={-45.5,-119.5}), iconTransformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-60.5,-109})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
equation
  connect(getTStorageLower.y, coldStorageTemperature) annotation (Line(points={
          {-139,52},{-134,52},{-134,-120}}, color={0,0,127}));
  connect(getTStorageUpper.y, heatStorageTemperature) annotation (Line(points={
          {-139,68},{-132,68},{-120,68},{-120,-88},{-100,-88},{-100,-120}},
        color={0,0,127}));
  connect(heatPumpPower, heatPumpControlBus.PelMea) annotation (Line(points={{-45.5,
          -119.5},{-45.5,-80},{-110,-80},{-110,64},{-94,64},{-94,79.095},{-0.3975,
          79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (experiment(StopTime=86400, Interval=10), Documentation(info="<html><p>
  Base class of an example demonstrating the use of a heat pump
  connected to two storages and a geothermal source. A replaceable
  model is connected in the flow line of the heating circuit. A peak
  load device can be added here. This model also includes basic
  controllers.
</p>
<ul>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end GeothermalHeatPumpControlledBase;
