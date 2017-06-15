within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"
  extends
    AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.Components.BoilerStandAlone PeakLoadDevice(redeclare
        package Medium =                                                                                          Medium));

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
equation
  connect(resistanceColdConsumerFlow.port_b,coldConsumerFlow. ports[1])
    annotation (Line(points={{94,-20},{94,-20},{148,-20}},  color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64.86,6},{64.86,-11.6}},        color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{56,6},{56,-36},{64.86,-36},{64.86,-41.6}},        color={0,
          0,127}));
  connect(resistanceColdConsumerReturn.port_a,coldConsumerReturn. ports[1])
    annotation (Line(points={{94,32},{114,32},{148,32}},
                                                color={0,127,255}));
  connect(resistanceHeatConsumerReturn.port_a,heatConsumerReturn. ports[1])
    annotation (Line(points={{94,-106},{94,-106},{148,-106}}, color={0,127,255}));
  connect(pressureDifference.y, pumpEvaporator.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64,6},{64,54},{7.14,54},{7.14,44.4}},        color={0,0,
          127}));
  connect(pressureDifference.y, pumpCondenser.dp_in) annotation (Line(points={{147.4,6},
          {56,6},{56,-36},{-0.86,-36},{-0.86,-89.6}},         color={0,0,127}));
  connect(pumpGeothermalSource.dp_in,pressureDifference. y) annotation (Line(
        points={{-89.14,-45.6},{-89.14,-36},{56,-36},{56,6},{147.4,6}},color={0,
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
  annotation (experiment(StopTime=86400, Interval=10), Documentation(revisions="<html>
<ul>
<li>
May 19, 2017, by Marc Baranski:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 10pt;\">Information</span></b> </p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Simple model of a combined heat and cold supply system. The geothermal heat pump can either transport heat </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold storage to the geothermal field (heat storage disconnected)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the geothermal field to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In the flow line of the heating circuit a boiler is connected as a peak load device. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Consumers are modeled as sinks are sources with a constant temperature.</span></p>
</html>"));
end GeothermalHeatPump;
