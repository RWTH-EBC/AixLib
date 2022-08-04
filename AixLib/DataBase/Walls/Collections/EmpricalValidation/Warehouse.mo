within AixLib.DataBase.Walls.Collections.EmpricalValidation;
record Warehouse "Warehouse wall collection"
  extends OFD.BaseDataMultiInnerWalls(
    OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_Warehouse(),
    IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.FL_Warehouse(),
    groundPlate_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roof=AixLib.DataBase.Walls.EmpiricalValidation.RO_Warehouse(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition());
end Warehouse;
