within AixLib.DataBase.Pipes.PE_X;
record DIN_16893_SDR11_d40 "PE-X Pipe, d_o=40mm, SDR11"
  extends DataBase.Pipes.PipeBaseDataDefinition(
    d_i=0.0326,
    d_o=0.04,
    d=940,
    lambda=0.38,
    c=2300);

  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>
<p>
  Record for PE-X pipe.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  The pipe dimensions are according to standard DIN 16893.
</p>
<p>
  SDR is the diameter to wall thickness ratio.
</p>
<p>
  d is the diameter in mm.
</p>
<h4>
  <span style=\"color:#008000\">References</span>
</h4>
<p>
  Record is used with <a href=
  \"AixLib.Fluid.FixedResistances.Pipe\">AixLib.Fluid.FixedResistances.Pipe</a>
</p>
<p>
  Source:
</p>
<ul>
  <li>DIN 16983:2000-09
  </li>
</ul>
</html>",
      revisions="<html><ul>
  <li>
    <i>April 25, 2017</i> by Tobias Blacha:<br/>
    Moved into AixLib
  </li>
  <li>
    <i>January 29, 2014&#160;</i> by Ana Constantin:<br/>
    Added to HVAC, formated and upgraded to current version of
    Dymola/Modelica
  </li>
  <li>
    <i>March 13, 2012&#160;</i> by Tim Comanns (supervisor: Ana
    Constantin):<br/>
    Implemented.
  </li>
</ul>
</html>"));
end DIN_16893_SDR11_d40;
