within AixLib.Systems.HydraulicModules;
model SimpleConsumer
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(
  final V=Q_flow_nom*5.24444e-06,
  final m_flow_nominal=Q_flow_nom/(Medium.cp_const*dT_nom),
  senMasFlo(allowFlowReversal=allowFlowReversal),
  senTFlow(allowFlowReversal=allowFlowReversal),
  fan(allowFlowReversal=allowFlowReversal),
  volume(allowFlowReversal=allowFlowReversal),
  senTReturn(allowFlowReversal=allowFlowReversal));

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter Modelica.Units.SI.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter Modelica.Units.SI.TemperatureDifference dT_maxNominalReturn = 5 "maximum undercooling/overheating based on nominal return temperature";
  parameter Modelica.Units.SI.HeatCapacity capacity=500 "Capacity of the material";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom= 0 "Nominal heat flow";
  parameter Modelica.Units.SI.TemperatureDifference dT_nom = 20 "nominal temperature difference";




  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true, group = "System"));



  Modelica.Blocks.Interfaces.RealInput TPrescribedSet
    if functionality == "T_input" annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-100}), iconTransformation(
        extent={{-14,-13},{14,13}},
        rotation=0,
        origin={-110,85})));
  Modelica.Blocks.Interfaces.RealInput Q_flowSet
    if functionality == "Q_flow_input"        annotation (Placement(
        transformation(extent={{-122,38},{-94,66}}, rotation=0),
        iconTransformation(extent={{-122,38},{-94,66}})));

  // Pump
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TOutSetSou "Source for set value for outlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Pump", enable = hasPump));
  parameter Modelica.Units.SI.Temperature TOutSetValue
    "Constant set value for outlet temperature"                                               annotation(Dialog(enable=
          TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
           and hasPump,                                     group="Pump"));

  // Feedback
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TInSetSou "Source for set value for inlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Feedback", enable = hasFeedback));
  parameter Modelica.Units.SI.Temperature TInSetValue
    "Constant set value for inlet temperature"                                              annotation(Dialog(enable=TInSetSou
           == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
           and hasFeedback,                                      group="Feedback"));



  Controller.CtrSimpleConsumer ctrSimpleConsumer(
    final demandType=demandType,
    final hasPump=hasPump,
    final hasFeedback=hasFeedback,
    final k_ControlConsumerPump=k_ControlConsumerPump,
    final Ti_ControlConsumerPump=Ti_ControlConsumerPump,
    final k_ControlConsumerValve=k_ControlConsumerValve,
    final Ti_ControlConsumerValve=Ti_ControlConsumerValve,
    final functionality=functionality,
    final kA=kA,
    final T_fixed=T_fixed,
    final capacity=capacity,
    final Q_flow_fixed=Q_flow_fixed,
    final T_start=T_start,
    dT_maxNominalReturn=dT_maxNominalReturn,
    cp_medium=Medium.cp_const)
    annotation (Placement(transformation(extent={{-48,-100},{-8,-60}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(T(start=
          T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={66,-92},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
 if functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={38,-54},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression kA_realExp(y=kA) if functionality == "T_input"
     or functionality == "T_fixed" annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={38,-79})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
 if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={36,-96})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={12,-74})));
  Modelica.Blocks.Interfaces.RealInput TInSet if TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-44})));
  Modelica.Blocks.Interfaces.RealInput TOutSet if TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-62})));
  Modelica.Blocks.Sources.RealExpression TInSetConstant(y=TInSetValue)
 if TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
    "Constant set value if no continous source provided" annotation (Placement(
        transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=0,
        origin={-82.5,-29.5})));
  Modelica.Blocks.Sources.RealExpression TOutSetConstant(y=TOutSetValue)
 if TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
    "Constant set value if no continous source provided" annotation (Placement(
        transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=0,
        origin={-82.5,-39.5})));
  Modelica.Blocks.Interfaces.RealOutput TInMea(unit="K", displayUnit="degC")
    "Measured temperature at consumer inlet"
    annotation (Placement(transformation(extent={{102,-32},{122,-12}})));
  Modelica.Blocks.Interfaces.RealOutput TOutMea(unit="K", displayUnit="degC")
    "Measured temperature at consumer outlet"
    annotation (Placement(transformation(extent={{102,-48},{122,-28}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={66,-46})));
  Modelica.Blocks.Interfaces.RealOutput Q_flowMea
    "Measured heatflow into or from consumer"
    annotation (Placement(transformation(extent={{100,-66},{120,-46}})));
equation

  connect(TInSet, ctrSimpleConsumer.T_Flow) annotation (Line(
      points={{-106,-44},{-60,-44},{-60,-70},{-49.5,-70}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TOutSet, ctrSimpleConsumer.T_Return) annotation (Line(
      points={{-106,-62},{-60,-62},{-60,-75},{-49.5,-75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senTFlow.T, ctrSimpleConsumer.T_Flow_Mea)
    annotation (Line(points={{-52,-11},{-52,-48},{-38,-48},{-38,-58.5}},
                                                      color={0,0,127}));
  connect(ctrSimpleConsumer.y_val, val.y) annotation (Line(points={{-33,-58.5},{
          -33,-50},{-56,-50},{-56,-18},{-80,-18},{-80,-12}},
                                          color={0,0,127}));
  connect(ctrSimpleConsumer.y_pump, fan.y) annotation (Line(points={{-23,-58.5},
          {-23,-18},{8,-18},{8,-12}}, color={0,0,127}));
  connect(ctrSimpleConsumer.T_Return_Mea, senTReturn.T) annotation (Line(points={{-28,
          -58.5},{-28,-50},{-16,-50},{-16,-32},{68,-32},{68,-11}},
                                                     color={0,0,127}));

  if functionality == "T_input" then
  elseif functionality == "Q_flow_input" then
  end if;

  connect(convection.fluid,prescribedTemperature.port)
    annotation (Line(points={{28,-54},{20,-54},{20,-64},{22,-64},{22,-74},{18,-74}},
                                                 color={191,0,0},
      pattern=LinePattern.Dash));
    connect(heatCapacitor.port,convection.solid) annotation (Line(points={{66,-82},
          {66,-54},{48,-54}},            color={191,0,0},
      pattern=LinePattern.Dash));
  connect(kA_realExp.y,convection. Gc)
    annotation (Line(points={{38,-71.3},{38,-64}},
                                              color={0,0,127}));
    connect(prescribedHeatFlow.port,heatCapacitor. port)
    annotation (Line(points={{44,-96},{50,-96},{50,-74},{66,-74},{66,-82}},
                                                         color={191,0,0},
      pattern=LinePattern.Dash));
  connect(ctrSimpleConsumer.Q_flow_vol, prescribedHeatFlow.Q_flow) annotation (
      Line(points={{-6.5,-86.5},{22,-86.5},{22,-96},{28,-96}},color={0,0,127}));
  connect(ctrSimpleConsumer.TFixed_vol, prescribedTemperature.T) annotation (
      Line(points={{-7,-77.5},{0,-77.5},{0,-74},{4.8,-74}},color={0,0,127}));
  connect(TInSetConstant.y, ctrSimpleConsumer.T_Flow) annotation (Line(
      points={{-70.95,-29.5},{-66,-29.5},{-66,-30},{-60,-30},{-60,-70},{-49.5,-70}},
      color={0,0,127},
      pattern=LinePattern.Dash));

  connect(TOutSetConstant.y, ctrSimpleConsumer.T_Return) annotation (Line(
      points={{-70.95,-39.5},{-60,-39.5},{-60,-74},{-49.5,-74},{-49.5,-75}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(senMasFlo.m_flow, ctrSimpleConsumer.m_flow_Mea) annotation (Line(
        points={{-22,11},{-22,16},{-32,16},{-32,-44},{-15.5,-44},{-15.5,-58.5}},
        color={0,0,127}));
  connect(senTFlow.T, TInMea)
    annotation (Line(points={{-52,-11},{-52,-22},{112,-22}}, color={0,0,127}));
  connect(heatCapacitor.port, heatFlowSensor.port_b)
    annotation (Line(points={{66,-82},{66,-56}}, color={191,0,0}));
  connect(volume.heatPort, heatFlowSensor.port_a) annotation (Line(points={{50,-10},
          {54,-10},{54,-24},{66,-24},{66,-36}}, color={191,0,0}));
  connect(senTReturn.T, TOutMea)
    annotation (Line(points={{68,-11},{68,-38},{112,-38}}, color={0,0,127}));
  connect(heatFlowSensor.Q_flow, Q_flowMea) annotation (Line(points={{77,-46},{94,
          -46},{94,-56},{110,-56}}, color={0,0,127}));
  connect(TPrescribedSet, ctrSimpleConsumer.T) annotation (Line(points={{-106,
          -100},{-80,-100},{-80,-85},{-49,-85}}, color={0,0,127}));
  connect(Q_flowSet, ctrSimpleConsumer.Q_flow) annotation (Line(points={{-108,
          52},{-90,52},{-90,-95},{-49,-95}}, color={0,0,127}));
end SimpleConsumer;
