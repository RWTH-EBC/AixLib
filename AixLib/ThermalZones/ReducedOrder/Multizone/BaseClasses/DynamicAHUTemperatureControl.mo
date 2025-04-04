within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model DynamicAHUTemperatureControl
  "AHU T_Sup control depending on outdoor temperature"
  extends Modelica.Blocks.Icons.Block;

  parameter Boolean dynamicSetTempControlAHU = false
  "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";
  parameter Modelica.Units.SI.Temperature T_Treshold_Heating = 290.15
    "Temperature after HRS in AHU over which there should be no ahu heating";
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling = 294.15
    "Temperature after HRS in AHU under which there should be no ahu cooling";
  parameter Real phi_HRS = 0.85 "Heating recovery efficency";

  Modelica.Blocks.Interfaces.RealOutput TsetAHU_Out annotation (Placement(
        transformation(extent={{-100,-20},{-140,20}}), iconTransformation(
          extent={{-100,-20},{-140,20}})));
  Modelica.Units.SI.Temperature T_AHU_After_HRS "Temp after HRS in AHU";
  Modelica.Units.SI.Temperature TsetAHU "Dummy for set temparature of AHU";
  Modelica.Blocks.Interfaces.RealInput T_Oda "Outdoor air temperature"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={-8,120}),iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={80,120})));
  Modelica.Blocks.Interfaces.RealInput T_Eta "Extracted air temperature"
    annotation (Placement(transformation(
        extent={{-20,20},{20,-20}},
        rotation=270,
        origin={0,120}),  iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={-78,120})));
  Modelica.Blocks.Interfaces.RealInput TsetAHU_In annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={120,-70}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,0})));
  Modelica.Blocks.Logical.LessEqualThreshold HeatingThreshold(threshold=
        T_Treshold_Heating)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold CoolingThreshold(threshold=
        T_Treshold_Cooling)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Blocks.Logical.Switch switch
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        dynamicSetTempControlAHU)
    annotation (Placement(transformation(extent={{-12,-70},{-32,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=T_AHU_After_HRS)
    annotation (Placement(transformation(extent={{-60,54},{-40,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=TsetAHU)
    annotation (Placement(transformation(extent={{-20,-2},{-40,18}})));
equation

  T_AHU_After_HRS = T_Oda + phi_HRS * (T_Eta - T_Oda + 1e-3);

  if HeatingThreshold.y then
    TsetAHU = T_Treshold_Heating;
  elseif CoolingThreshold.y then
    TsetAHU = T_Treshold_Cooling;
  else
    TsetAHU = TsetAHU_In;
  end if;

  connect(TsetAHU_In, switch.u3) annotation (Line(points={{120,-70},{-52,-70},{-52,
          -8},{-58,-8}}, color={0,0,127}));
  connect(booleanExpression.y, switch.u2) annotation (Line(points={{-33,-60},{-48,
          -60},{-48,0},{-58,0}}, color={255,0,255}));
  connect(switch.y, TsetAHU_Out)
    annotation (Line(points={{-81,0},{-120,0}}, color={0,0,127}));
  connect(realExpression.y, HeatingThreshold.u) annotation (Line(points={{-39,64},
          {90,64},{90,30},{82,30}}, color={0,0,127}));
  connect(realExpression.y, CoolingThreshold.u) annotation (Line(points={{-39,64},
          {90,64},{90,-30},{82,-30}}, color={0,0,127}));
  connect(realExpression1.y, switch.u1)
    annotation (Line(points={{-41,8},{-58,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DynamicAHUTemperatureControl;
