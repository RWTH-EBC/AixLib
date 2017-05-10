within AixLib.Building.Components.Weather.RadiationOnTiltedSurface.BaseClasses;
partial model PartialRadOnTiltedSurf_bus
  "with bus for solar radiation"
  parameter Integer WeatherFormat = 1 "Format weather file" annotation (Evaluate = true, Dialog(group=
        "Properties of Weather Data",                                                                              compact = true, descriptionLabel = true), choices(choice = 1 "TRY", choice= 2 "TMY", radioButtons = true));
  parameter Modelica.SIunits.Angle Latitude
    "latitude of location"
    annotation (Dialog(group="Location Properties"));
  parameter Real GroundReflection=0.2 "ground reflection coefficient"
    annotation (Dialog(group="Ground reflection"));

  parameter Modelica.SIunits.Angle Azimut
    "azimut of tilted surface, e.g. 0=south, 90=west, 180=north, -90=east" annotation(Dialog(group="Surface Properties"));
  parameter Modelica.SIunits.Angle Tilt
    "tilt of surface, e.g. 0=horizontal surface, 90=vertical surface" annotation (Dialog(group="Surface Properties"));

  Utilities.Interfaces.SolarRad_out   OutTotalRadTilted
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  SolarRadiationBus solarRadiationBus annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-94,16}), iconTransformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-96,8})));

protected
    Modelica.Blocks.Interfaces.RealInput InHourAngleSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-80,10}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-41})));

    Modelica.Blocks.Interfaces.RealInput InDayAngleSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-80,44}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-21})));
    Modelica.Blocks.Interfaces.RealInput InDeclinationSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          origin={-80,-30}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-61})));
  Modelica.Blocks.Interfaces.RealInput solarInput1
    "beam horizontal for TRY; beam for TMY" annotation (Placement(
        transformation(
        origin={-42,100},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={-61,73})));
  Modelica.Blocks.Interfaces.RealInput solarInput2
    "diffuse horizontal for TRY; ground horizontal for TMY" annotation (
      Placement(transformation(
        origin={40,100},
        extent={{-10,-10},{10,10}},
        rotation=270), iconTransformation(
        extent={{-7,-7},{7,7}},
        rotation=270,
        origin={37,73})));
equation
  connect(solarRadiationBus.DayAngleSun, InDayAngleSun) annotation (Line(
      points={{-94.1,16.1},{-84,16.1},{-84,44},{-80,44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(solarRadiationBus.HourAngleSun, InHourAngleSun) annotation (Line(
      points={{-94.1,16.1},{-88,16.1},{-88,10},{-80,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(solarRadiationBus.DeclinationSun, InDeclinationSun) annotation (Line(
      points={{-94.1,16.1},{-84,16.1},{-84,-30},{-80,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  if WeatherFormat == 1 then
    connect(solarRadiationBus.BeamRadHor, solarInput1) annotation (Line(
        points={{-94.1,16.1},{-84,16.1},{-84,100},{-42,100}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(solarRadiationBus.DiffRadHor, solarInput2) annotation (Line(
        points={{-94.1,16.1},{-90,16.1},{-90,18},{-84,18},{-84,100},{40,100}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
  else
    connect(solarRadiationBus.BeamRad, solarInput1) annotation (Line(
        points={{-94.1,16.1},{-84,16.1},{-84,100},{-42,100}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(solarRadiationBus.GlobalRadHor, solarInput2) annotation (Line(
        points={{-94.1,16.1},{-90,16.1},{-90,18},{-84,18},{-84,100},{40,100}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
  end if;
  annotation ( Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for <b>RadOnTiltedSurf</b> modely, which calculate the total solar radiance on a tilted surface. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Resources/Images/Stars/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
</html>", revisions="<html>
<ul>
<li><i>March 23, 2015&nbsp;</i> by Ana Constantin:<br/>Implemented. </li>
</ul>
</html>"));
end PartialRadOnTiltedSurf_bus;
