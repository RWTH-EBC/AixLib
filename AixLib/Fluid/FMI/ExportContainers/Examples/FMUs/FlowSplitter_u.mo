within AixLib.Fluid.FMI.ExportContainers.Examples.FMUs;
block FlowSplitter_u "Declaration of an FMU that exports a flow splitter"
   extends AixLib.Fluid.FMI.FlowSplitter_u(
     redeclare replaceable package Medium = AixLib.Media.Air,
        nout=2,
        m_flow_nominal={0.1, 0.2},
        allowFlowReversal(start=false));

  annotation (  Documentation(info="<html>
<p>
This example demonstrates how to export an FMU with a fluid flow component.
The FMU is an instance of
<a href=\"modelica://AixLib.Fluid.FMI.FlowSplitter_u\">
AixLib.Fluid.FMI.FlowSplitter_u</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
November 20, 2014 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://AixLib/Resources/Scripts/Dymola/Fluid/FMI/ExportContainers/Examples/FMUs/FlowSplitter_u.mos"
        "Export FMU"));
end FlowSplitter_u;
