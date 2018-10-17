within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class GettingStarted "Getting started"
  extends Modelica.Icons.Information;

  annotation (preferredView="info",Documentation(info="<html>

<p>
For getting started have a closer look at the models <code>Components.TCPCommunicatorExample</code> 
and <code>Examples.ExampleClientLoop</code>. The first one shows how the procedure of starting a TCP
communication has to be done. The latter shows <code>Components.TCPCommunicatorExample</code> in a real Example, 
where the signal of a feedback-control system is send via TCP. The server needed for this example can be executed or compiled.
</p>
The source code for the server is provided alongside with this package in
<code>Components.ExampleClientLoop</code>.
 
 <h4>Compatibility</h4>
 <p>The package and functions have been tested using Dymola 2015 32-bit,
 Windows 7 64-bit and MS Visual Studio 2010 Professional.</p>
  <p>Tests with OpenModelica failed due to MS Visual Studio specific
  statements in the external C-functions headerfile (\"#pragma comment\").</p>
 <p> A possible work around is to include the C-code already compiled as a 
 static libary. However our intention is to provide the full source code of
 the C-functions with this package via the header file. </p>
 <p>
 Users opting to use open source Modelica implementations such as OpenModelica
 may consider compiling the C-functions from the header file as a static library
 and then link it via an extra header file as demonstrated for example
 in <code>Modelica.Blocks.Tables.CombiTable1D</code>.</p>
  
</html>
",
revisions="<HTML>
<ul>
 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
</ul>
</HTML>"));
end GettingStarted;
