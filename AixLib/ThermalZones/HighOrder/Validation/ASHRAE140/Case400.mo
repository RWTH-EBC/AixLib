within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case400
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
    redeclare model CorrSolarGainWin =
        Components.WindowsDoors.BaseClasses.CorrectionSolarGain.CorGSimple,
    redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140_NoSWTrans
      windowParam,
    solar_absorptance_OW=0.1,
    internalGains=0,
    airExchange=0,
    tableCoolOrTempMin=[400,-61,0],
    tableHeatOrTempMax=[400,6900,8770]);
  annotation (
    experiment(StopTime=31539600, Tolerance=1e-06),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/ThermalZones/HighOrder/Validation/ASHRAE140/Case400.mos"
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
  Input Specifications of <b>Case 400</b> as described in ASHRAE
  Standard 140:
</p>
<p>
  Difference to case 600:
</p>
<ul>
  <li>Opaque windows, no shortwave transmittance
  </li>
  <li>Air Exchange Rate = 0
  </li>
  <li>Internal Gains = 0
  </li>
  <li>Solar absorptance on exterior surface = 0.1
  </li>
  <li>Solar absorptance on interior surface = -
  </li>
</ul>
</html>"));
end Case400;
