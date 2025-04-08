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
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
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
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling[numZones](uLow=-0.25, uHigh=
        0.1)
    annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisHeating[numZones](uLow=-0.25,
      uHigh=0.2)
    annotation (Placement(transformation(extent={{40,70},{20,90}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff[numZones](y=
        OnOff) annotation (Placement(transformation(extent={{-8,-6},{-20,6}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{86,-8},{74,8}})));
  Modelica.Blocks.Math.Product product[numZones]
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{-90,-80},{-70,-60}})));
  Modelica.Blocks.Logical.Not not1[numZones]
    annotation (Placement(transformation(extent={{4,-84},{-4,-76}})));
  Modelica.Blocks.Logical.Not not2[numZones]
    annotation (Placement(transformation(extent={{4,76},{-4,84}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling[numZones]
    annotation (Placement(transformation(extent={{20,-10},{0,10}})));
  Modelica.Blocks.Math.Add TSetAvg[numZones](k1=0.5, k2=0.5)
    annotation (Placement(transformation(extent={{80,-16},{68,-28}})));
  Utilities.Logical.DynamicHysteresis HysteresisHeatinCooling[numZones]
    annotation (Placement(transformation(extent={{50,10},{30,-10}})));
  Modelica.Blocks.Math.Add add[numZones](k1=+1, k2=+1)
    annotation (Placement(transformation(extent={{56,24},{52,28}})));
  Modelica.Blocks.Math.Add add1[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{56,16},{52,20}})));
  Modelica.Blocks.Sources.Constant const3[numZones](k=0.5)
    annotation (Placement(transformation(extent={{66,20},{62,24}})));
equation

  for i in 1:numZones loop
    if hysteresisHeating[i].y and hysteresisCooling[i].y then
      OnOff[i] = false;
    else
      OnOff[i] = true;
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
    annotation (Line(points={{100,0},{86,0}}, color={191,0,0}));
  connect(TZone.T, dTZoneHeat.u2) annotation (Line(points={{73.4,0},{68,0},{68,
          24},{110,24},{110,44},{102,44}},             color={0,0,127}));
  connect(TSetHeat, dTZoneHeat.u1) annotation (Line(points={{30,-120},{30,-98},{
          116,-98},{116,56},{102,56}},                   color={0,0,127}));
  connect(const1.y, PI_AHU_Heat.u_s) annotation (Line(points={{59.4,54},{52,54},
          {52,50},{42,50}}, color={0,0,127}));
  connect(const2.y, switchHeat.u3)
    annotation (Line(points={{-39.4,50},{-28,50},{-28,42}}, color={0,0,127}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-37.4,-20},{-34,-20},{-34,-14},{-22,-14},{-22,-8},
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
  connect(hysteresisCooling.y, not1.u) annotation (Line(points={{19,-80},{4.8,-80}},
                               color={255,0,255}));
  connect(not1.y, switchCool.u2) annotation (Line(points={{-4.4,-80},{-20,-80},{
          -20,-42}}, color={255,0,255}));
  connect(hysteresisHeating.y, not2.u)
    annotation (Line(points={{19,80},{4.8,80}},            color={255,0,255}));
  connect(not2.y, switchHeat.u2)
    annotation (Line(points={{-4.4,80},{-20,80},{-20,42}},color={255,0,255}));
  connect(dTZoneHeat.y, hysteresisHeating.u) annotation (Line(points={{79,50},{76,
          50},{76,80},{42,80}}, color={0,0,127}));
  connect(dTZoneHeat.y, PI_AHU_Heat.u_m) annotation (Line(points={{79,50},{76,50},
          {76,32},{30,32},{30,38}}, color={0,0,127}));
  connect(dTZoneCool.y, PI_AHU_Cool.u_m) annotation (Line(points={{79,-50},{76,-50},
          {76,-32},{30,-32},{30,-38}}, color={0,0,127}));
  connect(dTZoneCool.y, hysteresisCooling.u) annotation (Line(points={{79,-50},{
          76,-50},{76,-80},{42,-80}}, color={0,0,127}));
  connect(switchHeatingCooling.y, switchOff.u1) annotation (Line(points={{-1,0},{
          -4,0},{-4,8},{-28,8}},    color={0,0,127}));
  connect(switchHeat.y, switchHeatingCooling.u1) annotation (Line(points={{-20,19},
          {-20,14},{26,14},{26,8},{22,8}},          color={0,0,127}));
  connect(switchCool.y, switchHeatingCooling.u3) annotation (Line(points={{-20,-19},
          {-20,-14},{26,-14},{26,-8},{22,-8}},                     color={0,0,127}));
  connect(TZone.T, dTZoneCool.u1) annotation (Line(points={{73.4,0},{68,0},{68,
          -12},{108,-12},{108,-44},{102,-44}},
                                          color={0,0,127}));
  connect(TSetCool, dTZoneCool.u2) annotation (Line(points={{-30,-120},{-30,-94},
          {110,-94},{110,-56},{102,-56}}, color={0,0,127}));
  connect(TSetHeat, TSetAvg.u2) annotation (Line(points={{30,-120},{30,-98},{116,
          -98},{116,-18},{82,-18},{82,-18.4},{81.2,-18.4}}, color={0,0,127}));
  connect(TSetCool, TSetAvg.u1) annotation (Line(points={{-30,-120},{-30,-94},{110,
          -94},{110,-26},{96,-26},{96,-25.6},{81.2,-25.6}}, color={0,0,127}));
  connect(const3.y, add.u2) annotation (Line(points={{61.8,22},{58,22},{58,24},
          {56.4,24},{56.4,24.8}}, color={0,0,127}));
  connect(const3.y, add1.u1) annotation (Line(points={{61.8,22},{58,22},{58,
          19.2},{56.4,19.2}}, color={0,0,127}));
  connect(TZone.T, add1.u2) annotation (Line(points={{73.4,0},{68,0},{68,16.8},
          {56.4,16.8}}, color={0,0,127}));
  connect(TZone.T, add.u1) annotation (Line(points={{73.4,0},{68,0},{68,27.2},{
          56.4,27.2}}, color={0,0,127}));
  connect(HysteresisHeatinCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{29,0},{22,0}}, color={255,0,255}));
  connect(TSetAvg.y, HysteresisHeatinCooling.u) annotation (Line(points={{67.4,
          -22},{60,-22},{60,0},{52,0}}, color={0,0,127}));
  connect(add1.y, HysteresisHeatinCooling.uLow)
    annotation (Line(points={{51.8,18},{45,18},{45,12}}, color={0,0,127}));
  connect(add.y, HysteresisHeatinCooling.uHigh)
    annotation (Line(points={{51.8,26},{37,26},{37,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Dynamic_Vflow_Control;
