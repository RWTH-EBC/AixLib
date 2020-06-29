within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvBerndGlueck;
model Case810
  extends heatConvBerndGlueck.Case900(
                  Room(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01));
end Case810;
