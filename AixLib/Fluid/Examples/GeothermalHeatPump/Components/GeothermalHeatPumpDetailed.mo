within AixLib.Fluid.Examples.GeothermalHeatPump.Components;
model GeothermalHeatPumpDetailed
  "Component model of the geothermal heat pump example with connectors"
  extends
    AixLib.Fluid.Examples.GeothermalHeatPump.BaseClasses.GeothermalHeatPumpControlledDetailed(
  redeclare AixLib.Fluid.Examples.GeothermalHeatPump.Components.BoilerExternalControl PeakLoadDevice(redeclare
        package Medium =                                                                                          Medium),
      heatPumpPoly(factorScale=1,
      timeConstantCycle=10,
      T_startEva=279.15,
      CoP_output=false),
    resistanceHeatConsumerFlow(m_flow_nominal=2, dp_nominal=10),
    resistanceHeatConsumerReturn(m_flow_nominal=2, dp_nominal=10),
    resistanceColdConsumerReturn(m_flow_nominal=4, dp_nominal=10),
    resistanceColdConsumerFlow(m_flow_nominal=4, dp_nominal=10),
    pumpColdConsumer(m_flow_nominal=4),
    pumpHeatConsumer(m_flow_nominal=2),
    heatStorage(
      k_HE=500,
      A_HE=50,
      h=2,
      d=1.2),
    coldStorage(
      k_HE=500,
      A_HE=50,
      d=1.2,
      h=2),
    pumpGeothermalSource(m_flow_nominal=5),
    valveColdStorage(allowFlowReversal=false, riseTime=120),
    valveHeatSource(allowFlowReversal=false),
    valveHeatSink(show_T=false),
    valveHeatStorage(allowFlowReversal=false),
    resistanceHeatStorage(dp_nominal=500),
    resistanceColdStorage(dp_nominal=500),
    resistanceGeothermalSource(dp_nominal=50000));
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
        origin={-80,90})));
  Controls.Interfaces.BoilerControlBus boilerControlBus
    annotation (Placement(transformation(extent={{90,60},{132,98}})));
  Control.ValveControlBus valveControlBus
    annotation (Placement(transformation(extent={{-72,58},{-30,100}})));
  Modes.Communication.SensorDataBus sensorDataBus
    annotation (Placement(transformation(extent={{128,60},{172,98}})));
  Sensors.Temperature T_evaOut(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
  Sensors.Temperature T_conOut(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-8,10},{0,18}})));
  Sensors.Temperature THeatSup(redeclare package Medium = Medium)
    "heat supply temperature"
    annotation (Placement(transformation(extent={{132,-46},{140,-38}})));
  Sensors.Temperature THeatRet(redeclare package Medium = Medium)
    "heat return temperature"
    annotation (Placement(transformation(extent={{134,-102},{142,-94}})));
  Modelica.Blocks.Sources.RealExpression TColdStorageLower(y=coldStorage.layer[
        1].heatPort.T)
    annotation (Placement(transformation(extent={{108,92},{128,112}})));
  Modelica.Blocks.Sources.RealExpression TColdStorageUpper(y=coldStorage.layer[
        5].heatPort.T)
    annotation (Placement(transformation(extent={{108,122},{128,142}})));
  Modelica.Blocks.Sources.RealExpression TColdStorageMiddle(y=coldStorage.layer[
        3].heatPort.T)
    annotation (Placement(transformation(extent={{108,108},{128,128}})));
  Modelica.Blocks.Sources.RealExpression THeatStorageLower(y=heatStorage.layer[
        1].heatPort.T)
    annotation (Placement(transformation(extent={{108,140},{128,160}})));
  Modelica.Blocks.Sources.RealExpression THeatStorageUpper(y=heatStorage.layer[
        5].heatPort.T)
    annotation (Placement(transformation(extent={{108,170},{128,190}})));
  Modelica.Blocks.Sources.RealExpression THeatStorageMiddle(y=heatStorage.layer[
        3].heatPort.T)
    annotation (Placement(transformation(extent={{108,156},{128,176}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin
    annotation (Placement(transformation(extent={{134,176},{140,182}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
    annotation (Placement(transformation(extent={{134,114},{140,120}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
    annotation (Placement(transformation(extent={{134,128},{140,134}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
    annotation (Placement(transformation(extent={{134,146},{140,152}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
    annotation (Placement(transformation(extent={{134,162},{140,168}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
    annotation (Placement(transformation(extent={{134,98},{140,104}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin T_conOut_C
    annotation (Placement(transformation(extent={{4,12},{10,18}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin T_evaOut_C
    annotation (Placement(transformation(extent={{-46,-4},{-40,2}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin T_evaIn_C
    annotation (Placement(transformation(extent={{-46,12},{-40,18}})));
  Sensors.Temperature T_evaIn(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-58,10},{-50,18}})));
  Modelica.Thermal.HeatTransfer.Celsius.FromKelvin T_conIn_C
    annotation (Placement(transformation(extent={{4,-6},{10,0}})));
  Sensors.Temperature T_conIn(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-8,-8},{0,0}})));
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
        points={{3.14,-103.6},{3.14,-60},{16,-60},{16,60},{61.105,60},{61.105,
          79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pumpEvaporator.dp_in, pumpControlBus.p_pumpEvaporator) annotation (
      Line(points={{7.14,56.4},{7.14,60},{61.105,60},{61.105,79.095}}, color={0,
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
  connect(valveColdStorage.y_actual, valveControlBus.feedback_valveColdStorage)
    annotation (Line(points={{-64.9,33},{-56,33},{-56,44},{-56,44},{-56,62},{
          -50.895,62},{-50.895,79.105}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(getTStorageLower.y, TStorageLower) annotation (Line(points={{-139,52},
          {-88,52},{-88,66},{-80,66},{-80,90}}, color={0,0,127}));
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
  connect(valveColdStorage.y, valveControlBus.opening_valveColdStorage)
    annotation (Line(points={{-68.4,36},{-68.4,62},{-68.4,79.105},{-50.895,
          79.105}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatSource.y, valveControlBus.opening_valveHeatSource)
    annotation (Line(points={{-67.3,-28.5},{-74,-28.5},{-74,52},{-50.895,52},{
          -50.895,79.105}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatSource.y_actual, valveControlBus.feedback_valveHeatSource)
    annotation (Line(points={{-64.05,-25.25},{-66,-25.25},{-66,62},{-50.895,62},
          {-50.895,79.105}},
                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatSink.y, valveControlBus.opening_valveHeatSink) annotation (
      Line(points={{-26,-45.6},{-26,-28},{-66,-28},{-66,62},{-50.895,62},{
          -50.895,79.105}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatSink.y_actual, valveControlBus.feedback_valveHeatSink)
    annotation (Line(points={{-23,-49.1},{-26,-49.1},{-26,-26},{-68,-26},{-68,
          62},{-50.895,62},{-50.895,79.105}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatStorage.y, valveControlBus.opening_valveHeatStorage)
    annotation (Line(points={{-7.3,-68.5},{-38,-68.5},{-38,-28},{-66,-28},{-66,
          62},{-50.895,62},{-50.895,79.105}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveHeatStorage.y_actual, valveControlBus.feedback_valveHeatStorage)
    annotation (Line(points={{-4.05,-65.25},{-22,-65.25},{-22,-26},{-66,-26},{
          -66,62},{-50.895,62},{-50.895,79.105}},
                                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_evaOut.port, heatPumpPoly.port_evaOut) annotation (Line(points={{-54,-6},
          {-54,-10.4},{-37.6,-10.4}},         color={0,127,255}));
  connect(T_conOut.port, heatPumpPoly.port_conOut)
    annotation (Line(points={{-4,10},{-4,6.4},{-6.4,6.4}}, color={0,127,255}));
  connect(THeatSup.port, port_b_consumerHeat) annotation (Line(points={{136,-46},
          {136,-50},{160,-50}}, color={0,127,255}));
  connect(THeatRet.port, port_a_consumerHeat) annotation (Line(points={{138,
          -102},{138,-106},{160,-106}}, color={0,127,255}));
  connect(THeatSup.T, sensorDataBus.THeatSup) annotation (Line(points={{138.8,
          -42},{144,-42},{144,79.095},{150.11,79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(THeatRet.T, sensorDataBus.THeatRet) annotation (Line(points={{140.8,
          -98},{144,-98},{144,79.095},{150.11,79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(THeatStorageUpper.y, fromKelvin.Kelvin) annotation (Line(points={{129,
          180},{132,180},{132,179},{133.4,179}}, color={0,0,127}));
  connect(THeatStorageMiddle.y, fromKelvin5.Kelvin) annotation (Line(points={{
          129,166},{132,166},{132,165},{133.4,165}}, color={0,0,127}));
  connect(THeatStorageLower.y, fromKelvin4.Kelvin) annotation (Line(points={{
          129,150},{132,150},{132,149},{133.4,149}}, color={0,0,127}));
  connect(TColdStorageUpper.y, fromKelvin3.Kelvin) annotation (Line(points={{
          129,132},{132,132},{132,131},{133.4,131}}, color={0,0,127}));
  connect(TColdStorageMiddle.y, fromKelvin2.Kelvin) annotation (Line(points={{
          129,118},{132,118},{132,117},{133.4,117}}, color={0,0,127}));
  connect(TColdStorageLower.y, fromKelvin1.Kelvin) annotation (Line(points={{
          129,102},{132,102},{132,101},{133.4,101}}, color={0,0,127}));
  connect(fromKelvin1.Celsius, sensorDataBus.TColdStorageLower) annotation (
      Line(points={{140.3,101},{140.3,90.5},{150.11,90.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fromKelvin2.Celsius, sensorDataBus.TColdStorageMiddle) annotation (
      Line(points={{140.3,117},{140.3,117.5},{150.11,117.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fromKelvin3.Celsius, sensorDataBus.TColdStorageUpper) annotation (
      Line(points={{140.3,131},{140.3,131.5},{150.11,131.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fromKelvin4.Celsius, sensorDataBus.THeatStorageLower) annotation (
      Line(points={{140.3,149},{140.3,149.5},{150.11,149.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fromKelvin5.Celsius, sensorDataBus.THeatStorageMiddle) annotation (
      Line(points={{140.3,165},{140.3,164.5},{150.11,164.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(fromKelvin.Celsius, sensorDataBus.THeatStorageUpper) annotation (Line(
        points={{140.3,179},{140.3,179.5},{150.11,179.5},{150.11,79.095}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_conOut.T, T_conOut_C.Kelvin) annotation (Line(points={{-1.2,14},{2,
          14},{2,15},{3.4,15}}, color={0,0,127}));
  connect(T_conOut_C.Celsius, sensorDataBus.TconOut) annotation (Line(points={{
          10.3,15},{80.15,15},{80.15,79.095},{150.11,79.095}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_evaOut.T, T_evaOut_C.Kelvin) annotation (Line(points={{-51.2,-2},{
          -48,-2},{-48,-1},{-46.6,-1}}, color={0,0,127}));
  connect(T_evaOut_C.Celsius, sensorDataBus.TevaOut) annotation (Line(points={{
          -39.7,-1},{150.11,-1},{150.11,79.095}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_conIn.port, heatPumpPoly.port_conIn) annotation (Line(points={{-4,
          -8},{-4,-10},{-6.4,-10.4}}, color={0,127,255}));
  connect(T_evaIn.port, heatPumpPoly.port_evaIn) annotation (Line(points={{-54,
          10},{-54,6},{-37.6,6.4}}, color={0,127,255}));
  connect(T_evaIn.T, T_evaIn_C.Kelvin) annotation (Line(points={{-51.2,14},{-48,
          14},{-48,15},{-46.6,15}}, color={0,0,127}));
  connect(T_conIn.T, T_conIn_C.Kelvin) annotation (Line(points={{-1.2,-4},{2,-4},
          {2,-3},{3.4,-3}}, color={0,0,127}));
  connect(T_conIn_C.Celsius, sensorDataBus.TconIn) annotation (Line(points={{
          10.3,-3},{78.15,-3},{78.15,79.095},{150.11,79.095}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(T_evaIn_C.Celsius, sensorDataBus.TevaIn) annotation (Line(points={{
          -39.7,15},{52.15,15},{52.15,79.095},{150.11,79.095}}, color={0,0,127}),
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
</html>", info="<html>
<p><b><span style=\"font-family: MS Shell Dlg 2; font-size: 10pt;\">Information</span></b> </p>
<p><b><span style=\"font-family: MS Shell Dlg 2; color: #008000;\">Overview</span></b> </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Simple component model of a combined heat and cold supply system. The geothermal heat pump can either transport heat </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the cold storage to the geothermal field (heat storage disconnected)</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">- from the geothermal field to the heat storage</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">In the flow line of the heating circuit a boiler is connected as a peak load device. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Consumers are modeled as sinks are sources with a constant temperature.</span></p>
</html>"));
end GeothermalHeatPumpDetailed;
