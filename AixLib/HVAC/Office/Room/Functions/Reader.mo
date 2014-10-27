within AixLib.HVAC.Office.Room.Functions;

function Reader
  input Integer index "Integer value to be sent to external program";
  output Real W "Real value to be received from external program";

  external "C" W = reader(index);
  annotation(Include = "#include <Header.h>", Library = "ExternalC", Documentation(revisions = "<html>
 <ul>
   <li><i>Feb 26, 2014&nbsp;</i> by Bjoern Flieger:<br/>Implemented</li>

 </ul>
 </html>", info = "<html>
 <h4><span style=\"color:#008000\">Overview</span></h4>
 <p>Function for reading a value.</p>
 </html>"));
end Reader;