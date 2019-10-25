within AixLib.FastHVAC.Valves;
model ThreeWayValve
  Interfaces.EnthalpyPort_b enthalpyPort_a annotation (Placement(transformation(
          extent={{80,-10},{100,10}}),   iconTransformation(extent={{90,-10},{110,
            10}})));
  Interfaces.EnthalpyPort_a enthalpyPort_ab annotation (Placement(
        transformation(extent={{-100,-10},{-80,10}}),
                                                    iconTransformation(extent={{
            -108,-10},{-88,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b annotation (Placement(transformation(
          extent={{-10,-102},{10,-82}}), iconTransformation(extent={{-10,-110},{
            10,-90}})));
  Modelica.Blocks.Interfaces.RealInput opening( unit="1")
    "Valve position [ab=b] 0...1 [ab=a]" annotation (Placement(
        transformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,100}),                           iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
equation
  enthalpyPort_a.m_flow = - enthalpyPort_ab.m_flow * opening;
  enthalpyPort_b.m_flow = - enthalpyPort_ab.m_flow * (1 - opening);
  inStream(enthalpyPort_ab.h_outflow) = enthalpyPort_b.h_outflow;
  inStream(enthalpyPort_ab.h_outflow) = enthalpyPort_a.h_outflow;
  enthalpyPort_ab.h_outflow = 0;
  enthalpyPort_ab.dummy_potential =
    (enthalpyPort_a.dummy_potential + enthalpyPort_b.dummy_potential) / 2;
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
     Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span> </b></p>
<p>Model for a three way valve. The opening value describes the separation of the incoming massflow. </p>
<p>Valve opening positions:</p>
<ul>
	<li>0 := [ab=b] </li>
	<li>1 := [ab=a] </li>
</ul>
<p> </p>
<p><b><span style=\"color: #008000;\">Concept</span> </b></p>
<p>The instreaming flow can be divided into two flows. The ratio of the two flows is controlled by the external input. </p>
</html>",
revisions="<html><ul>
  <li>
    <i>October 25, 2019;</i> David Jansen:<br/>
    Reworked for using massflow as flow variable
  </li>
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
