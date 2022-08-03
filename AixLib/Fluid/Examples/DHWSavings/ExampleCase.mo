within AixLib.Fluid.Examples.DHWSavings;
model ExampleCase "Example case to check if the model is running"
  extends AixLib.Fluid.Examples.DHWSavings.BaseClasses.PartialDHWSavings(
    factorInsAir=0.01,
    QLosPerDay=3,
    TSetDHW_nominal=333.15,
    pumpSchedule=AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Constant,
    tempSchedule=AixLib.Fluid.Examples.DHWSavings.Types.Schedule.Constant,
    DHWProfile=DHWSavings.Profiles.ProfileS_TwoHours());
  annotation (experiment(
      StopTime=864000,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end ExampleCase;
