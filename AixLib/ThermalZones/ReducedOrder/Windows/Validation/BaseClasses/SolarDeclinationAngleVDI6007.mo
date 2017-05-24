within AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses;
model SolarDeclinationAngleVDI6007 "Calculates the solar azimuth angle based on
  the equations of VDI 6007 part 3.
  It is modelled to test other models based on VDI2078. "
  extends Modelica.Blocks.Icons.Block;
  import Modelica.SIunits.Conversions.from_deg;

  Modelica.Blocks.Interfaces.RealOutput decAng(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar declination angle"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
    constant Modelica.SIunits.Time day=86400 "Number of seconds in a day";
    Modelica.SIunits.Angle J_;
equation
  J_=from_deg(360*105/365);
  decAng=from_deg(0.3948-23.2559*Modelica.Math.cos(J_+from_deg(9.1))-0.3915
  *Modelica.Math.cos(2*J_+from_deg(5.4))-0.1764*Modelica.Math.cos(3*J_+from_deg(26)));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
This model computes the solar declination angle for test case 1 and 3 of
the VDI2078 in April.
</html>"));
end SolarDeclinationAngleVDI6007;
