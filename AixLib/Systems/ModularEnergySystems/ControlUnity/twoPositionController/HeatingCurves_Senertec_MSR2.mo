within AixLib.Systems.ModularEnergySystems.ControlUnity.twoPositionController;
record HeatingCurves_Senertec_MSR2
  extends
    AixLib.DataBase.Boiler.DayNightMode.HeatingCurvesDayNightBaseDataDefinition(
  name="HC_Senertec_MSR2",
  varFlowTempDay=[0, 1.0; -20, 80; -15, 76; -10, 70; -5, 64; 0, 58; 5, 52; 10, 46; 15, 40; 20, 34; 25, 30; 30, 30],
  varFlowTempNight=[0, 1.0; -20, 65; -15, 61; -10, 55; -5, 59; 0, 43; 5, 37; 10, 31; 15, 30; 20, 30; 25, 30; 30, 30])
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatingCurves_Senertec_MSR2;
