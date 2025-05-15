within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Vitocal222S08 "Vitocal 222 S08"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15, 323.15; 263.15, 333.15; 308.15, 333.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0,275.15,280.15,283.15,293.15,303.15,308.15;
      308.15,6000.0,9000.0,10860.0,13290.0,14030.0,15860.0;
      318.15,6250.0,9480.0,10380.0,13760.0,15030.0,16000.0;
      328.15,6120.0,8870.0,9710.0,12830.0,15240.0,15270.0;
      333.15,6110.0,8530.0,9360.0,12260.0,14290.0,14770.0],
    tabPEle=[
      0,275.15,280.15,283.15,293.15,303.15,308.15;
      308.15,1460.0,1800.0,1920.0,1890.0,1480.0,1240.0;
      318.15,2150.0,2530.0,2490.0,2360.0,2300.0,1960.0;
      328.15,2810.0,3070.0,3000.0,2920.0,2940.0,2580.0;
      333.15,3040.0,3260.0,3210.0,2670.0,2750.0,2840.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=9776/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vitocal 222 S08");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")),
    Documentation(revisions="<html>

 <ul><li>
 <i>May 15, 2025</i> by Anton Lleshaj:<br/>
  First implementation (see issue <a href= \"https://github.com/RWTH-EBC/AixLib/issues/1593\"> #1593</a>)
 </li></ul>

</html>", info="<html>
<p>According to data from Viessmann data sheets. Electrical power <span style=\"font-family: Courier New;\">PEle</span> is calculated using the formula: <span style=\"font-family: Courier New;\">PEle</span> = <span style=\"font-family: Courier New;\">Qmax</span> / <span style=\"font-family: Courier New;\">COP</span>.</p>
<p><br>Viessmman, Planungsanleitung Vitocal <a href=\"https://www.haustechnik-handrich.de/media/60/36/d9/1709725041/vie-pa-z022670.pdf\"> Viessmann Planungsanleitung Vitocal</a>. </p>
</html>
"));
end Vitocal222S08;
