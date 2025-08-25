within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record NIBE_F2120_20 "NIBE F2120 20"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[248.15, 335.15; 264.15, 338.15; 310.15, 338.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 248.15, 253.15, 258.15, 263.15, 268.15, 270.45, 273.15, 275.85, 278.15, 283.15, 288.15;
      308.15, 10020.0, 11420.0, 12820.0, 14220.0, 15600.0, 16220.0, 16190.0, 16250.0, 16220.0, 16210.0, 16180.0;
      318.15, 9450.0, 10850.0, 12220.0, 13660.0, 15060.0, 15590.0, 16040.0, 16280.0, 16220.0, 16240.0, 16210.0;
      328.15, 8850.0, 10310.0, 11710.0, 13120.0, 14580.0, 15270.0, 15800.0, 16310.0, 16250.0, 16210.0, 16240.0],
    tabPEle=[
      0, 248.15, 253.15, 258.15, 263.15, 268.15, 270.45, 273.15, 275.85, 278.15, 283.15, 288.15;
      308.15, 3980.0, 4120.0, 4230.0, 4240.0, 4180.0, 4150.0, 3930.0, 3730.0, 3560.0, 3210.0, 2920.0;
      318.15, 4540.0, 4700.0, 4790.0, 4880.0, 4810.0, 4740.0, 4620.0, 4440.0, 4230.0, 3830.0, 3480.0;
      328.15, 4810.0, 5160.0, 5370.0, 5470.0, 5540.0, 5570.0, 5510.0, 5420.0, 5190.0, 4770.0, 4410.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="NIBE F2120 20");

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

<p><br>NIBE F2120 Installateurhandbuch. <a href=\"https://assetstore.nibe.se/hcms/v2.3/entity/document/849031/storage/ODQ5MDMxLzAvbWFzdGVy\">Luft/Wasser-W&auml;rmepumpe NIBE F2120</a>. </p>
</html>"));
end NIBE_F2120_20;
