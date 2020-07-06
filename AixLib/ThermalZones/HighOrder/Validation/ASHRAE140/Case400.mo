within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case400
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
                 Room(
      solar_absorptance_OW=0.1,
    outerWall_South( windowSimple(redeclare model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoTransmittance),
      use_shortWaveRadIn=false,
      use_shortWaveRadOut=false,
      solar_absorptance=0.1),
    ceiling(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_West(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_North(use_shortWaveRadIn=false, solar_absorptance=0.1),
    outerWall_East(use_shortWaveRadIn=false, solar_absorptance=0.1),
    floor(use_shortWaveRadIn=false)),
    TransmittedRad(y=0),
    Source_InternalGains(k=0),
    AirExchangeRate(k=0),
    ReferenceHeatingLoad(table=[400,6900,8770]),
    ReferenceCoolingLoad(table=[400,-61,0]));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 600: </p>
<ul>
<li> Opaque windows, no shortwave transmittance</li>
<li> Air Exchange Rate = 0</li>
<li> Internal Gains = 0</li>
<li> Solar absorptance on exterior surface = 0.1</li>
<li> Solar absorptance on exterior surface = -</li>
</ul>
</ul>
</ul>
</html>"));
end Case400;
