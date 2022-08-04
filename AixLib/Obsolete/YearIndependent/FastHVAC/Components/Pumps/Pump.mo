within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Pumps;
model Pump " Ideal pump "
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Medium
     ******************************************************************* */

 parameter FastHVAC.Media.BaseClasses.MediumSimple medium=
      FastHVAC.Media.WaterSimple()
    "Standard charastics for water (heat capacity, density, thermal conductivity)"
    annotation (choicesAllMatching);
protected
  parameter Modelica.Units.SI.SpecificHeatCapacity cp=medium.c
    "Medium's specific heat capacity";
  /* *******************************************************************
      Components
     ******************************************************************* */

public
  Modelica.Blocks.Interfaces.RealInput dotm_setValue( unit="kg/s")
    "External real input to set the mass flow rate" annotation (Placement(
        transformation(
        extent={{-27,-27},{27,27}},
        rotation=270,
        origin={3,67}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
  FastHVAC.Interfaces.EnthalpyPort_a enthalpyPort_a
    "Thermal port for input values (temperature, mass flow rate, specific enthalpy, constant specific heat capacity)"
    annotation (Placement(transformation(extent={{-86,-10},{-66,10}}),
        iconTransformation(extent={{-116,-20},{-76,20}})));
  FastHVAC.Interfaces.EnthalpyPort_b enthalpyPort_b
    "Thermal port for output values (temperature, mass flow rate, specific enthalpy, constant specific heat capacity)"
    annotation (Placement(transformation(extent={{64,-12},{84,8}}),
        iconTransformation(extent={{76,-20},{116,20}})));
equation
  // balances
  enthalpyPort_b.m_flow = dotm_setValue " set value of outlet port ";
  enthalpyPort_b.c = cp " set value of outlet port ";

  // constant values
  enthalpyPort_a.T = enthalpyPort_b.T;
  enthalpyPort_a.h = enthalpyPort_b.h;

    annotation (
    defaultComponentName="pump",
    choicesAllMatching, Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for an ideal pump.
</p>
<h4>
  <span style=\"color:#008000\">Assumptions</span>
</h4>
<p>
  Ideal pump
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The input and output of the pump include respectively following
  values:
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
  The pump uses the real input to set the mass flow rate. The specific
  heat capacity of the medium can be set as a parameter, default value
  is referred to the record SimpleMedium. The temperature and the
  specific enthalpy remain constant.
</p>
<h4>
  <span style=\"color:#008000\">Example Results</span>
</h4>
<p>
  Examples can be found in <a href=
  \"modelica:/AixLib.FastHVAC.Examples.Pumps.Pump\">Pump</a>
</p>
</html>",
    revisions="<html><ul>
  <li>
    <i>December 16, 2014&#160;</i> by Konstantin Finkbeiner:<br/>
    Implemented
  </li>
</ul>
</html> "),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},{100,
            100}}),   graphics={
        Ellipse(extent={{-46,40},{54,-50}}, lineColor={0,0,255}),
        Line(
          points={{-28,28},{54,-8}},
          color={0,0,255},
          smooth=Smooth.None),
        Line(
          points={{54,-8},{-32,-34},{-34,-34}},
          color={0,0,255},
          smooth=Smooth.None)}), Icon(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}),
        graphics={
        Ellipse(
          extent={{-76,78},{76,-78}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,226,113}),
        Polygon(
          points={{-28,30},{-28,-34},{54,0},{-28,30}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={220,220,220}),
        Polygon(
          points={{42,-72},{82,-87},{42,-102},{42,-72}},
          lineColor={176,0,0},
          smooth=Smooth.None,
          fillColor={176,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,-77},{72,-87},{42,-97},{42,-77}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Line(
          points={{77,-87},{-38,-87}},
          color={176,0,0},
          smooth=Smooth.None),
          Text(
          extent={{-150,-90},{150,-130}},
          textString="%name",
          lineColor={0,0,255})}),
    uses(Modelica(version="3.2")));
end Pump;
