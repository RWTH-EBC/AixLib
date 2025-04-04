within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model DynamicT_SUPControl "AHU T_Sup control"
  extends Modelica.Blocks.Icons.Block;


  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";
  parameter Boolean dynamicSetTempControlAHU = false
  "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";
  parameter Modelica.Units.SI.Temperature T_Treshold_Heating = 290.15
    "Temperature after HRS in AHU over which there should be no ahu heating";
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling = 294.15
    "Temperature after HRS in AHU under which there should be no ahu cooling";
  parameter Real phi_HRS = 0.85 "Heating recovery efficency";

  Modelica.Blocks.Interfaces.RealOutput TsetAHU_Out(unit="K", start = 293.15) annotation (Placement(
        transformation(extent={{-100,-20},{-140,20}}), iconTransformation(
          extent={{-100,-20},{-140,20}})));
  Modelica.Units.SI.Temperature T_AHU_After_HRS "Temp after HRS in AHU";
  Modelica.Units.SI.Temperature TsetAHU "Dummy for set temparature of AHU";
  Modelica.Blocks.Interfaces.RealInput TsetAHU_In(unit="K", start = 293.15) annotation (Placement(
        transformation(
        extent={{-20,20},{20,-20}},
        rotation=0,
        origin={-120,-70}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0})));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-20},{120,20}}),
        iconTransformation(extent={{80,-20},{120,20}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool(
    k=0.25*maxAHU_PI_Cool,
    yMax=0,
    yMin=5,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,-40},{20,-60}})));
  Modelica.Blocks.Math.Gain gainCool[numZones](k=-1)
    annotation (Placement(transformation(extent={{12,-56},{0,-44}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat(
    k=0.25*maxAHU_PI_Heat,
    yMax=5,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=0.1) annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Modelica.Blocks.Math.Gain gainHeat[numZones](k=1)
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
        origin={8,-122})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-70,-10},{-90,10}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Modelica.Blocks.Sources.BooleanConstant booleanCoolAHUExpression(k=coolAHU)
    annotation (Placement(transformation(extent={{150,-64},{138,-52}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-52,-56},{-40,-44}})));
  Modelica.Blocks.Math.Add dTZoneHeat[numZones](k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Modelica.Blocks.Math.Add dTZoneCool[numZones](k1=+1, k2=-1)
    annotation (Placement(transformation(extent={{100,-40},{80,-60}})));
  Utilities.Math.Average avedTZoneHeat(nin=numZones)
    annotation (Placement(transformation(extent={{72,28},{60,40}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{72,48},{60,60}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{-52,44},{-40,56}})));
  Modelica.Blocks.Sources.BooleanConstant booleanHeatAHUExpression(k=heatAHU)
    annotation (Placement(transformation(extent={{108,74},{96,86}})));
  Modelica.Blocks.Logical.Greater greater
    "check if outside temperature above threshold"
                                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-12})));
  Modelica.Blocks.Logical.Greater greaterHeating annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=0,
        origin={30,80})));
  Modelica.Blocks.Sources.Constant const3(k=0.5)
    annotation (Placement(transformation(extent={{66,82},{54,94}})));
  Utilities.Math.Average avedTZoneHeat1(nin=numZones)
    annotation (Placement(transformation(extent={{72,-40},{60,-28}})));
  Modelica.Blocks.Sources.Constant const4(k=0)
    annotation (Placement(transformation(extent={{72,-60},{60,-48}})));
  Modelica.Blocks.Logical.Greater greaterHeating1 annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={30,-80})));
  Modelica.Blocks.Sources.Constant const5(k=0.5)
    annotation (Placement(transformation(extent={{72,-94},{60,-82}})));
protected
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TZone[numZones]
    "Air temperature of the zones which are supplied by the AHU"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
