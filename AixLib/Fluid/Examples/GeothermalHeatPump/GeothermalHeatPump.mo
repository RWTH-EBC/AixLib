within AixLib.Fluid.Examples.GeothermalHeatPump;
model GeothermalHeatPump "Example of a geothermal heat pump system"
  extends AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.Boiler PeakLoadDevice(redeclare
        package                                                                                          Medium = Medium));
  Controls.HeatPump.HPControllerOnOff hPControllerOnOff(bandwidth=5)
    "Controls the temperature in the heat storage by switching the heat pump on or off"
    annotation (Placement(transformation(extent={{-62,62},{-42,82}})));

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
equation
  connect(resistanceColdConsumerFlow.port_b,coldConsumerFlow. ports[1])
    annotation (Line(points={{94,-20},{94,-20},{148,-20}},  color={0,127,255}));
  connect(pressureDifference.y, pumpColdConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{64.86,6},{64.86,-11.6}},        color={0,0,127}));
  connect(pressureDifference.y, pumpHeatConsumer.dp_in) annotation (Line(points={{147.4,6},
          {147.4,6},{56,6},{56,-36},{62.86,-36},{62.86,-41.6}},        color={0,
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
end GeothermalHeatPump;
