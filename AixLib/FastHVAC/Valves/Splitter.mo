within AixLib.FastHVAC.Valves;
model Splitter

  parameter Integer nOut = 2 "Number of splitter outputs";
  parameter Integer nIn = 1 "Number of splitter inputs";
  parameter Real splitFactor[nOut, nIn] = fill(1/nOut, nOut, nIn)
    "Matrix of split factor for outputs (between 0 and 1 for each row)";
  Modelica.SIunits.SpecificEnthalpy h_outflow_mixed
    "mixed specific enthalpy leaving port b";
  Interfaces.EnthalpyPort_a enthalpyPort_a[nIn]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Interfaces.EnthalpyPort_b enthalpyPort_b[nOut]
  "1-dimensional imput port n-dimensional output port" annotation (Placement(transformation(extent={{90,-10},{110,10}})));

equation
  enthalpyPort_b.m_flow = - enthalpyPort_a.m_flow * transpose(splitFactor)
    "Connecting the output vector according to desired dimension";
  enthalpyPort_a.dummy_potential = enthalpyPort_b.dummy_potential * splitFactor
    "Equivalent building temperature rerouted to SignalInput";
  h_outflow_mixed =
   sum(inStream(enthalpyPort_a.h_outflow) * enthalpyPort_a.m_flow)
   / sum(enthalpyPort_a.m_flow);
  enthalpyPort_a.h_outflow = fill(0, nIn);
  enthalpyPort_b.h_outflow = fill(h_outflow_mixed, nOut);
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),       Icon(coordinateSystem(preserveAspectRatio=
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
