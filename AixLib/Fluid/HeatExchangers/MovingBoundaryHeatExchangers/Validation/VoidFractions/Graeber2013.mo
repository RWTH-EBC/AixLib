within AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Validation.VoidFractions;
model Graeber2013
  "Validation model to check the derivative of the void fraction model"
  extends Modelica.Icons.Example;

  // Definition of input variables
  //
  Modelica.Blocks.Sources.Ramp ramPre(
    duration=500,
    height=35e5,
    offset=1e5)
    "Ramp to provide saturation pressure"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  // Definition of the void fraction model
  //
  Utilities.VoidFractions.Graeber2013 voiFraMod(
    redeclare package Medium = Modelica.Media.R134a.R134a_ph,
    p = ramPre.y,
    hSCTP = 250e3,
    hTPSH = 250e3,
    modCV=Utilities.Interfaces.ModeCVInput.TP)
    "Model that computes the void fraction"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  annotation (Documentation(revisions="<html>
<ul>
  <li>
  December 09, 2017, by Mirko Engelpracht:<br/>
  First implementation
  (see <a href=\"https://github.com/RWTH-EBC/AixLib/issues/516\">issue 516</a>).
  </li>
</ul>
</html>", info="<html>
<p>
This validation model checks the implementation of the derivative
of the void fraction model 
<a href=\"modelica://AixLib.Fluid.HeatExchangers.MovingBoundaryHeatExchangers.Utilities.VoidFractions.Graeber2013\">
Graeber2013</a> wrt. time.<br/><br/>
Therefore, the void fraction calculated by the model is 
differentiated first and integrated again. Moreover, this
model checks the usage of a first-order delay to smooth
the sudden change of void fraction that may occur while
switching flow states within a moving boundary heat exchanger.
</p>
</html>"), experiment(StopTime=750));
end Graeber2013;
