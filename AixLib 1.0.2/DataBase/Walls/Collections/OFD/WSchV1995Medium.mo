within AixLib.DataBase.Walls.Collections.OFD;
record WSchV1995Medium "Medium building mass, insulation according to regulation WSchV 1995"
  extends BaseDataMultiInnerWalls(OW=AixLib.DataBase.Walls.WSchV1995.OW.OW_WSchV1995_M(),
    IW_vert_half_a=AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half(),
    IW_vert_half_b=AixLib.DataBase.Walls.WSchV1995.IW.IWsimple_WSchV1995_M_half(),
    IW_hori_upp_half=AixLib.DataBase.Walls.WSchV1995.Floor.FLpartition_WSchV1995_SM_upHalf(),
    IW_hori_low_half=AixLib.DataBase.Walls.WSchV1995.Ceiling.CEpartition_WSchV1995_SM_loHalf(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.WSchV1995.Floor.FLattic_WSchV1995_SML_upHalf(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.WSchV1995.Ceiling.CEattic_WSchV1995_SML_loHalf(),
    groundPlate_upp_half=AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML_upHalf(),
    groundPlate_low_half=AixLib.DataBase.Walls.WSchV1995.Floor.FLground_WSchV1995_SML_loHalf(),
    roof=AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleAttic_WSchV1995_SML(),
    IW2_vert_half_a=AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half(),
    IW2_vert_half_b=AixLib.DataBase.Walls.WSchV1995.IW.IWload_WSchV1995_M_half(),
    roofRoomUpFloor=AixLib.DataBase.Walls.WSchV1995.Ceiling.ROsaddleRoom_WSchV1995_SML());
end WSchV1995Medium;
