within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record NIBE_S2125_12 "NIBE S2125 12"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 338.15; 288.15, 348.15; 311.15, 348.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 248.15, 253.15, 263.15, 273.15, 279.15, 283.15, 285.65, 293.15, 303.15, 311.15;
      308.15, 4700.0, 5540.0, 7580.0, 9310.0, 9860.0, 9850.0, 9690.0, 9740.0, 9760.0, 9730.0;
      318.15, 4720.0, 5440.0, 7500.0, 9240.0, 9690.0, 9590.0, 9340.0, 9330.0, 9320.0, 9320.0;
      328.15, 4720.0, 5610.0, 7720.0, 9410.0, 9690.0, 9420.0, 9170.0, 9170.0, 9160.0, 9130.0],
    tabPEle=[
      0, 248.15, 253.15, 258.15, 263.15, 268.15, 273.15, 278.15, 279.15, 283.15, 285.65, 288.15;
      308.15, 1870.0, 2000.0, 2170.0, 2260.0, 2260.0, 2260.0, 2150.0, 2120.0, 1950.0, 1830.0, 1750.0;
      318.15, 2270.0, 2350.0, 2540.0, 2680.0, 2670.0, 2660.0, 2510.0, 2480.0, 2260.0, 2100.0, 2000.0;
      328.15, 2570.0, 2800.0, 3060.0, 3220.0, 3260.0, 3280.0, 3080.0, 3040.0, 2770.0, 2590.0, 2490.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="NIBE S2125 12");


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")),
    Documentation(revisions="<html>

 <ul><li>
 <i>May 15, 2025</i> by Anton Lleshaj:<br/>
  First implementation (see issue <a href= \"https://github.com/RWTH-EBC/AixLib/issues/1593\"> #1593</a>)
 </li></ul>

</html>", info="<html>
<p>Data for air-to-water heat pump from NIBE. These tables are based on
  digitized data from manufacturer graphs. Temperature intervals are
  discretized with finer resolution in areas of high curvature to
  maintain accuracy. Electrical power <code>PEle</code> is calculated using the
  formula: <code>PEle</code> =
 <code>Qmax</code> / <code>COP</code>. Since manufacturers often
  provide <code>COP</code> and
  <code>Qmax</code> at different
  temperature points, <code>PEle</code> is calculated only at the
  temperature values common to both datasets to avoid extrapolation. As
  a result, the <code>Qmax</code> and
  <code>PEle</code> tables may differ
  in size.</p>

<p><br>NIBE S2125 Installateurhandbuch. <a href=\"https://assetstore.nibe.se/hcms/v2.3/entity/document/887685/storage/ODg3Njg1LzAvbWFzdGVy\">Luft/Wasser-W&auml;rmepumpe NIBE S2125</a>. </p>
</html>"));
end NIBE_S2125_12;
