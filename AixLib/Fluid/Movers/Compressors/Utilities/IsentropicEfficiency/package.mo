within AixLib.Fluid.Movers.Compressors.Utilities;
package IsentropicEfficiency "Package that contains models describing different isentropic efficiencies"
  extends Modelica.Icons.Library;











annotation (Icon(coordinateSystem(preserveAspectRatio=false),
              graphics={
                Ellipse(
                  extent={{-90,-90},{90,90}},
                  lineThickness=0.25,
                  pattern=LinePattern.None,
                  lineColor={215,215,215},
                  fillColor={215,215,215},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-40,60},{-30,70},{-20,60},{-20,60}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{-20,60},{-20,-30},{-20,38},{-16,50},
                          {-6,58},{0,60},{6,58}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5),
                Line(
                  points={{6,58},{16,50},{20,40},{20,-70},
                          {20,-70},{20,-70},{20,-70}},
                  color={0,0,0},
                  smooth=Smooth.Bezier,
                  thickness=0.5)}),
Documentation(revisions="<html><ul>
  <li>October 19, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models describing calculations procedures of
  isentropic efficiencies that are based on a literature review.
  However, in this library the isentropic efficiency is implemented in
  such a way that it fulfills<br/>
  <br/>
  <code>η<sub>ise</sub> = (h<sub>outIse</sub> - h<sub>inl</sub>) /
  (h<sub>out</sub> - h<sub>inl</sub>)</code>.<br/>
  <br/>
  For more information, please checkout <a href=
  \"modelica://AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression\">
  AixLib.Fluid.Movers.Compressors.BaseClasses.PartialCompression</a>.
</p>
<h4>
  Commen model variables
</h4>
<p>
  Calculation procedures presented in the litarture have some variables
  in commen and these variables are presented below:<br/>
</p>
<table summary=\"Inputs and outputs\" border=\"1\" cellspacing=\"0\"
cellpadding=\"2\" style=\"border-collapse:collapse;\">
  <tr>
    <th>
      Variable
    </th>
    <th>
      Comment
    </th>
  </tr>
  <tr>
    <td>
      <code>epsRef</code>
    </td>
    <td>
      Ratio of the real and the ideal displacement volume
    </td>
  </tr>
  <tr>
    <td>
      <code>VDis</code>
    </td>
    <td>
      Displacement volume
    </td>
  </tr>
  <tr>
    <td>
      <code>piPre</code>
    </td>
    <td>
      Pressure ratio
    </td>
  </tr>
  <tr>
    <td>
      <code>rotSpe</code>
    </td>
    <td>
      Rotational speed
    </td>
  </tr>
  <tr>
    <td>
      <code>staInl</code>
    </td>
    <td>
      Thermodynamic state at compressor's inlet conditions
    </td>
  </tr>
  <tr>
    <td>
      <code>staOut</code>
    </td>
    <td>
      Thermodynamic state at compressor's out conditions
    </td>
  </tr>
  <tr>
    <td>
      <code>TAmb</code>
    </td>
    <td>
      Ambient temperature
    </td>
  </tr>
</table>
<p>
  Moreover, two approaches can be identified in general: A polynomial
  and a power approach. The characteristics of these approaches are
  presented below.
</p>
<h4>
  Polynomial approaches
</h4>
<p>
  A generic polynomial approach is presented below:<br/>
  <br/>
  <code>η<sub>ise</sub> = corFact * sum(a[i]*P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  Actually, three polynomial approaches are implemented in this
  package.
</p>
<h4>
  Power approaches
</h4>
<p>
  A generic power approach is presented below:<br/>
  <br/>
  <code>η<sub>ise</sub> = corFact * a * product(P[i]^b[i] for i in
  1:nT)</code><br/>
  <br/>
  Actually, one power approache is implemented in this package.
</p>
<h4>
  References
</h4>
<p>
  In the following, some general references are given for information
  about calculating efficiencies of compressors:
</p>
<p>
  V. A. Cara Martin and R. Radermacher (2015): <a href=
  \"http://www.ahrinet.org/App_Content/ahri/files/RESEARCH/Technical%20Results/AHRI-8013_Final_Report.pdf\">
  AHRI Project 8013: A Study of Methods to Represent Compressor
  Performance Data over an Operating Envelope Based on a Finite Set of
  Test Data</a>. Publisher: <i>Air-Conditioning, Heating, and
  Refrigeration Institute (AHRI)</i>
</p>
</html>"));
end IsentropicEfficiency;
