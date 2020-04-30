within AixLib.Utilities.Math.Functions;
function round "Rounds values"

  input Real u;
  input Integer digits;
  output Real y;
protected
  Real tmp "helper variable";
  Real factor = 10^digits;
algorithm
  tmp:=integer(u*factor);
  y:=if noEvent(u*factor >= tmp+0.5) then (tmp+1)/factor else (tmp)/factor;
  annotation (Documentation(info="<html><h4>
  <span style=\"color:#008000\">Overview</span>
</h4>&lt;
<p>
  This function is there to round values. Same as <b><a href=
  \"Modelica.Blocks.Nonlinear.VariableLimiter\">Modelica.Blocks.Nonlinear.VariableLimiter</a></b>
  but it's a function.
</p>
<h4>
  <span style=\"color:#008000\">Known Limitations</span>
</h4>
<p>
  The precision should not be set higher than 3 or 4 digits, otherwise
  simulation time will increase significantly.
</p>
<h4>
  <span style=\"color:#008000\">Concept</span>
</h4>
<p>
  Rounding real input signals to the given number of digits after the
  decimal point. The output is a real. This function may be used in
  conjunction with lookup tables that must not be interpolatated. The
  table data must then be provied with the set precision.
</p>
</html>",
        revisions="<html><ul>
  <li>
    <i>April 11, 2013&#160;</i> by Ole Odendahl:<br/>
    Formatted documentation appropriately
  </li>
  <li>
    <i>July, 2007&#160;</i> by Peter Matthes:<br/>
    Implemented.
  </li>
</ul>
</html>"));
end round;
