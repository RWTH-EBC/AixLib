within AixLib.Media;
package Refrigerants "Package with models for different refrigerants"
  package Interfaces "Package with interfaces for refrigerant models"
    extends Modelica.Icons.InterfacesPackage;
    model TemplateHybridTwoPhaseMedium
      "Template for media models using a hybrid aprroach"
      extends Modelica.Icons.MaterialPropertiesPackage;
      annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>",   info="<html>
<p>This package is a <b>template</b> for <b>new medium</b> models using a hybrid approach (for detailed information please see <a href=\"modelica://Modelica.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium\">Modelica.Media.Refrigerants.Interfaces.PartialHybridTwoPhaseMedium</a>). For a new refrigerant model just make a copy of this package, remove the &QUOT;partial&QUOT; keyword from the package and provide the information that is requested in the comments of the Modelica source. A refrigerant package inherits from <b>PartialHybridTwoPhaseMedium</b> and provides the equations for the refrigerant. Moreover, the PartialHybridTwoPhaseMedium package inherits from <b>PartialMedium</b> and, therefore, the details of this package are described in <a href=\"modelica://Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</p>
</html>"));
    end TemplateHybridTwoPhaseMedium;

    partial package PartialHybridTwoPhaseMedium
      "Base class for two phase medium using a hybrid approach"
      extends Modelica.Icons.MaterialPropertiesPackage;
      annotation (Documentation(revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>", info="<html>
<p>A detailed documentation will follow later.</p>
<ul>
<li>Which approach is provided?</li>
<li>Source?</li>
<li>Why hybrid? (Polynomial fits and Helmholtz EoS)</li>
</ul>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>"));
    end PartialHybridTwoPhaseMedium;
    annotation (Documentation(info="<html>
<p>This package provides basic interfaces for the definition of new refrigerant models.</p><p>A detailed documentation will follow later (e.g. which aprroaches are provided within this package).</p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end Interfaces;

  package R134a "Package with models for the refrigerant R134a"
    extends Modelica.Icons.VariantsPackage;
    annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end R134a;

  package R410a "Package with models for the refrigerant R410a"
    extends Modelica.Icons.VariantsPackage;
    annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<p><b>Main equations</b> </p>
<p>xxx </p>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Options</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>Implementation</b> </p>
<p>xxx </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
  </li>
</ul>
</html>"));
  end R410a;
  annotation (Documentation(info="<html>
<p>A detailed documentation will follow later. </p>
<ul>
<li>What is implemented so far?</li>
<li>e.g. Approaches and refrigerants</li>
<li>e.g. Limitations for implemented refrigerants</li>
<li>Main references?</li>
</ul>
<p><b>Assumptions and limitations</b> </p>
<p>xxx </p>
<p><b>Typical use and important parameters</b> </p>
<p>xxx </p>
<p><b>Dynamics</b> </p>
<p>Describe which states and dynamics are present in the model and which parameters may be used to influence them. This need not be added in partial classes. </p>
<p><b>Validation</b> </p>
<p>Describe whether the validation was done using analytical validation, comparative model validation or empirical validation. </p>
<p><b>References</b> </p>
<p>xxx </p>
</html>", revisions="<html>
<ul>
  <li>
  June 6, 2017, by Mirko Engelpracht:<br/>
  First implementation (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/408\">issue 408</a>).
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
          textString="R1270"),
        Text(
          extent={{8,20},{40,0}},
          lineColor={28,108,200},
          textString="R744"),
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
