within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
partial model PartialUnderFloorHeatingParameters
  "Common parameters for underfloor heating"

  parameter Modelica.Units.SI.Diameter dOut "Outer diameter of pipe"
                                                                    annotation (Dialog( group=
          "Panel Heating"));
  parameter Modelica.Units.SI.Diameter dInn=dOut - 2*thicknessPipe
    "Inner diameter of pipe";

  parameter Modelica.Units.SI.ThermalResistance R_x = 0
    "Thermal Resistance between Screed and Pipe";
  parameter Boolean withSheathing = false "=false if pipe has no Sheathing" annotation (Dialog(group = "Panel Heating"), choices(checkBox=true));
  parameter Modelica.Units.SI.Thickness thicknessSheathing "Thickness of pipe sheathing"
    annotation (Dialog(group="Panel Heating"));
  replaceable parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PipeMaterials.PipeMaterialDefinition
    pipeMaterial "Pipe Material"
    annotation (Dialog(group="Panel Heating"), choicesAllMatching=true);
  parameter Integer dis(min = 1) "Parameter to enable dissertisation layers";

  parameter Modelica.Units.SI.Thickness thicknessPipe "Thickness of pipe wall"
    annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
  replaceable parameter AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.Sheathing_Materials.SheathingMaterialDefinition sheathingMaterial
      "Sheathing Material" annotation (
        Dialog(group="Panel Heating", enable=withSheathing), choicesAllMatching=true);
  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
    "Wall type for floor"
    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
    "Wall type for ceiling"
    annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);

  parameter Modelica.Fluid.Types.Dynamics energyDynamicsWalls=
    Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance for wall capacities: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab="Dynamics"));
  parameter Boolean raiseErrorForMaxVelocity
    "=true to raise error if v > v_max (0.5 m/s)"
    annotation(Dialog(tab="Advanced"));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialUnderFloorHeatingParameters;
