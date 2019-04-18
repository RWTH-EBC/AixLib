within AixLib.PlugNHarvest.Components.InternalGains.Facilities;
model Facilities
  parameter Modelica.SIunits.Area zoneArea = 100 "zone floor area" annotation(Dialog(descriptionLabel = true));
  parameter Real spPelSurface_elApp(unit = "W/m2") =  22 "specific Pel/m2 for type of el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
  parameter Real coeffThermal_elApp = 0.5 "coeff = Pth/Pel for el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
  parameter Real coeffRadThermal_elApp = 0.75 "coeff = Pth,rad/Pth for el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));
  parameter Real emissivity_elApp =  0.9 "emissivity of el. appliances" annotation(Dialog(group = "Electrical Appliances",descriptionLabel = true));

  parameter Real spPelSurface_lights(unit = "W/m2") =  22 "specific Pel/m2 for type of light source" annotation(Dialog(group = "Lights",descriptionLabel = true));
  parameter Real coeffThermal_lights = 0.9 "coeff = Pth/Pel for lights" annotation(Dialog(group = "Lights",descriptionLabel = true));
  parameter Real coeffRadThermal_lights = 0.89 "coeff = Pth,rad/Pth for lights" annotation(Dialog(group = "Lights",descriptionLabel = true));
  parameter Real emissivity_lights =  0.98 "emissivity lights" annotation(Dialog(group = "Lights",descriptionLabel = true));

  ElAppliances.ElAppliancesForZone machinesForZone(
    zoneArea=zoneArea,
    spPelSurface=spPelSurface_elApp,
    coeffThermal=coeffThermal_elApp,
    coeffRadThermal=coeffRadThermal_elApp,
    emissivityMachine=emissivity_elApp)
    annotation (Placement(transformation(extent={{-24,30},{20,68}})));
  Lights.LightingForZone lightingForZone(
    zoneArea=zoneArea,
    spPelSurface=spPelSurface_lights,
    coeffThermal=coeffThermal_lights,
    coeffRadThermal=coeffRadThermal_lights,
    emissivityLamp=emissivity_lights)
    annotation (Placement(transformation(extent={{-20,-20},{18,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat[2]
    "1- machines; 2 - lights" annotation (Placement(transformation(extent={{76,56},
            {102,82}}), iconTransformation(extent={{80,60},{100,80}})));
  AixLib.Utilities.Interfaces.Star RadHeat[2] "1- machines; 2 - lights"
    annotation (Placement(transformation(extent={{80,20},{100,40}}),
        iconTransformation(extent={{80,20},{100,40}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_elApp
    "electrical load in W for electrical appliances" annotation (Placement(
        transformation(extent={{80,-40},{100,-20}}), iconTransformation(extent={
            {80,-40},{100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Pel_lights
    "electrical load in W for lighting" annotation (Placement(transformation(
          extent={{80,-80},{100,-60}}), iconTransformation(extent={{80,-80},{100,
            -60}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_elAppliances "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,28},{-80,68}}),
        iconTransformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Interfaces.RealInput Schedule_lights "from 0 to 1"
    annotation (Placement(transformation(extent={{-120,-24},{-80,16}}),
        iconTransformation(extent={{-100,-40},{-80,-20}})));
equation
  connect(machinesForZone.RadHeat, RadHeat[1]) annotation (Line(points={{17.8,51.28},
          {36,51.28},{36,25},{90,25}}, color={95,95,95}));
  connect(lightingForZone.RadHeat, RadHeat[2]) annotation (Line(points={{16.1,-2.08},
          {36,-2.08},{36,35},{90,35}}, color={95,95,95}));
  connect(machinesForZone.Pel, Pel_elApp) annotation (Line(points={{17.8,39.5},{
          36,39.5},{36,-30},{90,-30}}, color={0,0,127}));
  connect(lightingForZone.Pel, Pel_lights) annotation (Line(points={{16.1,-12},{
          36,-12},{36,-70},{90,-70}}, color={0,0,127}));
  connect(machinesForZone.Schedule, Schedule_elAppliances) annotation (Line(
        points={{-21.8,49},{-22,49},{-22,48},{-100,48}}, color={0,0,127}));
  connect(lightingForZone.Schedule, Schedule_lights)
    annotation (Line(points={{-18.1,-4},{-100,-4}}, color={0,0,127}));
  connect(machinesForZone.ConvHeat, ConvHeat[1]) annotation (Line(points={{17.8,
          62.3},{84,62.3},{84,62.5},{89,62.5}}, color={191,0,0}));
  connect(lightingForZone.ConvHeat, ConvHeat[2]) annotation (Line(points={{16.1,
          7.2},{36,7.2},{36,75.5},{89,75.5}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid), Text(
          extent={{-80,66},{76,-72}},
          lineColor={255,255,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.None,
          textString="Facilities Zone
 - El. Appliances
 - Lights")}),
            Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li><i>September, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>",
        info="<html>
<p>Aggregated model for electrical appliances and lights for a zone.</p>
</html>"));
end Facilities;
