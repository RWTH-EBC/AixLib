within AixLib.Fluid;
package FixedResistances "Package with models for fixed flow resistances"
  extends Modelica.Icons.VariantsPackage;

  annotation (preferredView="info", Documentation(info="<html><p>
  This package contains component models for fixed flow resistances. By
  fixed flow resistance, we mean resistances that do not change the
  flow coefficient
</p>
<p style=\"text-align:center;font-style:italic;\">
  k = m ⁄ √<span style=\"text-decoration:overline;\">ΔP</span>.
</p>
<p>
  For models of valves and air dampers, see <a href=
  \"modelica://AixLib.Fluid.Actuators\">AixLib.Fluid.Actuators</a>. For
  models of flow resistances as part of the building constructions, see
  <a href=
  \"modelica://AixLib.Airflow.Multizone\">AixLib.Airflow.Multizone</a>.
</p>
<p>
  The model <a href=
  \"modelica://AixLib.Fluid.FixedResistances.PressureDrop\">AixLib.Fluid.FixedResistances.PressureDrop</a>
  is a fixed flow resistance that takes as parameter a nominal flow
  rate and a nominal pressure drop. The actual resistance is scaled
  using the above equation.
</p>
<p>
  The model <a href=
  \"modelica://AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>
  is a fixed flow resistance that takes as parameter a nominal flow
  rate and a hydraulic diameter. The actual resistance is scaled using
  the above equation.
</p>
<p>
  The model <a href=
  \"modelica://AixLib.Fluid.FixedResistances.LosslessPipe\">AixLib.Fluid.FixedResistances.LosslessPipe</a>
  is an ideal pipe segment with no pressure drop. It is primarily used
  in models in which the above pressure drop model need to be replaced
  by a model with no pressure drop.
</p>
<p>
  The model <a href=
  \"modelica://AixLib.Fluid.FixedResistances.Junction\">AixLib.Fluid.FixedResistances.Junction</a>
  can be used to model flow splitters or flow merges.
</p>
</html>"));
end FixedResistances;
