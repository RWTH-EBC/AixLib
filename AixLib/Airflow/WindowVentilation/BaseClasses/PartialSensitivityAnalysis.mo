within AixLib.Airflow.WindowVentilation.BaseClasses;
partial model PartialSensitivityAnalysis "Sensitivity analysis"
  /*Parameters for boundary conditions*/
  parameter Modelica.Units.SI.Length winClrWidth(min=0)=1.0
    "Width of the window clear opening";
  parameter Modelica.Units.SI.Height winClrHeight(min=0)=1.0
    "Height of the window clear opening";
  parameter Modelica.Units.SI.Angle aziRef(displayUnit="deg")=0
    "Azimuth angle of the referece surface impacted by wind";
  parameter Modelica.Units.SI.Height locHeight(min=0)=5
    "Middle local height of the ventilation zone";
  Modelica.Blocks.Interfaces.RealInput TRoom(final unit="K")
    "Room temperature"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput TAmb(final unit="K")
    "Ambient temperature"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput winSpe10(unit="m/s")
    "Local wind speed at a height of 10 m"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Modelica.Blocks.Interfaces.RealInput winDir(final unit="rad",
    displayUnit="deg")
    "Local wind direction"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  AixLib.Airflow.WindowVentilation.Utilities.WindProfilePowerLaw winSpeProLoc(
    height=locHeight, heightRef=10)
    "Calculate wind speed profile local"
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
equation
  connect(winSpe10, winSpeProLoc.winSpeRef)
    annotation (Line(points={{-120,-20},{-82,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialSensitivityAnalysis;
