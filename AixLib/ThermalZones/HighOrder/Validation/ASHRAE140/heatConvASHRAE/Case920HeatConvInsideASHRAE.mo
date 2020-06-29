within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case920HeatConvInsideASHRAE
  extends Case620HeatConvInsideASHRAE(Room(wallTypes(OW=
            AixLib.DataBase.Walls.ASHRAE140.OW_Case900(), groundPlate_upp_half=
            AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
end Case920HeatConvInsideASHRAE;
