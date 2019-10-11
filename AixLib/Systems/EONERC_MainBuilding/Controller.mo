within AixLib.Systems.EONERC_MainBuilding;
package Controller "Controller for subsystems"
  extends Modelica.Icons.VariantsPackage;
  model HeatPumpSystemDataInput
    "Intput from table connected with heatPUmpSystemBus"
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(table=table, smoothness=
         Modelica.Blocks.Types.Smoothness.ConstantSegments)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
    parameter Real table[:,:]
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
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
  equation
    connect(combiTimeTable.y[4], greaterThreshold.u) annotation (Line(points={{-79,0},
            {-74,0},{-74,93},{-1.4,93}},     color={0,0,127}));
    connect(greaterThreshold.y, heatPumpSystemBus1.busPumpCold.pumpBus.onOff_Input)
      annotation (Line(points={{14.7,93},{80,93},{80,92},{100.05,92},{100.05,0.05}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(rpmPumpCold.y, heatPumpSystemBus1.busPumpCold.pumpBus.rpm_Input)
      annotation (Line(points={{14.7,73},{100.05,73},{100.05,0.05}},  color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(rpmPumpHot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpm_Input)
      annotation (Line(points={{14.7,55},{100.05,55},{100.05,0.05}},  color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(combiTimeTable.y[8], greaterThreshold1.u) annotation (Line(points={{-79,0},
            {-74,0},{-74,34},{-1.4,34},{-1.4,33}},      color={0,0,127}));
    connect(greaterThreshold1.y, heatPumpSystemBus1.busPumpHot.pumpBus.onOff_Input)
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
    connect(division.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{12.6,14},
            {100.05,14},{100.05,0.05}},     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
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
    connect(gain1.y, heatPumpSystemBus1.busThrottleHS.valSet) annotation (Line(
          points={{4.3,-21},{100.05,-21},{100.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain2.u, combiTimeTable.y[12]) annotation (Line(points={{-2.6,-33},{-74,
            -33},{-74,0},{-79,0}}, color={0,0,127}));
    connect(gain2.y, heatPumpSystemBus1.busThrottleCS.valSet) annotation (Line(
          points={{4.3,-33},{100.05,-33},{100.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain3.u, combiTimeTable.y[32]) annotation (Line(points={{-2.6,-43},{-74,
            -43},{-74,0},{-79,0}}, color={0,0,127}));
    connect(gain3.y, heatPumpSystemBus1.busThrottleFreecool.valSet) annotation (
        Line(points={{4.3,-43},{100.05,-43},{100.05,0.05}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain4.u, combiTimeTable.y[33]) annotation (Line(points={{-2.6,-53},{-74,
            -53},{-74,0},{-79,0}}, color={0,0,127}));
    connect(gain4.y, heatPumpSystemBus1.busThrottleRecool.valSet) annotation (
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
    connect(greaterThreshold2.y, heatPumpSystemBus1.AirCoolerOn) annotation (Line(
          points={{34.7,-67},{100.05,-67},{100.05,0.05}}, color={255,0,255}),
        Text(
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

  model HeatPumpSystemConstantControl
    "Constant intput connected with heatPUmpSystemBus"
    parameter Real table[:,:]
      "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
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
    Modelica.Blocks.Sources.Constant rpmPumpCold1(k=1)
      annotation (Placement(transformation(extent={{-80,80},{-66,94}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold2(k=20)
      annotation (Placement(transformation(extent={{-80,18},{-66,32}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold3(k=100)
      annotation (Placement(transformation(extent={{-56,-30},{-42,-16}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold4(k=0)
      annotation (Placement(transformation(extent={{-56,-54},{-42,-40}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold5(k=20)
      annotation (Placement(transformation(extent={{-116,-100},{-102,-86}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold6(k=17)
      annotation (Placement(transformation(extent={{-98,-80},{-84,-66}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold7(k=30)
      annotation (Placement(transformation(extent={{42,-128},{56,-114}})));
    Modelica.Blocks.Sources.Constant rpmPumpCold8(k=5)
      annotation (Placement(transformation(extent={{-80,-130},{-66,-116}})));
  equation
    connect(greaterThreshold.y, heatPumpSystemBus1.busPumpCold.pumpBus.onOff_Input)
      annotation (Line(points={{14.7,93},{80,93},{80,92},{100.05,92},{100.05,0.05}},
          color={255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(rpmPumpCold.y, heatPumpSystemBus1.busPumpCold.pumpBus.rpm_Input)
      annotation (Line(points={{14.7,73},{100.05,73},{100.05,0.05}},  color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(rpmPumpHot.y, heatPumpSystemBus1.busPumpHot.pumpBus.rpm_Input)
      annotation (Line(points={{14.7,55},{100.05,55},{100.05,0.05}},  color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(greaterThreshold1.y, heatPumpSystemBus1.busPumpHot.pumpBus.onOff_Input)
      annotation (Line(points={{14.7,33},{100.05,33},{100.05,0.05}},  color={255,0,
            255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(division.u2, const.y) annotation (Line(points={{-1.2,10.4},{-6,10.4},{
            -6,10},{-7.6,10}},    color={0,0,127}));
    connect(division.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{12.6,14},
            {100.05,14},{100.05,0.05}},     color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(booleanConstant.y, heatPumpSystemBus1.busHP.mode) annotation (Line(
          points={{32.6,0},{46.35,0},{46.35,0.05},{100.05,0.05}}, color={255,0,255}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain1.y, heatPumpSystemBus1.busThrottleHS.valSet) annotation (Line(
          points={{4.3,-21},{100.05,-21},{100.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain2.y, heatPumpSystemBus1.busThrottleCS.valSet) annotation (Line(
          points={{4.3,-33},{100.05,-33},{100.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain3.y, heatPumpSystemBus1.busThrottleFreecool.valSet) annotation (
        Line(points={{4.3,-43},{100.05,-43},{100.05,0.05}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain4.y, heatPumpSystemBus1.busThrottleRecool.valSet) annotation (
        Line(points={{4.3,-53},{100.05,-53},{100.05,0.05}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ice.y, heatPumpSystemBus1.busHP.iceFac) annotation (Line(points={{74.7,
            -7},{86.35,-7},{86.35,0.05},{100.05,0.05}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(gain4.u, greaterThreshold2.u) annotation (Line(points={{-2.6,-53},{-4.3,
            -53},{-4.3,-67},{18.6,-67}}, color={0,0,127}));
    connect(greaterThreshold2.y, heatPumpSystemBus1.AirCoolerOn) annotation (Line(
          points={{34.7,-67},{100.05,-67},{100.05,0.05}}, color={255,0,255}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(rpmPumpCold1.y, greaterThreshold.u) annotation (Line(points={{-65.3,
            87},{-32.65,87},{-32.65,93},{-1.4,93}}, color={0,0,127}));
    connect(rpmPumpCold1.y, greaterThreshold1.u) annotation (Line(points={{-65.3,
            87},{-33.65,87},{-33.65,33},{-1.4,33}}, color={0,0,127}));
    connect(rpmPumpCold2.y, division.u1) annotation (Line(points={{-65.3,25},{
            -34.65,25},{-34.65,17.6},{-1.2,17.6}}, color={0,0,127}));
    connect(rpmPumpCold3.y, gain1.u) annotation (Line(points={{-41.3,-23},{-2.6,
            -23},{-2.6,-21}}, color={0,0,127}));
    connect(rpmPumpCold3.y, gain2.u) annotation (Line(points={{-41.3,-23},{-32,
            -23},{-32,-33},{-2.6,-33}}, color={0,0,127}));
    connect(rpmPumpCold4.y, gain3.u) annotation (Line(points={{-41.3,-47},{-19.65,
            -47},{-19.65,-43},{-2.6,-43}}, color={0,0,127}));
    connect(rpmPumpCold4.y, gain4.u) annotation (Line(points={{-41.3,-47},{-19.65,
            -47},{-19.65,-53},{-2.6,-53}}, color={0,0,127}));
    connect(Toutside, rpmPumpCold5.y) annotation (Line(points={{-80,-100},{-90,
            -100},{-90,-93},{-101.3,-93}}, color={0,0,127}));
    connect(rpmPumpCold6.y, T_in_cold_side) annotation (Line(points={{-83.3,-73},
            {-51.65,-73},{-51.65,-100},{-20,-100}}, color={0,0,127}));
    connect(rpmPumpCold7.y, T_in_hot_side) annotation (Line(points={{56.7,-121},{
            27.35,-121},{27.35,-100},{0,-100}}, color={0,0,127}));
    connect(rpmPumpCold8.y, m_flow_cold_side) annotation (Line(points={{-65.3,
            -123},{-65.3,-107.5},{-60,-107.5},{-60,-100}}, color={0,0,127}));
    connect(rpmPumpCold8.y, m_flow_hot_side) annotation (Line(points={{-65.3,-123},
            {-40,-123},{-40,-100}}, color={0,0,127}));
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
  end HeatPumpSystemConstantControl;

  model CtrSWU "Mode based controller for switching unit"

    parameter Real rpm_pump(min=0, unit="1") = 2000 "Rpm of the Pump";
    BaseClasses.SWUBus sWUBus annotation (Placement(transformation(extent={{80,-18},
              {120,18}}), iconTransformation(extent={{78,-16},{110,16}})));
    Modelica.Blocks.Interfaces.IntegerInput mode "Modes 1 to 5"
                                                 annotation (Placement(
          transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
            extent={{-120,-20},{-80,20}})));
    Real K1 "Opening for flap K1";
    Real K2 "Opening for flap K2";
    Real K3 "Opening for flap K3";
    Real K4 "Opening for flap K4";
    Real Y2 "Opening for valve Y1";
    Real Y3 "Opening for valve Y2";
    Boolean pumpOn "Pump on signal";

    Modelica.Blocks.Sources.RealExpression realExpression1(y=K1)
      annotation (Placement(transformation(extent={{-20,34},{0,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=K2)
      annotation (Placement(transformation(extent={{-20,14},{0,34}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=K3)
      annotation (Placement(transformation(extent={{-20,-6},{0,14}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=K4)
      annotation (Placement(transformation(extent={{-20,-28},{0,-8}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=Y2)
      annotation (Placement(transformation(extent={{-20,-46},{0,-26}})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=Y3)
      annotation (Placement(transformation(extent={{-20,-66},{0,-46}})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=pumpOn)
      annotation (Placement(transformation(extent={{-20,54},{0,74}})));
    Modelica.Blocks.Sources.Constant const(k=rpm_pump)
      annotation (Placement(transformation(extent={{-20,80},{0,100}})));
  equation
    if mode == 1 then
      K1=0;
      K2=0;
      K3=1;
      K4=1;
      Y2=0;
      Y3=0;
      pumpOn=true;
    elseif mode == 2 then
      K1=1;
      K2=0;
      K3=1;
      K4=1;
      Y2=0;
      Y3=1;
      pumpOn=true;
    elseif mode == 3 then
      K1=0;
      K2=1;
      K3=0;
      K4=0;
      Y2=1;
      Y3=0;
      pumpOn=false;
    elseif mode == 4 then
      K1=1;
      K2=0;
      K3=0;
      K4=0;
      Y2=0;
      Y3=1;
      pumpOn=false;
    elseif mode == 5 then
      K1=1;
      K2=1;
      K3=0;
      K4=0;
      Y2=1;
      Y3=1;
      pumpOn=false;
    else
      K1=0;
      K2=0;
      K3=0;
      K4=0;
      Y2=0;
      Y3=0;
      pumpOn=false;
    end if;

    connect(realExpression1.y, sWUBus.K1valSet) annotation (Line(points={{1,44},{50,
            44},{50,0.09},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression2.y, sWUBus.K2valSet) annotation (Line(points={{1,24},{48,
            24},{48,0.09},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression3.y, sWUBus.K3valSet) annotation (Line(points={{1,4},{50,
            4},{50,0.09},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression4.y, sWUBus.K4valSet) annotation (Line(points={{1,-18},{
            100.1,-18},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression5.y, sWUBus.Y2valSet) annotation (Line(points={{1,-36},{
            100.1,-36},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression6.y, sWUBus.Y3valSet) annotation (Line(points={{1,-56},
            {100.1,-56},{100.1,0.09}},color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(booleanExpression.y, sWUBus.pumpBus.onOff_Input) annotation (Line(
          points={{1,64},{44,64},{44,60},{100.1,60},{100.1,0.09}}, color={255,0,255}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(const.y, sWUBus.pumpBus.rpm_Input) annotation (Line(points={{1,90},{100.1,
            90},{100.1,0.09}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
            extent={{-80,20},{66,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="HCMI"),
            Rectangle(
            extent={{-80,80},{80,-80}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),Line(
            points={{20,80},{80,0},{40,-80}},
            color={95,95,95},
            thickness=0.5),
            Text(
            extent={{-80,20},{66,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Control")}),                               Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end CtrSWU;

  block CtrHXSsystem
    "Controller for heat exchanger system of E.ON ERC main building"
    //Boolean choice;
    extends AixLib.Systems.HydraulicModules.Controller.CtrMix;
    parameter Real rpm_pump_htc(min=0, unit="1") = 2000 "Rpm of the pump on the high temperature side";


    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.01)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Math.BooleanToReal booleanToReal
      annotation (Placement(transformation(extent={{40,70},{60,90}})));
    HydraulicModules.BaseClasses.HydraulicBus hydraulicBusHTC
      "Hydraulic bus for HTC part of heat exchanger system" annotation (Placement(
          transformation(extent={{74,52},{128,108}}), iconTransformation(extent={{66,20},
              {120,72}})));
    Modelica.Blocks.Sources.Constant constRpmPump1(final k=rpm_pump_htc)
                                                                    annotation (Placement(transformation(extent={{0,80},{
              20,100}})));
  equation
    connect(PID.y, greaterThreshold.u)
      annotation (Line(points={{5,-50},{-2,-50},{-2,50}}, color={0,0,127}));
    connect(greaterThreshold.y, booleanToReal.u) annotation (Line(points={{21,50},
            {30,50},{30,80},{38,80}}, color={255,0,255}));
    connect(booleanToReal.y, hydraulicBusHTC.valSet) annotation (Line(points={{61,
            80},{82,80},{82,80.14},{101.135,80.14}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(greaterThreshold.y, hydraulicBusHTC.pumpBus.onOff_Input) annotation (
        Line(points={{21,50},{32,50},{32,52},{101.135,52},{101.135,80.14}}, color=
           {255,0,255}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(constRpmPump1.y, hydraulicBusHTC.pumpBus.rpm_Input) annotation (Line(
          points={{21,90},{79.5,90},{79.5,80.14},{101.135,80.14}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="HCMI"),
            Rectangle(
            extent={{-90,80},{70,-80}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid),Line(
            points={{10,80},{70,0},{30,-80}},
            color={95,95,95},
            thickness=0.5),
            Text(
            extent={{-90,20},{56,-20}},
            lineColor={95,95,95},
            lineThickness=0.5,
            fillColor={215,215,215},
            fillPattern=FillPattern.Solid,
            textString="Control")}),
                                  Diagram(coordinateSystem(preserveAspectRatio=
              false)),
      Documentation(revisions="<html>
<ul>
<li>January 22, 2019, by Alexander K&uuml;mpel:<br/>External T_set added.</li>
<li>October 25, 2017, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>",   info="<html>
<p>Simple controller for admix and injection circuit. The controlled variable is the outflow temperature T_fwrd_out.</p>
</html>"));
  end CtrHXSsystem;
end Controller;
