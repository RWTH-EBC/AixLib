within AixLib.FastHVAC.Components.Valves;
model ThreeWayValve

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
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104}),                           iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));

Modelica.Blocks.Continuous.Filter filter(order=2, f_cut=5/(2*Modelica.Constants.pi
      *1))
      annotation (Placement(transformation(extent={{56,60},{70,74}})));
Modelica.Blocks.Interfaces.RealOutput opening_filtzered
  "Filtered valve position in the range 0..1"
  annotation (Placement(transformation(extent={{88,56},{108,76}}),
        iconTransformation(extent={{72,58},{92,78}})));

  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter
    annotation (Placement(transformation(extent={{34,58},{50,74}})));
  Modelica.Blocks.Sources.Constant const(k=1e-3)
    annotation (Placement(transformation(extent={{0,38},{20,58}})));
  Modelica.Blocks.Sources.Constant const1(k=Modelica.Constants.inf)
    annotation (Placement(transformation(extent={{8,78},{28,98}})));
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

   connect(filter.y, opening_filtzered) annotation (Line(points={{70.7,67},{
          79.35,67},{79.35,66},{98,66}},
                                    color={0,0,127}));
  connect(const1.y, variableLimiter.limit1) annotation (Line(points={{29,88},{
          32,88},{32,72.4},{32.4,72.4}}, color={0,0,127}));
  connect(const.y, variableLimiter.limit2) annotation (Line(points={{21,48},{26,
          48},{26,59.6},{32.4,59.6}}, color={0,0,127}));
  connect(variableLimiter.y, filter.u) annotation (Line(points={{50.8,66},{52,
          66},{52,67},{54.6,67}}, color={0,0,127}));
  connect(opening, variableLimiter.u) annotation (Line(points={{0,104},{2,104},
          {2,66},{32.4,66}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(graphics={Polygon(
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
