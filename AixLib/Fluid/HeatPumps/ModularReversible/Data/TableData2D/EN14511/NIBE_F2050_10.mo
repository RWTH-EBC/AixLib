within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record NIBE_F2050_10 "NIBE F2050 10"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.15, 331.15; 315.15, 331.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 253.15, 258.14, 263.18, 268.17, 273.21, 278.16, 280.15;
      308.15, 5890.0, 7000.0, 8250.0, 9250.0, 10280.0, 11170.0, 11530.0;
      318.15, 5440.0, 6530.0, 7580.0, 8690.0, 9750.0, 10810.0, 11220.0;
      328.15, 4360.0, 5220.0, 6330.0, 7560.0, 8890.0, 10420.0, 11030.0],
    tabPEle=[
      0, 258.15, 263.15, 263.18, 268.15, 268.17, 273.15, 273.21, 278.15, 278.16, 280.15;
      308.15, 2930.0, 2940.0, 2940.0, 2780.0, 2780.0, 2590.0, 2590.0, 2360.0, 2360.0, 2270.0;
      318.15, 3570.0, 3440.0, 3440.0, 3280.0, 3280.0, 3110.0, 3110.0, 2940.0, 2940.0, 2880.0;
      328.15, 3110.0, 3360.0, 3360.0, 3510.0, 3510.0, 3580.0, 3580.0, 3690.0, 3690.0, 3690.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="NIBE F2050 10");

// These tables were created by taking data from graphs from the manufacturer.
// The temperature intervals are discretized based on the curvature of the curves:
// finer resolution is used in regions with higher curvature to preserve accuracy.
// The electrical power (Pel) is calculated using: Pel = Qmax / COP.
// Some manufacturers don’t provide the same temperature intervals for COP and Qmax,
// so for Pel, only the common temperature values are used to avoid extrapolation.
// That’s why the table sizes for Qmax and Pel may be different.
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")));
end NIBE_F2050_10;
