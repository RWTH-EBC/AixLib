within AixLib.DataBase.Boiler.General;
record Boiler_Vitodens300W_11kW
  "Condesing boiler Viessmann Vitodens 300W 11kW, for Tv/Tr = 50/30 degC"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitodens300W_11kW",
    volume=0.0042,
    pressureDrop=17025510099,
    Q_flowFuel_nominal=10300,
    Q_flow_nominal=11000,
    Q_min=3600,
    eta=[0.173,1.056; 1.0,1.068]);
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
end Boiler_Vitodens300W_11kW;
