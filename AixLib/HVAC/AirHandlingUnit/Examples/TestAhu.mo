within AixLib.HVAC.AirHandlingUnit.Examples;
model TestAhu "Example to test all states of the AHU model"
    extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine     TempOutside(
    amplitude=10,
    freqHz=1/86400,
    offset=293,
    phase=-3.1415/2)
    annotation (Placement(transformation(extent={{-100,-16},{-80,4}})));
  Modelica.Blocks.Sources.Constant Vflow_in(k=100)
    annotation (Placement(transformation(extent={{-100,24},{-80,44}})));
  Modelica.Blocks.Sources.Constant TempRoom(k=293)
    annotation (Placement(transformation(extent={{62,-26},{42,-6}})));
  Ahu     aHUFull(HRS=true, clockPeriodGeneric=30,
    cooling=false)
    annotation (Placement(transformation(extent={{-72,-62},{30,48}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(
      alpha=2) annotation (Placement(transformation(extent={{74,0},{60,14}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{56,2},{46,12}})));
  Modelica.Blocks.Sources.Constant HeatLoadRoom(k=500) "in W"
    annotation (Placement(transformation(extent={{100,12},{80,32}})));
  Modelica.Blocks.Sources.Constant phi_roomMin(k=0.45)
    annotation (Placement(transformation(extent={{68,-56},{48,-36}})));
  Modelica.Blocks.Sources.Constant phi_roomMax(k=0.55)
    annotation (Placement(transformation(extent={{98,-56},{78,-36}})));

  Modelica.Blocks.Sources.Sine WaterLoadOutside(
    freqHz=1/86400,
    offset=0.008,
    amplitude=0.002,
    phase=-0.054829518451402)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Constant phi_RoomExtractAir(k=0.6)
    annotation (Placement(transformation(extent={{98,-24},{78,-4}})));
equation

  connect(TempRoom.y, aHUFull.T_supplyAir) annotation (Line(
      points={{41,-16},{34,-16},{34,-7},{21.84,-7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TempOutside.y, aHUFull.T_outdoorAir) annotation (Line(
      points={{-79,-6},{-74,-6},{-74,-9.44444},{-65.88,-9.44444}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Vflow_in.y, aHUFull.Vflow_in) annotation (Line(
      points={{-79,34},{-76,34},{-76,-5.77778},{-69.96,-5.77778}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(temperatureSensor.T, aHUFull.T_extractAir) annotation (Line(
      points={{46,7},{46,12},{32,12},{32,16.2222},{21.84,16.2222}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeatLoadRoom.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{79,22},{76,22},{76,7},{74,7}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, temperatureSensor.port) annotation (Line(
      points={{60,7},{56,7}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(phi_roomMin.y, aHUFull.phi_supplyAir[1]) annotation (Line(
      points={{47,-46},{34,-46},{34,-11.8889},{21.84,-11.8889}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_roomMax.y, aHUFull.phi_supplyAir[2]) annotation (Line(
      points={{77,-46},{50,-46},{50,-14.3333},{21.84,-14.3333}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(WaterLoadOutside.y, aHUFull.X_outdoorAir) annotation (Line(
      points={{-79,-40},{-70,-40},{-70,-15.5556},{-65.88,-15.5556}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(phi_RoomExtractAir.y, aHUFull.phi_extractAir) annotation (Line(
      points={{77,-14},{66,-14},{66,0},{30,0},{30,10.1111},{21.84,10.1111}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Lsodar"),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Simulation to check the behaviour of the simple Air Handling Unit models. Various possibilities for inputs are provided. </p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Temperature inputs are in Kelvin and the water load fraction is in kg(Water)/kg(Dry Air). </p>
<p>Occupation and Schedule is a percentage value between 0 and 1.</p>
<p>The zone parameter is needed to automatically calculate the air flow rate based on the occupation and room area.</p>
</html>"));
end TestAhu;
