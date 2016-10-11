within AixLib.Fluid.Solar.Electric.BaseClases;
model PVmoduleDC "PVmoduleDC with temperature dependency for efficiency"

parameter Real Area=20;
parameter Real eta0=0.176;
parameter Real NOCT_Temp=25;
parameter Real NOCT_Temp_Cell=45;
parameter Real NOCT_radiation=1000;
parameter Real TempCoeff=0.003;
Real Power_PV;
Real eta_var;
Real T_cell;

 Modelica.Blocks.Interfaces.RealInput Solar_Irradation_per_m2
    "'input Real' as connector"                                                            annotation(Placement(
  transformation(extent={{-115,49},{-75,89}}),
  iconTransformation(extent={{-122,32},{-82,72}})));
 Modelica.Blocks.Interfaces.RealInput ambient_temperature_in_C
    "ambient temperature in Celsius"                                                           annotation(Placement(
  transformation(extent={{-115,-70},{-75,-30}}),
  iconTransformation(extent={{-122,-68},{-82,-28}})));
 Modelica.Blocks.Interfaces.RealOutput DC_output_power
    "DC output power of PV panels"                                                   annotation(Placement(
  transformation(extent={{110,70},{130,90}}),
  iconTransformation(extent={{90,-10},{110,10}})));

equation
  T_cell=ambient_temperature_in_C+(NOCT_Temp_Cell-NOCT_Temp)*Solar_Irradation_per_m2/NOCT_radiation;
  eta_var=eta0-TempCoeff*(T_cell-NOCT_Temp)*eta0;
  Power_PV=Solar_Irradation_per_m2*Area*eta_var;
  DC_output_power=Power_PV;
  annotation (
   Icon(
    coordinateSystem(extent={{-100,-100},{100,100}}),
    graphics={
     Rectangle(
      lineColor={0,0,0},
      fillColor={255,255,255},
      fillPattern=FillPattern.Solid,
      extent={{-100,100},{100,-100}}),
     Line(
      points={{-3,100},{100,0},{0,-100}},
      color={0,0,0})}),
   experiment(
    StopTime=1,
    StartTime=0),
    Diagram(graphics),
     Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The <b>PVmoduleDC</b> model represents a simple PV cell. </p>
<p><br><h4><span style=\"color: #008000\">Concept</span></h4></p>
<p>PV moduleDC has a temperature&nbsp;dependency&nbsp;for&nbsp;efficiency.</p>
</html>",
     revisions="<html>
<p><ul>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
</ul></p>
</html>"));
end PVmoduleDC;
