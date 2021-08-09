within AixLib.Obsolete.YearIndependent.FastHVAC.Data.Boiler.General;
record Boiler_Vitodens300W_13kW
  "Condesing boiler Viessmann Vitodens 300W 13kW, for Tv/Tr = 50/30 °C"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitodens300W_13kW",
    volume=0.0076,
    PressureDrop=10218000000.0,
    Q_nom=16700,
    Q_min=3600,
    eta=[0.3,1.061; 1.0,0.954]);
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>Mai 03, 2012&#160;</i> by Ana Constantin:<br/>
    implemented.
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
  <li>Product: Vitodens 300 W
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Borschure: Vitodens 300W; 5/2010
  </li>
  <li>Efficiency values from Energieberater
  </li>
  <li>Watervolume and pressure drop from Vitodens 200-F 11kW
  </li>
  <li>Bibtexkey: ViessmannVitodens300W2010
  </li>
</ul>
</html>"));
end Boiler_Vitodens300W_13kW;
