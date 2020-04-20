within AixLib.DataBase.Walls.Collections.OFD;
record BaseDataMultiInnerWalls
  extends BaseDataMultiWalls;
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW2_vert_half_a
    "Wall type for inside wall type 2 (first half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition IW2_vert_half_b
    "Wall type for inside wall type 2 (second half)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
  parameter AixLib.DataBase.Walls.WallBaseDataDefinition roofAttic
    "Wall type for roof in attic (not upper floor)"
    annotation (Dialog(group="Wall data"), choicesAllMatching=true);
end BaseDataMultiInnerWalls;
