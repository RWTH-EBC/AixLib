within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Ochsner_GMSW_15plus "Ochsner GMSW 15 plus"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[265.15, 325.15; 273.15, 338.15; 293.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 268.15, 273.15, 278.15;
      308.15, 12762, 14500, 16100;
      318.15, 12100, 13900, 15600;
      328.15, 11513, 13200, 14900],
    tabPEle=[
      0, 268.15, 273.15, 278.15;
      308.15, 3225, 3300, 3300;
      318.15, 4000, 4000, 4000;
      328.15, 4825, 4900, 4900],
    mEva_flow_nominal=(14500 - 3300)/3600/3,
    mCon_flow_nominal=14500/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Ochsner_GMSW_15plus");

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(revisions="<html><ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>", info="<html>
<p>
  According to data from WPZ Buchs, Swiss; EN14511
</p>
</html>"));
end Ochsner_GMSW_15plus;
