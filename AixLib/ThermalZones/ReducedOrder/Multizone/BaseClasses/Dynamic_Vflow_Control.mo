within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_Vflow_Control "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  parameter Real gain_Vflow_Heat_Max = 2
    "max temperature difference of T_SUP for further heating power";
  parameter Real gain_Vflow_Cool_Max = 2
    "max temperature difference of T_SUP for further cooling power";

  Boolean HeatingCooling[numZones];
  Boolean OnOff[numZones];

  Modelica.Blocks.Interfaces.RealOutput Vflow_setAHU[numZones] annotation (
      Placement(transformation(extent={{-100,-20},{-140,20}}),
        iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput AHUProfile                           annotation (Placement(
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
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool[numZones](
    k=0.25*gain_Vflow_Heat_Max,
    yMax=gain_Vflow_Heat_Max,
    yMin=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat[numZones](
    k=0.25*gain_Vflow_Heat_Max,
    yMax=gain_Vflow_Heat_Max,
    yMin=1,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Gain gainHeat[numZones](k=1)
    annotation (Placement(transformation(extent={{12,44},{0,56}})));
  Modelica.Blocks.Logical.Switch switchCool[numZones] annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-20,-30})));
  Modelica.Blocks.Logical.Switch switchHeat[numZones] annotation (Placement(
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
  Modelica.Blocks.Sources.Constant const[numZones](k=1)
    annotation (Placement(transformation(extent={{-52,-56},{-40,-44}})));
  Modelica.Blocks.Math.Add dTZoneHeat[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=+1, k2=-1)
    annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
  Modelica.Blocks.Sources.Constant const1[numZones](k=0)
    annotation (Placement(transformation(extent={{72,48},{60,60}})));
  Modelica.Blocks.Sources.Constant const2[numZones](k=1)
    annotation (Placement(transformation(extent={{-52,44},{-40,56}})));
  Modelica.Blocks.Sources.Constant const4[numZones](k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Switch switchOff[numZones]
    annotation (Placement(transformation(extent={{-30,-10},{-50,10}})));
  Modelica.Blocks.Sources.Constant const6[numZones](k=1)
    annotation (Placement(transformation(extent={{-50,-26},{-38,-14}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling[numZones](uLow=-0.25,
      uHigh=0.2)
    annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating[numZones](uLow=-0.25,
      uHigh=0.2)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff[numZones](y=
        OnOff) annotation (Placement(transformation(extent={{-8,-6},{-20,6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Math.Product product[numZones]
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Blocks.Logical.Not not1[numZones]
    annotation (Placement(transformation(extent={{4,-80},{-4,-72}})));
  Modelica.Blocks.Logical.Not not2[numZones]
    annotation (Placement(transformation(extent={{10,82},{2,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeatingCooling[numZones](
     y=HeatingCooling)
    annotation (Placement(transformation(extent={{46,-6},{34,6}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling[numZones]
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Interfaces.RealInput TOda(unit="K", start=293.15) annotation (
     Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,90}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,80})));
equation

  for i in 1:numZones loop
    if not hysteresisHeating[i].y and not hysteresisCooling[i].y then
      OnOff[i] = false;
    else
      OnOff[i] = true;
    end if;

    if TOda < 283.15 then
      HeatingCooling[i] = true;
    else
      HeatingCooling[i] = false;
    end if;

  end for;

  connect(gainHeat.y,switchHeat.u1)
    annotation (Line(points={{-0.6,50},{-12,50},{-12,42}},
                                                  color={0,0,127}));
  connect(PI_AHU_Heat.y,gainHeat.u)
    annotation (Line(points={{19,50},{13.2,50}},color={0,0,127}));
  connect(const.y, switchCool.u3) annotation (Line(points={{-39.4,-50},{-28,-50},
          {-28,-42}},    color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(TZone.T, dTZoneHeat.u2) annotation (Line(points={{59,0},{50,0},{50,24},
          {110,24},{110,44},{102,44}},                 color={0,0,127}));
  connect(TSetHeat, dTZoneHeat.u1) annotation (Line(points={{30,-120},{30,-98},{
          116,-98},{116,22},{120,22},{120,56},{102,56}}, color={0,0,127}));
  connect(TSetCool, dTZoneCool.u1) annotation (Line(points={{-30,-120},{-30,-96},
          {108,-96},{108,-56},{102,-56}}, color={0,0,127}));
  connect(TZone.T, dTZoneCool.u2) annotation (Line(points={{59,0},{50,0},{50,-20},
          {110,-20},{110,-44},{102,-44}},                   color={0,0,127}));
  connect(const1.y, PI_AHU_Heat.u_s) annotation (Line(points={{59.4,54},{52,54},
          {52,50},{42,50}}, color={0,0,127}));
  connect(const2.y, switchHeat.u3)
    annotation (Line(points={{-39.4,50},{-28,50},{-28,42}}, color={0,0,127}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-37.4,-20},{-34,-20},{-34,-14},{-20,-14},{-20,-8},
          {-28,-8}},                               color={0,0,127}));
  connect(booleanExpressionOnOff.y, switchOff.u2)
    annotation (Line(points={{-20.6,0},{-28,0}}, color={255,0,255}));
  connect(PI_AHU_Cool.y, switchCool.u1)
    annotation (Line(points={{19,-50},{-12,-50},{-12,-42}}, color={0,0,127}));
  connect(switchOff.y, product.u1) annotation (Line(points={{-51,0},{-60,0},{
          -60,6},{-68,6}}, color={0,0,127}));
  connect(replicator.y, product.u2) annotation (Line(points={{-69,-70},{-60,-70},
          {-60,-6},{-68,-6}}, color={0,0,127}));
  connect(AHUProfile, replicator.u)
    annotation (Line(points={{-120,-70},{-92,-70}}, color={0,0,127}));
  connect(product.y, Vflow_setAHU)
    annotation (Line(points={{-91,0},{-120,0}}, color={0,0,127}));
  connect(hysteresisCooling.y, not1.u) annotation (Line(points={{19,-80},{10,-80},
          {10,-76},{4.8,-76}}, color={255,0,255}));
  connect(not1.y, switchCool.u2) annotation (Line(points={{-4.4,-76},{-20,-76},{
          -20,-42}}, color={255,0,255}));
  connect(hysteresisHeating.y, not2.u)
    annotation (Line(points={{19,80},{10.8,80},{10.8,86}}, color={255,0,255}));
  connect(not2.y, switchHeat.u2)
    annotation (Line(points={{1.6,86},{-20,86},{-20,42}}, color={255,0,255}));
  connect(dTZoneHeat.y, hysteresisHeating.u) annotation (Line(points={{79,50},{76,
          50},{76,80},{42,80}}, color={0,0,127}));
  connect(dTZoneHeat.y, PI_AHU_Heat.u_m) annotation (Line(points={{79,50},{76,50},
          {76,32},{30,32},{30,38}}, color={0,0,127}));
  connect(dTZoneCool.y, PI_AHU_Cool.u_m) annotation (Line(points={{79,-50},{76,-50},
          {76,-32},{30,-32},{30,-38}}, color={0,0,127}));
  connect(dTZoneCool.y, hysteresisCooling.u) annotation (Line(points={{79,-50},{
          76,-50},{76,-80},{42,-80}}, color={0,0,127}));
  connect(switchHeatingCooling.y, switchOff.u1) annotation (Line(points={{-1,0},
          {-12,0},{-12,8},{-28,8}}, color={0,0,127}));
  connect(switchHeat.y, switchHeatingCooling.u1) annotation (Line(points={{-20,19},
          {-20,12},{-4,12},{-4,14},{22,14},{22,8}}, color={0,0,127}));
  connect(switchCool.y, switchHeatingCooling.u3) annotation (Line(points={{-20,-19},
          {-18,-19},{-18,-12},{-4,-12},{-4,-14},{22,-14},{22,-8}}, color={0,0,127}));
  connect(booleanExpressionHeatingCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{33.4,0},{22,0}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Dynamic_Vflow_Control;
