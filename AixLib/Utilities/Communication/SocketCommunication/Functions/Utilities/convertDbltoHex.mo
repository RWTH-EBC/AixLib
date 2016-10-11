within AixLib.Utilities.Communication.SocketCommunication.Functions.Utilities;
function convertDbltoHex
  "External C function that converts a double number into a byte array"
input Real num "Number to be converted into byte array";
output String ans "String that contains converted number";

external "C" ans = convertDbltoHex(num);
annotation (    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include",   Documentation(
            info="<HTML>
            Function that converts a double number into a byte array.
            <h4>C source code of <code>convertDbltoHex()</code></h4>
            <pre>
          unsigned char **convertDbltoHex(double num) {
          unsigned char *byArr;
              unsigned char *buffer;
            int i;
            float num_f;

            union record_4 {
              char c[4];
              unsigned char u[4];
              short s[2];
              long l;
              float f;
              } r;
  
        r.f = (float)num; 
        byArr = ModelicaAllocateString(4);
        buffer = ModelicaAllocateString(8);
        
        // Change order high and low byte
        byArr[0] = r.u[1];
        byArr[1] = r.u[0];
        byArr[2] = r.u[3];
        byArr[3] = r.u[2];

        
         for(i = 0; i &lt; 4; i++)
         {
          sprintf(buffer+2*i, &quot;%02X&quot;, byArr[i]);
        }

        return buffer; // *((Float*)&byArr)
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
end convertDbltoHex;
