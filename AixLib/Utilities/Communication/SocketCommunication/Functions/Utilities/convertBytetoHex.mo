within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertBytetoHex
  "External C function that converts a byte array into a hex string "
input String str "String that contains byte array";
output String ans "String with converted byte array as a hex string";

external "C" ans = convertBytetoHex(str);

annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include",
            Documentation(
            info="<HTML>
<p>Function that converts a byte array into a hex string.</p>
            <h4>C source code of <code>convertBytetoHex()</code></h4>
            <pre>
            char *convertBytetoHex(unsigned char *ByteStr)
            {
              int i;
              char *buffer;
              int len = strlen(ByteStr);
              buffer = ModelicaAllocateString(len*2+1);
              for(i = 0; i &lt; len; i++)
                {
                sprintf(buffer+2*i, &quot;%02X&quot;, ByteStr[i]);
                }
              return(buffer);
              }

            </pre>
</HTML>",
revisions="<HTML>
<ul>
  <li>
  <i>October 07, 2015&nbsp;</i>
  by Georg Ferdinand Schneider:<br />
  Revised for publishing</li>
  <li>
  <i>September 24, 2013&nbsp;</i>
  by Dr. Jens Oppermann:<br />
  First implementation</li>
</ul>
</HTML>"));
end convertBytetoHex;
