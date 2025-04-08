within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_T_SUP_Control "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  parameter Modelica.Units.SI.Temperature dT_SUP_Heat_Max = 5
    "max temperature difference of T_SUP for further heating power";
  parameter Modelica.Units.SI.Temperature dT_SUP_Cool_Max = 5
    "max temperature difference of T_SUP for further cooling power";

  Boolean HeatingCooling;
  Boolean OnOff;

  Modelica.Blocks.Interfaces.RealOutput TsetAHU_Out(unit="K", start = 293.15) annotation (Placement(
        transformation(extent={{-100,-20},{-140,20}}), iconTransformation(
          extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput TsetAHU_In(unit="K", start = 293.15) annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,-70}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-80})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool(
    k=0.25*dT_SUP_Cool_Max,
    yMax=dT_SUP_Cool_Max,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=5*60,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Math.Gain gainCool(k=-1)
    annotation (Placement(transformation(extent={{12,-56},{0,-44}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat(
    k=0.25*dT_SUP_Heat_Max,
    yMax=dT_SUP_Heat_Max,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=5*60,
    Td=0.1) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Gain gainHeat(k=1)
    annotation (Placement(transformation(extent={{12,44},{0,56}})));
  Modelica.Blocks.Logical.Switch switchCool
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-30})));
  Modelica.Blocks.Logical.Switch switchHeat annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-20,30})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones] annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={-30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones] annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={40,-120})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-52,-56},{-40,-44}})));
  Modelica.Blocks.Math.Add dTZoneHeat[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{72,48},{60,60}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-52,44},{-40,56}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Switch switchOff
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-50,-26},{-38,-14}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(uLow=-0.5, uHigh=0.25)
    annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating(uLow=-0.5, uHigh=0.25)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff(y=OnOff)
    annotation (Placement(transformation(extent={{-8,-6},{-20,6}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeatingCooling(y=
        HeatingCooling)
    annotation (Placement(transformation(extent={{46,-6},{34,6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Math.MinMax minMaxHeat(nu=numZones)
    annotation (Placement(transformation(extent={{72,26},{58,40}})));
  Modelica.Blocks.Math.MinMax minMax(nu=numZones)
    annotation (Placement(transformation(extent={{68,-40},{56,-28}})));
  Modelica.Blocks.Interfaces.RealInput TOda(unit="K", start=293.15) annotation (
     Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,90}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,80})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant
    annotation (Placement(transformation(extent={{-42,-88},{-22,-68}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant1
    annotation (Placement(transformation(extent={{-62,68},{-42,88}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{8,76},{0,84}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{8,-84},{0,-76}})));
equation

  if TOda < 283.15 then
    HeatingCooling = true;
  else
    HeatingCooling = false;
  end if;

  if hysteresisHeating.y and hysteresisCooling.y then
    OnOff = false;
  else
    OnOff = true;
  end if;

  connect(PI_AHU_Cool.y,gainCool.u)
    annotation (Line(points={{19,-50},{13.2,-50}},color={0,0,127}));
  connect(gainCool.y,switchCool.u1)
    annotation (Line(points={{-0.6,-50},{-12,-50},{-12,-42}},
                                                    color={0,0,127}));
  connect(gainHeat.y,switchHeat.u1)
    annotation (Line(points={{-0.6,50},{-12,50},{-12,42}},
                                                  color={0,0,127}));
  connect(PI_AHU_Heat.y,gainHeat.u)
    annotation (Line(points={{19,50},{13.2,50}},color={0,0,127}));
  connect(TsetAHU_In, add.u2) annotation (Line(points={{-120,-70},{-60,-70},{-60,
          -6},{-68,-6}}, color={0,0,127}));
  connect(add.y, TsetAHU_Out)
    annotation (Line(points={{-91,0},{-120,0}}, color={0,0,127}));
  connect(const.y, switchCool.u3) annotation (Line(points={{-39.4,-50},{-28,-50},
          {-28,-42}},    color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(TZone.T, dTZoneHeat.u2) annotation (Line(points={{59,0},{50,0},{50,22},
          {110,22},{110,44},{102,44}},                 color={0,0,127}));
  connect(TSetHeat, dTZoneHeat.u1) annotation (Line(points={{30,-120},{30,-98},
          {116,-98},{116,56},{102,56}},                  color={0,0,127}));
  connect(const1.y, PI_AHU_Heat.u_s) annotation (Line(points={{59.4,54},{52,54},
          {52,50},{42,50}}, color={0,0,127}));
  connect(const2.y, switchHeat.u3)
    annotation (Line(points={{-39.4,50},{-28,50},{-28,42}}, color={0,0,127}));
  connect(switchHeat.y, switchHeatingCooling.u1) annotation (Line(points={{-20,19},
          {-20,16},{30,16},{30,8},{22,8}}, color={0,0,127}));
  connect(switchCool.y, switchHeatingCooling.u3) annotation (Line(points={{-20,-19},
          {-20,-16},{30,-16},{30,-8},{22,-8}}, color={0,0,127}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(switchHeatingCooling.y, switchOff.u1)
    annotation (Line(points={{-1,0},{-4,0},{-4,8},{-28,8}}, color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-37.4,-20},{-34,-20},{-34,-14},{-20,-14},{-20,-8},
          {-28,-8}},                               color={0,0,127}));
  connect(switchOff.y, add.u1) annotation (Line(points={{-51,0},{-60,0},{-60,6},
          {-68,6}}, color={0,0,127}));
  connect(booleanExpressionOnOff.y, switchOff.u2)
    annotation (Line(points={{-20.6,0},{-28,0}}, color={255,0,255}));
  connect(booleanExpressionHeatingCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{33.4,0},{22,0}}, color={255,0,255}));
  connect(dTZoneHeat.y, minMaxHeat.u) annotation (Line(points={{79,50},{74,50},
          {74,44},{76,44},{76,33},{72,33}}, color={0,0,127}));
  connect(dTZoneCool.y, minMax.u) annotation (Line(points={{79,-50},{78,-50},{78,
          -34},{68,-34}}, color={0,0,127}));
  connect(PI_AHU_Heat.u_m, minMaxHeat.yMin)
    annotation (Line(points={{30,38},{30,28.8},{57.3,28.8}}, color={0,0,127}));
  connect(hysteresisHeating.u, minMaxHeat.yMin) annotation (Line(points={{42,80},
          {48,80},{48,28.8},{57.3,28.8}}, color={0,0,127}));
  connect(minMax.yMin, PI_AHU_Cool.u_m) annotation (Line(points={{55.4,-37.6},{36,
          -37.6},{36,-32},{30,-32},{30,-38}}, color={0,0,127}));
  connect(minMax.yMin, hysteresisCooling.u) annotation (Line(points={{55.4,-37.6},
          {48,-37.6},{48,-80},{42,-80}}, color={0,0,127}));
  connect(hysteresisHeating.y, not1.u)
    annotation (Line(points={{19,80},{8.8,80}}, color={255,0,255}));
  connect(not1.y, switchHeat.u2)
    annotation (Line(points={{-0.4,80},{-20,80},{-20,42}}, color={255,0,255}));
  connect(hysteresisCooling.y, not2.u)
    annotation (Line(points={{19,-80},{8.8,-80}}, color={255,0,255}));
  connect(not2.y, switchCool.u2) annotation (Line(points={{-0.4,-80},{-14,-80},{
          -14,-48},{-20,-48},{-20,-42}}, color={255,0,255}));
  connect(TZone.T, dTZoneCool.u1) annotation (Line(points={{59,0},{50,0},{50,
          -22},{110,-22},{110,-44},{102,-44}}, color={0,0,127}));
  connect(TSetCool, dTZoneCool.u2) annotation (Line(points={{-30,-120},{-30,-96},
          {110,-96},{110,-56},{102,-56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Dynamic_T_SUP_Control;
