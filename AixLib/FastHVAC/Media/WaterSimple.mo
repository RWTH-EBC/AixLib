within AixLib.FastHVAC.Media;
record WaterSimple
extends AixLib.FastHVAC.Media.BaseClasses.MediumSimple(
    rho=995,
    c=4119,
    lambda=0.64);
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
