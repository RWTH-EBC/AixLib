within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case400
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
    solar_absorptance_OW=0.1,
    internalGains=0,
    airExchange=0,
                 Room(outerWall_South( windowSimple(redeclare model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoTransmittance))),
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
