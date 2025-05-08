within AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.EN14511;
record Novelan_L12_Split "Novelan L12 Split"
  extends
    AixLib.Fluid.HeatPumps.ModularReversible.Data.TableData2D.GenericAirToWater(
    dpEva_nominal=0,
    dpCon_nominal=0,
    tabUppBou=[253.14999999999998, 331.15; 316.15, 331.15],
    use_TConOutForOpeEnv=true,
    use_TEvaOutForOpeEnv=false,
    tabQCon_flow=[
      0, 253.15, 258.15, 263.15, 268.15, 271.9, 273.15, 278.15, 281.85;
      308.15, 5880.0, 7060.0, 9330.0, 11240.0, 12760.0, 8360.0, 11150.0, 14820.0;
      318.15, 5270.0, 6790.0, 9000.0, 11270.0, 13180.0, 8450.0, 10970.0, 13670.0;
      328.15, 4450.0, 6180.0, 8120.0, 10240.0, 11820.0, 8360.0, 10640.0, 12480.0],
    tabPEle=[
      0, 253.15, 257.15, 258.15, 263.15, 267.15, 268.15, 271.15, 271.9, 272.15, 273.15, 278.15, 281.85;
      308.15, 2900.0, 3050.0, 3000.0, 3520.0, 3980.0, 3990.0, 3830.0, 3770.0, 3460.0, 2340.0, 2640.0, 3100.0;
      318.15, 2930.0, 3240.0, 3400.0, 4430.0, 5490.0, 5500.0, 6070.0, 6160.0, 5690.0, 3910.0, 4200.0, 4540.0;
      328.15, 2750.0, 3240.0, 3400.0, 4120.0, 4590.0, 4490.0, 4420.0, 4390.0, 4090.0, 2830.0, 3110.0, 3280.0],
    mEva_flow_nominal=1,
    mCon_flow_nominal=13000/4180/5,
    use_TConOutForTab=true,
    use_TEvaOutForTab=false,
    devIde="Novelan L12 Split");
// These tables were created by taking data from graphs from the manufacturer.
// The temperature intervals are discretized based on the curvature of the curves:
// finer resolution is used in regions with higher curvature to preserve accuracy.
// The electrical power (Pel) is calculated using: Pel = Qmax / COP.

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    uses(AixLib(version="2.1.1")));
end Novelan_L12_Split;
