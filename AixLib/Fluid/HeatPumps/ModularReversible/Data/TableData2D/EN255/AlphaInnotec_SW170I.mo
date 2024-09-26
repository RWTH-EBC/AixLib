within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255;
record AlphaInnotec_SW170I "Alpha Innotec SW 170 I"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[251.15,338.15; 318.15,338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 268.15, 273.15, 278.15;
      308.15, 14800, 17200, 19100;
      323.15, 14400, 16400, 18300],
    tabPEle=[
      0, 268.15, 273.15, 278.15;
      308.15, 3700, 3600, 3600;
      323.15, 5100, 5100, 5100],
    mEva_flow_nominal=13600/3600/3,
    mCon_flow_nominal=17200/4180/10,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="AlphaInnotec_SW170I");

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  According to data from WPZ Buchs, Swiss; EN 255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end AlphaInnotec_SW170I;
