within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Remko_CMFCMT_180 "Remko CMF-CMT 180"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15, 313.15; 263.15, 328.15; 293.15, 328.15; 308.15, 328.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 258.15, 263.15, 268.15, 273.15, 278.15, 283.15, 288.15, 293.15;
      308.15, 4850.0, 6040.0, 6130.0, 6530.0, 7580.0, 9040.0, 10300.0, 10560.0;
      318.15, 4990.0, 5800.0, 5980.0, 6230.0, 7030.0, 8490.0, 9890.0, 10050.0;
      328.15, 4320.0, 5120.0, 5310.0, 5420.0, 6060.0, 7400.0, 8980.0, 9460.0],
    tabPEle=[
      0, 258.15, 260.15, 263.15, 266.15, 268.15, 273.15, 278.15, 280.15, 283.15, 288.15, 293.15;
      308.15, 2210.0, 2230.0, 2240.0, 2040.0, 1940.0, 1800.0, 1860.0, 1930.0, 2010.0, 2150.0, 2020.0;
      318.15, 2470.0, 2590.0, 2690.0, 2490.0, 2310.0, 1990.0, 1870.0, 1880.0, 1920.0, 1990.0, 1880.0;
      328.15, 2720.0, 2710.0, 2680.0, 2490.0, 2410.0, 2210.0, 2260.0, 2390.0, 2550.0, 2880.0, 2820.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Remko CMF-CMT 180");


  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")),
    Documentation(revisions="<html><ul>
  <li>
    <i>May 15, 2025</i> by Anton Lleshaj:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1593\">#1593</a>)
  </li>
</ul>
</html>", info="<html><p>
  Data for air-to-water heat pump from Remko. These tables are based on
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
  in size.
</p>
<p>
  <br/>
  Remko, Montage- und Betriebsanleitung REMKO CMF / CMT 180 <a href=
  \"https://remko.canto.de/pdfviewer/viewer/viewer.html?v=medienportal&amp;portalType=v%2Fmedienportal&amp;column=document&amp;id=ogl474tqb557d7hgdvht8sni6d&amp;suffix=pdf&amp;print=1\">
  Montage- und Betriebsanleitung REMKO CMF/CMT 180</a>.
</p>
</html>"));
end Remko_CMFCMT_180;
