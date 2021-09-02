within AixLib.Fluid.HeatExchangers.ActiveWalls.UnderfloorHeating.BaseClasses.FloorLayers;
record EnEV2009Heavy_UFH
  "Heavy building mass, insulation according to regulation EnEV 2009 in combination with underfloor heating"
  extends AixLib.DataBase.Walls.Collections.OFD.BaseDataMultiInnerWalls(
    OW=AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    IW_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half(),
    IW_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWsimple_EnEV2009_S_half(),
    IW_hori_upp_half=
        UnderfloorHeating.BaseClasses.FloorLayers.FLpartition_EnEV2009_SM_upHalf_UFH(),
    IW_hori_low_half=
        UnderfloorHeating.BaseClasses.FloorLayers.CEpartition_EnEV2009_SM_loHalf_UFH(),
    IW_hori_att_upp_half=
        AixLib.DataBase.Walls.EnEV2009.Floor.FLattic_EnEV2009_SML_upHalf(),
    IW_hori_att_low_half=
        AixLib.DataBase.Walls.EnEV2009.Ceiling.CEattic_EnEV2009_SML_loHalf(),
    groundPlate_upp_half=
        UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_upHalf_UFH(),
    groundPlate_low_half=
        UnderfloorHeating.BaseClasses.FloorLayers.FLground_EnEV2009_SML_loHalf_UFH(),
    roof=AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleAttic_EnEV2009_SML(),
    IW2_vert_half_a=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    IW2_vert_half_b=AixLib.DataBase.Walls.EnEV2009.IW.IWload_EnEV2009_S_half(),
    roofRoomUpFloor=
        AixLib.DataBase.Walls.EnEV2009.Ceiling.ROsaddleRoom_EnEV2009_SML());

end EnEV2009Heavy_UFH;
