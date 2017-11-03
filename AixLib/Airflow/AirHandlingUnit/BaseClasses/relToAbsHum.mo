within AixLib.Airflow.AirHandlingUnit.BaseClasses;
model relToAbsHum "calculation from relative to absolute humidity"
  package Medium = AixLib.Media.Air "Medium model";

  Modelica.Blocks.Interfaces.RealInput relHum( min=0, max=1) "relative Humidity"
    annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  Modelica.Blocks.Interfaces.RealOutput X_w[2] "absolute Humidity"
    annotation (Placement(transformation(extent={{96,-10},{116,10}})));
  Modelica.Blocks.Interfaces.RealInput Tem "Temperature of air"
    annotation (Placement(transformation(extent={{-126,40},{-86,80}})));
  Modelica.Blocks.Interfaces.RealInput p_In "pressure of the fluid"
    annotation (Placement(transformation(extent={{-126,-80},{-86,-40}})));

  Modelica.SIunits.AbsolutePressure pSat "Saturation pressure";



equation
  pSat = Medium.saturationPressure(Tem);
  X_w[1]= AixLib.Utilities.Psychrometrics.Functions.X_pSatpphi(pSat=pSat, p=p_In, phi=relHum);
  X_w[2]=1-X_w[1];

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                               Diagram(coordinateSystem(preserveAspectRatio=false)));
end relToAbsHum;
