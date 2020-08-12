within AixLib.Systems.EONERC_MainBuilding.Controller;
model HeatPumpSystemDataInput
  "Intput from table connected with heatPUmpSystemBus"
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=dataHPSystem.October2015,
                                                                     smoothness=
       Modelica.Blocks.Types.Smoothness.ConstantSegments)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  BaseClasses.HeatPumpSystemBus heatPumpSystemBus1 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}),
                                                  iconTransformation(extent={{78,-22},
            {122,24}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{0,86},{14,100}})));
  Modelica.Blocks.Sources.Constant rpmPumpCold(k=rpmC)
    annotation (Placement(transformation(extent={{0,66},{14,80}})));
  parameter Real rpmC=1750 "RPM for pump on cold side";
  Modelica.Blocks.Sources.Constant rpmPumpHot(k=rpmH)
    annotation (Placement(transformation(extent={{0,48},{14,62}})));
  parameter Real rpmH=2820 "RPM for pump hot side";
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1
    annotation (Placement(transformation(extent={{0,26},{14,40}})));
  Modelica.Blocks.Sources.Constant const(k=51)
    annotation (Placement(transformation(extent={{-16,6},{-8,14}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{0,8},{12,20}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{20,-6},{32,6}})));
  Modelica.Blocks.Interfaces.RealOutput Toutside
    "Connector of Real output signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-80,-110})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_cold_side
    "Connector of Real output signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-60,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealOutput m_flow_hot_side
    "Connector of Real output signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-40,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-110})));
  Modelica.Blocks.Math.Gain gain1(k=1/100)
    annotation (Placement(transformation(extent={{-2,-24},{4,-18}})));
  Modelica.Blocks.Interfaces.RealOutput T_in_cold_side
    "Connector of Real output signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-20,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-110})));
  Modelica.Blocks.Interfaces.RealOutput T_in_hot_side
    "Connector of Real output signals" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={80,-110})));
  Modelica.Blocks.Math.Gain gain2(k=1/100)
    annotation (Placement(transformation(extent={{-2,-36},{4,-30}})));
  Modelica.Blocks.Math.Gain gain3(k=1/100)
    annotation (Placement(transformation(extent={{-2,-46},{4,-40}})));
  Modelica.Blocks.Math.Gain gain4(k=1/100)
    annotation (Placement(transformation(extent={{-2,-56},{4,-50}})));
  Modelica.Blocks.Sources.Constant ice(k=1)
    annotation (Placement(transformation(extent={{60,-14},{74,0}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold2
    annotation (Placement(transformation(extent={{20,-74},{34,-60}})));
  Validation.DataHPSystem dataHPSystem
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
equation
  connect(combiTimeTable.y[4], greaterThreshold.u) annotation (Line(points={{-79,0},
          {-74,0},{-74,93},{-1.4,93}},     color={0,0,127}));
  connect(greaterThreshold.y, heatPumpSystemBus1.busPumpCold.pumpBus.onSet)
    annotation (Line(points={{14.7,93},{80,93},{80,92},{100.05,92},{100.05,0.05}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumpCold.y, heatPumpSystemBus1.busPumpCold.pumpBus.rpmSet)
    annotation (Line(points={{14.7,73},{100.05,73},{100.05,0.05}},  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(rpmPumpHot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpmSet)
    annotation (Line(points={{14.7,55},{100.05,55},{100.05,0.05}},  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[8], greaterThreshold1.u) annotation (Line(points={{-79,0},
          {-74,0},{-74,34},{-1.4,34},{-1.4,33}},      color={0,0,127}));
  connect(greaterThreshold1.y, heatPumpSystemBus1.busPumpHot.pumpBus.onSet)
    annotation (Line(points={{14.7,33},{100.05,33},{100.05,0.05}},  color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.u2, const.y) annotation (Line(points={{-1.2,10.4},{-6,10.4},{
          -6,10},{-7.6,10}},    color={0,0,127}));
  connect(combiTimeTable.y[9], division.u1) annotation (Line(points={{-79,0},{-74,
          0},{-74,17.6},{-1.2,17.6}},  color={0,0,127}));
  connect(booleanConstant.y, heatPumpSystemBus1.busHP.mode) annotation (Line(
        points={{32.6,0},{46.35,0},{46.35,0.05},{100.05,0.05}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(combiTimeTable.y[27], m_flow_cold_side) annotation (Line(points={{-79,
          0},{-74,0},{-74,-60},{-60,-60},{-60,-100}}, color={0,0,127}));
  connect(m_flow_hot_side, combiTimeTable.y[17]) annotation (Line(points={{-40,-100},
          {-40,-60},{-74,-60},{-74,0},{-79,0}}, color={0,0,127}));
  connect(T_in_cold_side, combiTimeTable.y[25]) annotation (Line(points={{-20,-100},
          {-20,-60},{-74,-60},{-74,0},{-79,0}}, color={0,0,127}));
  connect(T_in_hot_side, combiTimeTable.y[15]) annotation (Line(points={{0,-100},
          {0,-60},{-74,-60},{-74,0},{-79,0}}, color={0,0,127}));
  connect(gain1.u, combiTimeTable.y[11]) annotation (Line(points={{-2.6,-21},{-74,
          -21},{-74,0},{-79,0}}, color={0,0,127}));
  connect(gain1.y, heatPumpSystemBus1.busThrottleHS.valveSet) annotation (Line(
        points={{4.3,-21},{100.05,-21},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain2.u, combiTimeTable.y[12]) annotation (Line(points={{-2.6,-33},{-74,
          -33},{-74,0},{-79,0}}, color={0,0,127}));
  connect(gain2.y, heatPumpSystemBus1.busThrottleCS.valveSet) annotation (Line(
        points={{4.3,-33},{100.05,-33},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain3.u, combiTimeTable.y[32]) annotation (Line(points={{-2.6,-43},{-74,
          -43},{-74,0},{-79,0}}, color={0,0,127}));
  connect(gain3.y, heatPumpSystemBus1.busThrottleFreecool.valveSet) annotation (
     Line(points={{4.3,-43},{100.05,-43},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain4.u, combiTimeTable.y[33]) annotation (Line(points={{-2.6,-53},{-74,
          -53},{-74,0},{-79,0}}, color={0,0,127}));
  connect(gain4.y, heatPumpSystemBus1.busThrottleRecool.valveSet) annotation (
      Line(points={{4.3,-53},{100.05,-53},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Toutside, combiTimeTable.y[14])
    annotation (Line(points={{-80,-100},{-80,0},{-79,0}}, color={0,0,127}));
  connect(ice.y, heatPumpSystemBus1.busHP.iceFac) annotation (Line(points={{74.7,
          -7},{86.35,-7},{86.35,0.05},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain4.u, greaterThreshold2.u) annotation (Line(points={{-2.6,-53},{-4.3,
          -53},{-4.3,-67},{18.6,-67}}, color={0,0,127}));
  connect(greaterThreshold2.y, heatPumpSystemBus1.AirCoolerOnSet) annotation (Line(
        points={{34.7,-67},{100.05,-67},{100.05,0.05}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(division.y, heatPumpSystemBus1.busHP.n) annotation (Line(points={{
          12.6,14},{100.05,14},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-100,100},{98,2},{-100,-100}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HeatPumpSystemDataInput;
