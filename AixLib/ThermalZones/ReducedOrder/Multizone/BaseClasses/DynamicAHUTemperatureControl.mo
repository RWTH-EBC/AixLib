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
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=
        T_Treshold_Heating)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       T_Treshold_Cooling)
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{30,-10},{10,10}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-20,10},{-40,-10}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-60,-10},{-80,10}})));

  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=
        dynamicSetTempControlAHU)
    annotation (Placement(transformation(extent={{-10,-40},{-30,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=T_AHU_After_HRS)
    annotation (Placement(transformation(extent={{-60,54},{-40,74}})));
equation

  T_AHU_After_HRS = T_Oda + phi_HRS * (T_Eta - T_Oda + 1e-3);

  connect(lessEqualThreshold.y, or1.u1) annotation (Line(points={{59,30},{40,30},
          {40,0},{32,0}}, color={255,0,255}));
  connect(greaterEqualThreshold.y, or1.u2) annotation (Line(points={{59,-30},{40,
          -30},{40,-8},{32,-8}}, color={255,0,255}));
  connect(or1.y, switch1.u2)
    annotation (Line(points={{9,0},{-18,0}},  color={255,0,255}));
  connect(TsetAHU_In, switch1.u1) annotation (Line(points={{120,-70},{0,-70},{0,
          -8},{-18,-8}},
                       color={0,0,127}));
  connect(switch1.y, switch2.u1) annotation (Line(points={{-41,0},{-46,0},{-46,8},
          {-58,8}},  color={0,0,127}));
  connect(TsetAHU_In, switch2.u3) annotation (Line(points={{120,-70},{-52,-70},{
          -52,-8},{-58,-8}},
                       color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-31,-30},{-48,
          -30},{-48,0},{-58,0}}, color={255,0,255}));
  connect(switch2.y, TsetAHU_Out)
    annotation (Line(points={{-81,0},{-120,0}}, color={0,0,127}));
  connect(realExpression.y, lessEqualThreshold.u) annotation (Line(points={{-39,
          64},{90,64},{90,30},{82,30}}, color={0,0,127}));
  connect(realExpression.y, greaterEqualThreshold.u) annotation (Line(points={{-39,
          64},{90,64},{90,-30},{82,-30}}, color={0,0,127}));
  connect(realExpression.y, switch1.u3)
    annotation (Line(points={{-39,64},{0,64},{0,8},{-18,8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DynamicAHUTemperatureControl;
