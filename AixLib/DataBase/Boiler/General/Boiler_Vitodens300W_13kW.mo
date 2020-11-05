within AixLib.DataBase.Boiler.General;
record Boiler_Vitodens300W_13kW
  "Condesing boiler Viessmann Vitodens 300W 13kW, for Tv/Tr = 50/30 degC"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitodens300W_13kW",
    volume=0.0076,
    pressureDrop=10218000000.0,
    Q_nom=16700,
    Q_min=3600,
    eta=[0.3,1.061; 1.0,0.954]);
  annotation (Documentation(revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>Mai 03, 2012&#160;</i> by Ana Constantin:<br/>
    implemented.
  </li>
</ul>
</html>", info="<html>
<p>
  Source:
</p>
<ul>
  <li>Product: Vitodens 300 W
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Broschure: Vitodens 300W; 5/2010
  </li>
  <li>Efficiency values from Energieberater
  </li>
  <li>Watervolume and pressure drop from Vitodens 200-F 11kW
  </li>
</ul>
</html>"));
end Boiler_Vitodens300W_13kW;
