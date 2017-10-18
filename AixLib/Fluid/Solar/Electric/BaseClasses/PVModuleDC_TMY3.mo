within AixLib.Fluid.Solar.Electric.BaseClasses;
model PVModuleDC_TMY3 "PV module with temperature dependent efficiency"

 parameter Modelica.SIunits.Area Area
  "Area of one Panel";
 parameter Modelica.SIunits.Efficiency Eta0
  "Maximum efficiency";
 parameter Modelica.SIunits.Temp_K NoctTemp
  "Defined temperature";
 parameter Modelica.SIunits.Temp_K NoctTempCell
  "Meassured cell temperature";
 parameter Modelica.SIunits.RadiantEnergyFluenceRate NoctRadiation
  "Defined radiation";
 parameter Modelica.SIunits.LinearTemperatureCoefficient TempCoeff
  "Temperature coeffient";
 Modelica.SIunits.Power PowerPV
  "Power of PV panels";
 Modelica.SIunits.Efficiency EtaVar
  "Efficiency of PV cell";
 Modelica.SIunits.Temp_K TCell
  "Cell temperature";
 Modelica.Blocks.Interfaces.RealInput AmbientTemperature(
  final quantity="ThermodynamicTemperature",
  final unit="K")
  "Ambient temperature"
  annotation(Placement(
  transformation(extent={{-139,54},{-99,94}}),
  iconTransformation(extent={{-140,62},{-100,102}})));
 Modelica.Blocks.Interfaces.RealOutput DCOutputPower(
  final quantity="Power",
  final unit="W")
  "DC output power of PV panels"
  annotation(Placement(
  transformation(extent={{100,70},{120,90}}),
  iconTransformation(extent={{100,-10},{120,10}})));

  Real SolarIrradiationPerSquareMeter( final unit = "W/m2")= HGloHor
  "Total solar irradiation per square meter";

  Modelica.Blocks.Interfaces.RealInput HGloHor
    "diffuse horizintal for TRY; ground horizontal for TMY"
                                               annotation (Placement(
        transformation(extent={{-140,-52},{-100,-12}}), iconTransformation(
          extent={{-132,-34},{-100,-2}})));

equation

  TCell=AmbientTemperature+(NoctTempCell-NoctTemp)*
  SolarIrradiationPerSquareMeter/NoctRadiation;
  EtaVar=Eta0-TempCoeff*(TCell-NoctTemp)*Eta0;
  PowerPV=SolarIrradiationPerSquareMeter*Area*EtaVar;
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
     Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>The <b>PVmoduleDC</b> model represents a simple PV cell. </p>
<h4><span style=\"color: #008000\">Concept</span></h4>
<p>PV moduleDC has a temperature&nbsp;dependency&nbsp;for&nbsp;efficiency.</p>
</html>",
     revisions="<html>
<p><ul>
<li><i>October 11, 2016 </i> by Tobias Blacha:<br/>Moved into AixLib</li>
<li><i>Februar 21, 2013  </i>by Corinna Leonhardt:<br/>Implemented</li>
</ul></p>
</html>"),   Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVModuleDC_TMY3;
