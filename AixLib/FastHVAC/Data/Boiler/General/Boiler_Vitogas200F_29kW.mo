within AixLib.FastHVAC.Data.Boiler.General;
record Boiler_Vitogas200F_29kW "Gas-fired boiler Viessmann Vitogas200-F 29kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitogas200F_29kW",
    volume=0.0117,
    PressureDrop=6411000000,
    Q_nom=32000,
    Q_min=9600,
    eta=[0.3,0.93; 1.0,0.93]);
                                  annotation (Documentation(revisions="<html>
<ul>
  <li><i>June 19, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately, awarded 5 stars</li>
  <li><i>June 23, 2006&nbsp;</i> by Ana Constantin:<br/>implemented</li>
</ul>
</html>", info="<html>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.HeatGenerators.Boiler.BoilerWithController\">HVAC.Components.HeatGenerators.Boiler.BoilerWithController</a></p>
<p>Source:</p>
<p><ul>
<li>Product: Vitogas 200-F</li>
<li>Manufacturer: Viessmann</li>
<li>Borschure: Vitogas 200-F; 5/2010</li>
<li>Bibtexkey: Viessmann-Vitogas200F2010</li>
</ul></p>
</html>"));
end Boiler_Vitogas200F_29kW;
