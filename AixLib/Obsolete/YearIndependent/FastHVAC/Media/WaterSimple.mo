within AixLib.Obsolete.YearIndependent.FastHVAC.Media;
record WaterSimple
extends AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses.MediumSimple(
    rho=999.7,
    c=4195,
    lambda=0.579,
    eta=0.0013059 "all Data from VDI-Waermeatlas 1bar, 10 °C");
  annotation (Documentation(info="<html><p>
  This record declares parameters that are used by models within the
  FastHVAC Package.
</p>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib.
  </li>
  <li>
    <i>August 11, 2017</i>, by David Jansen:<br/>
    corrected data and inserted dynamic viscosity.
  </li>
</ul>
</html>"));
end WaterSimple;
