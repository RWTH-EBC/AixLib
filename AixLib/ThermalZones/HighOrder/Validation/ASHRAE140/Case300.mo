within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case300
 extends Case620(
    Tset_Cooler(k=20.0001),
    TSet_Heater(k=19.9999),
    Source_InternalGains(k=0),
    AirExchangeRate(k=0),
    Room(eps_out=0.1, absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09));
end Case300;
