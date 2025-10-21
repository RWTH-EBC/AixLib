within AixLib.ThermalZones.ReducedOrder.Multizone.BaseClasses;
model Dynamic_AHU_Control
  "Dynamic controller for volume flow and supply temperature of modular AHU"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer numZones = 1 "Numer of zones";
  parameter AixLib.DataBase.ThermalZones.ZoneBaseRecord zoneParam[numZones]
    "Records of zones";

  parameter Boolean dynamicSetTempControlAHU=false
    "Status of dynamic set Temperature control in AHU control depending on temperature in AHU after HRS";
  parameter Boolean dynamicVolumeFlowControlAHU=false
    "Status of dynamic AHU control depending on room temperature";

  parameter Real gain_Vflow_Heat_Max = 2
    "max volume flow gain for further heating power";
  parameter Real gain_Vflow_Cool_Max = 2
    "max volume flow gain for further cooling power";

  parameter Modelica.Units.SI.TemperatureDifference dT_SUP_Cool_Max = 5
    "max temperature difference of T_SUP for further cooling power";

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
  Dynamic_T_SUP_Control_Cooling dynamic_T_SUP_Control_Cooling(numZones=numZones,
      zoneParam=zoneParam,
    dynamicSetTempControlAHU=dynamicSetTempControlAHU,
    dT_SUP_Cool_Max=dT_SUP_Cool_Max)
    annotation (Placement(transformation(extent={{-20,20},{22,62}})));
  Dynamic_Vflow_Control dynamic_Vflow_SUP_Control(numZones=numZones, zoneParam=
        zoneParam,
    dynamicVolumeFlowControlAHU=dynamicVolumeFlowControlAHU,
    gain_Vflow_Heat_Max=gain_Vflow_Heat_Max,
    gain_Vflow_Cool_Max=gain_Vflow_Cool_Max)
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Modelica.Blocks.Interfaces.RealOutput Vflow_AHU_Set[numZones]
               annotation (Placement(transformation(extent={{-100,-60},{-140,
            -20}}), iconTransformation(extent={{-100,-80},{-140,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a roomHeatPort[numZones]
    annotation (Placement(transformation(extent={{80,-70},{120,-30}}),
        iconTransformation(extent={{80,-70},{120,-30}})));
equation

  connect(dynamic_T_SUP_Control_Cooling.Tset_AHU_Out, Tset_AHU_Set) annotation
    (Line(points={{-24.2,41},{-96,41},{-96,60},{-120,60}}, color={0,0,127}));
  connect(dynamic_Vflow_SUP_Control.Vflow_AHU_set, Vflow_AHU_Set)
    annotation (Line(points={{-24,-40},{-120,-40}}, color={0,0,127}));
  connect(TSetHeat, dynamic_Vflow_SUP_Control.TSetHeat) annotation (Line(points
        ={{30,-120},{30,-74},{8,-74},{8,-64}}, color={0,0,127}));
  connect(TSetCool, dynamic_Vflow_SUP_Control.TSetCool) annotation (Line(points
        ={{-30,-120},{-30,-74},{-8,-74},{-8,-64}}, color={0,0,127}));
  connect(TSetCool, dynamic_T_SUP_Control_Cooling.TSetCool) annotation (Line(
        points={{-30,-120},{-30,-48},{-32,-48},{-32,6},{-7.4,6},{-7.4,15.8}},
        color={0,0,127}));
  connect(AHU_In[1], dynamic_T_SUP_Control_Cooling.Tset_AHU_In) annotation (
      Line(points={{120,42.5},{114,42.5},{114,42},{116,42},{116,53.6},{26.2,53.6}},
        color={0,0,127}));
  connect(AHU_In[4], dynamic_Vflow_SUP_Control.V_flow_AHU_In) annotation (Line(
        points={{120,57.5},{40,57.5},{40,48},{36,48},{36,-28},{24,-28}}, color={
          0,0,127}));
  connect(roomHeatPort, dynamic_T_SUP_Control_Cooling.roomHeatPort) annotation
    (Line(points={{100,-50},{100,-22},{34,-22},{34,41},{22,41}}, color={191,0,0}));
  connect(roomHeatPort, dynamic_Vflow_SUP_Control.roomHeatPort) annotation (
      Line(points={{100,-50},{100,-22},{34,-22},{34,-50},{28,-50},{28,-40},{20,
          -40}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Model that combines dynamic volume flow and air supply temperature control of the air handling unit in <a href=\"AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped\">AixLib.ThermalZones.ReducedOrder.Multizone.MultizoneEquipped</a>.</p>
</html>"));
end Dynamic_AHU_Control;
