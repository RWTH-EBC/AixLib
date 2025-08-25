within AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses;
model SkylineShadowing
  "Calculation of the limit elevation angle for shadowing by a skyline
   (for direct solar irradiation)"
  extends Modelica.Blocks.Icons.Block;
  parameter Integer n(min = 1) "Number of corner points"
      annotation(dialog(group="skyline"));
  parameter Modelica.Units.SI.Angle[n] alpha(displayUnit="deg") "Azimuth of corner points, sorted from north to east to south to west,
     azi=-90 degree if surface outward unit normal points toward east;
     azi=0 if it points toward south" annotation (dialog(group="skyline"));
  parameter Modelica.Units.SI.Height[n] deltaH
    "Difference between height of corner point and the window centre"
    annotation (dialog(group="skyline"));
  parameter Modelica.Units.SI.Distance[n] s
    "Horizontal distance between corner point and window centre"
    annotation (dialog(group="skyline"));
  parameter Boolean[n-1] gap
    "Corner points i and i+1 are gap between buildings: true, else: false"
    annotation(dialog(group="skyline"));

  Modelica.Blocks.Interfaces.RealInput solAzi(
    final quantity="Angle",
    final unit="rad",
    displayUnit="deg") "Solar azimuth"
     annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.RealOutput altLim(
    final quantity="Angle",
    final unit="rad",
    final displayUnit="deg") "Limit elevation angle for shadowing by a skyline"
  annotation (Placement(transformation(extent={{100,-14},{128,14}}),
        iconTransformation(extent={{100,-10},{120,10}})));

protected
  Modelica.Units.SI.Angle[n - 1] X "Calculation factor to simplify equations";
  Modelica.Units.SI.Angle[n - 1] Y "Calculation factor to simplify equations";
  Modelica.Units.SI.Angle altLimi[n - 1](displayUnit="deg")
    "Limit elevation angle for shadowing by a skyline for point i and i+1";
  Modelica.Units.SI.Angle gamma[n](
    min=0,
    max=Modelica.Constants.pi/2,
    displayUnit="deg") "Elevation angle of the obstruction for point i";
equation
  //Calculating gamma
  for i in 1:n loop
    Modelica.Math.tan(gamma[i])=deltaH[i]/s[i];
  end for;
  //Calculating altLim
  for i in 1:(n-1) loop
    X[i] = Modelica.Constants.pi-Y[i]-(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i+1])-
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i]));
    Y[i] = Modelica.Math.atan((Modelica.Math.tan(gamma[i+1])*Modelica.Math.sin(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i+1])-
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i])))/(Modelica.Math.tan(gamma[i])-Modelica.Math.tan(gamma[i+1])*
    Modelica.Math.cos(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i+1])-
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i]))));
    if gap[i] then
      altLimi[i]=-Modelica.Constants.pi/2;
    else
    altLimi[i] = Modelica.Math.atan(Modelica.Math.sin(gamma[i])/
    Modelica.Math.cos(gamma[i])*Modelica.Math.sin(Modelica.Constants.pi-X[i]-(
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    solAzi)-
    AixLib.ThermalZones.ReducedOrder.Windows.BaseClasses.Conversions.to_northAzimuth(
    alpha[i])))/Modelica.Math.sin(X[i]));
    end if;
  end for;
  altLim=max(altLimi);
    annotation(dialog(group="skyline"),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-84,-92},{84,90}}, fileName=
              "modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/SkylineShadowing.png")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html><ul>
  <li>May 23, 2016,&#160; by Stanley Risch:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  This model considers third party shadowing due to horizon vertical
  exaggeration and/or obstruction for direct radiation based on VDI
  6007 part 3. It calculates a limit elevation angle for the sun.
</p>
<p>
  <img alt=\"SkylineShadowing\" src=
  \"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/SkylineShadowing.png\"
  height=\"400\">
</p>
<p>
  <img alt=\"SkylineShadowing\" src=
  \"modelica://AixLib/Resources/Images/ThermalZones/ReducedOrder/Windows/BaseClasses/SkylineShadowing(2).png\"
  height=\"400\">
</p>The figures show how the parameter should be set. For every
considered cornerpoint of the skyline there should be an azimut, a
heightdifference between the cornerpoint and the middle of the window
and a distance between the window centre and the cornerpoint. The
Boolean gap indicates if there is a gap in the skyline and should be
set for every cornerpointpair. In the example above it should be set
{false,false,true,false,false} for the pairs {1+2,2+3,3+4,4+5,5+6}.
<p>
  <b>References</b>
</p>
<p>
  VDI. German Association of Engineers Guideline VDI 6007-3 June 2015.
  Calculation of transient thermal response of rooms and buildings -
  Modelling of solar radiation.
</p>
</html>"));
end SkylineShadowing;
