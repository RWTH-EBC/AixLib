within AixLib.Utilities.Sources.InternalGains.Humans.BaseClasses;
model CO2Balance
  "This model tracks the incoming and outgoing CO2 massflow in the volume"

  parameter Modelica.SIunits.Density rho;
  parameter Modelica.SIunits.Volume V;
  parameter Modelica.SIunits.Concentration CO2_vent = 6.12157E-4 "CO2 Concentration in atmosphere (equals 403ppm)";

  Modelica.SIunits.MassFlowRate massFlowVent "MassFlowRate of ventilation";

  Modelica.Blocks.Interfaces.RealOutput CO2_flow "Change of CO2 mass in Volume"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput massFlowTracerPeople
    "CO2 massflow of people in room"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput ventSum "Total ventilation rate"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput C "concentration of CO2 in room"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
equation

   massFlowVent = ventSum * rho * V/3600;
   CO2_flow = massFlowVent * (CO2_vent - C) + massFlowTracerPeople;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model tracks the incoming and outgoing CO2 massflow in the volume.</p>
<p><b><font style=\"color: #008000; \">Concept</font></b> </p>
<p>The CO2 massflow is calculated with a simple mass balance around the Volume. The equation looks like this:
</p>
<p align=\"center\"><i>CO2_flow = massFlowVent * (CO2_vent - C) + massFlowTracerPeople;</i></p>
<p>The output is positive or negative depending on the balance.</p>
</html>", revisions="<html>
<ul>
  <li>
  November, 2019, by Ervin Lejlic and Nils Meyer:<br/>
  First implementation.
  </li>
 </ul>
</html>"),      Dialog(tab="CO2 Produktion"),
              Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
        Icon(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end CO2Balance;
