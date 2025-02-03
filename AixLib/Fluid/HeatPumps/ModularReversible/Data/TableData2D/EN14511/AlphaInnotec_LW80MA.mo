within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record AlphaInnotec_LW80MA "Alpha Innotec LW 80 M-A"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 338.15; 313.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 266.15, 275.15, 280.15, 283.15, 288.15, 293.15;
      308.15, 6300, 8000, 9400, 10300, 11850, 13190;
      318.15, 6167, 7733, 9000, 9750, 11017, 11730;
      323.15, 6100, 7600, 8800, 9475, 10600, 11000],
    tabPEle=[
      0, 266.15, 275.15, 280.15, 283.15, 288.15, 293.15;
      308.15, 2625, 2424, 2410, 2395, 2347, 2322;
      318.15, 3136, 3053, 3000, 2970, 2912, 2889;
      323.15, 3486, 3535, 3451, 3414, 3365, 3385],
    mEva_flow_nominal=1,
    mCon_flow_nominal=9400/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="AlphaInnotec_LW80MA");
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
  According to manufacturer's data which was inter- and extrapolated
  linearly; EN14511
</p>
</html>"));
end AlphaInnotec_LW80MA;
