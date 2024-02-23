within AixLib.DataBase.Walls.Collections.OFD;
record WSchV1984Heavy "Heavy building mass, insulation according to regulation WSchV 1984"
  extends BaseDataMultiInnerWalls(OW=AixLib.DataBase.Walls.WSchV1984.OW.OW_WSchV1984_S(),
    IW_vert_half_a=AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half(),
    IW_vert_half_b=AixLib.DataBase.Walls.WSchV1984.IW.IWsimple_WSchV1984_S_half(),
    IW_hori_upp_half=AixLib.DataBase.Walls.WSchV1984.Floor.FLpartition_WSchV1984_SM_upHalf(),
    IW_hori_low_half=AixLib.DataBase.Walls.WSchV1984.Ceiling.CEpartition_WSchV1984_SM_loHalf(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.WSchV1984.Floor.FLattic_WSchV1984_SML_upHalf(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.WSchV1984.Ceiling.CEattic_WSchV1984_SML_loHalf(),
    groundPlate_upp_half=AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML_upHalf(),
    groundPlate_low_half=AixLib.DataBase.Walls.WSchV1984.Floor.FLground_WSchV1984_SML_loHalf(),
    roof=AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleAttic_WSchV1984_SML(),
    IW2_vert_half_a=AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half(),
    IW2_vert_half_b=AixLib.DataBase.Walls.WSchV1984.IW.IWload_WSchV1984_S_half(),
    roofRoomUpFloor=AixLib.DataBase.Walls.WSchV1984.Ceiling.ROsaddleRoom_WSchV1984_SML());
end WSchV1984Heavy;
