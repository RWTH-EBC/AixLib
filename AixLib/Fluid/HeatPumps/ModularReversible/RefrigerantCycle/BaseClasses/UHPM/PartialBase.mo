within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
partial model PartialBase





  parameter AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.Refrigerant refrigerant =
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.Refrigerant.R410A
    annotation (Dialog(group="Refrigerant"));

protected
  final parameter AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.SDFFilePaths paths =
    AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM.path_variables(refrigerant);

  final parameter String filename_T_Comp = paths.filename_T_Comp;
  final parameter String filename_COP    = paths.filename_COP;
  final parameter String filename_PI     = paths.filename_PI;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end PartialBase;
