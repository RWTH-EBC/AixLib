within AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.General;
record Boiler_Vitogas200F_48kW "Gas-fired boiler Viessmann Vitogas200-F 48kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitogas200F_48kW",
    volume=0.0159,
    PressureDrop=3240000000.0,
    Q_nom=53000,
    Q_min=15900,
    eta=[0.3,0.93; 1.0,0.93]);
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
  <span style=\"color:#008000\">Level of Development</span>
</h4>
<p>
  <img src=\"modelica://HVAC/Images/stars5.png\" alt=\"\">
</p>
<h4>
  <span style=\"color:#008000\">References</span>
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
end Boiler_Vitogas200F_48kW;
