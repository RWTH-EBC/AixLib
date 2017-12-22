within AixLib.Utilities.Communication.SocketCommunication.Components;
model TCPCommunicatorExample
  "Example model to show TCP-Communication with simple server"
  extends BaseClasses.PartialTCPCommunicator(
          final nin = nSend,
          final nout = nRecv,
          final samplePeriod = samplePeriodExample,
          final startTime=startTimeExample,
          final IP_Address=IP_AddressExample,
          final port=portExample); //Extends basic TCP communication model

  /**************** necessary Input ****************************/
  parameter Modelica.SIunits.Time samplePeriodExample = 1
    "Sample period how often a telegram is send";
  parameter Modelica.SIunits.Time startTimeExample = 0
    "Start time when sampling starts";
  parameter String IP_AddressExample = "127.0.0.1"
    "IP address or name of Server";
  parameter String portExample="27015" "Port on server";
  parameter Integer nSend = 1 "Number of datapoints to be written";
  parameter Integer nRecv = 1 "Number of datapoints to be read";

  parameter Integer maxLen = 512
    "Maximum number of single characters receiveable per message";
  String msgSend "Variable for the message to be send";
  Integer intLength "integer value of length of message";
  Integer stateExample
    "dummy variable to check state of function, 0 == OK, 1 == errror";
  String msgRecv "Variable to host received message";
equation

algorithm
  when {sampleTrigger} then

     intLength := Modelica.Utilities.Strings.length(String(u[1]));// Evaluate length of input u[1]
     msgSend := String(u[1]);// Insert String of u[1]
     stateExample :=Functions.TCP.SocketSend(msgSend, intLength,socketHandle);    // send message

/************************* In between for expalanation ******************************/
   Modelica.Utilities.Streams.print("SocketSend(): Send message to IP " + IP_Address + " at port " + port + ": " + msgSend);
/************************* In between for expalanation ******************************/

   (msgRecv, stateExample) :=Functions.TCP.SocketReceive(maxLen,socketHandle);   // receive message

    y[1] :=Modelica.Utilities.Strings.scanReal(msgRecv);

/************************* In between for expalanation ******************************/
  Modelica.Utilities.Streams.print("SocketReceive(): Message received from IP " + IP_Address + " at port " + port + ": " + msgRecv);
/************************* In between for expalanation ******************************/

 end when;

annotation(Documentation(revisions="<html>
<ul>
<li><i>June 01, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Implemented</li>
 <li><i>September 03, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised and updated </li>
</ul>
</html>", info="<html>

<h4>Simple TCP Communicator Example</h4>

<p>This is a small example Block which allows to establish a TCP Connection between a Client (i.e. Dymola) 
and a Server (External) it sends the value of input <code>u[1]</code> as a string to the server and receives a string message.
This received string message should only contain a real number as it is converted into a <code>Real</code> value afterwards and
forwarded to output <code>y[1]</code>. Check <code>SocketCommunication.Examples.ExampleClientLoop</code> for a executable example.
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
          extent={{-38,10},{28,-36}},
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
