within AixLib.PlugNHarvest.Aggregation;
model Room_EnergySyst "Room and energy system"
  Room_intGain room_intGain
    annotation (Placement(transformation(extent={{-30,14},{32,72}})));
  Components.EnergySystem.IdealHeaterCooler.HeaterCoolerPI_withPel
    heaterCoolerPI_withPel
    annotation (Placement(transformation(extent={{-34,-50},{12,-6}})));
  Components.Controls.Cooler cooler
    annotation (Placement(transformation(extent={{-52,-88},{-24,-62}})));
  Components.Controls.Heater heater
    annotation (Placement(transformation(extent={{-6,-90},{22,-62}})));
  AixLib.Utilities.Interfaces.SolarRad_in solRadPort_Facade1
    annotation (Placement(transformation(extent={{-104,78},{-84,98}})));
  Modelica.Blocks.Interfaces.RealInput AirComposition[size(room_intGain.AirComposition,
    1)] annotation (Placement(transformation(extent={{-120,36},{-80,76}}),
        iconTransformation(extent={{-100,42},{-80,62}})));
  Modelica.Blocks.Interfaces.RealInput WindSpeedPort annotation (Placement(
        transformation(extent={{-120,0},{-80,40}}), iconTransformation(extent={
            {-100,8},{-78,30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a thermOutside1 annotation (
     Placement(transformation(extent={{-100,-26},{-80,-6}}), iconTransformation(
          extent={{-100,-26},{-80,-6}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-66},{-80,-26}}),
        iconTransformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_Occupants "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-100},{-80,-60}}),
        iconTransformation(extent={{-100,-84},{-80,-64}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-56,-4},{-36,16}})));
  Modelica.Blocks.Interfaces.BooleanInput isChillerOn
    "On/Off switch for the chiller" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-50,-120}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-110})));
  Modelica.Blocks.Interfaces.BooleanInput isHeaterOn
    "On/Off switch for the heater" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-18,-120}), iconTransformation(
        extent={{-9,-9},{9,9}},
        rotation=90,
        origin={-29,-109})));
  Modelica.Blocks.Interfaces.RealOutput Troom
    "Absolute temperature as output signal" annotation (Placement(
        transformation(extent={{78,-2},{98,18}}), iconTransformation(extent={{
            78,-2},{98,18}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-124},{-80,-84}}),
        iconTransformation(extent={{-100,-106},{-80,-86}})));
equation
  connect(heaterCoolerPI_withPel.heatCoolRoom, room_intGain.thermRoom)
    annotation (Line(points={{9.7,-36.8},{16,-36.8},{16,-36},{22,-36},{22,10},{
          -0.24,10},{-0.24,15.74}}, color={191,0,0}));
  connect(cooler.ControlBus, heaterCoolerPI_withPel.ControlBus_idealHeater)
    annotation (Line(
      points={{-24.035,-72.075},{-24.035,-56},{-31.35,-56},{-31.35,-48.24},{
          -21.35,-48.24}},
      color={255,204,51},
      thickness=0.5));
  connect(heater.ControlBus, heaterCoolerPI_withPel.ControlBus_idealCooler)
    annotation (Line(
      points={{21.965,-72.85},{26,-72.85},{26,-74},{32,-74},{32,-56},{-5.71,-56},
          {-5.71,-47.8}},
      color={255,204,51},
      thickness=0.5));
  connect(room_intGain.solRadPort_Facade, solRadPort_Facade1) annotation (Line(
        points={{-28.14,66.2},{-60,66.2},{-60,88},{-94,88}}, color={255,128,0}));
  connect(room_intGain.AirComposition, AirComposition) annotation (Line(points=
          {{-26.9,58.08},{-60,58.08},{-60,56},{-100,56}}, color={0,0,127}));
  connect(room_intGain.WindSpeedPort, WindSpeedPort) annotation (Line(points={{
          -26.9,48.8},{-60,48.8},{-60,20},{-100,20}}, color={0,0,127}));
  connect(room_intGain.thermOutside, thermOutside1) annotation (Line(points={{-27.52,
          41.84},{-60,41.84},{-60,-16},{-90,-16}}, color={191,0,0}));
  connect(room_intGain.Schedule_lights, Schedule_lights) annotation (Line(
        points={{-26.59,34.01},{-60,34.01},{-60,-46},{-100,-46}}, color={0,0,
          127}));
  connect(room_intGain.Schedule_Occupants, Schedule_Occupants) annotation (Line(
        points={{-26.59,26.47},{-60,26.47},{-60,-80},{-100,-80}}, color={0,0,
          127}));
  connect(thermOutside1, temperatureSensor.port) annotation (Line(points={{-90,
          -16},{-74,-16},{-74,6},{-56,6}}, color={191,0,0}));
  connect(temperatureSensor.T, cooler.Toutside) annotation (Line(points={{-36,6},
          {-26,6},{-26,-10},{-60,-10},{-60,-75.585},{-51.615,-75.585}}, color={
          0,0,127}));
  connect(heater.Toutside, temperatureSensor.T) annotation (Line(points={{
          -5.615,-76.63},{-8,-76.63},{-8,-100},{-60,-100},{-60,-10},{-26,-10},{
          -26,6},{-36,6}}, color={0,0,127}));
  connect(cooler.isOn, isChillerOn) annotation (Line(points={{-51.44,-63.69},{
          -60,-63.69},{-60,-120},{-50,-120}}, color={255,0,255}));
  connect(heater.isOn, isHeaterOn) annotation (Line(points={{-5.44,-63.82},{-10,
          -63.82},{-10,-120},{-18,-120}}, color={255,0,255}));
  connect(room_intGain.Troom, Troom) annotation (Line(points={{31.38,43},{38,43},
          {38,8},{88,8}}, color={0,0,127}));
  connect(room_intGain.Schedule_elAppliances, Schedule_elAppliances)
    annotation (Line(points={{-26.59,18.35},{-60,18.35},{-60,-104},{-100,-104}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-76,-86},{82,84}}, fileName=
              "modelica://AixLib/Resources/Images/PnH/PnH_Logo.png")}),    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>April, 2019&nbsp;</i> by Ana Constantin:<br>First implementation</li>
</ul>
</html>"));
end Room_EnergySyst;
