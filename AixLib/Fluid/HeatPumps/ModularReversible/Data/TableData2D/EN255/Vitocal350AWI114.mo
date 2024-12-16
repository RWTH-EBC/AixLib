within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255;
record Vitocal350AWI114 "Vitocal 350 AWI 114"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15,328.15; 268.15,338.15; 308.15,338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 253.15, 258.15, 263.15, 268.15, 273.15, 278.15, 283.15, 288.15, 293.15, 298.15, 303.15;
      308.15, 9204.5, 11136.4, 11477.3, 12215.9, 13863.6, 15056.8, 16931.8, 19090.9, 21250.0, 21477.3, 21761.4;
      323.15, 10795.5, 11988.6, 12215.9, 13068.2, 14545.5, 15681.8, 17613.6, 20284.1, 22500.0, 23181.8, 23863.6;
      338.15, 0, 12954.5, 13465.9, 14431.8, 15965.9, 17386.4, 19204.5, 21250.0, 22897.7, 23863.6, 24886.4],
    tabPEle=[
      0, 253.15, 258.15, 263.15, 268.15, 273.15, 278.15, 283.15, 288.15, 293.15, 298.15, 303.15;
      308.15, 3295.5, 3522.7, 3750.0, 3977.3, 4034.1, 4090.9, 4204.5, 4375.0, 4488.6, 4488.6, 4545.5;
      323.15, 4659.1, 4886.4, 5113.6, 5227.3, 5511.4, 5568.2, 5738.6, 5909.1, 6022.7, 6250.0, 6477.3;
      338.15, 0, 6875.0, 7159.1, 7500.0, 7727.3, 7897.7, 7954.5, 7954.5, 8181.8, 8409.1, 8579.5],
    mEva_flow_nominal=1,
    mCon_flow_nominal=15400/4180/10,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vitocal350AWI114");

  annotation(preferedView="text", DymolaStoredErrors,
    Icon,
    Documentation(info="<html><p>
  Data from manufacturer's data sheet (Viessmann). These exact curves
  are given in the data sheet for measurement procedure according to EN
  255.
</p>
<ul>
  <li>
    <i>Oct 14, 2016&#160;</i> by Philipp Mehrfeld:<br/>
    Transferred to AixLib.
  </li>
</ul>
</html>"));
end Vitocal350AWI114;
