within AixLib.Utilities.Sources.InternalGains.CO2;
model Obsolete_HumanCO2Source
  "Model for calculating CO2 production of people"

  parameter Real activityDegree "Activity degree (Met units)";
  constant Modelica.SIunits.Area A = 1.8 "Body surface Area sourc SIA 2024:2015 [m^2]";
  constant Modelica.SIunits.DensityOfHeatFlowRate met = 58 "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]";
  Modelica.SIunits.VolumeFlowRate V_flow "CO2 emission of an adult person [m^3/s]";
  Modelica.SIunits.DensityOfHeatFlowRate M = met*activityDegree "Metabolic heat production rate [W/m^2]";
  Modelica.SIunits.MassFlowRate mOneP_flow "Emission CO2 of one Person [kg/s]";
  Modelica.SIunits.Density dCO2 "CO2 density";
  Real k "Pure CO2 emission of an adult person [liter/h]";

  Modelica.Blocks.Interfaces.RealInput nP "Number of people in room"
    annotation (Placement(transformation(rotation=0, extent={{-110,30},{-90,50}})));

  Modelica.Blocks.Interfaces.RealInput TRoom "Room Air temperature"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));

    parameter Modelica.SIunits.Density rho "Air Density";
  parameter Modelica.SIunits.Volume V "Zone volume";
  parameter Modelica.SIunits.MassFraction XCO2_amb = 6.12157E-4 "Massfraction of CO2 in atmosphere (equals 403ppm)";

  Modelica.SIunits.MassFlowRate mAirExchange_flow
    "Massflowrate of ventilation and infiltration [kg/s]";

  Modelica.Blocks.Interfaces.RealOutput CO2_flow
    "Incoming and outgoing CO2 massflow [kg/s]"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.SIunits.MassFlow CO2People_flow
    "CO2 massflow of people in zone [kg/s]"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealInput airExchange
    "Total ventilation and infiltration rate [1/h]"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput CO2Con
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));

  Modelica.SIunits.MassFraction XCO2
    "Massfraction of CO2 in room [kgCO2/kgTotalAir]";

protected
   constant Modelica.SIunits.MolarMass MolCO2 = 0.04401;

equation
   XCO2 = CO2Con*(28.949/MolCO2)*1E6;
  mAirExchange_flow = airExchange*rho*V/3600;
   CO2_flow =mAirExchange_flow*(XCO2_amb - XCO2) + CO2People_flow;

  dCO2 = MolCO2*101325/(Modelica.Constants.R*TRoom); // "Ideal gas equation"
  k =  0.83 * M*A/5.617 * TRoom/273.15;
  V_flow =  k/1000/3600;
  mOneP_flow =  V_flow * dCO2;

  CO2People_flow = mOneP_flow*nP;

  annotation (Documentation(info="<html>
<p><b><span style=\"color: #008000;\">Overview</span></b> </p>
<p>This model calculates the CO2 production of all people in the room (Volume)[1]. </p>
<p>Human CO2 output (kg/s) per person is calculated depending on metabolic heat production rate and body surface area.</p>
<p><b><span style=\"color: #008000;\">Concept</span></b> </p>
<p>The CO2 output k (liter/h) is calculated by the following equation[2]:</p>
<p><i>k = 0.83 * M*A/5.617 * TRoom/273.15</i></p>
<p>The result k is then converted into kg/s (m_flow).</p>
<p><b><span style=\"color: #008000;\">References</span></b> </p>
<p>[1]: W. Zapfel, &apos;Dimensionierung von L&uuml;ftungsanlagen f&uuml;r Schulgeb&auml;ude&apos;, Heizung L&uuml;ftung Klimatechnik, vol. 11, 2006. p. 4-7 </p>
<p>[2]: Engineering ToolBox, (2004). Met - Metabolic Rate. [online] Available at: https://www.engineeringtoolbox.com/met-metabolic-rate-d_733.html </p>
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
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={
        Rectangle(
          extent={{-88,90},{92,-90}},
          lineColor={215,215,215},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,170}),
        Ellipse(
          extent={{-54,64},{0,10}},
          lineColor={95,95,95},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,4},{2,-76}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-76,2},{-60,-50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{12,2},{28,-50}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{12,78},{80,30}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255}),
        Text(
          extent={{18,74},{72,32}},
          lineColor={0,128,255},
          fillPattern=FillPattern.Sphere,
          fillColor={255,255,255},
          textString="CO2")}));
end Obsolete_HumanCO2Source;
