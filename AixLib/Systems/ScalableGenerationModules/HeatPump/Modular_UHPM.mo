within AixLib.Systems.ScalableGenerationModules.HeatPump;
model Modular_UHPM
  Fluid.HeatPumps.ModularReversible.Modular modular(redeclare model
      RefrigerantCycleHeatPumpHeating =
        AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.UHPM)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Modular_UHPM;
