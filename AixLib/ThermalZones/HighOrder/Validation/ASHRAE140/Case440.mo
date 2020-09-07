within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case440
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
    absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01,
    ReferenceCoolingLoad(table=[440,-5204,-3967]),
    ReferenceHeatingLoad(table=[440,4449,5811]));
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case440.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput(events=true),
Documentation(revisions="<html><ul>
  <li>
    <i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>
    Implemented
  </li>
</ul>
</html>", info="<html>
<p>
  As described in ASHRAE Standard 140.
</p>
<p>
  Difference to case 600:
</p>
<ul>
  <li>Solar absorptance on exterior surface = 0.6
  </li>
  <li>Solar absorptance on exterior surface = 0.1
  </li>
</ul>
</html>"));
end Case440;
