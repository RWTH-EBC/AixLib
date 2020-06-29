within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvBerndGlueck;
model Case395
  extends heatConvBerndGlueck.Case400(
                  Room(outerWall_South(withWindow=false)));
  parameter Real coeff=Room.outerWall_South.solar_absorptance
    "Weight coefficient";
end Case395;
