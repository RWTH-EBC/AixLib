within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case280HeatConvInsideASHRAE
  extends Case270HeatConvInsideASHRAE(
                  Room(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01));
end Case280HeatConvInsideASHRAE;
