within AixLib.DataBase.Walls.Collections.OFD.EmpricalValidation;
record Building1
  extends BaseDataMultiInnerWalls(OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_Building1(),
    IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.FL_Building1(),
    groundPlate_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roof=AixLib.DataBase.Walls.EmpiricalValidation.RO_Building1(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition());
end Building1;
