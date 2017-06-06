within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"
  extends BaseClasses.GeothermalHeatPumpBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.Boiler PeakLoadDevice(redeclare
        package                                                                                          Medium = Medium));
  Sources.Boundary_pT coldConsumerFlow(redeclare package Medium = Medium,
      nPorts=1) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,-20})));
  Sources.Boundary_pT heatConsumerFlow(redeclare package Medium = Medium,
      nPorts=1) "Sink representing heat consumer"
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={156,-50})));
  Sources.Boundary_pT heatConsumerReturn(redeclare package Medium = Medium,
      nPorts=1,
    T=303.15) "Source representing heat consumer"
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,-106})));
  Sources.Boundary_pT coldConsumerReturn(redeclare package Medium = Medium,
      nPorts=1,
    T=290.15) "Source representing cold consumer"
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,32})));
  Modelica.Blocks.Sources.Constant pressureDifference(k=20000)
    "Pressure difference used for all pumps"                   annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,6})));
  Controls.HeatPump.HPControllerOnOff hPControllerOnOff(bandwidth=5)
    "Controls the temperature in the heat storage by switching the heat pump on or off"
    annotation (Placement(transformation(extent={{-62,62},{-42,82}})));
  Modelica.Blocks.Sources.RealExpression TStorageUpper(y=heatStorage.layer[
        heatStorage.n].T) "Temperature of upper heat storage layer"
    annotation (Placement(transformation(extent={{-160,58},{-140,78}})));
  Modelica.Blocks.Sources.Constant TStorageSet(k=273.15 + 35)
    "Set point of upper heat storage temperature"
    annotation (Placement(transformation(extent={{-160,4},{-148,16}})));
  BaseClasses.geothermalFieldController geothermalFieldControllerWarm
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,-34},{-84,-18}})));
  BaseClasses.geothermalFieldController geothermalFieldControllerCold(
      temperature_low=273.15 + 6, temperature_high=273.15 + 8)
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,28},{-84,44}})));
  Modelica.Blocks.Sources.RealExpression TStorageLower(y=coldStorage.layer[1].T)
    "Temperature of lower cold storage layer"
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
  connect(resistanceColdConsumerFlow.port_b, coldConsumerFlow.ports[1])
    annotation (Line(points={{94,-20},{122,-20},{148,-20}}, color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64.86,6},{64.86,-11.6}},        color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{56,6},{56,-36},{62.86,-36},{62.86,-41.6}},        color={0,
          0,127}));
  connect(resistanceColdConsumerReturn.port_a, coldConsumerReturn.ports[1])
    annotation (Line(points={{94,32},{148,32}}, color={0,127,255}));
  connect(resistanceHeatConsumerReturn.port_a, heatConsumerReturn.ports[1])
    annotation (Line(points={{94,-106},{94,-106},{148,-106}}, color={0,127,255}));
  connect(pressureDifference.y, pumpEvaporator.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64,6},{64,54},{7.14,54},{7.14,44.4}},        color={0,0,
          127}));
  connect(pressureDifference.y, pumpCondenser.dp_in) annotation (Line(points={{147.4,6},
          {56,6},{56,-36},{-0.86,-36},{-0.86,-89.6}},         color={0,0,127}));
  connect(pumpGeothermalSource.dp_in, pressureDifference.y) annotation (Line(
        points={{-89.14,-45.6},{-89.14,-36},{56,-36},{56,6},{147.4,6}},color={0,
          0,127}));
  connect(TStorageSet.y, hPControllerOnOff.T_meas) annotation (Line(points={{-147.4,
          10},{-116,10},{-116,76},{-62,76}}, color={0,0,127}));
  connect(TStorageUpper.y, hPControllerOnOff.T_set) annotation (Line(points={{-139,68},
          {-120,68},{-100,68},{-62,68}},               color={0,0,127}));
  connect(TStorageUpper.y, geothermalFieldControllerWarm.temperature)
    annotation (Line(points={{-139,68},{-120,68},{-120,-26},{-100,-26}}, color=
          {0,0,127}));
  connect(TStorageLower.y, geothermalFieldControllerCold.temperature)
    annotation (Line(points={{-139,52},{-122,52},{-108,52},{-108,36},{-100,36}},
        color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening1, valveColdStorage.y)
    annotation (Line(points={{-83.04,40.8},{-82,40.8},{-82,40},{-82,52},{-82,54},
          {-52,54},{-52,46.4}}, color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening2, valveHeatSource.y)
    annotation (Line(points={{-83.04,31.2},{-82,31.2},{-82,1},{-68.4,1}}, color=
         {0,0,127}));
  connect(valveColdSource.y, geothermalFieldControllerWarm.valveOpening1)
    annotation (Line(points={{-30,-45.6},{-30,-45.6},{-30,-32},{-30,-21.2},{
          -83.04,-21.2}}, color={0,0,127}));
  connect(geothermalFieldControllerWarm.valveOpening2, valveHeatStorage.y)
    annotation (Line(points={{-83.04,-30.8},{-56,-30.8},{-56,-63},{-26.4,-63}},
        color={0,0,127}));
  connect(heatPumpTab.Power, heatPumpPower) annotation (Line(points={{-22,-12.3},
          {-22,-12.3},{-22,-40},{-45.5,-40},{-45.5,-119.5}}, color={0,0,127}));
  connect(TStorageLower.y, coldStorageTemperature) annotation (Line(points={{
          -139,52},{-134,52},{-134,-120}}, color={0,0,127}));
  connect(TStorageUpper.y, heatStorageTemperature) annotation (Line(points={{
          -139,68},{-132,68},{-120,68},{-120,-88},{-100,-88},{-100,-120}},
        color={0,0,127}));
  connect(hPControllerOnOff.heatPumpControlBus, heatPumpControlBus) annotation (
     Line(
      points={{-42.05,72.05},{-28,72.05},{-28,79},{-0.5,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PeakLoadDevice.port_b, heatConsumerFlow.ports[1]) annotation (Line(
        points={{120,-50},{136,-50},{150,-50}}, color={0,127,255}));
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
end GeothermalHeatPump;
