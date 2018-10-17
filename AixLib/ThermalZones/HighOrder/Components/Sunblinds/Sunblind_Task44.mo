within AixLib.ThermalZones.HighOrder.Components.Sunblinds;
model Sunblind_Task44 "sunblinds modell after suggestions by IEA Task 44"
  extends BaseClasses.PartialSunblind(
    n=5,
    Imax=300,
    gsunblind={0.25,0.25,0.25,0.25,0.25});

  outer Modelica.SIunits.Temperature Tamb;
  Modelica.SIunits.RadiantEnergyFluenceRate Rad_horizontal;

  parameter Modelica.SIunits.Temperature Tmax=273.15+23.8
    "At temperatures higher than this shading is allowed to be activated";
  parameter Modelica.SIunits.Temperature Tmin=273.15+22.8
    "At temperatures lower than this shading is allowed to be deactivated";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a RoomTempSensor
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=Tmin, uHigh=Tmax)
    annotation (Placement(transformation(extent={{40,60},{20,80}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=273.15 + 12)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{68,60},{48,80}})));
  Modelica.Blocks.Sources.RealExpression realExpression[n](y=Rad_horizontal)
    annotation (Placement(transformation(extent={{-100,26},{-80,46}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis1[n](uLow=fill(Imin, n), uHigh=
        fill(Imax, n))
    annotation (Placement(transformation(extent={{-66,26},{-46,46}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{20,32},{40,52}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=Tamb)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
     parameter Modelica.SIunits.RadiantEnergyFluenceRate Imin=200
    "Intensity at which the sunblind opens again";
  Utilities.Math.MovingAverage
                            movingAverage
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));

equation
   for i in 1:n loop
       Rad_Out[i].I=smooth(1,noEvent(if (and1.y and hysteresis1[i].y) then Rad_In[i].I*gsunblind[i] else Rad_In[i].I));
       Rad_Out[i].I_dir=smooth(1,noEvent(if (and1.y and hysteresis1[i].y) then Rad_In[i].I_dir*gsunblind[i] else Rad_In[i].I_dir));
       Rad_Out[i].I_diff=smooth(1,noEvent(if (and1.y and hysteresis1[i].y) then Rad_In[i].I_diff*gsunblind[i] else Rad_In[i].I_diff));
       Rad_Out[i].I_gr=smooth(1,noEvent(if (and1.y and hysteresis1[i].y) then Rad_In[i].I_gr*gsunblind[i] else Rad_In[i].I_gr));
       Rad_Out[i].AOI=Rad_In[i].AOI;
       sunblindonoff[i]=smooth(1,noEvent(if (and1.y and hysteresis1[i].y) then 1-gsunblind[i] else 0));
   end for;

   Rad_horizontal = Rad_In[5].I; /// !!!!!!!!!!!!!!!!
  connect(realExpression1.y, movingAverage.u) annotation (Line(
      points={{-79,70},{-62,70}},
      color={0,0,127}));
  connect(movingAverage.y, greaterThreshold.u) annotation (Line(
      points={{-39,70},{-12,70}},
      color={0,0,127}));
  connect(realExpression.y, hysteresis1.u) annotation (Line(
      points={{-79,36},{-68,36}},
      color={0,0,127}));
  connect(greaterThreshold.y, and1.u1) annotation (Line(
      points={{11,70},{14,70},{14,42},{18,42}},
      color={255,0,255}));
  connect(hysteresis.y, and1.u2) annotation (Line(
      points={{19,70},{12,70},{12,34},{18,34}},
      color={255,0,255}));
  connect(temperatureSensor1.T, hysteresis.u) annotation (Line(
      points={{48,70},{42,70}},
      color={0,0,127}));
  connect(temperatureSensor1.port, RoomTempSensor) annotation (Line(
      points={{68,70},{90,70}},
      color={191,0,0}));
            annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                                graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={0,0,0},
          fillColor={87,205,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,80},{80,66}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Ellipse(
          extent={{-36,44},{36,-22}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-80,16},{80,2}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-80,32},{80,18}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-80,48},{80,34}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-80,64},{80,50}},
          lineColor={0,0,0},
          fillColor={135,135,135},
          fillPattern=FillPattern.HorizontalCylinder),
        Rectangle(
          extent={{-80,80},{-76,2}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0}),
        Rectangle(
          extent={{76,80},{80,2}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0}),
        Rectangle(
          extent={{-56,-14},{-54,-44}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-59,-17},{-55,-9},{-51,-17}},
          thickness=1),
        Line(
          points={{-51,-41},{-55,-49},{-59,-41}},
          thickness=1),
        Rectangle(
          extent={{-76,-64},{76,-76}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-70,-56},{-12,-70}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="Imax"),
        Rectangle(
          extent={{-2,80},{2,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0},
          origin={0,-78},
          rotation=-90),
        Rectangle(
          extent={{-80,2},{-76,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0}),
        Rectangle(
          extent={{76,2},{80,-76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0}),
        Rectangle(
          extent={{-2,80},{2,-80}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={0,0,0},
          origin={0,78},
          rotation=-90),
        Rectangle(
          extent={{46,-52},{52,-64}},
          lineColor={144,72,0},
          fillColor={144,72,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{42,-38},{56,-54}},
          lineColor={0,127,0},
          fillColor={0,127,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<ul>
<li>Models sunblind position according to IEA Task 44</li>
<li>Normally used as replacable model in Walls.Wall of EBC Building Library</li>
</ul>
<p>Requires a variable Tamb to be able to calculate the running mean of ambient temperature. Should be supplied by inner Modelica.SIunits.Temperature Tamb, see Examples.Weather.sunblind_T44_test for an example how to implement inner data</p>
<h4><span style=\"color:#008000\">Assumptions</span></h4>
<h4><span style=\"color:#008000\">Known Limitations</span></h4>
<p>According to IEA Task 44 sunblindes are lowerd partially based on horizontal global radiation, thus there is no dependance on the buildings orientation, sunblinds are lowered the same for every side of the building</p>
<h4><span style=\"color:#008000\">Concept</span></h4>
<p>Lower the sunblinds to 75 &#37;; if</p>
<ul>
<li>global horizontal radiation exceeds 300 W/m&sup2;</li>
<li>Indoor temperature is &gt; 23,8 &deg;C</li>
<li>running average over last 24 hours of ambient temperature is &gt; 12 &deg;C</li>
</ul>
<p><br/>Return to open windows if:</p>
<ul>
<li>global horizontal radiation is less than 200 W/m&sup2;</li>
<li>Indoor temperature is &gt; 22,8 &deg;C</li>
</ul>
<p><br/><b><font style=\"color: #008000; \">References</font></b></p>
<ul>
<li>IEA Task 44 (http://task44.iea-shc.org/publications)</li>
</ul>
</html>",
        revisions="<html>
<ul>
<li>Implemented: Kristian Huchtemann</li>
<li><i>2013-11-03:</i> Michael Adolph<br/>Adapted to work with Walls.Wall model of EBC Building Library</li>
</ul>
<p>Generalisation of concept</p>
</html>"));
end Sunblind_Task44;
