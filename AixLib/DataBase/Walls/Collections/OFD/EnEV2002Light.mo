within AixLib.DataBase.Walls.Collections.OFD;
record EnEV2002Light "Light building mass, insulation according to regulation EnEV 2002"
  extends BaseDataMultiInnerWalls(OW=AixLib.DataBase.Walls.EnEV2002.OW.OW_EnEV2002_L(),
    IW_vert_half_a=AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half(),
    IW_vert_half_b=AixLib.DataBase.Walls.EnEV2002.IW.IWsimple_EnEV2002_L_half(),
    IW_hori_upp_half=AixLib.DataBase.Walls.EnEV2002.Floor.FLpartition_EnEV2002_L_upHalf(),
    IW_hori_low_half=AixLib.DataBase.Walls.EnEV2002.Ceiling.CEpartition_EnEV2002_L_loHalf(),
    IW_hori_att_upp_half=AixLib.DataBase.Walls.EnEV2002.Floor.FLattic_EnEV2002_SML_upHalf(),
    IW_hori_att_low_half=AixLib.DataBase.Walls.EnEV2002.Ceiling.CEattic_EnEV2002_SML_loHalf(),
    groundPlate_upp_half=AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML_upHalf(),
    groundPlate_low_half=AixLib.DataBase.Walls.EnEV2002.Floor.FLground_EnEV2002_SML_loHalf(),
    roof=AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleAttic_EnEV2002_SML(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EnEV2002.IW.IWload_EnEV2002_L_half(),
    roofRoomUpFloor=AixLib.DataBase.Walls.EnEV2002.Ceiling.ROsaddleRoom_EnEV2002_SML());
end EnEV2002Light;
