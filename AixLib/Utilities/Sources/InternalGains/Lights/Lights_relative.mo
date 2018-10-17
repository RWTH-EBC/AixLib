within AixLib.Utilities.Sources.InternalGains.Lights;
model Lights_relative "light heat source model"
  extends BaseClasses.PartialInternalGain(ratioConv=0.5, RadiativeHeat(T_ref=T0));
  parameter Modelica.SIunits.Area RoomArea=20 "Area of room"    annotation(Dialog( descriptionLabel = true));
  parameter Real LightingPower = 10 "Heating power of lighting in W/m2" annotation(Dialog( descriptionLabel = true));
  parameter Modelica.SIunits.Area SurfaceArea_Lighting=1;
  parameter Real Emissivity_Lighting = 0.98;
  Modelica.Blocks.Sources.Constant MaxLighting(k=RoomArea*LightingPower)
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Math.MultiProduct productHeatOutput(nu=2)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Utilities.HeatTransfer.HeatToStar
                                  RadiationConvertor(
                              eps=Emissivity_Lighting, A=max(1e-4,
        SurfaceArea_Lighting))
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
equation
  connect(MaxLighting.y,productHeatOutput. u[2])
                                          annotation (Line(
      points={{-69,50},{-48,50},{-48,-3.5},{-40,-3.5}}));
  connect(Schedule,productHeatOutput. u[1]) annotation (Line(
      points={{-100,0},{-76,0},{-76,-20},{-48,-20},{-48,-4},{-40,-4},{-40,3.5}},
      color={0,0,127}));
  connect(RadiativeHeat.port, RadiationConvertor.Therm) annotation (Line(
      points={{40,-10},{46,-10},{46,-60},{50.8,-60}},
      color={191,0,0}));
  connect(RadiationConvertor.Star, RadHeat) annotation (Line(
      points={{69.1,-60},{90,-60}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(productHeatOutput.y, gain.u) annotation (Line(
      points={{-18.3,0},{-8,0},{-8,30},{3.2,30}},
      color={0,0,127}));
  connect(productHeatOutput.y, gain1.u) annotation (Line(
      points={{-18.3,0},{-8,0},{-8,-10},{3.2,-10}},
      color={0,0,127}));
  annotation (Icon(graphics={
        Ellipse(
          extent={{-52,72},{50,-40}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-26,-48},{22,-48}},
          thickness=1),
        Line(
          points={{-24,-56},{22,-56}},
          thickness=1),
        Line(
          points={{-24,-64},{22,-64}},
          thickness=1),
        Line(
          points={{-24,-72},{22,-72}},
          thickness=1),
        Line(
          points={{-28,-42},{-28,-80},{26,-80},{26,-42}},
          thickness=1)}), Documentation(revisions="<html>
<ul>
<li><i>October 21, 2014&nbsp;</i> by Ana Constantin:<br/>Added a lower positive limit to the surface area, so it will not lead to a division by zero</li>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>May 07, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Light heat source model. Maximum lighting can be given as input and be adjusted by a schedule input.</p>
<h4><span style=\"color:#008000\">Known limitation</span></h4>
<p>The parameter <b>A</b> cannot be set by default since other models must be able to implement their own equations for <b>A</b>. For a model with variable area <b>A</b> refer to <a href=\"Building.Components.Sources.InternalGains.Lights.Lights_Avar\">Lights_Avar</a>.</p>
<p>The input signal can take values from 0 to 1, and is then multiplied with the maximum lighting power per square meter and the room area. </p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<p>The surface for radiation exchange is computed from the schedule, which leads to a surface area of zero, when no activity takes place. In particular cases this might lead to an error as depending of the rest of the system a division by this surface will be introduced in the system of equations -&gt; division by zero. For this reason a lower limitation of 1e-4 m2 has been introduced.</p>
<h4><span style=\"color:#008000\">Example Results</span></h4>
<p><a href=\"AixLib.Building.Examples.Sources.InternalGains.Lights\">AixLib.Building.Examples.Sources.InternalGains.Lights</a> </p>
<p><a href=\"AixLib.Building.Examples.Sources.InternalGains.OneOffice\">AixLib.Building.Examples.Sources.InternalGains.OneOffice</a></p>
</html>"));
end Lights_relative;
