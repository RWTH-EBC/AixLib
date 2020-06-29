within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case395HeatConvInsideASHRAE
  extends Case400HeatConvInsideASHRAE(
                  Room(outerWall_South(withWindow=false)));
  parameter Real coeff=Room.outerWall_South.solar_absorptance
    "Weight coefficient";
end Case395HeatConvInsideASHRAE;
