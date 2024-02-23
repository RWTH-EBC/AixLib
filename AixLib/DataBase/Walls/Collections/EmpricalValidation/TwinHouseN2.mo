within AixLib.DataBase.Walls.Collections.EmpricalValidation;
record TwinHouseN2
  extends OFD.BaseDataMultiInnerWalls(
    OW=AixLib.DataBase.Walls.EmpiricalValidation.OW_S_N_TwinHouses(),
    IW_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EmpiricalValidation.FL_TwinHouses(),
    groundPlate_low_half=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roof=AixLib.DataBase.Walls.EmpiricalValidation.CE_TwinHouses(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EmpiricalValidation.DummyDefinition());
end TwinHouseN2;
