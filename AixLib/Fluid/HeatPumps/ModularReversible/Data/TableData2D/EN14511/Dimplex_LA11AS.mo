within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Dimplex_LA11AS "Dimplex LA 11 AS"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 331.15; 308.15, 331.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 266.15, 275.15, 280.15, 283.15;
      308.15, 6600, 8800, 11300, 12100;
      318.15, 6400, 7898, 9600, 10145],
    tabPEle=[
      0, 266.15, 275.15, 280.15, 283.15;
      308.15, 2444, 2839, 3139, 3103;
      318.15, 2783, 2974, 3097, 3013],
    mEva_flow_nominal=1,
    mCon_flow_nominal=11300/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Dimplex_LA11AS");
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
  According to data from Dimplex data sheets; EN14511
</p>
</html>"));
end Dimplex_LA11AS;
