within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.heatConvASHRAE;
model Case440HeatConvInsideASHRAE
  extends Case600HeatConvInsideASHRAE(
                  Room(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01));
end Case440HeatConvInsideASHRAE;
