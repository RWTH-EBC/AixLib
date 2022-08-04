within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Valves;
model ThreeWayValve
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;

  /* *******************************************************************
      Components
     ******************************************************************* */

  Interfaces.EnthalpyPort_b enthalpyPort_a annotation (Placement(transformation(
          extent={{-100,-10},{-80,10}}), iconTransformation(extent={{90,-10},{110,
            10}})));
  Interfaces.EnthalpyPort_a enthalpyPort_ab annotation (Placement(
        transformation(extent={{82,-10},{102,10}}), iconTransformation(extent={{
            -108,-10},{-88,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b annotation (Placement(transformation(
          extent={{-10,-102},{10,-82}}), iconTransformation(extent={{-10,-110},{
            10,-90}})));
  Modelica.Blocks.Interfaces.RealInput opening( unit="1")
    "Valve position [ab=b] 0...1 [ab=a]" annotation (Placement(
        transformation(extent={{-22,40},{18,80}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));

equation
  // mass balance
  enthalpyPort_a.m_flow = enthalpyPort_ab.m_flow*opening;
  - enthalpyPort_ab.m_flow + enthalpyPort_a.m_flow + enthalpyPort_b.m_flow =
    0;
  // constant values
  enthalpyPort_a.T = enthalpyPort_ab.T;
  enthalpyPort_ab.T = enthalpyPort_b.T;
  enthalpyPort_a.c = enthalpyPort_ab.c;
  enthalpyPort_ab.c = enthalpyPort_b.c;
  enthalpyPort_ab.h = enthalpyPort_b.h;
  enthalpyPort_a.h = enthalpyPort_ab.h;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                      graphics), Icon(graphics={Polygon(
                  points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},
            {-100,50}},
                  lineColor={0,0,0},
                  lineThickness=0.5),Line(
                  points={{0,52},{0,0}},
                  color={0,0,0},
                  thickness=0.5),Rectangle(
                  extent={{-20,60},{20,52}},
                  lineColor={0,0,0},
                  fillColor={0,0,0},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-50,0},{50,50},{50,-50},{-50,0}},
                  color={0,0,0},
                  smooth=Smooth.None,
                  origin={0,-50},
                  rotation=270,
                  thickness=0.5),Text(
                  extent={{-80,12},{-60,-12}},
                  lineColor={0,0,0},
                  fontSize=48,
                  textString="AB"),Text(
                  extent={{64,12},{84,-12}},
                  lineColor={0,0,0},
                  textString="A  "),Text(
                  extent={{-6,-56},{14,-80}},
                  lineColor={0,0,0},
                  textString="B  ")}),
     Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a three way valve
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The instreaming flow can be divided into two flows. The ratio of the
  two flows is controlled by the external input.
</p>
</html>",
revisions="<html><ul>
  <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Markus Schumacher:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end ThreeWayValve;
