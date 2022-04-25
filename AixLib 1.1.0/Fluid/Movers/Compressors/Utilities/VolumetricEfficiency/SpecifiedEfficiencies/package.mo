within AixLib.Fluid.Movers.Compressors.Utilities.VolumetricEfficiency;
package SpecifiedEfficiencies "Package that engine efficiencies that are specifiied"
  extends Modelica.Icons.VariantsPackage;

  annotation (Documentation(revisions="<html><ul>
  <li>December 01, 2017, by Mirko Engelpracht:<br/>
    First implementation (see <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/467\">issue 467</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains volumetrtic efficiencies that are already
  specified. This means that the calculation approaches of the
  volumetrtic efficiency presented before are adapted for a specific
  compressor type and a specific refrigerant.
</p>
<h4>
  Naming and abbreviations
</h4>
<p>
  In the following, a guideline of naming efficiency models is
  summarised:
</p>
<p style=\"margin-left: 30px;\">
  <i>Approach of calculating efficiency</i> _ <i>Valid refrigerants</i>
  _ <i>Displacement volume</i> _ <i>Type of compressor</i>
</p>
<p>
  Moreover, the modeles are saved in a specific order. First, generic
  models are saved and then models based on the similitude theory are
  saved. Last, models of specific compressors are saved.
</p>
</html>"));
end SpecifiedEfficiencies;
