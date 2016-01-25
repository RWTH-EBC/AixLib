within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertStrtoInt
  "External C function that converts a string into a integer value"
input String str "String with integer number to be converted";
output Integer data "Converted number from string";

external "C" convertStrtoInt(str,data) annotation (
Include="#include \"TCP_Lib.h\"",
 IncludeDirectory="modelica://ConnectivityTCP/Resources/Include");

 annotation (Documentation(info="<HTML>

Function to convert a number coded as a string into a integer variable.
The function uses the function of the C++ standard library \"atoi()\". See C++ reference for more information.

<h4>Usage of Function</h4>
<pre>
ans = convertStrtoInt(\"11\")
</pre>
<p>
yields
<p>
ans = 11


<p><h4>C Source Code of convertStrtoDbl()</h4></p>
<p>Source code of convertStrtoDbl(). </p>
<pre>
void convertStrtoInt(char* string, int * data) 
{
        *data = atoi(string);
}
</HTML>",
revisions="<HTML>
<ul>
  <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         First implementation</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

</ul>
</HTML>"));

end convertStrtoInt;
