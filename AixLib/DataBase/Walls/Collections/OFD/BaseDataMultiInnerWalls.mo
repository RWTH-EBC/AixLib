within AixLib.DataBase.Walls.Collections.OFD;
record BaseDataMultiInnerWalls
  "Wall record with additional inner walls"
  extends BaseDataMultiWalls;
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW2_vert_half_a
    "Wall type for inside wall type 2 (first half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW2_vert_half_b
    "Wall type for inside wall type 2 (second half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition roofRoomUpFloor
    "Wall type for roof in attic (not upper floor)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  annotation (Documentation(info="<html><p>
  BaseDataMultiWalls in which 3 additional walls are added. This
  corresponds to the structure of
  AixLib.ThermalZones.HighOrder.House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope.
</p>
</html>"));
end BaseDataMultiInnerWalls;
