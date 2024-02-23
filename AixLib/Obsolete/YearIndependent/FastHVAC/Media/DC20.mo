within AixLib.Obsolete.YearIndependent.FastHVAC.Media;
record DC20 "solar fluid 50%-vol DC20"
extends AixLib.Obsolete.YearIndependent.FastHVAC.Media.BaseClasses.MediumSimple(
    rho=1043,
    c=3600,
    lambda=0.4,
    eta=0.0064666);
  annotation (Documentation(info="<html><p>
  This record declares parameters for the solar fluid with 50%-vol
  DC20. Media properties can be found in:
</p>
<p>
  http://www.wagnersolarshop.com/files//db3431d4-a9ac-4f0b-99ed-a11700e12772/EN-XX_DC20_TI-091110-11207500[1].pdf
</p>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib.
  </li>
</ul>
</html>"));
end DC20;
