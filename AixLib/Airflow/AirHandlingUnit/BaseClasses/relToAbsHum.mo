within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model relToAbsHum "calculation from relative to absolute humidity"
  package Medium = AixLib.Media.Air "Medium model";

  Modelica.Blocks.Interfaces.RealInput relHum( min=0, max=1) "relative Humidity"
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Blocks.Interfaces.RealOutput absHum "absolute Humidity"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Interfaces.RealInput Tem "Temperature of air"
    annotation (Placement(transformation(extent={{-126,38},{-86,78}})));

  parameter Modelica.SIunits.Pressure p = 101325 "Pressure of the fluid";
  Modelica.SIunits.AbsolutePressure pSat "Saturation pressure";


equation
  pSat = Medium.saturationPressure(Tem);
  absHum= AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(pSat=pSat, p=p, phi=relHum);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                               Diagram(coordinateSystem(preserveAspectRatio=false)));
end relToAbsHum;