equation

  T_AHU_After_HRS = T_Oda + phi_HRS * (T_Eta - T_Oda + 1e-3);

  if HeatingThreshold.y then
    TsetAHU = T_Treshold_Heating;
  elseif CoolingThreshold.y then
    TsetAHU = T_Treshold_Cooling;
  else
    TsetAHU = TsetAHU_In;
  end if;

  connect(PI_AHU_Cool.y,gainCool. u)
    annotation (Line(points={{19,-50},{13.2,-50}},color={0,0,127}));
  connect(gainCool.y,switchCool. u1)
    annotation (Line(points={{-0.6,-50},{-12,-50},{-12,-42}},
                                                    color={0,0,127}));
  connect(gainHeat.y,switchHeat. u1)
    annotation (Line(points={{-0.6,50},{-12,50},{-12,42}},
                                                  color={0,0,127}));
  connect(PI_AHU_Heat.y,gainHeat. u)
    annotation (Line(points={{19,50},{13.2,50}},color={0,0,127}));
  connect(TsetAHU_In, add.u2) annotation (Line(points={{-120,-70},{-62,-70},{
          -62,-6},{-68,-6}},
                         color={0,0,127}));
  connect(add.y, TsetAHU_Out)
    annotation (Line(points={{-91,0},{-120,0}}, color={0,0,127}));
  connect(switchHeatingCooling.y, add.u1) annotation (Line(points={{-61,0},{-68,
          0},{-68,6}},         color={0,0,127}));
  connect(const.y, switchCool.u3) annotation (Line(points={{-39.4,-50},{-28,-50},
          {-28,-42}},    color={0,0,127}));
  connect(roomHeatPort, TZone.port)
    annotation (Line(points={{100,0},{80,0}}, color={191,0,0}));
  connect(TZone.T, dTZoneHeat.u2) annotation (Line(points={{59,0},{58,0},{58,20},
          {76,20},{76,24},{108,24},{108,44},{102,44}}, color={0,0,127}));
  connect(TSetHeat, dTZoneHeat.u1) annotation (Line(points={{30,-120},{30,-98},
          {116,-98},{116,22},{120,22},{120,56},{102,56}}, color={0,0,127}));
  connect(TSetCool, dTZoneCool.u1) annotation (Line(points={{-30,-120},{-30,-96},
          {108,-96},{108,-56},{102,-56}}, color={0,0,127}));
  connect(TZone.T, dTZoneCool.u2) annotation (Line(points={{59,0},{58,0},{58,
          -12},{72,-12},{72,-24},{108,-24},{108,-44},{102,-44}}, color={0,0,127}));
  connect(dTZoneHeat.y, avedTZoneHeat.u) annotation (Line(points={{79,50},{76,
          50},{76,34},{73.2,34}}, color={0,0,127}));
  connect(avedTZoneHeat.y, PI_AHU_Heat.u_m)
    annotation (Line(points={{59.4,34},{30,34},{30,38}}, color={0,0,127}));
  connect(const1.y, PI_AHU_Heat.u_s) annotation (Line(points={{59.4,54},{48,54},
          {48,50},{42,50}}, color={0,0,127}));
  connect(const2.y, switchHeat.u3)
    annotation (Line(points={{-39.4,50},{-28,50},{-28,42}}, color={0,0,127}));
  connect(const3.y, greaterHeating.u2)
    annotation (Line(points={{53.4,88},{42,88}}, color={0,0,127}));
  connect(avedTZoneHeat.y, greaterHeating.u1) annotation (Line(points={{59.4,34},
          {50,34},{50,80},{42,80}}, color={0,0,127}));
  connect(greaterHeating.y, switchHeat.u2)
    annotation (Line(points={{19,80},{-20,80},{-20,42}}, color={255,0,255}));
  connect(switchHeat.y, switchHeatingCooling.u1)
    annotation (Line(points={{-20,19},{-20,8},{-38,8}}, color={0,0,127}));
  connect(switchCool.y, switchHeatingCooling.u3)
    annotation (Line(points={{-20,-19},{-20,-8},{-38,-8}}, color={0,0,127}));
  connect(avedTZoneHeat1.y, PI_AHU_Cool.u_m)
    annotation (Line(points={{59.4,-34},{30,-34},{30,-38}}, color={0,0,127}));
  connect(greaterHeating1.y, switchCool.u2) annotation (Line(points={{19,-80},{
          -20,-80},{-20,-42}}, color={255,0,255}));
  connect(const5.y, greaterHeating1.u2)
    annotation (Line(points={{59.4,-88},{42,-88}}, color={0,0,127}));
  connect(const4.y, PI_AHU_Cool.u_s) annotation (Line(points={{59.4,-54},{48,
          -54},{48,-50},{42,-50}}, color={0,0,127}));
  connect(avedTZoneHeat1.y, greaterHeating1.u1) annotation (Line(points={{59.4,
          -34},{50,-34},{50,-80},{42,-80}}, color={0,0,127}));
  connect(dTZoneCool.y, avedTZoneHeat1.u) annotation (Line(points={{79,-50},{76,
          -50},{76,-34},{73.2,-34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DynamicT_SUPControl;
