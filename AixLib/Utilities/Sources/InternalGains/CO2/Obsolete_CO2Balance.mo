within AixLib.Utilities.Sources.InternalGains.CO2;
model Obsolete_CO2Balance
  "This model tracks the incoming and outgoing CO2 massflow in the volume"

  parameter Modelica.SIunits.Density rho "Air Density";
  parameter Modelica.SIunits.Volume V "Zone volume";
  parameter Modelica.SIunits.MassFraction XCO2_amb = 6.12157E-4 "Massfraction of CO2 in atmosphere (equals 403ppm)";

  Modelica.SIunits.MassFlowRate mAirExchange_flow
    "Massflowrate of ventilation and infiltration [kg/s]";

  Modelica.Blocks.Interfaces.RealOutput CO2_flow
    "Incoming and outgoing CO2 massflow [kg/s]"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealInput CO2People_flow
    "CO2 massflow of people in zone [kg/s]"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput airExchange
    "Total ventilation and infiltration rate [1/h]"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput XCO2
    "Massfraction of CO2 in room [kgCO2/kgTotalAir]"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
equation
  XCO2 = CO2Con*(28.949/44.01)*1E6;
  mAirExchange_flow = airExchange*rho*V/3600;
   CO2_flow =mAirExchange_flow*(XCO2_amb - XCO2) + CO2People_flow;

  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This model tracks the incoming and outgoing CO2 massflow in the volume.</p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The CO2 massflow is calculated with a simple mass balance around the Volume. The equation looks like this: </p>
<p><i>CO2_flow = mAir_flow * (XCO2_amb - XCO2) +CO2People_flow</i></p>
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
end Obsolete_CO2Balance;
