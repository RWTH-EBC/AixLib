within AixLib.Building.HighOrder.Examples;
model OFDHeatLoad "Test environment to determine OFD's nominal heat load"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Constant constRooms[10](k={293.15,293.15,293.15,
        293.15,293.15,293.15,293.15,297.15,293.15,293.15})
    annotation (Placement(transformation(extent={{-70,-62},{-50,-42}})));
  Modelica.Blocks.Sources.Constant constAirEx[13](k={0.5,0.5,0.0,0.0,1.0,0.5,
        0.5,0.5,0.5,0.5,0.5,0.5,0.0})
    annotation (Placement(transformation(extent={{-70,6},{-50,26}})));
  Modelica.Blocks.Sources.Constant constWind(k=0)
    annotation (Placement(transformation(extent={{-70,36},{-50,56}})));
  Modelica.Blocks.Sources.Constant constAmb(k=271.15)
    annotation (Placement(transformation(extent={{-70,70},{-50,90}})));
  Modelica.Blocks.Sources.Constant innGains[13](k=fill(0, 13))
    annotation (Placement(transformation(extent={{-70,-26},{-50,-6}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature groundTemp(T=281.65)
    annotation (Placement(transformation(extent={{-54,-96},{-42,-84}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature[10]
    annotation (Placement(transformation(extent={{-36,-58},{-24,-46}})));
  Utilities.Interfaces.Adaptors.HeatStarToComb        heatStarToComb[10]
    annotation (Placement(transformation(
        extent={{10,-8},{-10,8}},
        rotation=0,
        origin={-24,-16})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature1
    annotation (Placement(transformation(extent={{-40,58},{-28,70}})));
  Utilities.Sources.PrescribedSolarRad        varRad(n=8)
    annotation (Placement(transformation(extent={{70,60},{50,80}})));
  Modelica.Blocks.Sources.Constant constSun[8](k=fill(0, 8))
    annotation (Placement(transformation(extent={{100,70},{80,90}})));
  Modelica.Blocks.Sources.RealExpression sumHeatLoads(y=-sum(
        prescribedTemperature[:].port.Q_flow))
    annotation (Placement(transformation(extent={{42,-72},{62,-52}})));
  Modelica.Blocks.Sources.RealExpression HeatLoads[(size(prescribedTemperature))[
     1]](y=-(prescribedTemperature[:].port.Q_flow))
    annotation (Placement(transformation(extent={{42,-92},{62,-72}})));
  Modelica.Blocks.Interfaces.RealOutput TotalheatLoad "Value of Real output"
    annotation (Placement(transformation(extent={{88,-72},{108,-52}})));
  Modelica.Blocks.Interfaces.RealOutput RoomHeatLoads[(size(
    prescribedTemperature))[1]] "Value of Real output"
    annotation (Placement(transformation(extent={{88,-92},{108,-72}})));
equation
  connect(constRooms.y,prescribedTemperature. T) annotation (Line(
      points={{-49,-52},{-37.2,-52}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedTemperature.port,heatStarToComb. star) annotation (Line(
      points={{-24,-52},{-18,-52},{-18,-32},{-40,-32},{-40,-10.2},{-34.4,-10.2}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(prescribedTemperature.port,heatStarToComb. therm) annotation (Line(
      points={{-24,-52},{-16,-52},{-16,-30},{-38,-30},{-38,-21.1},{-34.1,-21.1}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(constAmb.y,prescribedTemperature1. T) annotation (Line(
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
  connect(sumHeatLoads.y,TotalheatLoad)
                                    annotation (Line(
      points={{63,-62},{98,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(HeatLoads.y,RoomHeatLoads)  annotation (Line(
      points={{63,-82},{98,-82}},
      color={0,0,127},
      smooth=Smooth.None));
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
Calculation example: Chapter 6.1.3.4"),
        Text(
          extent={{-112,90},{-74,68}},
          lineColor={28,108,200},
          textString="DIN EN 12831 Beiblatt 1
Table 1")}));
end OFDHeatLoad;
