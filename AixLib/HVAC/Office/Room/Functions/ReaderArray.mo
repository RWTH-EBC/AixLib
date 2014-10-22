within AixLib.HVAC.Office.Room.Functions;
function ReaderArray
  input Real H[:] "Integer array to be sent to external program";
  output Real HBack[ size(H,1)]
    "Real array to be received from external program";
  external "C" readerArray(H,HBack,size(H,1));
  annotation (Include="#include <Header.h>",Library="ExternalC",
    Documentation(revisions="<html>
<ul>
  <li><i>Feb 26, 2014&nbsp;</i> by Bjoern Flieger:<br/>Implemented</li>

</ul>
</html>",
    info="<html>
<h4><span style=\"color:#008000\">Overview</span></h4>
<p>Function for reading an array.</p>
</html>"));
end ReaderArray;
