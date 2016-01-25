within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertStrtoDbl
  "External C function that converts a string into a real (double in C) value"
input String str "String with floating point number to be converted";
output Real data "Converted number from string";

external "C" convertStrtoDbl(str,data) annotation (
 Include="#include \"TCP_Lib.h\"",
 IncludeDirectory="modelica://ConnectivityTCP/Resources/Include");

annotation (Documentation(info="<html>

<p>
Function to convert a number coded as a string into a real variable.
The function uses the function of the C++ standard library \"atof()\". See C++ reference for more information.
</p>

<h4>Usage of Function</h4>
<pre>
ans = convertStrtoDbl(\"111.11\")
</pre>
<p>
yields
<p>
ans = 111.11

<p><h4>C Source Code of convertStrtoDbl()</h4></p>
<p>Source code of convertStrtoDbl(). </p>
<pre>
void convertStrtoDbl(char* string, double * data)
{
        *data = atof(string);
}

</pre>


</html>",
revisions="<HTML>
<ul>
  <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         First implementation
</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

</ul>
</HTML>"));
end convertStrtoDbl;
