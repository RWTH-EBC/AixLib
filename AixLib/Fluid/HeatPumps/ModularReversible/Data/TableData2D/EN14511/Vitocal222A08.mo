within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Vitocal222A08 "Vitocal 222 A08"
  extends AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15, 323.15; 263.15, 333.15; 301.15, 333.15; 308.15, 328.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
        0,266.15,275.15,280.15,283.15,293.15,303.15;
        308.15,6670.0,6990.0,7540.0,8100.0,10450.0,11870.0;
        318.15,6490.0,6850.0,7060.0,8810.0,10130.0,11460.0;
        328.15,6640.0,6720.0,6820.0,8420.0,9780.0,11010.0;
        333.15,6350.0,6260.0,6590.0,8000.0,9570.0,10760.0],
    tabPEle=[
        0,266.15,275.15,280.15,283.15,293.15,303.15;
        308.15,2310.0,1770.0,1600.0,1580.0,1600.0,1420.0;
        318.15,2720.0,2370.0,1970.0,2290.0,2090.0,1860.0;
        328.15,3130.0,3010.0,2480.0,2860.0,2670.0,2380.0;
        333.15,3310.0,3020.0,2710.0,3090.0,2990.0,2690.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=9776/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Vitocal 222 A08");

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")));
end Vitocal222A08;
