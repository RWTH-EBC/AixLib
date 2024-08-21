within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"

  extends Modelica.Icons.Example;

  extends
    AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledBase(
    redeclare model PeakLoadDeviceModel =
        AixLib.Fluid.Examples.GeothermalHeatPump.Components.BoilerStandAlone (
          redeclare package Medium = Medium, energyDynamics=energyDynamics));

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
    T=287.15) "Source representing cold consumer"
                annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,32})));
  Modelica.Blocks.Sources.Constant pressureDifference(k=60000)
    "Pressure difference used for all pumps"                   annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={154,6})));
  Controls.HeatPump.TwoPointControlledHP
                                      twoPointControlledHP(
    use_secHeaGen=false,
    use_heaLim=false,
    T_heaLim=293.15,
    movAveTime=300,
    bandwidth=2)
    "Controls the temperature in the heat storage by switching the heat pump on or off"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant TStorageSet(k=273.15 + 45)
    "Set point of upper heat storage temperature"
    annotation (Placement(transformation(extent={{-120,70},{-110,80}})));
  Control.geothermalFieldController     geothermalFieldControllerCold(
      temperature_low=273.15 + 8, temperature_high=273.15 + 10)
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-102,28},{-86,44}})));
  Control.geothermalFieldController     geothermalFieldControllerHeat(
      temperature_low=308.15, temperature_high=313.15)
    "Controls the heat exchange with the geothermal field and the heat storage"
    annotation (Placement(transformation(extent={{-100,-34},{-84,-18}})));
  Modelica.Blocks.Sources.BooleanConstant mode "Dummy signal for unit mode, true: heat pump, false: chiller"
    annotation (Placement(transformation(extent={{-56,56},{-44,68}})));
equation
  connect(resistanceColdConsumerFlow.port_b,coldConsumerFlow. ports[1])
    annotation (Line(points={{94,-20},{94,-20},{148,-20}},  color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{65,6},{65,-11.6}},              color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points={{147.4,6},
          {56,6},{56,-36},{65,-36},{65,-41.6}},                        color={0,
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
  connect(peaLoaDev.port_b,heatConsumerFlow. ports[1]) annotation (Line(
        points={{120,-50},{120,-50},{148,-50}}, color={0,127,255}));
  connect(peaLoaDev.chemicalEnergyFlowRate, chemicalEnergyFlowRate)
    annotation (Line(points={{112.77,-56.54},{112.77,-118},{-26,-118},{-26,-100},
          {-71.5,-100},{-71.5,-119.5}}, color={0,0,127}));
  connect(getTStorageLower.y,geothermalFieldControllerCold. temperature)
    annotation (Line(points={{-139,52},{-108,52},{-108,36},{-102,36}},
        color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening1, valveColdStorage.y)
    annotation (Line(points={{-85.04,40.8},{-82,40.8},{-82,54},{-52,54},{-52,
          46.4}},               color={0,0,127}));
  connect(geothermalFieldControllerCold.valveOpening2, valveHeatSource.y)
    annotation (Line(points={{-85.04,31.2},{-82,31.2},{-82,1},{-68.4,1}}, color=
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
  connect(valveHeatStorage.port_b, heatPump.port_a1) annotation (Line(points={{-18,-57},
          {-18,-8.00001},{-24,-8.00001},{-24,0}},                     color={0,
          127,255}));
  connect(TStorageSet.y, twoPointControlledHP.TSet) annotation (Line(points={{-109.5,
          75},{-98,75},{-98,76},{-81.6,76}},        color={0,0,127}));
  connect(twoPointControlledHP.sigBusHP, heatPumpControlBus) annotation (Line(
      points={{-80.7,66.9},{-84,66.9},{-84,86},{0,86},{0,79},{-0.5,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(getTStorageUpper.y,twoPointControlledHP.TMea)  annotation (Line(
        points={{-139,68},{-138,68},{-138,62},{-81.6,62}}, color={0,0,127}));
  connect(mode.y, heatPumpControlBus.hea) annotation (Line(points={{-43.4,62},{
          0,62},{0,80},{-0.5,80},{-0.5,79}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(heatPump.P, heatPumpPower) annotation (Line(points={{-30,21},{-30,20},
          {-116,20},{-116,-88},{-45.5,-88},{-45.5,-119.5}}, color={0,0,127}));
  connect(twoPointControlledHP.nOut, heatPumpControlBus.ySet) annotation (Line(
        points={{-59,70},{0,70},{0,79},{-0.5,79}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,6},{6,6}},
      horizontalAlignment=TextAlignment.Left));
  connect(twoPointControlledHP.nOut, heatPumpControlBus.yMea) annotation (Line(
        points={{-59,70},{-0.5,70},{-0.5,79}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (experiment(Tolerance=1e-6, StartTime=0, Interval=500, StopTime=86400, __Dymola_Algorithm="Dassl"), __Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/Examples/GeothermalHeatPump.mos"
        "Simulate and plot"), Documentation(revisions="<html><ul>
  <li>
    <i>May 5, 2021</i> by Fabian Wüllhorst:<br/>
    Use new heat pump model and add simulate and plot script. (see
    issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1093\">#1093</a>)
  </li>
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
