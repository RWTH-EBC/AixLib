within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Pumps;
model FluidSource " Ideal fluid source "
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Medium
     ******************************************************************* */

  parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard  charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
protected
  parameter Modelica.Units.SI.SpecificHeatCapacity cp=medium.c
    "medium's specific heat capacity";
  /* *******************************************************************
      Components
     ******************************************************************* */

public
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b
    "Thermal port for output values (temperature, mass flow rate, specific enthalpy, constant specific heat capacity)"
    annotation (Placement(transformation(extent={{64,-12},{84,8}}),
        iconTransformation(extent={{80,-10},{120,30}})));
  Modelica.Blocks.Interfaces.RealInput T_fluid( unit="K")
    "External real input to set the temperature of the fluid"
    annotation (Placement(transformation(extent={{-100,22},{-60,62}})));
  Modelica.Blocks.Interfaces.RealInput dotm( unit="kg/s")
    "External real input to set the mass flow rate"
    annotation (Placement(transformation(extent={{-100,-46},{-60,-6}})));
equation
  // balances
  enthalpyPort_b.m_flow = dotm " set value of outlet port ";
  enthalpyPort_b.c = cp " set value of outlet port ";
  enthalpyPort_b.T = T_fluid " set value of outlet port ";
  enthalpyPort_b.h = cp*T_fluid " set value of outlet port ";

    annotation (
    defaultComponentName="fluidSource",
    choicesAllMatching, Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for an ideal fluid source with real input connectors to set the
  mass flow and the temperature of the fluid.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The output of the fluid source includes following values:
</p>
<ul>
  <li>mass flow rate
  </li>
  <li>temperature
  </li>
  <li>specific enthalpy
  </li>
  <li>specific heat capacity
  </li>
</ul>
<p>
  <br/>
  The fluid source uses the real input to set the flow mass rate and
  the temperature of the fluid. The specific heat capacity of the
  medium is referred to the record SimpleMedium. The specific enthalpy
  is a dependent variable (h=T*cp).
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  Examples can be found in <a href=
  \"modelica:/AixLib.FastHVAC.Examples.Pumps.FluidSource\">FluidSource</a>
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 25, 2017&#160;</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>December 16, 2014&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html> "),
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                                      graphics={
        Ellipse(extent={{-46,40},{54,-50}}, lineColor={0,0,255}),
        Line(
          points={{-28,28},{54,-8}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{54,-8},{-32,-34},{-34,-34}},
          color={0,0,255},
          smooth=Smooth.None)}), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(
          extent={{-80,94},{80,-66}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,226,113}),
        Polygon(
          points={{-28,68},{-28,-36},{54,16},{-28,68}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={220,220,220}),
          Text(
          extent={{-152,-60},{148,-100}},
          textString="%name",
          lineColor={0,0,255})}));
end FluidSource;
