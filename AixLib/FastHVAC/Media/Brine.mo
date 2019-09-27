within AixLib.FastHVAC.Media;
record Brine "brine fluid for geothermal 30%-vol DC20 at 0 °C"
extends AixLib.FastHVAC.Media.BaseClasses.MediumSimple(
    rho=1051,
    c=3700,
    lambda=0.478,
    eta=0.00461);
  annotation (Documentation(info="<html><p>
  This record declares parameters for the solar fluid with 50%-vol
  DC20. Media properties can be found in:
</p>
<p>
  http://www.wagnersolarshop.com/files//db3431d4-a9ac-4f0b-99ed-a11700e12772/EN-XX_DC20_TI-091110-11207500[1].pdf
</p>
</html>", revisions="<html>
<ul>
  <li>
    <i>April 25, 2017</i>, by Michael Mans:<br/>
    Moved to AixLib.
  </li>
</ul>
</html>"));
end Brine;
