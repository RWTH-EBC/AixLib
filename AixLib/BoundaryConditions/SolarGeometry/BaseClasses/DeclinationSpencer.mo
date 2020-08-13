within AixLib.BoundaryConditions.SolarGeometry.BaseClasses;
model DeclinationSpencer "Declination angle after (Spencer, 1971)"
  extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput nDay(quantity="Time", unit="s")
      "Day number with units of seconds"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput decAng(
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg") "Solar declination angle"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
    Real B "Auxiliary parameter";

equation
    B = (nDay/24/60/60-1)*360/365*Modelica.Constants.pi/180;
    decAng  = 0.006918-0.399912*Modelica.Math.cos(B)+0.070257*Modelica.Math.sin(B)-
    0.006758*Modelica.Math.cos(2*B)+0.000907*Modelica.Math.sin(2*B)-
    0.002697*Modelica.Math.cos(3*B)+0.00148*Modelica.Math.sin(3*B);
  annotation (Icon(graphics={   Bitmap(extent={{-90,-90},{90,90}}, fileName=
              "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/Declination.png")}));
end DeclinationSpencer;
