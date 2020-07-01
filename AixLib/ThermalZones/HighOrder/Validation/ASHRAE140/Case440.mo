within AixLib.ThermalZones.HighOrder.Validation.ASHRAE140;
model Case440
  extends AixLib.ThermalZones.HighOrder.Validation.ASHRAE140.Case600(
                  Room(absInnerWallSurf=AixLib.ThermalZones.HighOrder.Components.Types.selectorCoefficients.abs01));
  annotation (Documentation(revisions="<html>
 <ul>
 <li><i>July 1, 2020</i> by Konstantina Xanthopoulou:<br/>Implemented</li>
 </ul>
 </html>", info="<html>
<p>As described in ASHRAE Standard 140.</p>
<p>Difference to case 600: </p>
<ul>
<li> Solar absorptance on exterior surface = 0.6</li>
<li> Solar absorptance on exterior surface = 0.1</li>
</ul>
</ul>
</ul>
</html>"));
end Case440;
