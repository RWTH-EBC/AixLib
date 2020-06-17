within AixLib.ThermalZones.HighOrder.Examples;
model OFDHeatLoad "Test environment to determine OFD's nominal heat load"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant constRooms[9](k={293.15,293.15,288.15,293.15,
        293.15,293.15,293.15,297.15,293.15})
    "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Bath_UF, 9: Child2_UF"
    annotation (Placement(transformation(extent={{-70,-62},{-50,-42}})));
  Modelica.Blocks.Sources.Constant constAirEx[8](k={0.5,0.5,0.5,0.5,0.5,0.5,0.5,
        0.5})
    "1: LivingRoom_GF, 2: Hobby_GF, 3: WC_Storage_GF, 4: Kitchen_GF, 5: Bedroom_UF, 6: Child1_UF, 7: Bath_UF, 8: Child2_UF"
              annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Blocks.Sources.Constant constWind(k=0)
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Modelica.Blocks.Sources.Constant constAmb(k=261.15)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTemp[5](T=fill(
        273.15 + 8.5, 5))
    annotation (Placement(transformation(extent={{-54,-96},{-42,-84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature[9]
    annotation (Placement(transformation(extent={{-36,-58},{-24,-46}})));
  Utilities.Interfaces.Adaptors.ConvRadToCombPort heatStarToComb[9] annotation (Placement(transformation(
        extent={{10,-8},{-10,8}},
        rotation=0,
        origin={-24,-16})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedAmbTemperature
    annotation (Placement(transformation(extent={{-40,58},{-28,70}})));
  Utilities.Sources.PrescribedSolarRad        varRad(n=6)
    annotation (Placement(transformation(extent={{70,60},{50,80}})));
  Modelica.Blocks.Sources.Constant constSun[6](k=fill(0, 6))
    annotation (Placement(transformation(extent={{100,70},{80,90}})));
  Modelica.Blocks.Sources.RealExpression sumHeatLoads(y=-sum(
        prescribedTemperature[:].port.Q_flow))
    annotation (Placement(transformation(extent={{42,-72},{62,-52}})));
  Modelica.Blocks.Sources.RealExpression heatLoads[size(prescribedTemperature,
    1)](y=-(prescribedTemperature[:].port.Q_flow))
    annotation (Placement(transformation(extent={{42,-92},{62,-72}})));
  Modelica.Blocks.Interfaces.RealOutput totalHeatLoad
    annotation (Placement(transformation(extent={{88,-72},{108,-52}})));
  Modelica.Blocks.Interfaces.RealOutput roomHeatLoads[size(
    prescribedTemperature, 1)]
    annotation (Placement(transformation(extent={{88,-92},{108,-72}})));
  House.OFD_MiddleInnerLoadWall.BuildingEnvelope.WholeHouseBuildingEnvelope
    wholeHouseBuildingEnvelope
    annotation (Placement(transformation(extent={{-14,-10},{42,46}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow    prescribedHeatFlowRad[9]
    annotation (Placement(transformation(extent={{-60,-24},{-48,-12}})));
  Modelica.Blocks.Sources.Constant adiabaticRadRooms[9](k=fill(0, 9))
    "1: LivingRoom_GF, 2: Hobby_GF, 3: Corridor_GF, 4: WC_Storage_GF, 5: Kitchen_GF, 6: Bedroom_UF, 7: Child1_UF, 8: Bath_UF, 9: Child2_UF"
    annotation (Placement(transformation(extent={{-90,-26},{-74,-10}})));
equation
  connect(constRooms.y,prescribedTemperature. T) annotation (Line(
      points={{-49,-52},{-37.2,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port, heatStarToComb.portConv) annotation (Line(
      points={{-24,-52},{-16,-52},{-16,-30},{-38,-30},{-38,-21.1},{-34.1,-21.1}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(constAmb.y, prescribedAmbTemperature.T) annotation (Line(
      points={{-49,80},{-46,80},{-46,64},{-41.2,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constSun.y,varRad. I) annotation (Line(
      points={{79,80},{74,80},{74,78.9},{68.9,78.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constSun.y,varRad. I_dir) annotation (Line(
      points={{79,80},{74,80},{74,75},{69,75}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constSun.y,varRad. I_diff) annotation (Line(
      points={{79,80},{74,80},{74,71},{69,71}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constSun.y,varRad. I_gr) annotation (Line(
      points={{79,80},{74,80},{74,66.9},{68.9,66.9}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constSun.y,varRad. AOI) annotation (Line(
      points={{79,80},{74,80},{74,63},{69,63}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sumHeatLoads.y,totalHeatLoad)
                                    annotation (Line(
      points={{63,-62},{98,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(heatLoads.y,roomHeatLoads)  annotation (Line(
      points={{63,-82},{98,-82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(constWind.y, wholeHouseBuildingEnvelope.WindSpeedPort) annotation (
      Line(points={{-49,46},{-38,46},{-38,32.56},{-12.32,32.56}}, color={0,0,
          127}));
  connect(prescribedAmbTemperature.port, wholeHouseBuildingEnvelope.thermOutside)
    annotation (Line(points={{-28,64},{-11.2,64},{-11.2,43.2}}, color={191,0,0}));
  connect(groundTemp.port, wholeHouseBuildingEnvelope.groundTemp)
    annotation (Line(points={{-42,-90},{14,-90},{14,1.2}}, color={191,0,0}));
  connect(varRad.solarRad_out[1], wholeHouseBuildingEnvelope.North) annotation (
     Line(points={{51,69.1667},{48,69.1667},{48,23.04},{39.2,23.04}}, color={
          255,128,0}));
  connect(varRad.solarRad_out[2], wholeHouseBuildingEnvelope.East) annotation (
      Line(points={{51,69.5},{48,69.5},{48,12.96},{39.2,12.96}}, color={255,128,
          0}));
  connect(varRad.solarRad_out[3], wholeHouseBuildingEnvelope.South) annotation (
     Line(points={{51,69.8333},{48,69.8333},{48,2.32},{39.2,2.32}}, color={255,
          128,0}));
  connect(varRad.solarRad_out[4], wholeHouseBuildingEnvelope.West) annotation (
      Line(points={{51,70.1667},{48,70.1667},{48,-7.2},{39.2,-7.2}}, color={255,
          128,0}));
  connect(varRad.solarRad_out[5], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofN)
    annotation (Line(points={{51,70.5},{48,70.5},{48,43.2},{39.2,43.2}}, color=
          {255,128,0}));
  connect(varRad.solarRad_out[6], wholeHouseBuildingEnvelope.SolarRadiationPort_RoofS)
    annotation (Line(points={{51,70.8333},{48,70.8333},{48,34.24},{39.2,34.24}},
        color={255,128,0}));
  connect(heatStarToComb.portConvRadComb, wholeHouseBuildingEnvelope.heatingToRooms) annotation (Line(points={{-14.6,-16.1},{-6,-16.1},{-6,-8},{-11.2,-8},{-11.2,7.92}}, color={191,0,0}));
  connect(constAirEx.y, wholeHouseBuildingEnvelope.AirExchangePort) annotation (
     Line(points={{-49,16},{-44,16},{-44,20.8},{-12.32,20.8}}, color={0,0,127}));
  connect(prescribedHeatFlowRad.port, heatStarToComb.portRad) annotation (Line(points={{-48,-18},{-44,-18},{-44,-10.2},{-34.4,-10.2}}, color={191,0,0}));
  connect(adiabaticRadRooms.y, prescribedHeatFlowRad.Q_flow)
    annotation (Line(points={{-73.2,-18},{-60,-18}}, color={0,0,127}));
  annotation (Diagram(graphics={
        Text(
          extent={{-112,-40},{-74,-62}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 4"),
        Text(
          extent={{-112,26},{-74,4}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 8"),
        Text(
          extent={{-94,-80},{-56,-102}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 1 \\theta'_m,e and see
Calculation example: Chapter 6.1.3.4"),
        Text(
          extent={{-112,90},{-74,68}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 1")}), experiment(StopTime=25920000, Interval=3600),
    Documentation(revisions="<html><ul>
  <li>
    <i>August 1, 2017</i> by Philipp Mehrfeld:<br/>
    Implement example
  </li>
</ul>
</html>"));
end OFDHeatLoad;
