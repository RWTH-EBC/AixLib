within AixLib.ThermalZones.ReducedOrder.Windows.Validation.BaseClasses;
block IncidenceAngleVDI6007
  "The solar incidence angle on a tilted surface"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Angle azi(displayUnit="degree") "Surface azimuth. azi=-90 degree if surface outward unit normal points
     toward east; azi=0 if it points toward south";
  parameter Modelica.Units.SI.Angle til(displayUnit="degree")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof";
  Modelica.Blocks.Interfaces.RealInput solAzi(final quantity="Angle",
    final unit="rad")
    "Solar azimuth angle"
    annotation (Placement(transformation(extent={{-140,-68},{-100,-28}})));
  Modelica.Blocks.Interfaces.RealInput alt(final quantity="Angle",
    final unit="rad")
    "solar altitude angle"
    annotation (Placement(transformation(extent={{-142,34},{-102,74}})));
  Modelica.Blocks.Interfaces.RealOutput incAng(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Incidence angle on a tilted surface"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  incAng = max(0, Modelica.Math.acos(Modelica.Math.cos(
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
  til))*Modelica.Math.sin(alt) + Modelica.Math.sin(
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_surfaceTiltVDI(
  til))*Modelica.Math.cos(alt)*Modelica.Math.cos((abs(
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
  azi)-
  AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
  solAzi))))));

  annotation (
    defaultComponentName="incAng",
    Documentation(info="<html><p>
  This component computes the solar incidence angle on a tilted surface
  using the solar hour angle and the declination angle as input.
</p>
<ul>
  <li>Dec 7, 2010, by Michael Wetter:<br/>
    Rewrote equation in explicit form to avoid nonlinear equations in
    room model.
  </li>
  <li>May 19, 2010, by Wangda Zuo:<br/>
    First implementation.
  </li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          lineColor={0,0,255}),
        Bitmap(extent={{-90,-94},{90,92}}, fileName=
              "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/IncidenceAngle.png")}));
end IncidenceAngleVDI6007;
