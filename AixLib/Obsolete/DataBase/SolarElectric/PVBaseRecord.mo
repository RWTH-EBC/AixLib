within AixLib.Obsolete.DataBase.SolarElectric;
record PVBaseRecord
  extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
    extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Efficiency Eta0(min=0, max=1)
    "Maximum efficiency";
  parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff(min=0, max=1)
    "Temperature coeffient";
  parameter Modelica.SIunits.Temp_K NoctTempCell
    "Meassured cell temperature";
  parameter Modelica.SIunits.Temp_K NoctTemp
    "Defined temperature";
  parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation
    "Defined radiation";
  parameter Modelica.SIunits.Area Area
    "Area of one Panel";

  annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Base data definition for photovoltaics
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>",
      revisions="<html><ul>
  <li>
    <i>October 11, 2016</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>September 01, 2014&#160;</i> by Xian Wu:<br/>
    Added documentation and formatted appropriately
  </li>
</ul>
</html>"));
end PVBaseRecord;
