within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
block RelToAbsHum "Converts relative humidity to absolute humidity"
  extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput relHum(
    final unit="1")
    "Relative humidity in percent"
    annotation (Placement(transformation(extent={{-140,32},{-100,72}}),
    iconTransformation(extent={{-140,32},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput TDryBul(
    final quantity="ThermodynamicTemperature",
    final unit="K",
    displayUnit="degC")
    "Dry bulb temperature"
    annotation (Placement(transformation(extent={{-140,-76},{-100,-36}}),
    iconTransformation(extent={{-140,-76},{-100,-36}})));
  Modelica.Blocks.Interfaces.RealOutput absHum(
    final quantity="MassFraction",
    final unit="kg/kg")
    "Absolute humidity in kg water to kg air"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
    iconTransformation(extent={{100,-20},{140,20}})));

protected
  parameter Real coefficient = 100 * 18.016 * 287.058/(8314.3 * 101325) * 6.1078
  "Coefficient for Magnus formula";
equation
  absHum * TDryBul =coefficient*TDryBul*10^(7.5*
    Modelica.Units.Conversions.to_degC(TDryBul)/(237.3 +
    Modelica.Units.Conversions.to_degC(TDryBul)))*relHum;
  annotation (Documentation(revisions="<html><ul>
  <li>September 27, 2016 by Moritz Lauster:<br/>
    First Implementation.
  </li>
</ul>
</html>", info="<html>
<p>
  Simple model that converts absolute humidity to relative humidity
  taking into account the air temperature. It is based on Magnus
  formula and the ideal gas law. All coefficients are based on typical
  assumptions and combined to one coefficient for reduction of
  computational effort.
</p>
<p>
  The model has been validated against exemplary values calculated with
  <a href=
  \"http://www.ib-rauch.de/bautens/formel/abs_luftfeucht.html\">http://www.ib-rauch.de/bautens/formel/abs_luftfeucht.html</a>
  and deviate around maximum 2 Percent.
</p>
<h4>
  References
</h4>
<ul>
  <li>
    <a href=
    \"http://www.wetterochs.de/wetter/feuchte.html\">http://www.wetterochs.de/wetter/feuchte.html</a>
  </li>
  <li>
    <a href=
    \"https://en.wikipedia.org/wiki/Ideal_gas_law\">https://en.wikipedia.org/wiki/Ideal_gas_law</a>
  </li>
  <li>
    <a href=
    \"https://en.wikipedia.org/wiki/Density_of_air\">https://en.wikipedia.org/wiki/Density_of_air</a>
  </li>
</ul>
</html>"));
end RelToAbsHum;
