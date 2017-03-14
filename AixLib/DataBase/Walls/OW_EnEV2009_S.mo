within AixLib.DataBase.Walls;
record OW_EnEV2009_S
  extends WallBaseDataDefinition_new(
  materials = {
  AixLib.DataBase.Materials.WallLayers.LimeCement(),
  AixLib.DataBase.Materials.WallLayers.MineralWool035(),
  AixLib.DataBase.Materials.WallLayers.LimeStone(),
  AixLib.DataBase.Materials.WallLayers.GypsumPlaster()} "Array of construction materials",
  d = {0.05, 0.01, 0.24, 0.015} "Thickness of wall layers");
end OW_EnEV2009_S;
