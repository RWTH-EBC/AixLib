within AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses;
model GeothermalHeatPumpControlledBase
  "Example of a geothermal heat pump system with controllers"
  extends BaseClasses.GeothermalHeatPumpBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.Boiler PeakLoadDevice(redeclare
        package Medium =                                                                                          Medium));
  Modelica.Blocks.Sources.RealExpression getTStorageUpper(y=heatStorage.layer[
        heatStorage.n].T) "Gets the temperature of upper heat storage layer"
    annotation (Placement(transformation(extent={{-160,58},{-140,78}})));
  Control.geothermalFieldController     geothermalFieldControllerHeat
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,-34},{-84,-18}})));
  Control.geothermalFieldController     geothermalFieldControllerCold(
      temperature_low=273.15 + 6, temperature_high=273.15 + 8)
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,28},{-84,44}})));
  Modelica.Blocks.Sources.RealExpression getTStorageLower(y=coldStorage.layer[1].T)
    "Gets the temperature of lower cold storage layer"
    annotation (Placement(transformation(extent={{-160,42},{-140,62}})));
  Modelica.Blocks.Interfaces.RealOutput coldStorageTemperature(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC",
    min=0,
    start=T_start_cold[1]) "Temperature in the cold storage" annotation (
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
    start=T_start_warm[heatStorage.n]) "Temperature in the heat storage"
    annotation (Placement(transformation(
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
  connect(getTStorageUpper.y, geothermalFieldControllerHeat.temperature)
    annotation (Line(points={{-139,68},{-120,68},{-120,-26},{-100,-26}}, color=
          {0,0,127}));
  connect(getTStorageLower.y, geothermalFieldControllerCold.temperature)
    annotation (Line(points={{-139,52},{-122,52},{-108,52},{-108,36},{-100,36}},
        color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening1, valveColdStorage.y)
    annotation (Line(points={{-83.04,40.8},{-82,40.8},{-82,40},{-82,52},{-82,54},
          {-52,54},{-52,46.4}}, color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening2, valveHeatSource.y)
    annotation (Line(points={{-83.04,31.2},{-82,31.2},{-82,1},{-68.4,1}}, color=
         {0,0,127}));
  connect(valveColdSource.y,geothermalFieldControllerHeat. valveOpening1)
    annotation (Line(points={{-30,-45.6},{-30,-45.6},{-30,-32},{-30,-21.2},{
          -83.04,-21.2}}, color={0,0,127}));
  connect(geothermalFieldControllerHeat.valveOpening2, valveHeatStorage.y)
    annotation (Line(points={{-83.04,-30.8},{-56,-30.8},{-56,-63},{-26.4,-63}},
        color={0,0,127}));
  connect(heatPumpTab.Power, heatPumpPower) annotation (Line(points={{-22,-12.3},
          {-22,-12.3},{-22,-40},{-45.5,-40},{-45.5,-119.5}}, color={0,0,127}));
  connect(getTStorageLower.y, coldStorageTemperature) annotation (Line(points={
          {-139,52},{-134,52},{-134,-120}}, color={0,0,127}));
  connect(getTStorageUpper.y, heatStorageTemperature) annotation (Line(points={
          {-139,68},{-132,68},{-120,68},{-120,-88},{-100,-88},{-100,-120}},
        color={0,0,127}));
  connect(PeakLoadDevice.chemicalEnergyFlowRate, chemicalEnergyFlowRate)
    annotation (Line(points={{112.77,-56.54},{112.77,-120},{-30,-120},{-30,-98},
          {-71.5,-98},{-71.5,-119.5}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=10), Documentation(info="<html>
<p>Example model demonstrating the use of the <code>AixLib</code> hydraulic components and basic controllers. This model extends <a href=\"modelica://AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpBase\">AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpBase</a>.</p>
<p>The system model is for a hydronic system with a geothermal heat pump. The heat pump transfers heat from a cold to heat storage. If the temperature in the heat storage exceeds the maximum temperature, the heat pump can be connected to the geothermal field instead. The field thus functions as a heat sink. If the temperature in the cold storage drops below the minimum, the geothermal field can be used as a heat source. </p>
<p>The heat pump is on/off-controlled. The controlled variable is always the heat storage temperature. The temperature in the cold storage is not relevant for the control of the heat pump.</p>
<p>The geothermal field can be connected to or separated from the storages by opening or closing four valves. One pair of valves is controlled by one controller which ensures that the temperature in the respective storage are not too high or too low, respectively. </p>
</html>", revisions="<html>
<ul>
<li>
May 19, 2017, by Marc Baranski:<br/>
First implementation.
</li>
</ul>
</html>"));
end GeothermalHeatPumpControlledBase;
