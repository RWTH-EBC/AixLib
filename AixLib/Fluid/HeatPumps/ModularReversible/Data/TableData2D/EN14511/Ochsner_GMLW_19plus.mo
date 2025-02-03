within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Ochsner_GMLW_19plus "Ochsner GMLW 19 plus"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[249.15, 325.15; 258.15, 328.15; 263.15, 338.15; 313.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 263.15, 275.15, 280.15;
      308.15, 12600, 16800, 19800;
      323.15, 11700, 15900, 18900;
      333.15, 11400, 15600, 18600],
    tabPEle=[
      0, 263.15, 275.15, 280.15;
      308.15, 4100, 4300, 4400;
      323.15, 5500, 5700, 5800;
      333.15, 6300, 6500, 6600],
    mEva_flow_nominal=1,
    mCon_flow_nominal=19800/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Ochsner_GMLW_19plus");

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
  According to data from Ochsner data sheets; EN14511
</p>
</html>"));
end Ochsner_GMLW_19plus;
