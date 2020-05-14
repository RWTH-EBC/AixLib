within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case420
  extends Case410(Source_InternalGains_convective(k=0.4*200),
      Source_InternalGains_radiative(k=0.6*200));
end Case420;
