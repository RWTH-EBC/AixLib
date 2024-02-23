within AixLib.Controls.HVACAgentBasedControl.BaseClasses.Internal;
encapsulated function sendTo
  import Modelica;
  extends Modelica.Icons.Function;
  import Modelica_DeviceDrivers.Communication.UDPSocket;
  import Modelica_DeviceDrivers.Packaging.SerialPackager;
  input UDPSocket socket;
  input String ipAddress "IP address where data has to be sent";
  input Real port "Port number where data has to be sent";
  input SerialPackager pkg;
  input Integer dataSize "Size of data";
  external "C" MDD_udpSendP(socket, ipAddress, port, pkg, dataSize)
  annotation(IncludeDirectory="modelica://Modelica_DeviceDrivers/Resources/Include",
        Include = "#include \"MDDUDPSocket.h\"",
         Library = {"pthread", "Ws2_32"},
         __iti_dll = "ITI_MDD.dll",
         __iti_dllNoExport = true);
  annotation (Documentation(info="<html>The function was copied from the Modelica_DeviceDrivers library and
changed to the degree that the variable \"port\" is no longer of the type
Integer but Real instead.
<ul>
  <li>November 2016: Adapted from Modelica_DeviceDrivers by Felix
  Bünning
  </li>
</ul>
</html>"));
end sendTo;
