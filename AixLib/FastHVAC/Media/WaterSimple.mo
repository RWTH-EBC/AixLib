within AixLib.FastHVAC.Media;
record WaterSimple
extends AixLib.FastHVAC.Media.BaseClasses.MediumSimple(
    rho=995,
    c=4119,
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
end WaterSimple;
