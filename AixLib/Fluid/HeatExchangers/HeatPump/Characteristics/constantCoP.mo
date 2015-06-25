within AixLib.Fluid.HeatExchangers.HeatPump.Characteristics;
function constantCoP "Constant CoP and constant electric power"
  extends AixLib.Fluid.HeatExchangers.HeatPump.Characteristics.baseFct(
    N,
    T_con,
    T_eva,
    mFlow_eva,
    mFlow_con);
    parameter Modelica.SIunits.Power powerCompressor=2000
    "Constant electric power input for compressor";
    parameter Real CoP "Constant CoP";
algorithm
  Char:= {powerCompressor,powerCompressor*CoP};

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Carnot CoP and constant electric power, no dependency on speed or mass flow rates!</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://AixLib/Images/stars3.png\" alt=\"stars: 3 out of 5\"/></p>
<p><h4><font color=\"#008000\">References</font></h4></p>
</html>",
    revisions="<html>
<p><ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul></p>
</html>
"));
end constantCoP;
