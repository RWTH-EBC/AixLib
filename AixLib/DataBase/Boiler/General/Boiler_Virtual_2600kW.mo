within AixLib.DataBase.Boiler.General;
record Boiler_Virtual_2600kW
  "Virtual 2600 kW Boiler inspired by the Remeha Gas 610 Eco Pro with 710 kW"
   extends BoilerTwoPointBaseDataDefinition(
    name="Virtual_2600kW",
    volume=0.12,
    PressureDrop=3240000000,
    Q_nom=2600000,
    Q_min=200000,
    eta=[0.1,0.95; 0.5, 0.97; 1.0,1.0]);
                                  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>June 19, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately, awarded 5 stars
  </li>
  <li>
    <i>June 23, 2006&#160;</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<h4>
  <font color=\"#008000\">Level of Development</font>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars5.png\" alt=\"\" />
</p>
<h4>
  <font color=\"#008000\">References</font>
</h4>
<p>
  Record is used with <a href=
  \"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>Product: Vitogas 200-F
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Borschure: Vitogas 200-F; 5/2010
  </li>
  <li>Bibtexkey: Viessmann-Vitogas200F2010
  </li>
</ul>
</html>"));
end Boiler_Virtual_2600kW;
