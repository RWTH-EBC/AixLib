within AixLib.Utilities;
package Sensors "Sensors"
        extends Modelica.Icons.Package;

  model EEnergyMeter

    Modelica.Blocks.Interfaces.RealInput p
      annotation (Placement(transformation(
          origin={-86,0},
          extent={{-14,-14},{14,14}},
          rotation=180)));
    Modelica.SIunits.Conversions.NonSIunits.Energy_kWh q_kwh;
    Modelica.SIunits.Energy q_joule(stateSelect=StateSelect.avoid, start = 0.0);
  equation
    (der(q_joule)) = p;
    q_kwh = Modelica.SIunits.Conversions.to_kWh(q_joule);
    annotation (
      Diagram(graphics),
      Icon(graphics={
          Rectangle(
            extent={{-40,66},{46,-62}},
            lineColor={0,0,255},
            fillColor={95,95,95},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,38},{30,12}},
            lineColor={0,0,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{4,24},{4,14},{4,16}}, color={0,0,0}),
          Line(points={{14,24},{14,14},{14,16}}, color={0,0,0}),
          Line(points={{24,24},{24,14},{24,16}}, color={0,0,0}),
          Line(points={{-6,24},{-6,14},{-6,16}}, color={0,0,0}),
          Line(points={{-14,24},{-14,14},{-14,16}}, color={0,0,0}),
          Line(
            points={{-16,30},{28,30},{26,30}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{0,30},{10,30},{10,30}},
            color={255,0,0},
            thickness=0.5),
          Text(
            extent={{-12,24},{-4,14}},
            lineColor={0,0,0},
            textString=
                 "1"),
          Text(
            extent={{16,24},{24,14}},
            lineColor={0,0,0},
            textString=
                 "1"),
          Text(
            extent={{6,24},{14,14}},
            lineColor={0,0,0},
            textString=
                 "1"),
          Text(
            extent={{-4,24},{4,14}},
            lineColor={0,0,0},
            textString=
                 "1")}),
      Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Model of an electric meter (integration over time of the electric power).
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars2.png\"/></p>
</html>", revisions="<html>
<ul>
<li><i>October 15, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
  <li>
         by Alexander Hoh:<br>
         implemented</li>
<ul>
</html>"));
  end EEnergyMeter;

  model TEnergyMeter "measures thermal power (heat flow)"
    extends EEnergyMeter;

    annotation (Diagram(graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Model that meters the thermal power (heat flow)</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars2.png\"/></p>
</html>", revisions="<html>
<p><ul>
<li><i>October 15, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
  end TEnergyMeter;
end Sensors;
