within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN255;
record Vitocal350BWH110 "Vitocal 350 BWH 110"
  extends GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[268.15,328.15; 298.15,328.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 268.15, 273.15, 278.15, 283.15, 288.15;
      308.15, 9522, 11000, 12520, 14000, 15520;
      318.15, 11610, 12740, 13910, 15090, 16220;
      328.15, 11610, 12740, 13910, 15090, 16220;
      338.15, 11610, 12740, 13910, 15090, 16220],
    tabPEle=[
      0, 268.15, 273.15, 278.15, 283.15, 288.15;
      308.15, 2478, 2522, 2609, 2696, 2783;
      318.15, 3608, 3652, 3696, 3739, 3783;
      328.15, 4217, 4261, 4304, 4348, 4391;
      338.15, 5087, 5130, 5174, 5217, 5261],
    mEva_flow_nominal=8400/3600/3,
    mCon_flow_nominal=11000/4180/10,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vitocal350BWH110");

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
end Vitocal350BWH110;
