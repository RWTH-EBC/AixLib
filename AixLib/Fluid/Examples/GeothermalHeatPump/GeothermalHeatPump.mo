within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"

  extends Modelica.Icons.Example;

  extends AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.Components.BoilerStandAlone PeakLoadDevice(redeclare package Medium =
                         Medium));

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
        origin={154,-50})));
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
    annotation (Placement(transformation(extent={{-78,62},{-58,82}})));
  Modelica.Blocks.Sources.Constant TStorageSet(k=273.15 + 35)
    "Set point of upper heat storage temperature"
    annotation (Placement(transformation(extent={{-160,0},{-148,12}})));
  Control.geothermalFieldController     geothermalFieldControllerCold(
      temperature_low=273.15 + 6, temperature_high=273.15 + 8)
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,28},{-84,44}})));
  Control.geothermalFieldController     geothermalFieldControllerHeat
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,-34},{-84,-18}})));
equation
  connect(resistanceColdConsumerFlow.port_b,coldConsumerFlow. ports[1])
    annotation (Line(points={{94,-20},{94,-20},{148,-20}},  color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{65,6},{65,-11.6}},              color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{56,6},{56,-36},{65,-36},{65,-41.6}},              color={0,
          0,127}));
  connect(resistanceColdConsumerReturn.port_a,coldConsumerReturn. ports[1])
    annotation (Line(points={{94,32},{114,32},{148,32}},
                                                color={0,127,255}));
  connect(resistanceHeatConsumerReturn.port_a,heatConsumerReturn. ports[1])
    annotation (Line(points={{94,-106},{94,-106},{148,-106}}, color={0,127,255}));
  connect(pressureDifference.y, pumpEvaporator.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64,6},{64,54},{7,54},{7,44.4}},              color={0,0,
          127}));
  connect(pressureDifference.y, pumpCondenser.dp_in) annotation (Line(points={{147.4,6},
          {56,6},{56,-36},{-1,-36},{-1,-89.6}},               color={0,0,127}));
  connect(pumpGeothermalSource.dp_in,pressureDifference. y) annotation (Line(
        points={{-89,-45.6},{-89,-36},{56,-36},{56,6},{147.4,6}},      color={0,
          0,127}));
  connect(PeakLoadDevice.port_b,heatConsumerFlow. ports[1]) annotation (Line(
        points={{120,-50},{120,-50},{148,-50}}, color={0,127,255}));
  connect(TStorageSet.y,hPControllerOnOff. T_meas) annotation (Line(points={{-147.4,
          6},{-132,6},{-132,76},{-78,76}},   color={0,0,127}));
  connect(getTStorageUpper.y, hPControllerOnOff.T_set) annotation (Line(points=
          {{-139,68},{-139,68},{-116,68},{-78,68}}, color={0,0,127}));
  connect(hPControllerOnOff.heatPumpControlBus, heatPumpControlBus) annotation (
     Line(
      points={{-58.05,72.05},{-44,72.05},{-44,79},{-0.5,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(PeakLoadDevice.chemicalEnergyFlowRate, chemicalEnergyFlowRate)
    annotation (Line(points={{112.77,-56.54},{112.77,-118},{-26,-118},{-26,-100},
          {-71.5,-100},{-71.5,-119.5}}, color={0,0,127}));
  connect(getTStorageLower.y,geothermalFieldControllerCold. temperature)
    annotation (Line(points={{-139,52},{-122,52},{-108,52},{-108,36},{-100,36}},
        color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening1, valveColdStorage.y)
    annotation (Line(points={{-83.04,40.8},{-82,40.8},{-82,40},{-82,52},{-82,54},
          {-52,54},{-52,46.4}}, color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening2, valveHeatSource.y)
    annotation (Line(points={{-83.04,31.2},{-82,31.2},{-82,1},{-68.4,1}}, color=
         {0,0,127}));
  connect(getTStorageUpper.y,geothermalFieldControllerHeat. temperature)
    annotation (Line(points={{-139,68},{-120,68},{-120,-26},{-100,-26}}, color=
          {0,0,127}));
  connect(valveHeatSink.y, geothermalFieldControllerHeat.valveOpening1)
    annotation (Line(points={{-30,-45.6},{-30,-45.6},{-30,-32},{-30,-21.2},{-83.04,
          -21.2}}, color={0,0,127}));
  connect(geothermalFieldControllerHeat.valveOpening2, valveHeatStorage.y)
    annotation (Line(points={{-83.04,-30.8},{-56,-30.8},{-56,-63},{-26.4,-63}},
        color={0,0,127}));
  annotation (experiment(StopTime=86400, Interval=10), Documentation(revisions="<html><ul>
  <li>May 19, 2017, by Marc Baranski:<br/>
    First implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple stand-alone model of a combined heat and cold supply system.
  The geothermal heat pump can either transport heat
</p>
<ul>
  <li>from the cold to the heat storage
  </li>
  <li>from the cold storage to the geothermal field (heat storage
  disconnected)
  </li>
  <li>from the geothermal field to the heat storage
  </li>
</ul>
<p>
  In the flow line of the heating circuit a boiler is connected as a
  peak load device. Consumers are modeled as sinks are sources with a
  constant temperature.
</p>
</html>"),
    Diagram(coordinateSystem(extent={{-160,-120},{160,80}})),
    Icon(coordinateSystem(extent={{-160,-120},{160,80}})));
end GeothermalHeatPump;
