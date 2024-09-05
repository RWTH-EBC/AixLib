within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses;
partial model PartialUnderFloorHeatingParameters
  "Common parameters for underfloor heating"
  extends AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.PartialUnderFloorHeatingSystemParameters;
  parameter Modelica.Units.SI.Temperature TSurMax=29 + 273.15
    "Maximum surface temperature"                                                            annotation (Dialog(group=
          "Room Specifications"));

  parameter Modelica.Units.SI.Diameter dOut "Outer diameter of pipe"
                                                                    annotation (Dialog( group=
          "Panel Heating"));


  parameter Modelica.Units.SI.Diameter dInn=dOut - 2*thicknessPipe
    "Inner diameter of pipe";


  parameter Modelica.Units.SI.Thickness thicknessPipe "Thickness of pipe wall"
    annotation (Dialog(group="Panel Heating"));
  parameter Modelica.Units.SI.Area A "Floor Area" annotation(Dialog(group = "Room Specifications"));
  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeFloor
    "Wall type for floor"
    annotation (Dialog(group="Room Specifications"), choicesAllMatching=true);

  replaceable parameter AixLib.DataBase.Walls.WallBaseDataDefinition wallTypeCeiling
    "Wall type for ceiling"
    annotation (Dialog(group="Room Specifications", enable = Ceiling), choicesAllMatching=true);

 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialUnderFloorHeatingParameters;
