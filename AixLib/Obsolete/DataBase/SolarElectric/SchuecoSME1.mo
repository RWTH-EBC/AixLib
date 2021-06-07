within AixLib.Obsolete.DataBase.SolarElectric;
record SchuecoSME1 "SchuecoSME1"
  extends AixLib.Obsolete.DataBase.SolarElectric.PVBaseRecord(
    Eta0=0.147,
    TempCoeff=0.0037,
    NoctTempCell=45+273.15,
    NoctTemp=20+273.15,
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
end SchuecoSME1;
