within AixLib.Fluid.HeatExchangers.HeatPump.Characteristics;
function constantQualityGrade
  "Carnot CoP multiplied with constant quality grade and constant electric power"
  extends AixLib.Fluid.HeatExchangers.HeatPump.Characteristics.baseFct(
    N,
    T_con,
    T_eva,
    mFlow_eva,
    mFlow_con);
    parameter Real qualityGrade=0.3 "Constant quality grade";
    parameter Modelica.SIunits.Power P_com=2000
    "Constant electric power input for compressor";
protected
    Real CoP_C "Carnot CoP";
algorithm
  CoP_C:=T_con/(T_con - T_eva);
  Char:= {P_com,P_com*CoP_C*qualityGrade};

  annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>Carnot CoP multiplied with constant quality grade and constant electric power, no dependency on speed or mass flow rates! </p>
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
end constantQualityGrade;
