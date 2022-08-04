within AixLib.DataBase.Boiler.General;
record Boiler_Vitogas200F_29kW "Gas-fired boiler Viessmann Vitogas200-F 29kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitogas200F_29kW",
    volume=0.0117,
    pressureDrop=6411000000.0,
    Q_nom=32000,
    Q_min=9600,
    eta=[0.3,0.93; 1.0,0.93]);
    annotation (Documentation(revisions="<html><ul>
  <li>
    <i>December 08, 2016&#160;</i> by Moritz Lauster:<br/>
    Adapted to AixLib conventions
  </li>
  <li>
    <i>June 23, 2006&#160;</i> by Ana Constantin:<br/>
    implemented
  </li>
</ul>
</html>", info="<html>
<p>
  Source:
</p>
<ul>
  <li>Product: Vitogas 200-F
  </li>
  <li>Manufacturer: Viessmann
  </li>
  <li>Broschure: Vitogas 200-F; 5/2010
  </li>
</ul>
</html>"));
end Boiler_Vitogas200F_29kW;
