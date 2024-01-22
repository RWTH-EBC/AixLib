within AixLib.Controls.HVACAgentBasedControl.BaseClasses.Internal;
function sendToUDP
  extends Modelica.Icons.Function;
  input Modelica_DeviceDrivers.Communication.UDPSocket socket;
  input String ipAddress "IP address where data has to be sent";
  input Real port "Port number where data has to be sent";
  input Modelica_DeviceDrivers.Packaging.SerialPackager pkg;
  input Integer dataSize "Size of data";
  input Real dummy;
  output Real dummy2;
algorithm
  AixLib.Controls.HVACAgentBasedControl.BaseClasses.Internal.sendTo(
    socket,
    ipAddress,
    port,
    pkg,
    dataSize);
  dummy2 := dummy;
  annotation (Documentation(info="<html>The function was copied from the Modelica_DeviceDrivers library and
changed to the degree that the variable \"port\" is no longer of the type
Integer but Real instead.
<ul>
  <li>November 2016: Adapted from Modelica_DeviceDrivers by Felix
  Bünning
  </li>
</ul>
</html>"));
end sendToUDP;
