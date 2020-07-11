within AixLib.DataBase.Walls.Collections.ASHRAE140;
record LightMassCases_eps01 "Light Mass Cases but eps=0.1"
  extends LightMassCases(
  OW=AixLib.DataBase.Walls.ASHRAE140.OW_Case600_eps01(),
  groundPlate_upp_half=AixLib.DataBase.Walls.ASHRAE140.FL_Case600_eps01(),
      roof=AixLib.DataBase.Walls.ASHRAE140.RO_Case600_eps01());
end LightMassCases_eps01;
