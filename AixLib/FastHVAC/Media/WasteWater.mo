within AixLib.FastHVAC.Media;
record WasteWater
extends AixLib.FastHVAC.Media.BaseClasses.Medium(
    rho=999.70,
    c=4195,
    lambda=0.579,
    eta=0.0013059 "all Data from VDI-Waermeatlas 1bar, 10 °C");
  annotation (Documentation(info="<html>
<p>
This record declares parameters that are used by models within
the FastHVAC Package.
</p>
</html>", revisions="<html>
<ul>
<li>
<i>April 25, 2017</i>, by Michael Mans:<br/>
Moved to AixLib.
</li>
</ul>
</html>"));
end WasteWater;
