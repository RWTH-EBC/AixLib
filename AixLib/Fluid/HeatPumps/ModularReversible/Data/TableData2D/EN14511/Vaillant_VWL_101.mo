within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Vaillant_VWL_101 "Vaillant VWL10-1"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 338.15; 313.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 258.15, 266.15, 275.15, 280.15;
      308.15, 5842, 7523, 9776, 10807;
      318.15, 5842, 7332, 9050, 10387;
      328.15, 5728, 7179, 9050, 10043],
    tabPEle=[
      0, 258.15, 266.15, 275.15, 280.15;
      308.15, 2138, 2177, 2444, 2444;
      318.15, 2558, 2673, 2864, 3055;
      328.15, 2902, 3131, 3360, 3513],
    mEva_flow_nominal=1,
    mCon_flow_nominal=9776/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vaillant_VWL_101");
    //These boundary-tables are not from the datasheet but default values.

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(revisions="<html><ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>",
   info="<html><p>
  According to data from Vaillant data sheets; EN14511
</p>
</html>"));
end Vaillant_VWL_101;
