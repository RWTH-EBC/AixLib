within AixLib.Utilities.Communication.SocketCommunication;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;

annotation (Documentation(info="<html><p>
  This package presents the use of TCP-IP communication over sockets.
</p>
<p>
  Initialy the package contained its own set of functions, written as
  part of a thesis by Georg Ferdinand Schneider at a time when no such
  implemetation existed. For this version you can refer to an older
  version of AixLib, specifically 0.5.2 as the last version which
  includes this implementation.
</p>
<p>
  As the Modelica_DeviceDrivers over time incorporated such a
  functionality, with the help of Thomas Beutlich we switched to using
  the Modelica_DeviceDrivers.Communication.TCPIPSocketClient class.
</p>
<p>
  We kept the model and the example as a documented application
  example.
</p>
</html>", revisions="<HTML>
<ul>
<li><i>August 27, 2018&nbsp;</i>
         by Ana Constantin:<br />
         Implemented. This is for:<a href=\"https://github.com/RWTH-EBC/AixLib/issues/277\">#277</a></li>
</ul>
</HTML>"));
end UsersGuide;
