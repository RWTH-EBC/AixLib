within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record AverageAirToWaterResidential "Average Air To Water Residential Heat Pump"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15, 333.15; 316.15, 333.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 250.15, 255.15, 260.15, 265.15, 270.15, 275.15, 280.15, 285.15, 290.15, 295.15, 300.15, 305.15, 310.15;
      308.15, 1211.0, 1370.0, 1518.0, 1659.0, 1801.0, 1947.0, 2105.0, 2279.0, 2475.0, 2698.0, 2955.0, 3249.0, 3589.0;
      318.15, 1154.0, 1308.0, 1454.0, 1598.0, 1742.0, 1892.0, 2053.0, 2229.0, 2425.0, 2645.0, 2893.0, 3175.0, 3495.0;
      328.15, 1096.0, 1246.0, 1391.0, 1536.0, 1683.0, 1837.0, 2002.0, 2179.0, 2375.0, 2591.0, 2832.0, 3101.0, 3402.0;
      333.15, 1067.0, 1215.0, 1359.0, 1505.0, 1654.0, 1810.0, 1976.0, 2155.0, 2350.0, 2564.0, 2801.0, 3064.0, 3355.0],
    tabPEle=[
      0, 250.15, 255.15, 260.15, 265.15, 270.15, 275.15, 280.15, 285.15, 290.15, 295.15, 300.15, 305.15, 310.15;
      308.15, 500.0, 550.0, 570.0, 550.0, 520.0, 490.0, 460.0, 430.0, 400.0, 380.0, 370.0, 360.0, 350.0;
      318.15, 550.0, 610.0, 630.0, 620.0, 600.0, 570.0, 530.0, 500.0, 480.0, 460.0, 440.0, 430.0, 430.0;
      328.15, 610.0, 680.0, 720.0, 720.0, 710.0, 680.0, 650.0, 630.0, 600.0, 580.0, 560.0, 550.0, 550.0;
      333.15, 650.0, 730.0, 770.0, 790.0, 780.0, 760.0, 740.0, 710.0, 690.0, 670.0, 660.0, 650.0, 650.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Average Heat Pump");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>To create a representative heat pump model, performance data from multiple commercial air-to-water heat pumps were first digitized. These datasets included information such as coefficient of performance (<code>COP</code>) and heating power across a range of outdoor air temperatures and fixed supply temperatures. For each individual heat pump, regression models were fitted using polynomial functions. These regressions captured the variation of <code>COP</code> and heating power with outdoor temperature for each fixed supply temperature level. In a subsequent step, these individual regressions were used to derive a generalized model. For each selected supply temperature (e.g., 35 &deg;C, 45&deg;C, 55&deg;C, and 60&deg;C), a second polynomial regression was performed across all previously generated curves. </p>
<p>The resulting regression coefficients were then used to define a Modelica record representing an average heat pump. This record provides <code>COP</code> and heating power as continuous functions of the outdoor temperature and is intended for use in system-level simulations where a generic heat pump behavior is required.</p>
</html>", revisions="<html>

<ul><li>
<i>May 15, 2025</i> by Anton Lleshaj:<br/>
First implementation (see issue <a href= \"https://github.com/RWTH-EBC/AixLib/issues/1593\"> #1593</a>)
</li></ul>

</html>"));
end AverageAirToWaterResidential;
