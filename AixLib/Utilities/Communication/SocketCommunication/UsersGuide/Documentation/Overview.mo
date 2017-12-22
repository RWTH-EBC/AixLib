within AixLib.Utilities.Communication.SocketCommunication.UsersGuide.Documentation;
class Overview "Overview"
   extends Modelica.Icons.Information;

   annotation (preferredView="info", Documentation(info="<HTML>

   <h4>Introduction</h4>
   <p>This is a package which enables Modelica simulation environments to act as a TCP-Client
   to enable Modelica-based co-simulation and hardware-in-the-loop applications. To do so we implemented a 
   set of functions offered by the Microsoft Winsock-API in C to allow a Modelica
   simulation environment to act as a TCP Client and send and receive messages
   via a TCP socket to a server.</p>
   <p>These messages can be character strings. They need to be specified according to the
   required application and/or top-level protocol invocated on top.</p>
   <p>The authors are not able offer support for the code. Still we encourage every user to contribute to the package and C-code as well as to the <code>AixLib</code> library.</p>
   <h4>Acknowledgements</h4>
<p>This research is part of a master thesis which took place at WILO SE
   supervised by the Institute for Energy Efficient Buildings and Indoor Climate.
   We would like to thank WILO SE for financial support of the research 
   activities. Contributions to the package are welcome via the
   <code>AixLib</code> webpage
   <a href=\"https://www.github.com/RWTH-EBC/AixLib\">https://www.github.com/RWTH-EBC/AixLib</a>.</p>


</HTML>",
revisions="<HTML>
<ul>
<li><i>November 12, 2015&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         Revised for publishing</li>
<li><i>September 24, 2013&nbsp;</i>
         by Georg Ferdinand Schneider:<br />
         First implementation
</li>


         
 

</ul>
</HTML>"));
end Overview;
