within AixLib.Obsolete.Year2021;
package DataBase

  package SolarElectric
    record SymphonyEnergySE6M181 "Symphony Energy SE6M60 series"
      extends AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord(
        Eta0=0.126,
        TempCoeff=0.0043,
        NoctTempCell=46 + 273.15,
        NoctTemp=25 + 273.15,
        NoctRadiation=1000,
        Area=1.44);
      annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Polycrystalline Solar Module, single Area=1,44 m2
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>", revisions="<html><ul>
<ul>
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
    end SymphonyEnergySE6M181;

    record SchuecoSME1 "SchuecoSME1"
      extends AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord(
        Eta0=0.147,
        TempCoeff=0.0037,
        NoctTempCell=45 + 273.15,
        NoctTemp=20 + 273.15,
        NoctRadiation=800,
        Area=1.27664);
      annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  Monocrystalline Solar Module, single Area=1,27664m2
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>", revisions="<html><ul>
<ul>
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
    end SchuecoSME1;

    record PVBaseRecord
      extends AixLib.Obsolete.BaseClasses.ObsoleteModel;
        extends Modelica.Icons.Record;
      parameter Modelica.Units.SI.Efficiency Eta0(min=0, max=1)
        "Maximum efficiency";
      parameter Modelica.Units.SI.LinearTemperatureCoefficient TempCoeff(min=0,
          max=1) "Temperature coeffient";
      parameter Modelica.Units.SI.Temperature NoctTempCell
        "Meassured cell temperature";
      parameter Modelica.Units.SI.Temperature NoctTemp "Defined temperature";
      parameter Modelica.Units.SI.RadiantEnergyFluenceRate NoctRadiation
        "Defined radiation";
      parameter Modelica.Units.SI.Area Area "Area of one Panel";

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
</html>", revisions="<html><ul>
<ul>
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

    record CanadianSolarCS6P250P "CS6P250PPoly"

      extends AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord(
        Eta0=0.1554,
        TempCoeff=0.0034,
        NoctTempCell=45 + 273.15,
        NoctTemp=20 + 273.15,
        NoctRadiation=800,
        Area=1.608516);
      annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  single Area=1,608516m2
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>", revisions="<html><ul>
<ul>
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
    end CanadianSolarCS6P250P;

    record AleoS24 "solarmodul AleoS24"

      extends AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord(
        Eta0=0.139,
        TempCoeff=0.0034,
        NoctTempCell=47 + 273.15,
        NoctTemp=25 + 273.15,
        NoctRadiation=1000,
        Area=1.33155);
      annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  single Area=1,33155m2
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>", revisions="<html><ul>
<ul>
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
    end AleoS24;

    record ACSPanelSystem
      extends AixLib.Obsolete.Year2021.DataBase.SolarElectric.PVBaseRecord(
        Eta0=0.176,
        TempCoeff=0.003,
        NoctTempCell=45 + 273.15,
        NoctTemp=25 + 273.15,
        NoctRadiation=1000,
        Area=22.63);
      annotation (Documentation(info="<html><h4>
  <span style=\"color: #008000\">Overview</span>
</h4>
<p>
  ACS panel system
</p>
<h4>
  <span style=\"color: #008000\">References</span>
</h4>
<p>
  Record for record used with <a href=
  \"modelica://AixLib.Fluid.Solar.Electric.PVsystem\">AixLib.Fluid.Solar.Electric.PVsystem</a>
</p>
</html>", revisions="<html><ul>
<ul>
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
    end ACSPanelSystem;
  end SolarElectric;
end DataBase;
