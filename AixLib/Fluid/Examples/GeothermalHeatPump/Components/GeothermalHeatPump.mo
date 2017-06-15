within AixLib.Fluid.Examples.GeothermalHeatPump.Components;
model GeothermalHeatPump
  "Component model of the geothermal heat pump example with connectors"
  extends
    AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledBase(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.Components.BoilerExternalControl PeakLoadDevice(redeclare
        package Medium =                                                                                          Medium));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_consumerCold(redeclare package
      Medium = Medium) "Port to cold consumers" annotation (Placement(
        transformation(extent={{150,-30},{170,-10}}), iconTransformation(extent={{-170,30},
            {-150,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b_consumerHeat(redeclare package
      Medium = Medium) "Port to heat consumers" annotation (Placement(
        transformation(extent={{150,-60},{170,-40}}), iconTransformation(extent={{148,30},
            {168,50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_consumerCold(redeclare package
      Medium = Medium) "Port from cold consumer" annotation (Placement(
        transformation(extent={{150,22},{170,42}}), iconTransformation(extent={{-170,
            -72},{-150,-52}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a_consumerHeat(redeclare package
      Medium = Medium) "Port from heat consumer" annotation (Placement(
        transformation(extent={{150,-116},{170,-96}}), iconTransformation(
          extent={{150,-70},{170,-50}})));
  Control.PumpControlBus pumpControlBus
    annotation (Placement(transformation(extent={{40,60},{82,98}})));
  Modelica.Blocks.Interfaces.RealOutput TStorageUpper(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min=0,
    displayUnit="degC") "Temperature of upper heat storage layer" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,90})));
  Modelica.Blocks.Interfaces.RealOutput TStorageLower(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    min=0,
    displayUnit="degC") "Temperature of lower cold storage layer" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,90})));
  Controls.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{90,60},{132,98}})));
equation
  connect(resistanceColdConsumerReturn.port_a, port_a_consumerCold)
    annotation (Line(points={{94,32},{160,32}}, color={0,127,255}));
  connect(resistanceColdConsumerFlow.port_b, port_b_consumerCold)
    annotation (Line(points={{94,-20},{160,-20}}, color={0,127,255}));
  connect(PeakLoadDevice.port_b, port_b_consumerHeat)
    annotation (Line(points={{120,-50},{160,-50}}, color={0,127,255}));
  connect(resistanceHeatConsumerReturn.port_a, port_a_consumerHeat)
    annotation (Line(points={{94,-106},{160,-106}}, color={0,127,255}));
  connect(pumpGeothermalSource.dp_in, pumpControlBus.p_pumpGeothermalSource)
    annotation (Line(points={{-89.14,-45.6},{-89.14,-38},{16,-38},{16,60},{
          61.105,60},{61.105,79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpCondenser.dp_in, pumpControlBus.p_pumpCondenser) annotation (Line(
        points={{-0.86,-89.6},{-0.86,-60},{16,-60},{16,60},{61.105,60},{61.105,
          79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpEvaporator.dp_in, pumpControlBus.p_pumpEvaporator) annotation (
      Line(points={{7.14,44.4},{7.14,60},{61.105,60},{61.105,79.095}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpColdConsumer.dp_in, pumpControlBus.p_pumpColdConsumer)
    annotation (Line(points={{64.86,-11.6},{64.86,52},{61.105,52},{61.105,
          79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpHeatConsumer.dp_in, pumpControlBus.p_pumpHeatConsumer)
    annotation (Line(points={{64.86,-41.6},{64.86,-34},{54,-34},{54,52},{61.105,
          52},{61.105,79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(getTStorageUpper.y, TStorageUpper)
    annotation (Line(points={{-139,68},{-100,68},{-100,90}}, color={0,0,127}));
  connect(getTStorageLower.y, TStorageLower) annotation (Line(points={{-139,52},
          {-88,52},{-88,66},{-60,66},{-60,90}}, color={0,0,127}));
  connect(PeakLoadDevice.boilerControlBus, boilerControlBus) annotation (Line(
      points={{114,-44.06},{114,66},{111,66},{111,79}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(chemicalEnergyFlowRate, boilerControlBus.chemicalEnergyFlowRate)
    annotation (Line(points={{-71.5,-119.5},{-71.5,-92},{-28,-92},{-28,-114},{
          104,-114},{104,66},{111.105,66},{111.105,79.095}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Documentation(revisions="<html>
<ul>
<li>
May 19, 2017, by Marc Baranski:<br/>
First implementation.
</li>
</ul>
</html>"));
end GeothermalHeatPump;
