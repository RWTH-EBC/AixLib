within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
partial model PartialUnderFloorHeatingSystemParameters
  "Common parameters for underfloor heating system"
  parameter Boolean withSheathing = false "=false if pipe has no Sheathing" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
  replaceable parameter
    AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.PipeMaterials.PipeMaterialDefinition
    pipMat "Pipe Material"
    annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
  parameter Integer dis(min = 1) = 1 "Parameter to enable dissertisation layers";
  parameter Modelica.Units.SI.Thickness sShe=0 "Thickness of pipe sheathing"
    annotation (Dialog(enable=withSheathing, group="Panel Heating"));
  replaceable parameter
    AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.Sheathing_Materials.SheathingMaterialDefinition
    sheMat=AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.Sheathing_Materials.PVCwithoutAir()
    constrainedby
    AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.Data.Sheathing_Materials.SheathingMaterialDefinition
    "Sheathing Material" annotation (Dialog(group="Panel Heating", enable=
          withSheathing), choicesAllMatching=true);
  parameter Modelica.Units.SI.ThermalResistance R_x = 0
    "Thermal resistance between screed and pipe"
    annotation(Dialog(tab="Advanced"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics"));
  parameter Boolean raiseErrorForMaxVelocity = true
    "=true to raise error if v > v_max (0.5 m/s)"
    annotation(Dialog(tab="Advanced"));


 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialUnderFloorHeatingSystemParameters;
