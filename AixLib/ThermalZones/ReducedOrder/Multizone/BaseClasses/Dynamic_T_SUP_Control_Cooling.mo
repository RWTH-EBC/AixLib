within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_T_SUP_Control_Cooling "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  parameter Modelica.Units.SI.Temperature dT_SUP_Cool_Max = 5
    "max temperature difference of T_SUP for further cooling power";


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
    Ti=2*3600,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Math.Gain gainCool(k=-1)
    annotation (Placement(transformation(extent={{12,-56},{0,-44}})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones](each unit="K", each start = 293.15) annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={-30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones](each unit="K", each start = 293.15) annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={40,-120})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,-60},{80,-40}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Switch switchOff
    annotation (Placement(transformation(extent={{-2,-10},{-22,10}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-20,-26},{-8,-14}})));
  Modelica.Blocks.Logical.Hysteresis hysteresisCooling(uLow=-0.5, uHigh=0.25)
    annotation (Placement(transformation(extent={{40,-90},{20,-70}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Modelica.Blocks.Math.MinMax minMax(nu=numZones)
    annotation (Placement(transformation(extent={{68,-40},{56,-28}})));
  Modelica.Blocks.Logical.Not not2
    annotation (Placement(transformation(extent={{8,-84},{0,-76}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T(displayUnit="h") = 900)
    annotation (Placement(transformation(extent={{-40,-6},{-52,6}})));
equation

  connect(PI_AHU_Cool.y,gainCool.u)
    annotation (Line(points={{19,-50},{13.2,-50}},color={0,0,127}));
  connect(TsetAHU_In, add.u2) annotation (Line(points={{-120,-70},{-60,-70},{-60,
          -6},{-68,-6}}, color={0,0,127}));
  connect(add.y, TsetAHU_Out)
    annotation (Line(points={{-91,0},{-120,0}}, color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{52,-54},
          {52,-50},{42,-50}}, color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-7.4,-20},{10,-20},{10,-8},{0,-8}},
                                                   color={0,0,127}));
  connect(dTZoneCool.y, minMax.u) annotation (Line(points={{79,-50},{78,-50},{78,
          -34},{68,-34}}, color={0,0,127}));
  connect(minMax.yMin, PI_AHU_Cool.u_m) annotation (Line(points={{55.4,-37.6},{
          48,-37.6},{48,-32},{30,-32},{30,-38}},
                                              color={0,0,127}));
  connect(minMax.yMin, hysteresisCooling.u) annotation (Line(points={{55.4,-37.6},
          {48,-37.6},{48,-80},{42,-80}}, color={0,0,127}));
  connect(hysteresisCooling.y, not2.u)
    annotation (Line(points={{19,-80},{8.8,-80}}, color={255,0,255}));
  connect(TZone.T, dTZoneCool.u1) annotation (Line(points={{59,0},{50,0},{50,-22},
          {110,-22},{110,-44},{102,-44}}, color={0,0,127}));
  connect(TSetCool, dTZoneCool.u2) annotation (Line(points={{-30,-120},{-30,-96},
          {110,-96},{110,-56},{102,-56}}, color={0,0,127}));
  connect(gainCool.y, switchOff.u1) annotation (Line(points={{-0.6,-50},{-4,-50},
          {-4,-34},{20,-34},{20,8},{0,8}},
                           color={0,0,127}));
  connect(not2.y, switchOff.u2) annotation (Line(points={{-0.4,-80},{-8,-80},{
          -8,-32},{14,-32},{14,0},{0,0}},
                       color={255,0,255}));
  connect(firstOrder.u, switchOff.y)
    annotation (Line(points={{-38.8,0},{-23,0}}, color={0,0,127}));
  connect(firstOrder.y, add.u1) annotation (Line(points={{-52.6,0},{-58,0},{-58,
          6},{-68,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Dynamic_T_SUP_Control_Cooling;
