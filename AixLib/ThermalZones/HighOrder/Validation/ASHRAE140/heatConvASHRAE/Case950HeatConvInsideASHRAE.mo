within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case950HeatConvInsideASHRAE
  extends Case650HeatConvInsideASHRAE(Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
end Case950HeatConvInsideASHRAE;
