within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case900HeatConvInsideASHRAE
  extends Case600HeatConvInsideASHRAE(Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
end Case900HeatConvInsideASHRAE;
