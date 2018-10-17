within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertBytetoSgl
  "External C function that converts a byte array into a number"
input String str "String that contains the byte array to be converted";
output Real ans "Real number that contains converted number";

external "C" ans = convertBytetoSgl(str);
annotation (    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include",   Documentation(
            info="<HTML>
            Function that converts a byte array into a number.
            <h4>C source code of <code>convertBytetoSgl()</code></h4>
            <pre>
            float convertBytetoSgl(unsigned char *ByteArray)
            {
            char byArr[4];
            int i;
            union record_4 {
              char c[4];
              unsigned char u[4];
              short s[2];
              long l;
              float f;
              } r;
    
              r.u[0] = ByteArray[1];
              r.u[1] = ByteArray[0];
              r.u[2] = ByteArray[3];
              r.u[3] = ByteArray[2];
              return r.f; 
             }
            </pre>
            </HTML>",
          revisions="<HTML>
          <ul>
           <li><i>October 07, 2015&nbsp;</i>
 by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
          <li><i>September 24, 2013&nbsp;</i>
          by Dr. Jens Oppermann:<br />
           First implementation</li>
      </ul>
</HTML>"));
end convertBytetoSgl;
