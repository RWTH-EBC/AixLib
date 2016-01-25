within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class GettingStarted "Getting started"
  extends Modelica.Icons.Information;

  annotation (Documentation(info="<html>

<p>
For getting started have a closer look at the models <code>Components.TCPCommunicatorExample</code> 
and <code>Examples.ExampleClientLoop</code>. The first one shows how the procedure of starting a TCP
communication has to be done. The latter shows <code>Components.TCPCommunicatorExample</code> in a real Example, 
where the signal of a feedback-control system is send via TCP. The server needed for this example can be executed or compiled.
</p>
The source code for the server is provided alongside with this library.

</html>
",
revisions="<HTML>
<ul>
 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>
</ul>
</HTML>"));
end GettingStarted;
