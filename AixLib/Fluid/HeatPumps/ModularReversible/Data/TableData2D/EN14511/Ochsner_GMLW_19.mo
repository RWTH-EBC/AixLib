within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Ochsner_GMLW_19 "Ochsner GMLW 19"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[258.15, 328.15; 313.15, 328.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 263.15, 275.15, 280.15;
      308.15, 11600, 17000, 20200;
      323.15, 10200, 15600, 18800],
    tabPEle=[
      0, 263.15, 275.15, 280.15;
      308.15, 4300, 4400, 4600;
      323.15, 6300, 6400, 6600],
    mEva_flow_nominal=1,
    mCon_flow_nominal=20200/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Ochsner_GMLW_19");

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
end Ochsner_GMLW_19;
