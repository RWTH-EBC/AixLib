within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case210
  extends Case220(Room(
      outerWall_South(eps_in=0.1),
      ceiling(eps_in=0.1),
      outerWall_West(eps_in=0.1),
      outerWall_North(eps_in=0.1),
      outerWall_East(eps_in=0.1),
      floor(eps_in=0.1)));
end Case210;
