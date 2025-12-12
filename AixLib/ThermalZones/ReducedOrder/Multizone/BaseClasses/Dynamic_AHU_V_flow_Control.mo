within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_AHU_V_flow_Control "Dynamic control of air volume flow in AHU to control zone temperature"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  parameter Boolean dynamicVolumeFlowControlAHU=false
    "Status of dynamic AHU control depending on room temperature";

  parameter Modelica.Units.SI.Time Ti_PI_Heat = 300 "Time constant of heating PI controller";
  parameter Modelica.Units.SI.Time Ti_PI_Cool = 300 "Time constant of cooling PI controller";

  parameter Real gain_V_flow_Heat_Max = 2
    "max volume flow gain for further heating power";
  parameter Real gain_V_flow_Cool_Max = 2
    "max volume flow gain for further cooling power";

  parameter Modelica.Units.SI.Temperature T_Treshold_Heating_AHU=290.15
    "Temperature after HRS in AHU over which there should be no ahu heating
        for temperature reasons (humidifciation/dehumidifaction still possible)";
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling_AHU=294.15
        "Temperature after HRS in AHU under which there should be no ahu cooling
        for temperature reasons (humidifciation/dehumidifaction still possible)";

  Boolean OnOff[numZones];
  Boolean HeatingCooling[numZones];

  Modelica.Blocks.Interfaces.RealOutput V_flow_AHU_set[numZones] annotation (
      Placement(transformation(extent={{-100,-20},{-140,20}}),
        iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput V_flow_AHU_In annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={120,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));

  Modelica.Blocks.Continuous.LimPID PI_AHU_Cool[numZones](
    each k=0.25*gain_V_flow_Cool_Max,
    each yMax=-1,
    each yMin=-gain_V_flow_Cool_Max,
    each controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each Ti=Ti_PI_Cool,
    each Td=0.1) annotation (Placement(transformation(extent={{0,-40},{-20,-60}})));
  Modelica.Blocks.Continuous.LimPID PI_AHU_Heat[numZones](
    each k=0.25*gain_V_flow_Heat_Max,
    each yMax=gain_V_flow_Heat_Max,
    each yMin=1,
    each controllerType=Modelica.Blocks.Types.SimpleController.PI,
    each Ti=Ti_PI_Heat,
    each Td=0.1) annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  Modelica.Blocks.Math.Gain gainHeat[numZones](each k=1)
    annotation (Placement(transformation(extent={{-28,44},{-40,56}})));
  Modelica.Blocks.Interfaces.RealInput TSetCool[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)                                     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={-30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={-40,-120})));
  Modelica.Blocks.Interfaces.RealInput TSetHeat[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)                                     annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=270,
        origin={30,-120}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=270,
        origin={40,-120})));
  Modelica.Blocks.Logical.Switch switchOff[numZones]
    annotation (Placement(transformation(extent={{-12,-8},{-28,8}})));
  Modelica.Blocks.Sources.Constant const6[numZones](each k=1)
    annotation (Placement(transformation(extent={{-48,-30},{-40,-22}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff[numZones](
    y=OnOff) annotation (Placement(transformation(extent={{6,-14},{-4,-2}})));
  Modelica.Blocks.Math.Product product[numZones]
    annotation (Placement(transformation(extent={{-84,6},{-96,-6}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=numZones)
    annotation (Placement(transformation(extent={{-30,80},{-50,100}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling[numZones]
    annotation (Placement(transformation(extent={{22,-8},{6,8}})));
  Modelica.Blocks.Logical.Switch switchOnOff[numZones]
    annotation (Placement(transformation(extent={{-58,-8},{-74,8}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant[numZones](
    each k=dynamicVolumeFlowControlAHU)
    annotation (Placement(transformation(extent={{-70,-34},{-58,-22}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder[numZones](each T(displayUnit="s")
       = 2*60) annotation (Placement(transformation(extent={{-36,-4},{-44,4}})));
  Utilities.Logical.DynamicHysteresis HysteresisHeating[numZones]
    annotation (Placement(transformation(extent={{80,60},{60,40}})));
  Modelica.Blocks.Sources.Constant const5[numZones](each k=T_Treshold_Heating_AHU)
    annotation (Placement(transformation(extent={{34,74},{46,86}})));
  Utilities.Logical.DynamicHysteresis HysteresisCooling[numZones]
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Sources.Constant const7[numZones](each k=T_Treshold_Cooling_AHU)
    annotation (Placement(transformation(extent={{46,-92},{58,-80}})));
  Modelica.Blocks.Math.Add add2[numZones](each k1=+1, each k2=-1) annotation (Placement(
        transformation(
        extent={{5,5},{-5,-5}},
        rotation=-90,
        origin={75,-71})));
  Modelica.Blocks.Sources.RealExpression realExpression[numZones](each y=(
        T_Treshold_Cooling_AHU - T_Treshold_Heating_AHU)/4)
    annotation (Placement(transformation(extent={{160,-10},{140,10}})));
  Modelica.Blocks.Math.Add add3[numZones](each k1=+1, each k2=+1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={67,71})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeatingCooling[numZones](
     y=HeatingCooling)
    annotation (Placement(transformation(extent={{40,-6},{30,6}})));
  Modelica.Blocks.MathBoolean.Not NotHysteresisHeating[numZones]
    annotation (Placement(transformation(extent={{50,52},{42,60}})));
  Modelica.Blocks.Math.Gain gainCool[numZones](each k=-1)
    annotation (Placement(transformation(extent={{-28,-56},{-40,-44}})));
  Modelica.Blocks.Interfaces.RealInput Tmeasure[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0) annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={100,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-50})));
equation

  for i in 1:numZones loop

    if NotHysteresisHeating[i].y and HysteresisHeating[i].y then
      OnOff[i] = false;
      HeatingCooling[i] = false;
    elseif NotHysteresisHeating[i].y then
      HeatingCooling[i] = true;
      OnOff[i] = true;
    elseif HysteresisHeating[i].y then
      HeatingCooling[i] = false;
      OnOff[i] = true;
    else
      OnOff[i] = false;
      HeatingCooling[i] = false;
    end if;
  end for;

  connect(PI_AHU_Heat.y,gainHeat.u)
    annotation (Line(points={{-21,50},{-26.8,50}},
                                                color={0,0,127}));
  connect(const6.y, switchOff.u3)
    annotation (Line(points={{-39.6,-26},{-34,-26},{-34,-14},{-14,-14},{-14,-8},
          {-12,-8},{-12,-6.4},{-10.4,-6.4}},       color={0,0,127}));
  connect(booleanExpressionOnOff.y, switchOff.u2)
    annotation (Line(points={{-4.5,-8},{-10,-8},{-10,0},{-10.4,0}},
                                                 color={255,0,255}));
  connect(replicator.y, product.u2) annotation (Line(points={{-51,90},{-80,90},{
          -80,3.6},{-82.8,3.6}},
                              color={0,0,127}));
  connect(V_flow_AHU_In, replicator.u) annotation (Line(points={{120,100},{-20,100},
          {-20,90},{-28,90}}, color={0,0,127}));
  connect(const6.y, switchOnOff.u3) annotation (Line(points={{-39.6,-26},{-34,-26},
          {-34,-14},{-48,-14},{-48,-6},{-52,-6},{-52,-6.4},{-56.4,-6.4}},
                                           color={0,0,127}));
  connect(booleanConstant.y, switchOnOff.u2) annotation (Line(points={{-57.4,-28},
          {-52,-28},{-52,0},{-56.4,0}},
        color={255,0,255}));
  connect(switchOnOff.y, product.u1) annotation (Line(points={{-74.8,0},{-80,0},
          {-80,-3.6},{-82.8,-3.6}},
                         color={0,0,127}));
  connect(product.y, V_flow_AHU_set)
    annotation (Line(points={{-96.6,0},{-120,0}},
                                                color={0,0,127}));
  connect(firstOrder.y, switchOnOff.u1) annotation (Line(points={{-44.4,0},{-48,
          0},{-48,6.4},{-56.4,6.4}},
                               color={0,0,127}));
  connect(switchOff.y, firstOrder.u)
    annotation (Line(points={{-28.8,0},{-35.2,0}}, color={0,0,127}));
  connect(const7.y, add2.u1) annotation (Line(points={{58.6,-86},{72,-86},{72,-77}},
                 color={0,0,127}));
  connect(realExpression.y, add2.u2) annotation (Line(points={{139,0},{104,0},{104,
          -77},{78,-77}},            color={0,0,127}));
  connect(const5.y, add3.u2)
    annotation (Line(points={{46.6,80},{64,80},{64,77}},    color={0,0,127}));
  connect(realExpression.y, add3.u1) annotation (Line(points={{139,0},{130,0},{130,
          80},{70,80},{70,77}},   color={0,0,127}));
  connect(TSetCool, PI_AHU_Cool.u_s) annotation (Line(points={{-30,-120},{-30,-80},
          {12,-80},{12,-50},{2,-50}},  color={0,0,127}));
  connect(TSetHeat, PI_AHU_Heat.u_s) annotation (Line(points={{30,-120},{30,-34},
          {50,-34},{50,50},{2,50}},    color={0,0,127}));
  connect(booleanExpressionHeatingCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{29.5,0},{23.6,0}}, color={255,0,255}));
  connect(switchHeatingCooling.y, switchOff.u1) annotation (Line(points={{5.2,0},
          {-2,0},{-2,6},{-10,6},{-10,6.4},{-10.4,6.4}}, color={0,0,127}));
  connect(gainHeat.y, switchHeatingCooling.u1) annotation (Line(points={{-40.6,50},
          {-44,50},{-44,20},{28,20},{28,6},{23.6,6},{23.6,6.4}},
                                                   color={0,0,127}));
  connect(HysteresisHeating.y, NotHysteresisHeating.u)
    annotation (Line(points={{59,50},{51.6,50},{51.6,56}}, color={255,0,255}));
  connect(const7.y, HysteresisCooling.uHigh) annotation (Line(points={{58.6,-86},
          {66,-86},{66,-62},{67,-62}}, color={0,0,127}));
  connect(add3.y, HysteresisHeating.uHigh)
    annotation (Line(points={{67,65.5},{67,62}}, color={0,0,127}));
  connect(const5.y, HysteresisHeating.uLow) annotation (Line(points={{46.6,80},{
          64,80},{64,82},{75,82},{75,62}}, color={0,0,127}));
  connect(add2.y, HysteresisCooling.uLow)
    annotation (Line(points={{75,-65.5},{75,-62}}, color={0,0,127}));
  connect(PI_AHU_Cool.y, gainCool.u)
    annotation (Line(points={{-21,-50},{-26.8,-50}}, color={0,0,127}));
  connect(gainCool.y, switchHeatingCooling.u3) annotation (Line(points={{-40.6,-50},
          {-44,-50},{-44,-34},{-18,-34},{-18,-18},{23.6,-18},{23.6,-6.4}},
        color={0,0,127}));
  connect(Tmeasure, HysteresisHeating.u)
    annotation (Line(points={{100,0},{100,50},{82,50}}, color={0,0,127}));
  connect(Tmeasure, HysteresisCooling.u)
    annotation (Line(points={{100,0},{100,-50},{82,-50}}, color={0,0,127}));
  connect(Tmeasure, PI_AHU_Heat.u_m) annotation (Line(points={{100,0},{100,28},
          {-10,28},{-10,38}}, color={0,0,127}));
  connect(Tmeasure, PI_AHU_Cool.u_m) annotation (Line(points={{100,0},{100,-28},
          {-10,-28},{-10,-38}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model that may dynamically control the volume flow per thermal zone through the air handling unit to support heating or cooling in thermal zones in the <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.</p>
<p>Control paramaters need to be adjusted accordingly.</p>
</html>"));
end Dynamic_AHU_V_flow_Control;
