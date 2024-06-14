within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialExampleVentilationFlowRate
  "Boundary conditions for ventilation flow rate examples"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Length winClrWidth(min=0)=1.0
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrHeight(min=0)=1.8
    "Height of the window clear opening";
  Modelica.Blocks.Sources.Ramp TRoomSet(
    height=15,
    duration=120,
    offset=15,
    startTime=50) "Set room temperature in °C"
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Ramp TAmbSet(
    height=-40,
    duration=160,
    offset=40,
    startTime=10) "Set ambient temperature in °C"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC1 "Convert degC to K"
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.TimeTable winSpeSet(table=[0,0; 20,0; 30,5; 40,0; 50,10;
        60,0; 70,20; 80,0; 100,0; 110,20; 120,0; 130,10; 140,0; 150,5; 160,0; 180,
        0]) "Set wind speed"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Sine winDirSet(amplitude=2*Modelica.Constants.pi, f=0.05)
    "Set wind direction"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(TRoomSet.y, from_degC.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(TAmbSet.y, from_degC1.u)
    annotation (Line(points={{-79,60},{-62,60}}, color={0,0,127}));
  annotation (experiment(
      StopTime=180,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"), Documentation(revisions="<html>
<ul>
  <li>
    June 14, 2024, by Jun Jiang:<br/>
    First implementation (see <a href=\\\"https://github.com/RWTH-EBC/AixLib/issues/1492\\\">issue 1492</a>)
  </li>
</ul>
</html>", info="<html>
<p>This partial example provides the boundary condition settings for examples of ventilation flow rate.</p>
</html>"));
end PartialExampleVentilationFlowRate;
