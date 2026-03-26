within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses.UHPM;
partial model ParamsUHPM

    parameter Modelica.Units.SI.Temperature TConOutNom = 313.15
    "Nominal condenser outlet temperature"
    annotation (Dialog(group="UHPM parameters"));

  parameter Modelica.Units.SI.Temperature TEvaInNom = 278.15
    "Nominal temperature of TSource"
    annotation (Dialog(group="UHPM parameters"));

  parameter Modelica.Units.SI.HeatFlowRate QConNom = 30000
    "Nominal heat flow"
    annotation (Dialog(group="UHPM parameters"));

  parameter Modelica.Units.SI.TemperatureDifference DeltaTCon = 7
    "Temperature difference heat sink condenser"
    annotation (Dialog( group="UHPM parameters"));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ParamsUHPM;
