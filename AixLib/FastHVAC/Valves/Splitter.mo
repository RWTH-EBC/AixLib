within AixLib.FastHVAC.Valves;
model Splitter
  parameter Integer n(min=1) = 1 "Number of output flows";
  parameter Real dummy_potential_start = 1;
  Modelica.SIunits.MassFlowRate m_flow;
  Interfaces.EnthalpyPort_a enthalpyPort_a
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b[n]
  "1-dimensional imput port n-dimensional output port" annotation (Placement(transformation(extent={{90,-10},{110,10}})));
//  Real dummy_potential = if n > 0 then enthalpyPort_b[1].dummy_potential else dummy_potential_start;

equation

  //   sum(enthalpyPort_b.dummy_potential)/n = enthalpyPort_a.dummy_potential;
//    enthalpyPort_b[1].dummy_potential = enthalpyPort_a.dummy_potential;
dummy_potential = enthalpyPort_a.dummy_potential;
  for k in 1:n loop
    enthalpyPort_a.m_flow / n = - enthalpyPort_b[k].m_flow;
    enthalpyPort_b[k].h_outflow = inStream(enthalpyPort_a.h_outflow);
    enthalpyPort_a.h_outflow = 0;
  end for;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                           graphics), Icon(coordinateSystem(preserveAspectRatio=
           false, extent={{-100,-100},{100,100}}), graphics={Polygon(
          points={{-100,20},{-20,20},{20,60},{100,60},{100,60},{100,40},{30,40},
              {0,10},{100,10},{100,-10},{96,-10},{0,-10},{30,-40},{100,-40},{
              100,-60},{20,-60},{-20,-20},{-100,-20},{-100,-18},{-100,20}},
          lineColor={0,0,0},
          smooth=Smooth.None,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Model for a splitter
</p>
<h4>
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars2.png\" alt=\"\" />
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Splits the input flow evenly in n output flows.
</p>
</html>",
revisions="<html><ul>
 <li>
    <i>Ocotober 24, 2019</i>, by David Jansen:<br/>
    Reworked for using massflow as flow variable
 </li>   
 <li>
    <i>April 13, 2017&#160;</i> Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>February 22, 2014&#160;</i> by Nicolás Chang:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end Splitter;
