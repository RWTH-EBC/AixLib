within AixLib.DataBase.Walls.Collections.ASHRAE140;
record HighMassCases  "High building mass, insulation according to regulation ASAHRAE140"

  extends LightMassCases(
  OW=AixLib.DataBase.Walls.ASHRAE140.OW_Case900(),
  groundPlate_upp_half=AixLib.DataBase.Walls.ASHRAE140.FL_Case900());

end HighMassCases;
