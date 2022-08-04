within AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses;
model SolarHourAngleVDI6007 "Calculates the solar hour angle every hour based
  on the equations of VDI 6007 part 3. It is modelled to test other Models
   based on VDI2078. It doesn't consider summer time"

  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Angle lon "Longitude";
  Modelica.Units.SI.Angle J_ "Daily Angle for 105th day of the year";
  Modelica.Units.SI.Time zgl "Time equation";
  Modelica.Units.SI.Time woz "True time";
  Modelica.Blocks.Interfaces.RealOutput solHouAng(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar hour angle"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  constant Modelica.Units.SI.Time day=86400 "Number of seconds in a day";
equation
  J_=Modelica.Units.Conversions.from_deg(360*105/365);
  zgl=0.0066 + 7.3525*Modelica.Math.cos(J_ +
    Modelica.Units.Conversions.from_deg(85.9)) + 9.9359*Modelica.Math.cos(2*J_
     + Modelica.Units.Conversions.from_deg(108.9)) + 0.3387*Modelica.Math.cos(3
    *J_ + Modelica.Units.Conversions.from_deg(105.2));
    woz=(integer(time/3600) - 0.5 - integer(time/day)*24) - 4*(15 -
    Modelica.Units.Conversions.to_deg(lon))/60 + zgl/60;
  solHouAng=(12-woz)*2*Modelica.Constants.pi/24;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>This model computes the solar hour angle for test case 1 and 3 of
VDI2078 in April.
<ul>
  <li>July 17 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end SolarHourAngleVDI6007;
