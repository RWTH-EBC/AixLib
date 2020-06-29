within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case810HeatConvInsideASHRAE
  extends Case900HeatConvInsideASHRAE(
                  Room(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01));
end Case810HeatConvInsideASHRAE;
