within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255;
record Vitocal350BWH113 "Vitocal 350 BWH 113"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[268.15,328.15; 298.15,328.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 268.15, 273.15, 278.15, 283.15, 288.15;
      308.15, 14500, 16292, 18042, 19750, 21583;
      318.15, 15708, 17167, 18583, 20083, 21583;
      328.15, 15708, 17167, 18583, 20083, 21583;
      338.15, 15708, 17167, 18583, 20083, 21583],
    tabPEle=[
      0, 268.15, 273.15, 278.15, 283.15, 288.15;
      308.15, 3750, 3750, 3750, 3750, 3833;
      318.15, 4833, 4917, 4958, 5042, 5125;
      328.15, 5583, 5667, 5750, 5833, 5958;
      338.15, 7000, 7125, 7250, 7417, 7583],
    mEva_flow_nominal=12300/3600/3,
    mCon_flow_nominal=16292/4180/10,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vitocal350BWH113");

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
end Vitocal350BWH113;
