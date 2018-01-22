within AixLib.Building.Components.DryAir.BaseClasses;
partial model PartialBasisAirload
  replaceable package AirMedium = Modelica.Media.Air.SimpleAir constrainedby
    Modelica.Media.Interfaces.PartialMedium                                                                       "Medium in the room" annotation (choicesAllMatching = true);
  parameter Modelica.SIunits.Volume V = 48.0 "Volume of the room";
  parameter Modelica.SIunits.Temperature T = system.T_ambient "Initial temperature of the room";
  parameter Modelica.SIunits.Pressure p = system.p_ambient "Initial pressure of the room";
  inner Modelica.Fluid.System system;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
  annotation (Documentation(info = "<html>
 <h4><font color=\"#008000\">Overview</font></h4>
 <p>The <b>PartialBasisAirload</b> model provides a the basics parameters for the Airload model concluding a media model.</p>
 <h4><font color=\"#008000\">Concept</font></h4>
 <p>This model is used for example with a constant temperature model or a constant mass model depending on the customized behaviour of the room.</p>
 <p>In this case there are different opportunities how the connection-port is designed. This is modeled either with <code>HeatPort_a</code> or <code>FluidPorts_a</code>. </p>
 <h4><font color=\"#008000\">Example Results</font></h4>
 <p>This model is part of <a href=\"AixLib.Building.Components.DryAir.Airload\">Airload</a>. </p>
 </html>", revisions="<html>
 <ul>
 <li><i>Jan 22, 2008&nbsp;</i>
by Tim R&ouml;der:<br/>
          Implemented.</li>
 </ul>
 </html>"));
end PartialBasisAirload;
