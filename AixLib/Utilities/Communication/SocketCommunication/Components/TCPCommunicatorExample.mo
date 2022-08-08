within AixLib.Utilities.Communication.SocketCommunication.Components;
model TCPCommunicatorExample
  "Example model to show TCP communication with simple server"
  extends BaseClasses.PartialTCPCommunicator(
          final nin = nSend,
          final nout = nRecv,
          final samplePeriod = samplePeriodExample,
          final startTime=startTimeExample,
          final IP_Address=IP_AddressExample,
          final port=portExample); //Extends basic TCP communication model

  /**************** necessary Input ****************************/
  parameter Modelica.Units.SI.Time samplePeriodExample=1
    "Sample period how often a telegram is send";
  parameter Modelica.Units.SI.Time startTimeExample=0
    "Start time when sampling starts";
  parameter String IP_AddressExample = "127.0.0.1"
    "IP address or name of Server";
  parameter Integer portExample=27015 "Port on server";
  parameter Integer nSend = 1 "Number of data points to be written";
  parameter Integer nRecv = 1 "Number of data points to be read";
  parameter Modelica_DeviceDrivers.Utilities.Types.ByteOrder byteOrder = Modelica_DeviceDrivers.Utilities.Types.ByteOrder.LE "Byte order";
protected
  Integer stateExample "Dummy variable to check state of TCP send function, 0 == OK, 1 == error";
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgSend = Modelica_DeviceDrivers.Packaging.SerialPackager(8*nSend) "Package for the message to be send";
  Modelica_DeviceDrivers.Packaging.SerialPackager pkgRecv = Modelica_DeviceDrivers.Packaging.SerialPackager(8*nRecv) "Package to host the received message";

algorithm
  when {sampleTrigger} then
    if isConnected then
      Modelica_DeviceDrivers.Packaging.SerialPackager_.addReal(pkgSend, u, byteOrder);
      stateExample := Modelica_DeviceDrivers.Communication.TCPIPSocketClient_.sendTo(socketHandle, pkgSend, 8*nSend);    // send message
      Modelica_DeviceDrivers.Packaging.SerialPackager_.resetPointer(pkgSend);

/************************* In between for explanation ******************************/
      Modelica.Utilities.Streams.print("SocketSend(): Send message to IP " + IP_Address + " at port " + String(port) + ": " + String(u[1]));
/************************* In between for explanation ******************************/

      Modelica_DeviceDrivers.Communication.TCPIPSocketClient_.read(socketHandle, pkgRecv, 8*nRecv);   // receive message

      y := Modelica_DeviceDrivers.Packaging.SerialPackager_.getReal(pkgRecv, nRecv, byteOrder);
      Modelica_DeviceDrivers.Packaging.SerialPackager_.resetPointer(pkgRecv);

/************************* In between for explanation ******************************/
      Modelica.Utilities.Streams.print("SocketReceive(): Message received from IP " + IP_Address + " at port " + String(port) + ": " + String(y[1]));
/************************* In between for explanation ******************************/
    end if;
  end when;

annotation(Documentation(revisions="<html><ul>
  <li>
    <i>August 25, 2018&#160;</i> by Thomas Beutlich:<br/>
    Utilize TCPIPSocketClient_ functions from Modelica_DeviceDrivers
    library. This is for:<a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/277\">#277</a>
  </li>
  <li>
    <i>June 01, 2013&#160;</i> by Georg Ferdinand Schneider:<br/>
    Implemented
  </li>
  <li>
    <i>September 03, 2013&#160;</i> by Georg Ferdinand Schneider:<br/>
    Revised and updated
  </li>
</ul>
</html>", info="<html>
<h4>
  Simple TCP Communicator Example
</h4>
<p>
  This is a small example block which allows to establish a TCP
  connection between a client (i.e., Dymola or SimulationX by ESI) and
  an external server. It sends the value of input <code>u[1]</code> as
  a floating-point number to the server and receives a floating-point
  number. Check
  <code>SocketCommunication.Examples.ExampleClientLoop</code> for an
  executable example.
</p>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,66},{-30,30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,66},{84,30}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-88,22},{-30,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{26,22},{84,10}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-38,10},{38,-36}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="TCP"),
        Polygon(
          points={{-50,-10},{-96,-46},{-50,-80},{-50,-10}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-50,-38},{40,-52}},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-86,64},{-32,32}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,64},{82,32}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,-10},{86,-42},{40,-80},{40,-10}},
          smooth=Smooth.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}));
end TCPCommunicatorExample;
