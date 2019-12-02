within AixLib.Utilities.Sources.InternalGains.Humans;
model CO2Source "Model for calculating CO2 production of people"
  parameter Modelica.SIunits.Length height = 1.72 "Average body height" annotation (Dialog(tab="CO2 production"));
  parameter Modelica.SIunits.Mass weight = 76.3 "Average body mass" annotation (Dialog(tab="CO2 production"));

  Modelica.SIunits.DensityOfHeatFlowRate met = 58 "Metabolic rate of a relaxed seated person  [1 Met = 58 W/m^2]";
  Modelica.SIunits.DensityOfHeatFlowRate M = met*activityDegree "Metabolic heat production rate [W/m^2]";
  Modelica.SIunits.MassFlowRate mOneP_flow "Emission CO2 of one Person [kg/s]";
  Modelica.SIunits.Density dCO2 "CO2 density";
  Modelica.Blocks.Interfaces.RealInput nP "Number of people in room"
    annotation (Placement(transformation(rotation=0, extent={{-110,30},{-90,50}})));

  Modelica.Blocks.Interfaces.RealInput TRoom "Room Air temperature"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput activityDegree
    "Activity Degree (Met Units)"
    annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
  Modelica.Blocks.Interfaces.RealOutput CO2People_flow
    "Human CO2 production [kg/s]"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

protected
   constant Modelica.SIunits.MolarMass M_CO2 = 0.04401;

equation
  dCO2 = M_CO2*101325/(Modelica.Constants.R*TRoom); // "Ideal gas equation"
  (mOneP_flow) =
    BaseClasses.CO2EmissionAdult(
    M,
    BaseClasses.BodySurfaceArea(
      height, weight),
    TRoom,
   dCO2);

  CO2People_flow = mOneP_flow*nP;

  annotation (Documentation(info="<html>
<p><b><font style=\"color: #008000; \">Overview</font></b> </p>
<p>This model calculates the CO2 production of the people in the room (Volume).</p>
<p><b><font style=\"color: #008000; \">References</font></b> </p>
<p>[1]: Engineering ToolBox, (2004). Met - Metabolic Rate. [online] Available at: https://www.engineeringtoolbox.com/met-metabolic-rate-d_733.html  </p>

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
          extent={{-90,90},{90,-90}},
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
          extent={{-78,2},{-62,-50}},
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
end CO2Source;
