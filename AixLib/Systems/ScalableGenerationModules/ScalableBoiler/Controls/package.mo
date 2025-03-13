within AixLib.Systems.ScalableGenerationModules.ScalableBoiler;
package Controls "Holds controls for the ModularBoiler"
  extends Modelica.Icons.Package;

  annotation (Icon(graphics={
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
      Rectangle(
        origin={0,35.149},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Rectangle(
        origin={0,-34.851},
        fillColor={255,255,255},
        extent={{-30.0,-20.1488},{30.0,20.1488}}),
      Line(
        origin={-51.25,0},
        points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
      Polygon(
        origin={-40,35},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
      Line(
        origin={51.25,0},
        points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
      Polygon(
        origin={40,-35},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
<p>The controls for the ModularBoiler include: </p>
<ul>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.BoilerControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.BoilerControl</a>: Top level model of boiler control that puts the components below together.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.FirRatMinCheck\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FirRatMinCheck</a>: Make sure that the firing rate stays above minimal firing rate.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.SafetyControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.SafetyControl</a>: Stops the boiler if the flow temperature exceeds the maxmium flow temperature.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.heatingCurve\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.heatingCurve</a>: Optional control to set flow temperature based on ambient temperature and provided heating curve.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.FeedbackControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FeedbackControl</a>: Optional control to control the return temperature based on a feedback circuit.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ScalableBoiler.Controls.InternalFirRatControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.InternalFirRatControl</a>: Simple PI controller that controls the firing rate based on the provided set temperature.</li>

</ul>
</html>"));
end Controls;
