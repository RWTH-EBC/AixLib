within AixLib.ThermalZones.HighOrder.Components.Sunblinds;
model Sunblind "Reduces beam at Imax and TOutAirLimit"
  extends BaseClasses.PartialSunblind;

  parameter Modelica.Units.SI.Temperature TOutAirLimit
    "Temperature at which sunblind closes (see also Imax)";

  Modelica.Blocks.Interfaces.RealInput TOutAir(unit="K", displayUnit="degC")
    "Outdoor air (dry bulb) temperature"
    annotation (Placement(transformation(extent={{-112,-56},{-80,-24}}), iconTransformation(extent={{-100,-40},{-80,-20}})));
equation
   for i in 1:n loop
     if (Rad_In[i].I>Imax and TOutAir > TOutAirLimit) then
       Rad_Out[i].I=Rad_In[i].I*gsunblind[i];
       Rad_Out[i].I_dir=Rad_In[i].I_dir*gsunblind[i];
       Rad_Out[i].I_diff=Rad_In[i].I_diff*gsunblind[i];
       Rad_Out[i].I_gr=Rad_In[i].I_gr*gsunblind[i];
       Rad_Out[i].AOI=Rad_In[i].AOI;
       sunblindonoff[i]=1-gsunblind[i];
     else // quantity of solar radiation remains unchanged
       Rad_Out[i].I=Rad_In[i].I;
       Rad_Out[i].I_dir=Rad_In[i].I_dir;
       Rad_Out[i].I_diff=Rad_In[i].I_diff;
       Rad_Out[i].I_gr=Rad_In[i].I_gr;
       Rad_Out[i].AOI=Rad_In[i].AOI;
       sunblindonoff[i]=0;
     end if;
     end for;
            annotation ( Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-80,-80},{80,80}}),
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
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  This model represents a sunblind to reduce the vectorial radiance on
  facades, windows. etc.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<ul>
  <li>You can define the amount of radiance hitting the facade with
  gsunblind, which states how much radiance goes through the closed
  sunblind
  </li>
  <li>At which amount of radiance the sunblind will be closed is
  defined by Imax. Each directon is independent from all other
  directions and closes/opens seperately due to the radiance hitting
  the direction.
  </li>
  <li>The output sunblindonoff can be used to transfer the state of the
  shading to another model component. It contains 1-gsunblind, which is
  the amount of radiances, detained by the shading.
  </li>
</ul>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  Each direction closes seperatly, which means that in reality each
  direction has to have his own sensor. It seems, that if a building
  uses automatic shading, the sensor is on the roof and computes the
  radiance on each facade. This is quite similar to the concept of
  different sensors for different directions, as both systems close the
  sunblinds seperately for each direction.
</p>
<p>
  All three components of the solar radiation of the tilted surface
  (direct, diffuse and reflected from ground) are reduced by the same
  factor.
</p>
<p>
  There is no possibilty to disable the sunblind in a specific
  direction. This isn't necessary, as you can set gsunblind in this
  direction to 1, which means, that the whole radiance is passing
  through the closed sunblind.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  This model is part of <a href=
  \"AixLib.Building.Components.Walls.Wall\">Wall</a> and checked in the
  Examples <a href=
  \"AixLib.Building.Examples.Walls.InsideWall\">InsideWall</a> and
  <a href=\"AixLib.Building.Examples.Walls.OutsideWall\">OutsideWall</a>.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>January 16, 2015&#160;</i> by Ana Constantin:<br/>
    Implemented as extending from PartialSunblind and using the new
    solar radiation connectors
  </li>
  <li>
    <i>May 02, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>January 2012,&#160;</i> by Moritz Lauster:<br/>
    Implemented.
  </li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-80,-80},{80,80}})));
end Sunblind;
