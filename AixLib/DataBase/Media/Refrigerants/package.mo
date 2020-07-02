within AixLib.DataBase.Media;
package Refrigerants "Package that provides records describing properties of different refrigerants"
  extends Modelica.Icons.Package;


  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
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
          textString="R1270"),
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
          fillColor={120,120,120})}), Documentation(info="<html><p>
  This package provides records describing properties of different
  refrigerant media. In this case, properties are, for example, fitting
  coefficients obtained for the Helmholtz equation of state or the
  saturation pressure. These fitting coefficients are used for models
  stored in <a href=
  \"modelica://AixLib.Media.Refrigerants\">AixLib.Media.Refrigerants</a>.
</p>
<p>
  For reasons of simplicity, this package is structured as follows:
</p>
<ol>
  <li>
    <i>Base data definitions:</i> All base data definitions are saved
    as separate records.
  </li>
  <li>
    <i>Refrigerant packages:</i> For the different refrigerant media,
    records inherited from the base data definitions are saved within
    one refrigerant package.
  </li>
</ol>
<h4>
  Assumptions and limitations
</h4>
<p>
  Currently, there is implemented just one approach (i.e. the hybrid
  approach) to model refrigerant media (for detailed information,
  please see <a href=
  \"modelica://AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord\">
  AixLib.Media.Refrigerants.Interfaces.TemplateHybridTwoPhaseMediumRecord</a>).
  Hence, the base data definitions support just the hybrid approach.
</p>
<ul>
  <li>June 9, 2017, by Mirko Engelpracht, Christian Vering:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
end Refrigerants;
