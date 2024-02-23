within AixLib.DataBase.Walls.Collections.OFD;
record EnEV2009Medium "Medium building mass, insulation according to regulation EnEV 2009"
  extends BaseDataMultiInnerWalls(OW=AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_M(),
    IW_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half(),
    IW_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_M_half(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EnEV2009.Floor.FLpartition_EnEV2009_SM_upHalf(),
    IW_hori_low_half=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEpartition_EnEV2009_SM_loHalf(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EnEV2009.Floor.FLattic_EnEV2009_SML_upHalf(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML_upHalf(),
    groundPlate_low_half=AixLib.DataBase.Walls.EnEV2009.Floor.FLground_EnEV2009_SML_loHalf(),
    roof=AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_M_half(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML());
end EnEV2009Medium;
