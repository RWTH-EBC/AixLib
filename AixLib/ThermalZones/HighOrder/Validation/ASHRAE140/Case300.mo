within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case300
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case620(
    Tset_Cooler(k=20.0001),
    TSet_Heater(k=19.9999),
    Source_InternalGains(k=0),
    AirExchangeRate(k=0),
    Room(eps_out=0.1, absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs09),
    ReferenceHeatingLoad(table=[300,4761,5964]),
    ReferenceCoolingLoad(table=[300,-7100,-4302]));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 270: </p>
<ul>
<li>no windows on south side. two windows, one facing east, one facing west, each with a surface of 6m2.</li>
</ul>
</ul>
</ul>
</html>"));
end Case300;
