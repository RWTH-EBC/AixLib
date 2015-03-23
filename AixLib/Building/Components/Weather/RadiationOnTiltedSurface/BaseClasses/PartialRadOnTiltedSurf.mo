within AixLib.Building.Components.Weather.RadiationOnTiltedSurface.BaseClasses;
partial model PartialRadOnTiltedSurf

    Modelica.Blocks.Interfaces.RealInput InHourAngleSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=0,
          origin={-98,0}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-41})));
    Modelica.Blocks.Interfaces.RealInput InDeclinationSun
    annotation (Placement(transformation(
          extent={{-16,-16},{16,16}},
          rotation=0,
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
          rotation=0,
          origin={-98,34}),
          iconTransformation(
          extent={{9,-9},{-9,9}},
          rotation=180,
          origin={-79,-21})));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Partial model for <b>RadOnTiltedSurf</b> modely, which calculate the total solar radiance on a tilted surface. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>", revisions="<html>
<li><i>March 23, 2015&nbsp;</i> by Ana Constantin:<br/>Implemented. </li>
</html>"));
end PartialRadOnTiltedSurf;
