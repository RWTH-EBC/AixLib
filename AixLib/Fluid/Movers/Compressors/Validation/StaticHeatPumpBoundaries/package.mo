within AixLib.Fluid.Movers.Compressors.Validation;
package StaticHeatPumpBoundaries "This package contains models to validate the comprosser models using 
  static heat pump boundary conditions"
  extends Modelica.Icons.ExamplesPackage;




annotation (Documentation(revisions="<html><ul>
  <li>December 16, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package provides models to validate compressor models using
  static boundary conditions. Therefore, both base models and specified
  models are defined within this package. The specified models inherit
  from the base models. Currently, the following base models are
  defined:
</p>
<ol>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.BaseModelStaticBoundaries\">
    BaseModelStaticBoundaries:</a> Model that prescribes inlet and
    outlet conditions obtained by experimental data.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.BaseModelStaticHeatPump\">
    BaseModelStaticHeatPump:</a> Model that consits of a compressor
    models as well as a static evaporator and a static condenser.
    Boundary conditions are static heat pump condtions obtained by
    experimental data.
  </li>
  <li>
    <a href=
    \"modelica://AixLib.Fluid.Movers.Compressors.Validation.StaticHeatPumpBoundaries.BaseModelStaticHeatPumpController\">
    BaseModelStaticHeatPumpController:</a> Model that consits of a
    compressor models as well as a static evaporator and a static
    condenser. Boundary conditions are heat pump condtions obtained by
    experimental data. Moreover, this model demonstrates how to use a
    controller to follow a precsribed heat capacity.
  </li>
</ol>
<p>
  Additionally, detailed descriptions of the models are provided in
  each model's information section.
</p>
</html>"));
end StaticHeatPumpBoundaries;
