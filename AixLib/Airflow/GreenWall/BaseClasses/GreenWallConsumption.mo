within AixLib.Airflow.GreenWall.BaseClasses;
model GreenWallConsumption
  Modelica.SIunits.Energy electricCounter(start = 0);
  Modelica.SIunits.Volume waterCounter(start = 0);
  Modelica.Blocks.Sources.Constant electricConsumption(k = 16.96) "Electric power used by Naava in W" annotation (
    Placement(transformation(extent = {{-80, 20}, {-60, 40}})));
  Modelica.Blocks.Sources.Constant waterConsumption(k = 4.29 / 1000 / 24 / 3600) "Water used by Naava in m^3/s" annotation (
    Placement(transformation(extent = {{-80, -20}, {-60, 0}})));
  Modelica.Blocks.Interfaces.RealOutput electricEnergy "Integrated electric consumption" annotation (
    Placement(transformation(extent = {{94, 18}, {114, 38}})));
  Modelica.Blocks.Interfaces.RealOutput waterVolume "Integrated water consumption" annotation (
    Placement(transformation(extent = {{94, -20}, {114, 0}})));
equation
  der(electricCounter) = electricConsumption.k;
  der(waterCounter) = waterConsumption.k;
  electricCounter = electricEnergy;
  waterCounter = waterVolume;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html>
<h4>Overview </h4>
<p>Model assuming the plant wall consumption of water and electric power as constant based on experimental data.</p>
<h4>References </h4>
<p>[1] Bardey, J. (2020): Measurement and analysis of the influence of plant wall systems on indoor climate control (master thesis). RWTH Aachen University, Aachen. E.ON Energy Research Center, Institute for Energy Efficient Buildings and Indoor Climate; supervised by: Baranski, M.; M&uuml;ller, D.</p>
<p><br>Example Results</p>
<p>A validation experiment for the consumption of the plant wall is documented in [1, chapter 4.1.4]. </p>
</html>"));
end GreenWallConsumption;
