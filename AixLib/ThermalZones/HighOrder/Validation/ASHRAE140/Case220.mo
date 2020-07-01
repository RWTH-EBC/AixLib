within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case220
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
    AirExchangeRate(k=0),
    Source_InternalGains(k=0),
    Room(redeclare DataBase.WindowsDoors.Simple.WindowSimple_ASHRAE140 Type_Win,
    outerWall_South(windowSimple(redeclare model correctionSolarGain =
            Components.WindowsDoors.BaseClasses.CorrectionSolarGain.NoTransmittance)),
        solar_absorptance_OW=0.1),
    Tset_Cooler(k=20.0001),
    TSet_Heater(k=19.9999));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 600: </p>
<ul>
<li> Heat = ON if temperature &lt; 20 degC</li>
<li> Cool = ON if temperature &lt; 20 degC</li>
<li> Opaque windows, no shortwave transmittance</li>
<li> Air Exchange Rate = 0</li>
<li> Internal Gains = 0</li>
<li> Solar absorptance on exterior surface = 0.6</li>
<li> Solar absorptance on exterior surface = -</li>
</ul>
</ul>
</ul>
</html>"));
end Case220;
