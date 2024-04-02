within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialExampleVentilationFlowRate
  "Boundary conditions for ventilation flow rate examples"
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.Length winClrW = 1.0;
  parameter Modelica.Units.SI.Height winClrH = 1.8;
  Modelica.Blocks.Sources.Ramp T_i_ramp(
    height=15,
    duration=120,
    offset=15,
    startTime=50)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_i
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Sources.Ramp T_a_ramp(
    height=-40,
    duration=160,
    offset=40,
    startTime=10)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Modelica.Blocks.Math.UnitConversions.From_degC from_degC_a
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.CombiTimeTable windSpeed_ctt(
    table=[0,0; 20,0; 30,5; 40,0; 50,10; 60,0; 70,20; 80,0; 100,0; 110,20;
      120,0; 130,10; 140,0; 150,5; 160,0; 180,0],
    columns=2:2)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Sine windDirection_sine(amplitude=2*Modelica.Constants.pi,
      f=0.05) annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(T_i_ramp.y, from_degC_i.u)
    annotation (Line(points={{-79,90},{-62,90}}, color={0,0,127}));
  connect(T_a_ramp.y, from_degC_a.u)
    annotation (Line(points={{-79,60},{-62,60}}, color={0,0,127}));
  annotation (experiment(
      StopTime=180,
      Interval=0.1,
      __Dymola_Algorithm="Dassl"), Documentation(revisions="<html>
<ul>
  <li>
    <i>April 2, 2024&#160;</i> by Jun Jiang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PartialExampleVentilationFlowRate;
