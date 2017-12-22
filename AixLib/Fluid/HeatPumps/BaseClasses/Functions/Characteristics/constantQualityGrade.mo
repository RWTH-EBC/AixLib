within AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics;
function constantQualityGrade
  "Carnot CoP multiplied with constant quality grade and constant electric power"
  extends
    AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.baseFct(
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
<p>Carnot CoP multiplied with constant quality grade and constant electric power, no dependency on speed or mass flow rates! </p>
</html>",
    revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
end constantQualityGrade;
