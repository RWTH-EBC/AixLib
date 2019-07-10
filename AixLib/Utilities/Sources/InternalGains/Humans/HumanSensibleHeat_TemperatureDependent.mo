within AixLib.Utilities.Sources.InternalGains.Humans;
model HumanSensibleHeat_TemperatureDependent
  "Model for sensible heat output of humans to environment dependent on the room temperature"
  extends BaseClasses.PartialHuman(productHeatOutput(nu=2));

  parameter Real ActivityDegree = 1.0 "activity degree of persons in room in met";

  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation(Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {-90, 64})));
  Modelica.Blocks.Math.UnitConversions.To_degC to_degC annotation(Placement(transformation(extent = {{-82, 46}, {-72, 56}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a TRoom
    "Air temperature in room"                                                         annotation(Placement(transformation(extent = {{-100, 80}, {-80, 100}})));
  BaseClasses.TemperatureDependentHeatOutput_SIA2024
    temperatureDependentHeatOutput_SIA2024_1
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(TRoom,temperatureSensor. port) annotation(Line(points = {{-90, 90}, {-90, 74}}, color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(temperatureSensor.T,to_degC. u) annotation(Line(points = {{-90, 54}, {-84, 54}, {-84, 52}, {-83, 51}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(to_degC.y, temperatureDependentHeatOutput_SIA2024_1.Temperature)
    annotation (Line(points={{-71.5,51},{-66.75,51},{-66.75,50},{-61,50}},
        color={0,0,127}));
  connect(temperatureDependentHeatOutput_SIA2024_1.heatOutput,
    productHeatOutput.u[2]) annotation (Line(points={{-39,50},{-28,50},{-28,30},
          {-54,30},{-54,0.5},{-40,0.5}}, color={0,0,127}));
end HumanSensibleHeat_TemperatureDependent;
