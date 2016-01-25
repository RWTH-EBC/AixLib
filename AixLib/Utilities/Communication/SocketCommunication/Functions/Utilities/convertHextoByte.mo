within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertHextoByte
  "External C function that converts a hex string into a byte array"
input String str "String that contains hex string to be converted";
output String ans "String that contains converted byte array";

external "C" ans = convertHextoByte(str);
annotation (Include="#include \"TCP_Lib.h\"",
 IncludeDirectory="modelica://ConnectivityTCP/Resources/Include",
            Documentation(
            info="<HTML>
            Function that converts a hex string into a byte array.
            <h4>C Source Code of convertHextobyte()</h4>
            <pre>
            unsigned char *convertHextoByte(char *HEXStr)
            {
              int i, n;
              int len = strlen(HEXStr)/2;
            char *buffer;
 
            buffer = ModelicaAllocateString(len);
             for(i = 0; i &lt; len; i++)
                {
                sscanf(HEXStr+2*i, &quot;%02X&quot;, &n);
                buffer[i] = (char)n;
                }
           return buffer;
            }
            </pre>
            </HTML>",
          revisions="<HTML>
          <ul><li><i>September 24, 2013&nbsp;</i>
          by Dr. Jens Oppermann:<br>
           First implementation</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

      </ul>
</HTML>"));
end convertHextoByte;
