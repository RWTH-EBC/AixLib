within AixLib.Electrical.Transmission.MediumVoltageCables;
record Annealed_Al_10 "Annealed Al cable - AWG 1/0"
  extends AixLib.Electrical.Transmission.MediumVoltageCables.Generic(
    material=Types.Material.Al,
    M = 228.1 + 273.15,
    size="1/0",
    Rdc=0.551181e-3,
    T_ref=298.15,
    d=9.195e-3,
    D=26.543e-3,
    GMR=AixLib.Electrical.Transmission.Functions.computeGMR(d),
    GMD=AixLib.Electrical.Transmission.Functions.computeGMD(0.1905),
    Amp=195);
  annotation (Documentation(info="<html>
<p>
Annealed aluminium cable with a cross-sectional AWG 1/0
(American Wire Gauge).
This type of cable has the following properties
</p>
<pre>
Rdc  = 0.551181e-3 // Characteristic DC resistance at T = T_ref[Ohm/m]
T_ref= 298.15      // Reference temperature of the material [K]
d    = 9.195e-3    // Inner diameter [m]
D    = 26.543e-3   // Outer diameter [m]
Amp  = 195         // Ampacity [A]
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
end Annealed_Al_10;
