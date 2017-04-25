within AixLib.DataBase.Pipes.PE_X;
record DIN_16893_SDR11_d25 "PE-X Pipe, d_o=25mm, SDR11"
extends DataBase.Pipes.PipeBaseDataDefinition(
    d_i=0.0204,
    d_o=0.025,
    d=940,
    lambda=0.38,
    c=2300);

annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Record for PE-X pipe. </p>
<p><h4><font color=\"#008000\">Concept</font></h4></p>
<p>The pipe dimensions are according to standard DIN 16893.</p>
<p>SDR is the diameter to wall thickness ratio. </p>
<p>d is the diameter in mm.  </p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars5.png\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
<p>Record is used with <a href=\"HVAC.Components.Pipes.DynamicPipeEBC1\">HVAC.Components.Pipes.DynamicPipeEBC1</a> </p>
<p>Source: </p>
<p><ul>
<li>DIN 16983:2000-09</li>
</ul></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>January 29, 2014&nbsp;</i> by Ana Constantin:<br/>Added to HVAC, formated and upgraded to current version of Dymola/Modelica</li>
<li><i>March 13, 2012&nbsp;</i> by Tim Comanns (supervisor: Ana Constantin):<br/>Implemented.</li>
</ul></p>
</html>"));
end DIN_16893_SDR11_d25;
