within AixLib.Systems.EONERC_MainBuilding.Controller;
model HeatPumpSystemSimpleControl "Simple Control of the heat pump"

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
  Modelica.Blocks.Sources.Constant one(k=1)
    annotation (Placement(transformation(extent={{-80,80},{-66,94}})));
  Modelica.Blocks.Sources.Constant valveOpening(k=100)
    annotation (Placement(transformation(extent={{-56,-30},{-42,-16}})));
  Modelica.Blocks.Sources.Constant valveOpeningClosed(k=0)
    annotation (Placement(transformation(extent={{-56,-54},{-42,-40}})));
  Modelica.Blocks.Sources.Constant T_outside(k=20)
    annotation (Placement(transformation(extent={{-116,-100},{-102,-86}})));
  Modelica.Blocks.Sources.Constant TcoldIn(k=17)
    annotation (Placement(transformation(extent={{-98,-80},{-84,-66}})));
  Modelica.Blocks.Sources.Constant const1(k=30)
    annotation (Placement(transformation(extent={{40,-100},{54,-86}})));
  Modelica.Blocks.Sources.Constant const2(k=5)
    annotation (Placement(transformation(extent={{-80,-130},{-66,-116}})));
  Modelica.Blocks.Sources.Constant THPHotSet(k=273.15 + 12)
    annotation (Placement(transformation(extent={{-100,20},{-86,34}})));
  Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=273.15 + 7, uHigh=273.15
         + 11) annotation (Placement(transformation(extent={{-48,6},{-38,16}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-22,4},{-2,24}})));
  Controls.Continuous.LimPID PID(
    final yMax=1,
    final yMin=0,
    final controllerType=Modelica.Blocks.Types.SimpleController.PI,
    final k=0.1,
    final Ti=60,
    final Td=0,
    initType=Modelica.Blocks.Types.InitPID.NoInit,
    reverseActing=not (true))
    annotation (Placement(transformation(extent={{-76,20},{-56,40}})));
equation
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
  connect(greaterThreshold1.y, heatPumpSystemBus1.busPumpHot.pumpBus.onSet)
    annotation (Line(points={{14.7,33},{100.05,33},{100.05,0.05}},  color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanConstant.y, heatPumpSystemBus1.busHP.modeSet) annotation (Line(
        points={{32.6,0},{46.35,0},{46.35,0.05},{100.05,0.05}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain1.y, heatPumpSystemBus1.busThrottleHS.valveSet) annotation (Line(
        points={{4.3,-21},{100.05,-21},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain2.y, heatPumpSystemBus1.busThrottleCS.valveSet) annotation (Line(
        points={{4.3,-33},{100.05,-33},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain3.y, heatPumpSystemBus1.busThrottleFreecool.valveSet) annotation (
     Line(points={{4.3,-43},{100.05,-43},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(gain4.y, heatPumpSystemBus1.busThrottleRecool.valveSet) annotation (
      Line(points={{4.3,-53},{100.05,-53},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ice.y, heatPumpSystemBus1.busHP.iceFacMea) annotation (Line(points={{
          74.7,-7},{86.35,-7},{86.35,0.05},{100.05,0.05}}, color={0,0,127}),
      Text(
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
  connect(one.y, greaterThreshold.u) annotation (Line(points={{-65.3,87},{-32.65,
          87},{-32.65,93},{-1.4,93}}, color={0,0,127}));
  connect(one.y, greaterThreshold1.u) annotation (Line(points={{-65.3,87},{-33.65,
          87},{-33.65,33},{-1.4,33}}, color={0,0,127}));
  connect(valveOpening.y, gain1.u) annotation (Line(points={{-41.3,-23},{-2.6,
          -23},{-2.6,-21}}, color={0,0,127}));
  connect(valveOpening.y, gain2.u) annotation (Line(points={{-41.3,-23},{-32,
          -23},{-32,-33},{-2.6,-33}}, color={0,0,127}));
  connect(valveOpeningClosed.y, gain3.u) annotation (Line(points={{-41.3,-47},
          {-19.65,-47},{-19.65,-43},{-2.6,-43}}, color={0,0,127}));
  connect(valveOpeningClosed.y, gain4.u) annotation (Line(points={{-41.3,-47},
          {-19.65,-47},{-19.65,-53},{-2.6,-53}}, color={0,0,127}));
  connect(Toutside, T_outside.y) annotation (Line(points={{-80,-100},{-90,-100},
          {-90,-93},{-101.3,-93}}, color={0,0,127}));
  connect(TcoldIn.y, T_in_cold_side) annotation (Line(points={{-83.3,-73},{
          -19.65,-73},{-19.65,-100},{-20,-100}}, color={0,0,127}));
  connect(const1.y, T_in_hot_side) annotation (Line(points={{54.7,-93},{27.35,
          -93},{27.35,-100},{0,-100}}, color={0,0,127}));
  connect(const2.y, m_flow_cold_side) annotation (Line(points={{-65.3,-123},{
          -65.3,-107.5},{-60,-107.5},{-60,-100}}, color={0,0,127}));
  connect(const2.y, m_flow_hot_side) annotation (Line(points={{-65.3,-123},{-40,
          -123},{-40,-100}}, color={0,0,127}));
  connect(hysteresis.y, switch1.u2) annotation (Line(points={{-37.5,11},{-26,11},
          {-26,14},{-24,14}}, color={255,0,255}));
  connect(hysteresis.u, heatPumpSystemBus1.TBottomCSMea) annotation (Line(points={{-49,11},
          {-49,18},{100.05,18},{100.05,0.05}},          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switch1.y, heatPumpSystemBus1.busHP.N) annotation (Line(points={{-1,
          14},{100.05,14},{100.05,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valveOpeningClosed.y, switch1.u3)
    annotation (Line(points={{-41.3,-47},{-24,-47},{-24,6}}, color={0,0,127}));
  connect(THPHotSet.y, PID.u_s) annotation (Line(points={{-85.3,27},{-82.65,27},
          {-82.65,30},{-78,30}}, color={0,0,127}));
  connect(PID.y, switch1.u1) annotation (Line(points={{-55,30},{-40,30},{-40,22},
          {-24,22}}, color={0,0,127}));
  connect(PID.u_m, heatPumpSystemBus1.busHP.TConOutMea) annotation (Line(points
        ={{-66,18},{-66,-18},{100.05,-18},{100.05,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
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
end HeatPumpSystemSimpleControl;
