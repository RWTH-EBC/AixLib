within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case270
  extends Case220(Room(
      solar_absorptance_OW=0.1,
      outerWall_South(use_shortWaveRadIn=true, use_shortWaveRadOut=true),
      ceiling(use_shortWaveRadIn=true, use_shortWaveRadOut=false),
      outerWall_West(use_shortWaveRadIn=true),
      outerWall_North(use_shortWaveRadIn=true),
      outerWall_East(use_shortWaveRadIn=true),
      floor(use_shortWaveRadIn=true)));
end Case270;
