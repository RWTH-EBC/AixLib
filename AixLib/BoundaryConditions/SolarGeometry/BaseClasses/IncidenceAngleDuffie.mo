within AixLib.BoundaryConditions.SolarGeometry.BaseClasses;
block IncidenceAngleDuffie

 extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Angle lat "Latitude";
  parameter Modelica.SIunits.Angle azi(displayUnit="deg")
    "Surface azimuth. azi=-90 degree if surface outward unit normal points toward east; azi=0 if it points toward south";
  parameter Modelica.SIunits.Angle til(displayUnit="deg")
    "Surface tilt. til=90 degree for walls; til=0 for ceilings; til=180 for roof";
  Modelica.Blocks.Interfaces.RealInput solHouAng(quantity="Angle", unit="rad")
    "Solar hour angle"
    annotation (Placement(transformation(extent={{-140,-68},{-100,-28}})));
  Modelica.Blocks.Interfaces.RealInput decAng(quantity="Angle", unit="rad")
    "Declination"
    annotation (Placement(transformation(extent={{-142,34},{-102,74}})));
  Modelica.Blocks.Interfaces.RealOutput incAng(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Incidence angle on a tilted surface"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

equation
  incAng = acos( sin(decAng)*sin(lat)*cos(til)-sin(decAng)*cos(lat)*sin(til)*cos(azi)
+cos(decAng)*cos(lat)*cos(til)*cos(solHouAng)
+cos(decAng)*sin(lat)*sin(til)*cos(azi)*cos(solHouAng)
+cos(decAng)*sin(til)*sin(azi)*sin(solHouAng));
  annotation (
    defaultComponentName="incAng",
    Documentation(info="<html>
<p>
This component computes the solar incidence angle on a tilted surface using the solar hour angle and the declination angle as input.
</p>
</html>", revisions="<html>
<ul>
<li>
April 27, 2018, by Michael Wetter:<br/>
Corrected <code>displayUnit</code>.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/912\">AixLib, issue 912</a>.
</li>
<li>
Dec 7, 2010, by Michael Wetter:<br/>
Rewrote equation in explicit form to avoid nonlinear equations in room model.
</li>
<li>
May 19, 2010, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={
        Bitmap(extent={{-90,-90},{90,90}}, fileName=
              "modelica://AixLib/Resources/Images/BoundaryConditions/SolarGeometry/BaseClasses/IncidenceAngle.png"),
        Text(
          extent={{-150,110},{150,150}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-98,60},{-56,50}},
          lineColor={0,0,127},
          textString="decAng"),
        Text(
          extent={{-98,-42},{-42,-54}},
          lineColor={0,0,127},
          textString="solHouAng")}));
end IncidenceAngleDuffie;
