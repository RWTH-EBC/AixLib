within AixLib.Media;
package Refrigerants "Package with models for different refrigerants"
  extends Modelica.Icons.Package;





  annotation (Documentation(info="<html>
<p>
This package contains models for different refrigerants. The models are based
on hybrid approach developed by Sangi et al. and use both the Helmholtz
equation of state (EoS) and fitted formula for thermodynamic state properties
at bubble or dew line (e.g. p<sub>sat</sub> or h<sub>l,sat</sub>) and
thermodynamic state properties depending on two independent state properties
(e.g. T_ph or T_ps).
</p>
<p>
The hybrid approach is implemented in the package
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord\">
AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumRecord
</a>
and the fitting coefficients are stored in records in the package
<a href=\"modelica://AixLib.DataBase.Media.Refrigerants\">
AixLib.DataBase.Media.Refrigerants
</a>.
In order to allow an easy extension, a template for new refrigerant models
using the hybrid approach provided in
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord
</a>.
Moreover, the hybrid approach is also implented in the package
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula\">
AixLib.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMediumFormula
</a>
using the template
<a href=\"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula\">
AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumFormula
</a>.
Within the second template, no records are used to provide the fitting
coefficients. Therefore, the obtained formulas are implemented in an explicit
form in order to speed up the simulation.
</p>
<p>
Currently, the <b>following refrigerants are implemented</b>:
</p>
<ol>
<li>R134a</li>
<li>R290</li>
<li>R410a calculated as pseudo-pure fluid</li>
</ol>
<p>
For further information of <b>the EoS and its partial derivatives</b>, please
read the paper &quot;
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">
HelmholtzMedia - A fluid properties library
</a>
&quot; by Thorade and Saadat as well as the paper &quot;
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic simulation
</a>
&quot; by Thorade and Saadat. For further information of <b>the hybrid
approach</b>, please read the paper &quot;
<a href=\"http://dx.doi.org/10.3384/ecp14096\">
A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic
Simulations
</a>
&quot; by Sangi et al..
</p>
<h4>Assumptions and limitations</h4>
<p>
The refrigerant models in this package are using a hybrid approach and,
therefore, are based on the Helmholtz equation of state as well as on fitted
formula. Hence, the refrigerant models are just valid within the valid range
of the fitted formula. To find out the valid range of each refrigerant model,
please checkout its information.
</p>
<h4>Typical use and important parameters</h4>
<p>
The refrigerant models provided in this package are typically used for heat
pumps and refrigerating machines.
</p>
<h4>References</h4>
<p>
Thorade, Matthis; Saadat, Ali (2012):
<a href=\"http://www.ep.liu.se/ecp/076/006/ecp12076006.pdf\">
HelmholtzMedia - A fluid properties library
</a>. In: <i>Proceedings of the 9th International Modelica Conference</i>;
September 3-5; 2012; Munich; Germany. Link&ouml;ping University Electronic
Press, S. 63&ndash;70.
</p>
<p>
Thorade, Matthis; Saadat, Ali (2013):
<a href=\"http://gfzpublic.gfz-potsdam.de/pubman/item/escidoc:247373:5/component/escidoc:306833/247373.pdf\">
Partial derivatives of thermodynamic state properties for dynamic simulation
</a>. In:<i> Environmental earth sciences 70 (8)</i>, S. 3497&ndash;3503.
</p>
<p>
Sangi, Roozbeh; Jahangiri, Pooyan; Klasing, Freerk; Streblow, Rita;
M&uuml;ller, Dirk (2014): <a href=\"http://dx.doi.org/10.3384/ecp14096\">
A Medium Model for the Refrigerant Propane for Fast and Accurate Dynamic
Simulations</a>. In: <i>The 10th International Modelica Conference</i>. Lund,
Sweden, March 10-12, 2014: Link&ouml;ping University Electronic Press
(Link&ouml;ping Electronic Conference Proceedings), S. 1271&ndash;1275
</p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"), Icon(graphics={
        Ellipse(
          extent={{-90,40},{-54,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-90,-50},{-54,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-90,-40},{-54,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{6,-50},{42,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,40},{42,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,-40},{42,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-42,-50},{-6,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,40},{-6,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-40},{-6,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,-50},{90,30}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,40},{90,20}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,-40},{90,-60}},
          lineColor={255,128,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-88,20},{-56,0}},
          lineColor={28,108,200},
          textString="R134a"),
        Text(
          extent={{-40,20},{-8,0}},
          lineColor={28,108,200},
          textString="R410a"),
        Text(
          extent={{56,20},{88,0}},
          lineColor={28,108,200},
          textString="R290"),
        Text(
          extent={{8,20},{40,0}},
          lineColor={28,108,200},
          textString="R718"),
        Ellipse(
          extent={{-28,-34},{-8,-54}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{18,-20},{38,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{68,-32},{88,-52}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-40,2},{-20,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-86,-36},{-66,-56}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{56,-14},{76,-34}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{8,0},{28,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{68,2},{88,-18}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-88,0},{-68,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-76,-18},{-56,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{-40,-18},{-20,-38}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120}),
        Ellipse(
          extent={{8,-38},{28,-58}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={120,120,120})}));
end Refrigerants;
