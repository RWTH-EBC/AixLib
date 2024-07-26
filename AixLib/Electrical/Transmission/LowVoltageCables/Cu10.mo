within AixLib.Electrical.Transmission.LowVoltageCables;
record Cu10 "Cu cable 10 mm^2"
  extends AixLib.Electrical.Transmission.LowVoltageCables.Generic(
    material=Types.Material.Cu,
    M = 234.5 + 273.15,
    Amp=65,
    RCha=1.81e-003,
    XCha=0.076e-003);
  annotation (Documentation(info="<html>
<p>
Copper cable with a cross-sectional area of 10mm^2.
This type of cable has the following properties
</p>
<pre>
RCha = 1.810-003 // Characteristic resistance [Ohm/m]
XCha = 0.076e-003 // Characteristic reactance [Ohm/m]
</pre>
</html>", revisions="<html>
<ul>
<li>
September 24, 2014, by Marco Bonvini:<br/>
Revised structure of the record, now the temperature constant <code>M</code>
is directly specified in the record.
</li>
<li>
Sept 19, 2014, by Marco Bonvini:<br/>
Added User's guide.
</li>
</ul>
</html>"),  
   __Dymola_LockedEditing="Model from IBPSA");
end Cu10;
