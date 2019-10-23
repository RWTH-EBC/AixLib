within AixLib.FastHVAC;
package Controller

  model SwitchCounter "Counts the number of switching events"

    Integer n_switch(start=0) "number of switching events";

    Modelica.Blocks.Interfaces.BooleanInput u "switching signal"
      annotation (Placement(transformation(extent={{-120,-30},{-80,10}}),
          iconTransformation(extent={{-100,-10},{-80,10}})));

  initial equation
    pre(u) = false;

  algorithm
    when (u and not
                   (pre(u))) then
           n_switch:=n_switch + 1;
    end when;

    annotation (
    Documentation(info="<html>
<h4>Description of the Switch Counter: </h4>
<p> This model counts the number of times that the logical input <b>u</b> switches from 0 to 1 during the simulation time.</p><br/> 
</html>",   revisions="<html>
<ul>
<li><i>November 28, 2016&nbsp; </i> Tobias Blacha:<br/>
Moved into AixLib</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                           graphics={Rectangle(
            extent={{-86,20},{92,-20}},
            lineColor={0,0,0},
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={215,215,215}), Text(
            extent={{-70,28},{88,-22}},
            lineColor={0,0,0},
            fontName="Square721 BT",
            textString="0|0|0|1|")}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}}), graphics));
  end SwitchCounter;

annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
      Rectangle(
        origin={0.0,35.1488},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Rectangle(
        origin={0.0,-34.8512},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Line(
        origin={-51.25,0.0},
        points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
      Polygon(
        origin={-40.0,35.0},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
      Line(
        origin={51.25,0.0},
        points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
      Polygon(
        origin={40.0,-35.0},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}));
end Controller;
