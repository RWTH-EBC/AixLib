within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvBerndGlueck;
model Case800
  extends heatConvBerndGlueck.Case430(
                  Room(wallTypes(OW=AixLib.DataBase.Walls.ASHRAE140.OW_Case900(),
          groundPlate_upp_half=AixLib.DataBase.Walls.ASHRAE140.FL_Case900())));
end Case800;
