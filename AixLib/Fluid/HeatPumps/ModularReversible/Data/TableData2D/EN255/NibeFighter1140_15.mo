within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255;
record NibeFighter1140_15 "Nibe Fighter 1140-15"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[238.15,338.15; 323.15,338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 268.15, 273.15, 275.15, 278.15, 283.15;
      308.15, 13260, 15420, 16350, 17730, 19930;
      328.15, 12560, 14490, 15330, 16590, 18900],
    tabPEle=[
      0, 268.15, 273.15, 275.15, 278.15, 283.15;
      308.15, 3360, 3380, 3380, 3390, 3400;
      328.15, 4830, 4910, 4940, 4990, 5050],
    mEva_flow_nominal=(15420 - 3380)/3600/3,
    mCon_flow_nominal=15420/4180/10,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="NibeFighter1140_15");

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  According to manufacturer's data; EN 255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end NibeFighter1140_15;
