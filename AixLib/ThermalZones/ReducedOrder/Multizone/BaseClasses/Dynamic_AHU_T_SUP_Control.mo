within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_AHU_T_SUP_Control
  "Dynamic control of air supply temperature in AHU to control zone temperature"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones(min=1) = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  parameter Boolean dynamicSetTempControlAHU=false
    "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";

  parameter Modelica.Units.SI.Time Ti_PI_Heat(min=1) = 3600 "Time constant of heating PI controller" annotation (Dialog(enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.Time Ti_PI_Cool(min=1) = 3600 "Time constant of cooling PI controller" annotation (Dialog(enable=dynamicSetTempControlAHU));

  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Offset_Heat(min=Modelica.Constants.eps) = 1
    "base air supply temperature increase when in heating mode" annotation (Dialog(enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Offset_Cool(min=Modelica.Constants.eps) = 1
    "base air supply temperature decrease when in cooling mode" annotation (Dialog(enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Heat_Max(min=Modelica.Constants.eps) = 5
    "max temperature difference of T_SUP for further heating power" annotation (Dialog(enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Cool_Max(min=Modelica.Constants.eps) = 5
    "max temperature difference of T_SUP for further cooling power" annotation (Dialog(enable=dynamicSetTempControlAHU));

  parameter Modelica.Units.SI.Temperature T_Treshold_Heating_AHU(min=273.15)=290.15
    "Temperature after HRS in AHU over which there should be no ahu heating
        for temperature reasons (humidifciation/dehumidifaction still possible)"
                                                                                 annotation (Dialog(enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling_AHU(min=273.15)=294.15
        "Temperature after HRS in AHU under which there should be no ahu cooling
        for temperature reasons (humidifciation/dehumidifaction still possible)"
                                                                                 annotation (Dialog(enable=dynamicSetTempControlAHU));

  Boolean OnOff;
  Boolean HeatingCooling;

  Modelica.Blocks.Interfaces.RealOutput Tset_AHU_Out(
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)
    annotation (Placement(transformation(extent={{-100,-20},{-140,20}}),
        iconTransformation(extent={{-100,-20},{-140,20}})));
  Modelica.Blocks.Interfaces.RealInput Tset_AHU_In(
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)
    annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={100,100}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));

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
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-82,6},{-94,-6}})));
  AixLib.Controls.Continuous.LimPID PI_AHU_Cool(
    k=max(0.1*dT_SUP_Cool_Max, Modelica.Constants.eps),
    yMax=max((dT_SUP_Cool_Max - dT_SUP_Offset_Cool), Modelica.Constants.eps),
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=max(Ti_PI_Cool, 1),
    Td=0.1,
    reverseActing=false,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=0)
            annotation (Placement(transformation(extent={{0,-40},{-20,-60}})));
  AixLib.Controls.Continuous.LimPID PI_AHU_Heat(
    k=max(0.1*dT_SUP_Heat_Max, Modelica.Constants.eps),
    yMax=max(dT_SUP_Heat_Max - dT_SUP_Offset_Heat, Modelica.Constants.eps),
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=max(Ti_PI_Heat, 1),
    Td=0.1,
    reset=AixLib.Types.Reset.Parameter,
    y_reset=0)
            annotation (Placement(transformation(extent={{0,40},{-20,60}})));
  Modelica.Blocks.Math.Gain gainHeat(k=1)
    annotation (Placement(transformation(extent={{-28,44},{-40,56}})));
  Modelica.Blocks.Logical.Switch switchOff
    annotation (Placement(transformation(extent={{-12,-8},{-28,8}})));
  Modelica.Blocks.Sources.Constant const6(k=0)
    annotation (Placement(transformation(extent={{-44,-12},{-36,-4}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionOnOff(y=OnOff)
    annotation (Placement(transformation(extent={{86,-20},{76,-8}})));
  Modelica.Blocks.Logical.Switch switchHeatingCooling
    annotation (Placement(transformation(extent={{22,-8},{6,8}})));
  Modelica.Blocks.Logical.Switch switchOnOff
    annotation (Placement(transformation(extent={{-58,-8},{-74,8}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=
        dynamicSetTempControlAHU)
    annotation (Placement(transformation(extent={{-70,-34},{-58,-22}})));
  Utilities.Logical.DynamicHysteresis HysteresisHeating
    annotation (Placement(transformation(extent={{80,60},{60,40}})));
  Modelica.Blocks.Sources.Constant const5(k=T_Treshold_Heating_AHU)
    annotation (Placement(transformation(extent={{34,74},{46,86}})));
  Utilities.Logical.DynamicHysteresis HysteresisCooling
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Modelica.Blocks.Sources.Constant const7(k=T_Treshold_Cooling_AHU)
    annotation (Placement(transformation(extent={{46,-92},{58,-80}})));
  Modelica.Blocks.Math.Add add2(k1=+1, k2=-1) annotation (Placement(
        transformation(
        extent={{5,5},{-5,-5}},
        rotation=-90,
        origin={75,-71})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=(
        T_Treshold_Cooling_AHU - T_Treshold_Heating_AHU)/4)
    annotation (Placement(transformation(extent={{160,-10},{140,10}})));
  Modelica.Blocks.Math.Add add3(k1=+1, k2=+1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={67,71})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpressionHeatingCooling(y=
        HeatingCooling)
    annotation (Placement(transformation(extent={{46,-6},{36,6}})));
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
  Modelica.Blocks.MathBoolean.Not NotHysteresisHeating
    annotation (Placement(transformation(extent={{46,54},{38,62}})));
  Modelica.Blocks.Math.Add dT_Cool[numZones](each k1=+1, each k2=-1) annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={39,-29})));
  Modelica.Blocks.Math.Add dT_Heat[numZones](each k1=+1, each k2=-1) annotation (
      Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=0,
        origin={39,29})));
  Modelica.Blocks.Sources.RealExpression T_Max_Overheated_Zone(y=Tmeasure[
        dT_Cool_Max.iMax])
    annotation (Placement(transformation(extent={{120,-60},{100,-40}})));
  Utilities.Math.MinMax dT_Cool_Max(nu=numZones)
    annotation (Placement(transformation(extent={{4,-34},{-6,-24}})));
  Utilities.Math.MinMax dT_Heat_Max(nu=numZones)
    annotation (Placement(transformation(extent={{4,24},{-6,34}})));
  Modelica.Blocks.Sources.RealExpression T_Max_Undercooled_Zone(y=Tmeasure[
        dT_Heat_Max.iMin])
    annotation (Placement(transformation(extent={{120,40},{100,60}})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{18,-54},{10,-46}})));
  Modelica.Blocks.Sources.Constant const2(k=0)
    annotation (Placement(transformation(extent={{18,46},{10,54}})));
  Modelica.Blocks.Logical.Switch switchHeatingCoolingOffset
    annotation (Placement(transformation(extent={{-6,72},{-22,88}})));
  Modelica.Blocks.Sources.Constant dT_SUP_Cool(k=-dT_SUP_Offset_Cool)
    annotation (Placement(transformation(extent={{14,70},{6,78}})));
  Modelica.Blocks.Sources.Constant dT_Offset_Heat(k=dT_SUP_Offset_Heat)
    annotation (Placement(transformation(extent={{14,82},{6,90}})));
  Modelica.Blocks.Math.Add dT_Offset(k1=+1, k2=+1) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=0,
        origin={-2,12})));
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
        origin={120,-48})));
  Modelica.Blocks.Logical.Or OrResetHeat
    annotation (Placement(transformation(extent={{46,38},{36,48}})));
  Modelica.Blocks.Logical.Or OrResetCool
    annotation (Placement(transformation(extent={{36,-48},{26,-58}})));
  Modelica.Blocks.MathBoolean.RisingEdge rising2
    annotation (Placement(transformation(extent={{66,6},{58,14}})));
  Modelica.Blocks.MathBoolean.RisingEdge rising1
    annotation (Placement(transformation(extent={{32,54},{24,62}})));
  Modelica.Blocks.MathBoolean.RisingEdge rising3
    annotation (Placement(transformation(extent={{54,-58},{46,-50}})));
  Modelica.Blocks.Math.Gain gainHeat1(k=-1)
    annotation (Placement(transformation(extent={{-28,-56},{-40,-44}})));
