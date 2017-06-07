within AixLib.DataBase.Servers;
record genericCPUTempPowerRatio
  "Generic power consumption ratio of the CPU"
  extends AixLib.DataBase.Servers.TempretaurePowerRatioBaseDataDefinition(
  powerRatio = [     0,      0,     50,    100;
                294.05,      1, 1.2223, 1.4141;
                299.45, 1.0190, 1.2470, 1.4421]);
end genericCPUTempPowerRatio;
