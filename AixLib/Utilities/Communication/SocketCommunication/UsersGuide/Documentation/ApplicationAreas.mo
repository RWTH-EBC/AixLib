within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class ApplicationAreas "Overview"
   extends Modelica.Icons.Information;

   annotation (preferredView="info", Documentation(info="<HTML>
   <p>The template models and the C-functions shipped with the <code>SocketCommunication</code>-package
   enable a Modelica simulation environment to exchange simulation values at 
   runtime with other tools. The data is exchanged using network sockets and the
   TCP protocol. The Modelica simulation environment acts as a TCP-client.</p>
   <p>Possible applications are hardware-in-the-loop-simulation (HIL-simulation) and co-simulation
   of systems. An example of an application of the <code>SocketCommunication</code>-package
   for investigating circulating pump control through HIL-simulation is published in [1].</p>
   <p>
<table summary=\"Citation\">   
<tr>
<td>[1]</td>
<td>Schneider, G.F., Oppermann, J., Constantin, A., Streblow, R. and Mueller, D. (2015)
   Hardware-in-the-Loop-Simulation of a Building Energy and Control System to Investigate Circulating Pump 
   Control Using Modelica. In: Proceedings of the 11th International Modelica Conference. Versailles, France, pp.225–233.</td>
</tr>
</table>   </p>
</HTML>",
revisions="<HTML>
<ul>
<li><i>May 30, 2016&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Implemented</li>
</ul>
</HTML>"));
end ApplicationAreas;