equation

  if not NotHysteresisHeating.y and not HysteresisCooling.y then
    OnOff = false;
    HeatingCooling = false;
  elseif dT_Cool_Max.yMax > dT_Heat_Max.yMin and HysteresisCooling.y then
    HeatingCooling = false;
    OnOff = true;
  elseif dT_Cool_Max.yMax > dT_Heat_Max.yMin and NotHysteresisHeating.y then
    HeatingCooling = true;
    OnOff = true;
  elseif dT_Cool_Max.yMax < dT_Heat_Max.yMin and NotHysteresisHeating.y then
    HeatingCooling = true;
    OnOff = true;
  elseif dT_Cool_Max.yMax < dT_Heat_Max.yMin and HysteresisCooling.y then
    HeatingCooling = false;
    OnOff = true;
  else
    OnOff = false;
    HeatingCooling = false;
  end if;

  for i in 1:numZones loop
    connect(dT_Heat[i].y, dT_Heat_Max.u[i]);
    connect(dT_Cool[i].y, dT_Cool_Max.u[i]);
  end for;


  connect(Tset_AHU_In, add.u2) annotation (Line(points={{100,100},{100,98},{84,98},
          {84,100},{-78,100},{-78,4},{-80.8,4},{-80.8,3.6}},
                       color={0,0,127}));
  connect(add.y, Tset_AHU_Out)
    annotation (Line(points={{-94.6,0},{-120,0}},
                                                color={0,0,127}));
  connect(PI_AHU_Heat.y,gainHeat.u)
    annotation (Line(points={{-21,50},{-26.8,50}},
                                                color={0,0,127}));
  connect(const6.y,switchOff. u3)
    annotation (Line(points={{-35.6,-8},{-32,-8},{-32,-12},{-6,-12},{-6,-6.4},{
          -10.4,-6.4}},                            color={0,0,127}));
  connect(booleanExpressionOnOff.y,switchOff. u2)
    annotation (Line(points={{75.5,-14},{-4,-14},{-4,0},{-10.4,0}},
                                                 color={255,0,255}));
  connect(const6.y,switchOnOff. u3) annotation (Line(points={{-35.6,-8},{-32,-8},
          {-32,-16},{-54,-16},{-54,-6.4},{-56.4,-6.4}},
                                           color={0,0,127}));
  connect(booleanConstant.y,switchOnOff. u2) annotation (Line(points={{-57.4,-28},
          {-52,-28},{-52,0},{-56.4,0}},
        color={255,0,255}));
  connect(const7.y,add2. u1) annotation (Line(points={{58.6,-86},{72,-86},{72,-77}},
                 color={0,0,127}));
  connect(realExpression.y,add2. u2) annotation (Line(points={{139,0},{130,0},{130,
          -84},{78,-84},{78,-77}},   color={0,0,127}));
  connect(const5.y,add3. u2)
    annotation (Line(points={{46.6,80},{64,80},{64,77}},    color={0,0,127}));
  connect(realExpression.y,add3. u1) annotation (Line(points={{139,0},{130,0},{130,
          80},{70,80},{70,77}},   color={0,0,127}));
  connect(booleanExpressionHeatingCooling.y, switchHeatingCooling.u2)
    annotation (Line(points={{35.5,0},{23.6,0}}, color={255,0,255}));
  connect(gainHeat.y,switchHeatingCooling. u1) annotation (Line(points={{-40.6,50},
          {-44,50},{-44,22},{28,22},{28,6},{23.6,6},{23.6,6.4}},
                                                   color={0,0,127}));
  connect(add3.y, HysteresisHeating.uHigh)
    annotation (Line(points={{67,65.5},{67,62}}, color={0,0,127}));
  connect(const5.y, HysteresisHeating.uLow) annotation (Line(points={{46.6,80},{
          64,80},{64,82},{75,82},{75,62}}, color={0,0,127}));
  connect(add2.y, HysteresisCooling.uLow)
    annotation (Line(points={{75,-65.5},{75,-62}}, color={0,0,127}));
  connect(const7.y, HysteresisCooling.uHigh) annotation (Line(points={{58.6,-86},
          {66,-86},{66,-62},{67,-62}}, color={0,0,127}));
  connect(HysteresisHeating.y, NotHysteresisHeating.u) annotation (Line(points={
          {59,50},{52,50},{52,58},{47.6,58}}, color={255,0,255}));
  connect(switchOnOff.y, add.u1) annotation (Line(points={{-74.8,0},{-78,0},{-78,
          -3.6},{-80.8,-3.6}}, color={0,0,127}));
  connect(TSetHeat, dT_Heat.u2) annotation (Line(points={{30,-120},{30,-42},{50,
          -42},{50,26},{45,26}}, color={0,0,127}));
  connect(dT_Cool_Max.yMax, PI_AHU_Cool.u_m) annotation (Line(points={{-6.5,-26},
          {-10,-26},{-10,-38}}, color={0,0,127}));
  connect(dT_Heat_Max.yMin, PI_AHU_Heat.u_m)
    annotation (Line(points={{-6.5,26},{-10,26},{-10,38}}, color={0,0,127}));
  connect(T_Max_Undercooled_Zone.y, HysteresisHeating.u)
    annotation (Line(points={{99,50},{82,50}}, color={0,0,127}));
  connect(T_Max_Overheated_Zone.y, HysteresisCooling.u)
    annotation (Line(points={{99,-50},{82,-50}}, color={0,0,127}));
  connect(const1.y, PI_AHU_Cool.u_s)
    annotation (Line(points={{9.6,-50},{2,-50}}, color={0,0,127}));
  connect(const2.y, PI_AHU_Heat.u_s)
    annotation (Line(points={{9.6,50},{2,50}}, color={0,0,127}));
  connect(booleanExpressionHeatingCooling.y, switchHeatingCoolingOffset.u2)
    annotation (Line(points={{35.5,0},{30,0},{30,50},{20,50},{20,80},{-4.4,80}},
        color={255,0,255}));
  connect(dT_SUP_Cool.y, switchHeatingCoolingOffset.u3)
    annotation (Line(points={{5.6,74},{6,73.6},{-4.4,73.6}}, color={0,0,127}));
  connect(dT_Offset_Heat.y, switchHeatingCoolingOffset.u1)
    annotation (Line(points={{5.6,86},{6,86.4},{-4.4,86.4}}, color={0,0,127}));
  connect(switchHeatingCooling.y, dT_Offset.u2) annotation (Line(points={{5.2,0},
          {4,0},{4,10},{2,10},{2,9.6},{2.8,9.6}}, color={0,0,127}));
  connect(dT_Offset.y, switchOff.u1) annotation (Line(points={{-6.4,12},{-8,12},
          {-8,6.4},{-10.4,6.4}}, color={0,0,127}));
  connect(switchHeatingCoolingOffset.y, dT_Offset.u1) annotation (Line(points={{
          -22.8,80},{-48,80},{-48,20},{8,20},{8,14.4},{2.8,14.4}}, color={0,0,127}));
  connect(TSetCool, dT_Cool.u2) annotation (Line(points={{-30,-120},{-30,-94},{28,
          -94},{28,-40},{48,-40},{48,-32},{45,-32}},    color={0,0,127}));
  connect(Tmeasure, dT_Cool.u1) annotation (Line(points={{100,0},{52,0},{52,-26},
          {45,-26}}, color={0,0,127}));
  connect(Tmeasure, dT_Heat.u1) annotation (Line(points={{100,0},{52,0},{52,32},
          {45,32}}, color={0,0,127}));
  connect(switchOff.y, switchOnOff.u1) annotation (Line(points={{-28.8,0},{-40,0},
          {-40,6.4},{-56.4,6.4}}, color={0,0,127}));
  connect(OrResetHeat.y, PI_AHU_Heat.trigger) annotation (Line(points={{35.5,43},
          {22,43},{22,38},{-2,38}}, color={255,0,255}));
  connect(OrResetCool.y, PI_AHU_Cool.trigger) annotation (Line(points={{25.5,
          -53},{25.5,-52},{22,-52},{22,-38},{-2,-38}}, color={255,0,255}));
  connect(booleanExpressionOnOff.y, rising2.u) annotation (Line(points={{75.5,
          -14},{72,-14},{72,10},{67.6,10}}, color={255,0,255}));
  connect(NotHysteresisHeating.y, rising1.u)
    annotation (Line(points={{37.2,58},{33.6,58}}, color={255,0,255}));
  connect(rising1.y, OrResetHeat.u1) annotation (Line(points={{23.2,58},{22,58},
          {22,52},{50,52},{50,42},{47,42},{47,43}}, color={255,0,255}));
  connect(HysteresisCooling.y, rising3.u) annotation (Line(points={{59,-50},{
          55.6,-50},{55.6,-54}}, color={255,0,255}));
  connect(rising3.y, OrResetCool.u1) annotation (Line(points={{45.2,-54},{44,
          -54},{44,-53},{37,-53}}, color={255,0,255}));
  connect(rising2.y, OrResetHeat.u2) annotation (Line(points={{57.2,10},{54,10},
          {54,39},{47,39}}, color={255,0,255}));
  connect(rising2.y, OrResetCool.u2) annotation (Line(points={{57.2,10},{54,10},
          {54,-46},{42,-46},{42,-49},{37,-49}}, color={255,0,255}));
  connect(gainHeat1.y, switchHeatingCooling.u3) annotation (Line(points={{-40.6,
          -50},{-44,-50},{-44,-20},{28,-20},{28,-6.4},{23.6,-6.4}}, color={0,0,
          127}));
  connect(PI_AHU_Cool.y, gainHeat1.u)
    annotation (Line(points={{-21,-50},{-26.8,-50}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
    <p>Model that may dynamically control the air supply temperature of the air handling unit 
    to support cooling in thermal zones in the <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.</p>
<p>Control paramaters need to be adjusted accordingly.</p>
</html>", revisions="<html>
<ul>
<li>January, 2026 by Jonatan Höpp:<br/>
    First Implementation.
  </li>
</ul>
</html>"));
end Dynamic_AHU_T_SUP_Control;
