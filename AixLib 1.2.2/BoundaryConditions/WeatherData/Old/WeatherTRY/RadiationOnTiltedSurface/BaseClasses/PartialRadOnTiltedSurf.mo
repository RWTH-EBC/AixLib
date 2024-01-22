within AixLib.BoundaryConditions.WeatherData.Old.WeatherTRY.RadiationOnTiltedSurface.BaseClasses;
partial model PartialRadOnTiltedSurf
  parameter Integer WeatherFormat = 1 "Format weather file" annotation (Dialog(group=
        "Properties of Weather Data",                                                                              compact = true, descriptionLabel = true), choices(choice = 1 "TRY", choice= 2 "TMY", radioButtons = true));
  parameter Modelica.Units.NonSI.Angle_deg Latitude=49.5 "latitude of location"
    annotation (Dialog(group="Location Properties"));
  parameter Real GroundReflection=0.2 "ground reflection coefficient"
    annotation (Dialog(group="Ground reflection"));

  parameter Modelica.Units.NonSI.Angle_deg Azimut=13.400
    "azimut of tilted surface, e.g. 0=south, 90=west, 180=north, -90=east"
    annotation (Dialog(group="Surface Properties"));
  parameter Modelica.Units.NonSI.Angle_deg Tilt=90
    "tilt of surface, e.g. 0=horizontal surface, 90=vertical surface"
    annotation (Dialog(group="Surface Properties"));

    Modelica.Blocks.Interfaces.RealInput InHourAngleSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-98,0}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-41})));
    Modelica.Blocks.Interfaces.RealInput InDeclinationSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-98,-40}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-61})));
  Modelica.Blocks.Interfaces.RealInput solarInput1
    "beam horizontal for TRY; beam for TMY" annotation (Placement(
        transformation(
        origin={-60,90},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-61,73})));
  Modelica.Blocks.Interfaces.RealInput solarInput2
    "diffuse horizontal for TRY; ground horizontal for TMY" annotation (
      Placement(transformation(
        origin={22,90},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={37,73})));
  Utilities.Interfaces.SolarRad_out   OutTotalRadTilted
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
public
    Modelica.Blocks.Interfaces.RealInput InDayAngleSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-98,34}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-21})));
  annotation ( Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Partial model for <b>RadOnTiltedSurf</b> modely, which calculate the
  total solar radiance on a tilted surface.
</p>
<ul>
  <li>
    <i>March 23, 2015&#160;</i> by Ana Constantin:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end PartialRadOnTiltedSurf;
