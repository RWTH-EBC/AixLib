within AixLib.Utilities.Communication.SocketCommunication.Functions.TCP.Internal;
function add2 "For testing only"

input Integer a "Integer number";
input Integer b "Integer number";
output Integer ans
    "dummy answer 0 = OK!, 1 == Intialization failed, 2 == Connect failed";

external "C" ans = add2(a,b) annotation (
    Include="#include \"AixLibSocketCommunication.h\"",
    IncludeDirectory="modelica://AixLib/Resources/Include");

end add2;
