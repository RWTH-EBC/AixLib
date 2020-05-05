within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case240
  extends Case220(Source_InternalGains_radiative(k=0.6*200),
      Source_InternalGains_convective(k=0.4*200));
end Case240;
