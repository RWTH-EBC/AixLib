within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case430HeatConvInsideASHRAE
  extends Case420HeatConvInsideASHRAE(
                  Room(
      redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win(
          Emissivity=0.9),
      solar_absorptance_OW=0.6,
      outerWall_South(solar_absorptance=0.6),
      ceiling(solar_absorptance=0.6),
      outerWall_West(solar_absorptance=0.6),
      outerWall_North(solar_absorptance=0.6),
      outerWall_East(solar_absorptance=0.6)));
end Case430HeatConvInsideASHRAE;
