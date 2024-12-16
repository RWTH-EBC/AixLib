within AixLib.Systems.ScalableGenerationModules;
package ModularBoiler
    extends Modelica.Icons.VariantsPackage;
  annotation (Documentation(info="<html>
<p>The ModularBoiler package uses the <a href=\"modelica://AixLib.Fluid.BoilerCHP.BoilerGeneric\">AixLib.Fluid.BoilerCHP.BoilerGeneric</a> model to create an easy to use module. For detailed documentation see <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler\">AixLib.Systems.ScalableGenerationModules.ModularBoiler</a></p>
<h4>Controls</h4>#
<p>The controls for the ModularBoiler include: </p>
<ul>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.BoilerControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.BoilerControl</a>: Top level model of boiler control that puts the components below together.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FirRatMinCheck\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FirRatMinCheck</a>: Make sure that the firing rate stays above minimal firing rate.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.SafetyControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.SafetyControl</a>: Stops the boiler if the flow temperature exceeds the maxmium flow temperature.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.heatingCurve\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.heatingCurve</a>: Optional control to set flow temperature based on ambient temperature and provided heating curve.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FeedbackControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.FeedbackControl</a>: Optional control to control the return temperature based on a feedback circuit.</li>
<li>  <a href=\"modelica://AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.InternalFirRatControl\">AixLib.Systems.ScalableGenerationModules.ModularBoiler.Controls.InternalFirRatControl</a>: Simple PI controller that controls the firing rate based on the provided set temperature.</li>

</ul>
</html>"));
end ModularBoiler;
