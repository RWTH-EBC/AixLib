within AixLib.DataBase.Boiler.General;
record Boiler_Vitogas200F_42kW "Gas-fired boiler Viessmann Vitogas200-F 42kW"
  extends BoilerTwoPointBaseDataDefinition(
    name="Vitogas200F_42kW",
    volume=0.0159,
    a=4.0370E+9,
    n=1.9884,
    Q_nom=46400,
    Q_min=13920,
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
  <li>Broschure: Vitogas 200-F; 4/2014; 541039
  </li>
</ul>
</html>"));
end Boiler_Vitogas200F_42kW;
