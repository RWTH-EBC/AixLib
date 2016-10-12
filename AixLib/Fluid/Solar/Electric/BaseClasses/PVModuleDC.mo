within AixLib.Fluid.Solar.Electric.BaseClasses;
model PVModuleDC "PV module with temperature dependent efficiency"

parameter Modelica.SIunits.Area Area=20 "Area of one Panel";
parameter Modelica.SIunits.Efficiency Eta0=0.176 "Maximum efficiency";
parameter Modelica.SIunits.Temp_K NoctTemp=25+273.15 "Defined temperature";
parameter Modelica.SIunits.Temp_K NoctTempCell=45+273.15 "Meassured cell temperature";
parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation=1000 "Defined radiation";
parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff=0.003 "Temperature coeffient";
Modelica.SIunits.Power PowerPV "Power of PV panels";
Modelica.SIunits.Efficiency EtaVar "Efficiency of PV cell";
Modelica.SIunits.Temp_K TCell "Cell temperature";

 Modelica.Blocks.Interfaces.RealInput  SolarIrradationPerSquareMeter(
 final quantity="RadiantEnergyFluenceRate",
 final unit="W/m2")
    "Solar radiation per sqaure meter"                                                            annotation(Placement(
  transformation(extent={{-115,49},{-75,89}}),
  iconTransformation(extent={{-122,32},{-82,72}})));
 Modelica.Blocks.Interfaces.RealInput AmbientTemperature(
 final quantity="ThermodynamicTemperature",
 final unit="K")
    "Ambient temperature"                                                           annotation(Placement(
  transformation(extent={{-115,-70},{-75,-30}}),
  iconTransformation(extent={{-122,-68},{-82,-28}})));
 Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
 final quantity="Power",
 final unit="W")
    "DC output power of PV panels"                                                   annotation(Placement(
  transformation(extent={{110,70},{130,90}}),
  iconTransformation(extent={{90,-10},{110,10}})));

equation
  TCell=AmbientTemperature+(NoctTempCell-NoctTemp)*SolarIrradationPerSquareMeter/NoctRadiation;
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
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>"));
end PVModuleDC;
