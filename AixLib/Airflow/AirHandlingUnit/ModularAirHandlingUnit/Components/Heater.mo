within AixLib.Airflow.AirHandlingUnit.ModularAirHandlingUnit.Components;
model Heater
  "Idealized model for heater containing heat capacity of heat exchanger"
  extends Components.BaseClasses.PartialHeater;

equation

  // mass balance moisture
  X_airIn = X_airOut;

  annotation (Icon(graphics={Line(
          points={{-76,-58},{-76,-74}},
          color={0,0,0},
          thickness=1), Line(
          points={{-84,-66},{-68,-66}},
          color={0,0,0},
          thickness=1)}), Documentation(info="<html><p>
  This model provides a idealized heater. The model considers the
  convective heat transfer from the heat transfer surface in the air
  stream. Moreover the heat capacity of the heating surface and the
  housing of the heat exchanger is considered.
</p>
<h4>
  Heat transfer model:
</h4>
<p>
  The model assumes a heat transfer in a plane gap. Hence the
  convective heat transfer coefficient is calculated using the
  Nusselt-correlation for a plane gap as described in the
  VDI-Wärmeatlas 2013 (p.800, eq. 45).
</p>
<p style=\"text-align:center;\">
  <i>Nu<sub>m</sub> = 7.55 + (0.024 {Re Pr d<sub>h</sub> ⁄
  l}<sup>1.14</sup>) ⁄ (1 + 0.0358 {Re Pr d<sub>h</sub> ⁄
  l}<sup>0.64</sup> Pr<sup>0.17</sup>)</i>
</p>
</html>", revisions="<html>
<ul>
  <li>April, 2019, by Martin Kremer:<br/>
    First implementation.
  </li>
</ul>
</html>"));
end Heater;
