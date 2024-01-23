within AixLib.DataBase.Walls.Collections.ASHRAE140;
record LightMassCases
  "Light building mass, insulation according to regulation ASAHRAE140"
  extends AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls(
    OW=AixLib.DataBase.Walls.ASHRAE140.OW_Case600(),
    IW_vert_half_a=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    groundPlate_upp_half=AixLib.DataBase.Walls.ASHRAE140.FL_Case600(),
    groundPlate_low_half=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    roof=AixLib.DataBase.Walls.ASHRAE140.RO_Case600(),
    IW2_vert_half_a=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.ASHRAE140.DummyDefinition());

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end LightMassCases;
