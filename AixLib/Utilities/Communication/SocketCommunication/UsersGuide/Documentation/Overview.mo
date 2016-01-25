within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class Overview "Overview"
   extends Modelica.Icons.Information;

   annotation (preferredView=Info, Documentation(info="<HTML>
   <p>
   <h4>Introduction</h4>
   This is a library which enables Modelica simulation environments to act as a TCP-Client
   to enable Modelica-based co-simulation and hardware-in-the-loop applications. To do so we implemented a 
   set of functions offered by the Microsoft Winsock-API in C to allow a Modelica
   simulation environment to act as a TCP Client and send and receive messages
   via a TCP socket to a server.   <p>
   These messages can be character strings. They need to be specified according to the
   required application.<p>
    The authors are not able offer support for the code. Still we encourage every user to contribute to the library.
   <h4>Acknowledgements</h4>
   This research is part of a master thesis which took place at WILO SE
   supervised by the Institute for Energy Efficient Buildings and Indoor Climate.
   We would like to thank WILO SE for financial support of the research activities.


</HTML>",
revisions="<HTML>
<ul>
  <li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         First implementation
</li>

 <li><i>October 07, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>
         
 <li><i>November 12, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br>
         Revised for publishing</li>

</ul>
</HTML>"));
end Overview;
