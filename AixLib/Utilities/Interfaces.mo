within AixLib.Utilities;
package Interfaces "Interfaces that are not defined in MSL or Annex60-Library"
  extends Modelica.Icons.InterfacesPackage;

connector Star "Connector for twostar (approximated) radiation exchange"
  extends Modelica.Thermal.HeatTransfer.Interfaces.HeatPort;
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={95,95,95},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-13,86},{13,86},{13,12},{77,34},{85,6},{22,-14},{62,-72},{
                37,-88},{0,-28},{-35,-88},{-60,-72},{-22,-14},{-85,6},{-77,34},
                {-13,12},{-13,86}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={Rectangle(
            extent={{-82,84},{78,-76}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Polygon(
            points={{-13,86},{13,86},{13,12},{77,34},{85,6},{22,-14},{62,-72},{
                37,-88},{0,-28},{-35,-88},{-60,-72},{-22,-14},{-85,6},{-77,34},
                {-13,12},{-13,86}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>Star</b> connector extends from the <b><a href=\"Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a\">HeatPort</a></b> connector. But the carried data has to be interpreted in a different way: the temperature T is a virtual temperature describing the potential of longwave radiation exchange inside the room. The heat flow Q_flow is the resulting energy flow due to longwave radiation. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>",
        revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
<li><i>July 12, 2009&nbsp;</i>
         by Peter Matthes:<br>
         Switched to Modelica.SIunits.Temperature.</li>
  <li><i>June 16, 2006&nbsp;</i>
         by Timo Haase:<br>
         Implemented.</li>
  
</ul>
</html>"));
end Star;

  connector SolarRad_out "Scalar total radiation connector (output)"
    output Modelica.SIunits.RadiantEnergyFluenceRate I;
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(extent={{18,58},{-98,-58}}, lineColor={255,128,0}),
          Line(
            points={{-40,62},{-40,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{24,0},{78,0}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{6,44},{46,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{20,22},{72,40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-14,58},{-2,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-14,-58},{-2,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{8,-44},{46,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{20,-22},{74,-40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-40,-80},{-40,-62}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{-100,100},{-60,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,6},{-60,28},{-60,28},{-8,0},{-60,-26},{-60,-26},{-60,-6},
                {-60,6}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(extent={{18,58},{-98,-58}}, lineColor={255,128,0}),
          Line(
            points={{-40,62},{-40,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{24,0},{78,0}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{6,44},{46,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{20,22},{72,40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-14,58},{-2,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-14,-58},{-2,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{8,-44},{46,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{20,-22},{74,-40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-40,-80},{-40,-62}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{-100,100},{-60,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-60,6},{-60,28},{-60,28},{-8,0},{-60,-26},{-60,-26},{-60,-6},
                {-60,6}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>SolarRad_out</b> connector is used for total radiation output. Is explicitly defined as an output.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/> </p>
</html>",
        revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately</li>
</ul>
</html>"));

  end SolarRad_out;

  connector SolarRad_in "Scalar total radiation connector (input)"
    input Modelica.SIunits.RadiantEnergyFluenceRate I;
    annotation (
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}), graphics={
          Ellipse(extent={{-20,58},{96,-58}}, lineColor={255,128,0}),
          Rectangle(
            extent={{52,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{38,62},{38,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-24,0},{-78,0}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-6,44},{-46,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-20,22},{-72,40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{14,58},{2,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{14,-58},{2,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-8,-44},{-46,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-20,-22},{-74,-40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{38,-80},{38,-62}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Polygon(
            points={{0,6},{0,28},{0,28},{52,0},{0,-26},{0,-26},{0,-6},{0,6}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics={
          Ellipse(extent={{-20,58},{96,-58}}, lineColor={255,128,0}),
          Rectangle(
            extent={{52,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),
          Line(
            points={{38,62},{38,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-24,0},{-78,0}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-6,44},{-46,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-20,22},{-72,40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{14,58},{2,80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{14,-58},{2,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-8,-44},{-46,-80}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{-20,-22},{-74,-40}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Line(
            points={{38,-80},{38,-62}},
            color={255,128,0},
            smooth=Smooth.Bezier),
          Polygon(
            points={{0,6},{0,28},{0,28},{52,0},{0,-26},{0,-26},{0,-6},{0,6}},
            lineColor={0,0,0},
            fillColor={255,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>The <b>SolarRad_in</b> connector is used for total radiation input. Is explicitly defined as an input.</p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/> </p>
</html>",
        revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
</ul>
</html>"));

  end SolarRad_in;

connector HeatStarComb "Combines therm connector and star connector."

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Therm;
  AixLib.Utilities.Interfaces.Star Star;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
          extent={{-100,102},{102,-100}},
          lineColor={191,0,0},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid),   Polygon(
            points={{-9,86},{17,86},{17,12},{81,34},{89,6},{26,-14},{66,-72},{41,
              -88},{4,-28},{-31,-88},{-56,-72},{-18,-14},{-81,6},{-73,34},{-9,12},
              {-9,86}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,-100},
            {100,100}}),       graphics),  Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
This connector makes a single connection for a combination of Radiation and Convection possible.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/></p>
</html>
",    revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
<li>by Mark Wesseling:<br>Implemented.</li>
</ul>
</html>"));

end HeatStarComb;

  package Adaptors
    extends Modelica.Icons.Package;

    model HeatStarToComb

      AixLib.Utilities.Interfaces.HeatStarComb thermStarComb annotation (Placement(
            transformation(extent={{-120,-10},{-76,36}}), iconTransformation(extent=
               {{-116,-24},{-72,22}})));
    AixLib.Utilities.Interfaces.Star star annotation (Placement(transformation(extent={{84,
                38},{124,78}}), iconTransformation(extent={{84,38},{124,78}})));
      Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a therm annotation (
          Placement(transformation(extent={{84,-68},{118,-34}}),
            iconTransformation(extent={{84,-68},{118,-34}})));
    equation

    connect(thermStarComb.Star,star);
    connect(thermStarComb.Therm,therm);

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -80},{100,80}}),
                        graphics), Icon(coordinateSystem(preserveAspectRatio=
                true, extent={{-100,-80},{100,80}}),
                                        graphics={Polygon(
            points={{-76,0},{86,-72},{86,70},{-76,0}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
               Documentation(info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>This adaptor makes it possible to connect HeatStarComb with either Star or Heat connector or both. </p>
<h4><span style=\"color:#008000\">Level of Development</span></h4>
<p><img src=\"modelica://AixLib/Images/stars3.png\"/> </p>
</html>", revisions="<html>
<ul>
<li><i>Mai 19, 2014&nbsp;</i> by Ana Constantin:<br/>Uses components from MSL and respects the naming conventions</li>
<li><i>April 01, 2014 </i> by Moritz Lauster:<br>Renamed</li>
<li><i>April 10, 2013&nbsp;</i> by Ole Odendahl:<br>Formatted documentation appropriately </li>
<li>by Mark Wesseling:<br>Implemented.</li>
</ul>
</html>"));
    end HeatStarToComb;
  end Adaptors;
end Interfaces;
