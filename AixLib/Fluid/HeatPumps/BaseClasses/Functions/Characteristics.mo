within AixLib.Fluid.HeatPumps.BaseClasses.Functions;
package Characteristics
  extends Modelica.Icons.Package;

  partial function baseFct "Base class for Cycle Characteristic"
    extends Modelica.Icons.Function;
    input Real N;
    input Real T_con;
    input Real T_eva;
    input Real mFlow_eva;
    input Real mFlow_con;
    output Real Char[2];

    annotation (Documentation(info="<html>
<p><h4><font color=\"#008000\">Overview</font></h4></p>
<p>
Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate.
</p>
<p><h4><font color=\"#008000\">Level of Development</font></h4></p>
<p><img src=\"modelica://HVAC/Images/stars2.png\"/></p>
</html>",
      revisions="<html>
<p><ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul></p>
</html>
"));
  end baseFct;

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

  function constantCoP "Constant CoP and constant electric power"
    extends
      AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.baseFct(
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
end Characteristics;
