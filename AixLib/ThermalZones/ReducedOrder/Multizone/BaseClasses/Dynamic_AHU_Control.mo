within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_AHU_Control
  "Dynamic controller for volume flow and supply temperature of modular AHU to regulate zone temperature"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  // Volume flow controller
  parameter Boolean dynamicVolumeFlowControlAHU=false
    "Status of dynamic AHU control depending on room temperature" annotation(Dialog(group="Volume Flow Controller"));

  parameter Real gain_V_flow_Heat_Max = 2
    "max volume flow gain for further heating power" annotation(Dialog(group="Volume Flow Controller", enable=dynamicVolumeFlowControlAHU));
  parameter Real gain_V_flow_Cool_Max = 2
    "max volume flow gain for further cooling power" annotation(Dialog(group="Volume Flow Controller", enable=dynamicVolumeFlowControlAHU));

  parameter Modelica.Units.SI.Time Ti_PI_Heat_V_flow = 300
    "Time constant of heating PI controller" annotation(Dialog(group="Volume Flow Controller", enable=dynamicVolumeFlowControlAHU));
  parameter Modelica.Units.SI.Time Ti_PI_Cool_V_flow = 300
    "Time constant of cooling PI controller" annotation(Dialog(group="Volume Flow Controller", enable=dynamicVolumeFlowControlAHU));

  // Supply temperature controller
  parameter Boolean dynamicSetTempControlAHU=false
    "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS" annotation(Dialog(group="Supply Temperature Controller"));

  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Offset_Heat = 1
    "base air supply temperature increase when in heating mode" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Offset_Cool = 1
    "base air supply temperature decrease when in cooling mode" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Heat_Max = 5
    "max temperature difference of T_SUP for further heating power" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Cool_Max = 5
    "max temperature difference of T_SUP for further cooling power" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));

  parameter Modelica.Units.SI.Time Ti_PI_Heat_T_SUP = 3600
  "Time constant of heating PI controller" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));
  parameter Modelica.Units.SI.Time Ti_PI_Cool_T_SUP = 3600
  "Time constant of cooling PI controller" annotation(Dialog(group="Supply Temperature Controller", enable=dynamicSetTempControlAHU));

  // Temperature Tresholds
  parameter Modelica.Units.SI.Temperature T_Treshold_Heating_AHU=290.15
    "Temperature after HRS in AHU over which there should be no ahu heating
        for temperature reasons (humidifciation/dehumidifaction still possible)"
                                                                                 annotation (Dialog(enable=dynamicSetTempControlAHU or dynamicVolumeFlowControlAHU));
  parameter Modelica.Units.SI.Temperature T_Treshold_Cooling_AHU=294.15
        "Temperature after HRS in AHU under which there should be no ahu cooling
        for temperature reasons (humidifciation/dehumidifaction still possible)"
                                                                                 annotation (Dialog(enable=dynamicSetTempControlAHU or dynamicVolumeFlowControlAHU));

  Modelica.Blocks.Interfaces.RealOutput Tset_AHU_Set(
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0)
    annotation (Placement(transformation(extent={{-100,40},{-140,80}}),
        iconTransformation(extent={{-100,40},{-140,80}})));
  Modelica.Blocks.Interfaces.RealInput AHU_In[4] annotation (Placement(
        transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={120,50}), iconTransformation(
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
  Dynamic_AHU_T_SUP_Control dynamic_T_SUP_Control_Cooling(
    numZones=numZones,
    zoneParam=zoneParam,
    dynamicSetTempControlAHU=dynamicSetTempControlAHU,
    Ti_PI_Heat=Ti_PI_Heat_T_SUP,
    Ti_PI_Cool=Ti_PI_Cool_T_SUP,
    dT_SUP_Offset_Heat=dT_SUP_Offset_Heat,
    dT_SUP_Offset_Cool=dT_SUP_Offset_Cool,
    dT_SUP_Cool_Max=dT_SUP_Cool_Max,
    dT_SUP_Heat_Max=dT_SUP_Heat_Max,
    T_Treshold_Heating_AHU=T_Treshold_Heating_AHU,
    T_Treshold_Cooling_AHU=T_Treshold_Cooling_AHU)
    annotation (Placement(transformation(extent={{-20,20},{22,62}})));
  Dynamic_AHU_V_flow_Control dynamic_V_flow_SUP_Control(
    numZones=numZones,
    zoneParam=zoneParam,
    dynamicVolumeFlowControlAHU=dynamicVolumeFlowControlAHU,
    Ti_PI_Heat=Ti_PI_Heat_V_flow,
    Ti_PI_Cool=Ti_PI_Cool_V_flow,
    gain_V_flow_Heat_Max=gain_V_flow_Heat_Max,
    gain_V_flow_Cool_Max=gain_V_flow_Cool_Max,
    T_Treshold_Heating_AHU=T_Treshold_Heating_AHU,
    T_Treshold_Cooling_AHU=T_Treshold_Cooling_AHU)
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Modelica.Blocks.Interfaces.RealOutput V_flow_AHU_Set[numZones] annotation (
      Placement(transformation(extent={{-100,-60},{-140,-20}}),
        iconTransformation(extent={{-100,-80},{-140,-40}})));
  Modelica.Blocks.Interfaces.RealInput Tmeasure[numZones](
    each final quantity="ThermodynamicTemperature",
    each final unit="K",
    each displayUnit="degC",
    each min=0) annotation (Placement(transformation(
        extent={{20,20},{-20,-20}},
        rotation=0,
        origin={120,-44}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-48})));

equation

  connect(dynamic_T_SUP_Control_Cooling.Tset_AHU_Out, Tset_AHU_Set) annotation
    (Line(points={{-24.2,41},{-96,41},{-96,60},{-120,60}}, color={0,0,127}));
  connect(dynamic_V_flow_SUP_Control.V_flow_AHU_set, V_flow_AHU_Set)
    annotation (Line(points={{-24,-40},{-120,-40}}, color={0,0,127}));
  connect(TSetHeat, dynamic_V_flow_SUP_Control.TSetHeat) annotation (Line(
        points={{30,-120},{30,-74},{8,-74},{8,-64}}, color={0,0,127}));
  connect(TSetCool, dynamic_V_flow_SUP_Control.TSetCool) annotation (Line(
        points={{-30,-120},{-30,-74},{-8,-74},{-8,-64}}, color={0,0,127}));
  connect(TSetCool, dynamic_T_SUP_Control_Cooling.TSetCool) annotation (Line(
        points={{-30,-120},{-30,-48},{-32,-48},{-32,6},{-7.4,6},{-7.4,15.8}},
        color={0,0,127}));
  connect(AHU_In[1], dynamic_T_SUP_Control_Cooling.Tset_AHU_In) annotation (
      Line(points={{120,42.5},{114,42.5},{114,42},{116,42},{116,53.6},{26.2,53.6}},
        color={0,0,127}));
  connect(AHU_In[4], dynamic_V_flow_SUP_Control.V_flow_AHU_In) annotation (Line(
        points={{120,57.5},{120,58},{118,58},{118,54},{40,54},{40,-28},{24,-28}},
                                                                         color={
          0,0,127}));
  connect(TSetHeat, dynamic_T_SUP_Control_Cooling.TSetHeat) annotation (Line(
        points={{30,-120},{30,-74},{46,-74},{46,8},{9.4,8},{9.4,15.8}}, color={0,
          0,127}));
  connect(Tmeasure, dynamic_T_SUP_Control_Cooling.Tmeasure) annotation (Line(
        points={{120,-44},{56,-44},{56,30},{42,30},{42,30.92},{26.2,30.92}},
        color={0,0,127}));
  connect(Tmeasure, dynamic_V_flow_SUP_Control.Tmeasure) annotation (Line(
        points={{120,-44},{56,-44},{56,-52},{23.6,-52}},
                                                       color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
    <p>Model that combines dynamic volume flow and air supply temperature control 
    of the air handling unit in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.</p>
</html>", revisions="<html>
<ul>
<li>January, 2026 by Jonatan Höpp:<br/>
    First Implementation.
  </li>
</ul>
</html>"));
end Dynamic_AHU_Control;
