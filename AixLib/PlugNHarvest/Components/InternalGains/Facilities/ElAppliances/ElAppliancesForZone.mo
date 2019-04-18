within AixLib.PlugNHarvest.Components.InternalGains.Facilities.ElAppliances;
model ElAppliancesForZone
  extends
    PlugNHarvest.Components.InternalGains.BaseClasses.PartialElectricalEquipment;

  parameter Modelica.SIunits.Area zoneArea = 100 "zone area";
  parameter Real spPelSurface(unit = "W/m2") =  22 "specific Pel per surface area for type of machines";
  parameter Real coeffThermal = 0.5 "coeff = Pth/Pel";
  parameter Real coeffRadThermal = 0.75 "coeff = Pth,rad/Pth";
  parameter Real emissivityMachine =  0.9 "emissivity of machine";
  Modelica.Blocks.Sources.Constant AreaofZone(k=zoneArea)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.Constant SpecificElectricalPower(k=spPelSurface)
    "in W/m2 for area"
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=3)
    annotation (Placement(transformation(extent={{-16,-8},{-4,4}})));
  Modelica.Blocks.Math.Gain coeffPthermal(k=coeffThermal)
    annotation (Placement(transformation(extent={{12,14},{24,26}})));
  Modelica.Blocks.Math.Gain coefPth_conv(k=1 - coeffRadThermal)
    annotation (Placement(transformation(extent={{30,34},{38,42}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow ConvectiveHeat             annotation(Placement(transformation(extent={{46,28},
            {66,48}})));
  Modelica.Blocks.Math.Gain coeffOth_rad(k=coeffRadThermal)
    annotation (Placement(transformation(extent={{30,-4},{38,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow RadiativeHeat                    annotation(Placement(transformation(extent={{46,-10},
            {66,10}})));
  AixLib.Utilities.HeatTransfer.HeatToStar
                                  RadiationConvertor(eps=emissivityMachine, A=
       max(1e-4, zoneArea/10.0))
    annotation (Placement(transformation(extent={{70,-8},{90,12}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a ConvHeat
    "convective heat connector"                                                            annotation(Placement(transformation(extent={{80,60},
            {100,80}}),                                                                                                                                         iconTransformation(extent={{80,60},
            {100,80}})));
  AixLib.Utilities.Interfaces.Star
                            RadHeat "radiative heat connector" annotation(Placement(transformation(extent={{100,-8},
            {120,12}}),                                                                                                               iconTransformation(extent={{80,2},{
            100,22}})));
equation
  connect(AreaofZone.y,multiProduct. u[1]) annotation (Line(points={{-39,30},
          {-28,30},{-28,0.8},{-16,0.8}},
                                  color={0,0,127}));
  connect(SpecificElectricalPower.y,multiProduct. u[2]) annotation (Line(points={{-39,-30},
          {-28,-30},{-28,-2},{-16,-2}},               color={0,0,127}));
  connect(multiProduct.y,coeffPthermal. u) annotation (Line(points={{-2.98,-2},
          {0,-2},{0,20},{10.8,20}},color={0,0,127}));
  connect(coefPth_conv.y,ConvectiveHeat. Q_flow)
    annotation (Line(points={{38.4,38},{46,38}}, color={0,0,127}));
  connect(ConvectiveHeat.port,ConvHeat)  annotation(Line(points={{66,38},{74,
          38},{74,70},{90,70}},                                                                             color = {191, 0, 0}, pattern = LinePattern.Solid));
  connect(coeffOth_rad.y,RadiativeHeat. Q_flow)
    annotation (Line(points={{38.4,0},{46,0}}, color={0,0,127}));
  connect(RadiationConvertor.Star,RadHeat)  annotation (Line(
      points={{89.1,2},{110,2}},
      color={95,95,95},
      pattern=LinePattern.Solid));
  connect(coeffPthermal.y,coefPth_conv. u) annotation (Line(points={{24.6,20},
          {26,20},{26,38},{29.2,38}},
                                  color={0,0,127}));
  connect(coeffPthermal.y,coeffOth_rad. u) annotation (Line(points={{24.6,20},
          {26,20},{26,0},{29.2,0}},
                                color={0,0,127}));
  connect(RadiativeHeat.port,RadiationConvertor. Therm)
    annotation (Line(points={{66,0},{70,0},{70,2},{70.8,2}}, color={191,0,0}));
  connect(Schedule, multiProduct.u[3]) annotation (Line(points={{-100,0},{-60,
          0},{-60,-4.8},{-16,-4.8}}, color={0,0,127}));
  connect(multiProduct.y, Pel) annotation (Line(points={{-2.98,-2},{0,-2},{0,
          -50},{100,-50}}, color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(
          points={{-80,-60},{60,-60},{80,-34},{80,52},{-60,52},{-80,36},{-80,
              -60}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,36},{60,36},{60,-60}},
          color={0,0,0},
          thickness=1),
        Ellipse(
          extent={{-28,8},{8,-26}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-12,14},{-12,20},{-2,20},{-4,14},{4,10},{8,16},{14,8},{10,
              4},{14,-4},{20,-4},{20,-14},{14,-14},{10,-22},{16,-26},{10,-32},
              {4,-28},{-2,-32},{-2,-38},{-10,-38},{-10,-32},{-16,-32},{-18,
              -38},{-26,-34},{-24,-28},{-28,-26},{-32,-28},{-38,-24},{-32,-20},
              {-34,-14},{-40,-14},{-40,-4},{-36,-6},{-34,2},{-38,4},{-32,12},
              {-28,8},{-24,12},{-28,16},{-22,20},{-18,14},{-12,14}},
          color={0,0,0},
          thickness=1)}), Documentation(info="<html>
<h4>Objective </h4>
<p>The model describes the electrical power consumed by auxiliary equipment and the thermal power generated by it for a certain zone.</p>
<p>The model can be thus used to calculate both the thermal and the electrical load / energy consumption of a building caused by auxiliary equipment (help energy)</p>
<p>The input is a schedule for the equipment and can vary between 0 and 1.</p>
<p>The assumptions as well as exemplary values for the parameters are listed below. </p>
<h4>Assumptions</h4>
<p>The surface of the lamps is assumed as 1/10 of the zone area. The emissivity of the machines is assumed to be 0.9. Both these values are needed for the calculation of the radiative heat exchange.</p>
<h4>Heat loads by type of zone</h4>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><h4>Type of zone</h4></td>
<td><h4>Heat Load in W/m2</h4></td>
<td><h4>Source</h4></td>
</tr>
<tr>
<td><p>Supermarket Non-Food</p></td>
<td><p>1 / 2 / 3 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A6)</p></td>
</tr>
<tr>
<td><p>Supermarket Food (cooling)</p></td>
<td><p>-12 / -10 / -8 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A7) if heat from cooling taken outside</p></td>
</tr>
<tr>
<td><p>Office</p></td>
<td><p>2.8 / 7.1 / 15 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A2)</p></td>
</tr>
<tr>
<td><p>Kitchen (preparation, storage)</p></td>
<td><p>20 / 30 / 40 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A15)</p></td>
</tr>
<tr>
<td><p>Storage</p></td>
<td><p>0 / 0 / 0 (small, middle, high)</p></td>
<td><p>DIN 18599-10.2 (A18)</p></td>
</tr>
<tr>
<td><p>....</p></td>
<td></td>
<td></td>
</tr>
</table>
<p><br><br><h4>Relationship thermal - electrical load and convective - radiant thermal load</h4></p>
<p><span style=\"font-family: Arial;\">(Source ASHRAE Handbook of Fundamentals, 2001) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Cooking appliances (page 28.9) -&gt; used for type of zone kitchen</span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Heat gain 50&percnt; of rated hourly input - 66 &percnt; sensible (100&percnt; radiant as convective is exhausted) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Sales food (table 5) &ndash;&gt; used for type of zone sales </span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Display case refigerated / freezer / refrigerator : heat gain 40&percnt; of rated hourly input  (100&percnt; sensible and as radiant as convective is exhausted) </span></p>
<ul>
<li><span style=\"font-family: Arial;\">Office (page 29.9 + Table 13) &ndash;&gt; used for type of zone office </span></li>
</ul>
<p style=\"margin-left: 60px;\"><span style=\"font-family: Arial;\">Heat gain 50&percnt; of rated hourly input - 100 &percnt; sensible (22&percnt; radiant, 78 &percnt; convective as a mean between equipment with fans and without fans) </span></p>
</html>",
        revisions="<html>
<ul>
<li><i>September, 2017&nbsp;</i> by Ana Constantin:<br>Implemented</li>
</ul>
</html>"));
end ElAppliancesForZone;
