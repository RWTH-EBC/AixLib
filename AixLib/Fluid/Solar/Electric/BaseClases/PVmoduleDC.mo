within AixLib.Fluid.Solar.Electric.BaseClases;
model PVmoduleDC "PVmoduleDC with temperature dependency for efficiency"

parameter Real Area=20;
parameter Real Eta0=0.176;
parameter Real NoctTemp=25;
parameter Real NoctTempCell=45;
parameter Real NoctRadiation=1000;
parameter Real TempCoeff=0.003;
Real PowerPV;
Real EtaVar;
Real TCell;

 Modelica.Blocks.Interfaces.RealInput SolarIrradationPerSquareMeter
    "'input Real' as connector"                                                            annotation(Placement(
  transformation(extent={{-115,49},{-75,89}}),
  iconTransformation(extent={{-122,32},{-82,72}})));
 Modelica.Blocks.Interfaces.RealInput AmbientTemperatureDegC
    "ambient temperature in Celsius"                                                           annotation(Placement(
  transformation(extent={{-115,-70},{-75,-30}}),
  iconTransformation(extent={{-122,-68},{-82,-28}})));
 Modelica.Blocks.Interfaces.RealOutput DCOutputPower
    "DC output power of PV panels"                                                   annotation(Placement(
  transformation(extent={{110,70},{130,90}}),
  iconTransformation(extent={{90,-10},{110,10}})));

equation
  TCell=AmbientTemperatureDegC+(NoctTempCell-NoctTemp)*SolarIrradationPerSquareMeter/NoctRadiation;
  EtaVar=Eta0-TempCoeff*(TCell-NoctTemp)*Eta0;
  PowerPV=SolarIrradationPerSquareMeter*Area*EtaVar;
  DCOutputPower=PowerPV;
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
