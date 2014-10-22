within AixLib.Utilities.Sensors;
model TEnergyMeter "measures thermal power (heat flow)"
  extends EEnergyMeter;

  annotation (Diagram(graphics), Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Model that meters the thermal power (heat flow)</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars2.png\"/></p>
</html>",
        revisions="<html>
<p><ul>
<li><i>October 15, 2013&nbsp;</i> by Ole Odendahl:<br/>Added documentation and formatted appropriately</li>
</ul></p>
</html>
"));
end TEnergyMeter;
