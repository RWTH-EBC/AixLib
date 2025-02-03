within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record StiebelEltron_WPL18 "Stiebel Eltron WPL 18"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 338.15; 313.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 266.15, 275.15, 280.15, 283.15, 293.15;
      308.15, 9700, 11600, 13000, 14800, 16300;
      323.15, 10000, 11200, 12900, 16700, 17500],
    tabPEle=[
      0, 266.15, 275.15, 280.15, 283.15, 293.15;
      308.15, 3300, 3400, 3500, 3700, 3800;
      323.15, 4500, 4400, 4600, 5000, 5100],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="StiebelEltron_WPL18");
    //These boundary-tables are not from the datasheet but default values.

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
end StiebelEltron_WPL18;
