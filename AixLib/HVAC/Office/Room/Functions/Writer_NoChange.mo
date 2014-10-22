within AixLib.HVAC.Office.Room.Functions;
function Writer_NoChange
  input Real[:] V "Real value to be sent to external program";
  input Integer LENGTH "Integer value to be sent to external program";
  input String Stringer "String to be sent to external program";
  output Integer Const "Integer value to be received from external program";
  external "C" Const = writerNoChange(V, LENGTH, Stringer);
  annotation (Include="#include <Header.h>",Library="ExternalC",
     Documentation(revisions="<html>
<ul>
  <li><i>Feb 26, 2014&nbsp;</i> by Bjoern Flieger:<br/>Implemented</li>

</ul>
</html>",
     info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function for wirting a value.</p>
</html>"));
end Writer_NoChange;
