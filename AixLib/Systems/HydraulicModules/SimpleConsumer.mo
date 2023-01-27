within AixLib.Systems.HydraulicModules;
model SimpleConsumer
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base(
  final V=Q_flow_nom*5.24444e-06,
  final m_flow_nominal=Q_flow_nom/(Medium.cp_const*dT_nom));

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



  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-100}),
                          iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,100})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-80}),iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));

  // Pump
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TOutSetSou "Source for set value for outlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Pump", enable = hasPump));
  parameter Modelica.Units.SI.Temperature TOutSet "Constant set value for outlet temperature" annotation(Dialog(enable=TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.
      ModularConsumer.Types.InputType.Constant and hasPump, group="Pump"));

  // Feedback
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TInSetSou "Source for set value for inlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Feedback", enable = hasFeedback));
  parameter Modelica.Units.SI.Temperature TInSet "Constant set value for inlet temperature" annotation(Dialog(enable=TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.
      ModularConsumer.Types.InputType.Constant  and hasFeedback, group="Feedback"));



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
        origin={74,-58},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
 if functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={48,-48},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Blocks.Sources.RealExpression kA_realExp(y=kA) if functionality == "T_input"
     or functionality == "T_fixed" annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={48,-71})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
 if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={46,-88})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={14,-48})));
  Modelica.Blocks.Interfaces.RealInput T_Flow if TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-44})));
  Modelica.Blocks.Interfaces.RealInput T_Return if TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Continuous
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-62})));
  Modelica.Blocks.Sources.RealExpression TInSetConstant(y=TInSet) if TInSetSou ==
    AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
    "Constant set value if no continous source provided" annotation (Placement(
        transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=0,
        origin={-82.5,-29.5})));
  Modelica.Blocks.Sources.RealExpression TOutSetConstant(y=TOutSet)
 if TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType.Constant
    "Constant set value if no continous source provided" annotation (Placement(
        transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=0,
        origin={-82.5,-39.5})));
equation

  connect(T_Flow, ctrSimpleConsumer.T_Flow) annotation (Line(points={{-106,-44},
          {-60,-44},{-60,-70},{-49.5,-70}},     color={0,0,127},
      pattern=LinePattern.Dash));
  connect(T_Return, ctrSimpleConsumer.T_Return) annotation (Line(points={{-106,-62},
          {-60,-62},{-60,-75},{-49.5,-75}},     color={0,0,127},
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
    connect(T, ctrSimpleConsumer.Q_flow) annotation (Line(points={{-106,-100},{-64,
            -100},{-64,-76},{-62,-76},{-62,-95},{-49,-95}},
                                        color={0,0,127}));
  elseif functionality == "Q_flow_input" then
    connect(Q_flow, ctrSimpleConsumer.T) annotation (Line(points={{-106,-80},{-56,
            -80},{-56,-85},{-49,-85}}, color={0,0,127}));
  end if;

  connect(convection.fluid,prescribedTemperature.port)
    annotation (Line(points={{38,-48},{20,-48}}, color={191,0,0},
      pattern=LinePattern.Dash));
    connect(heatCapacitor.port,convection.solid) annotation (Line(points={{74,-48},
          {58,-48}},                     color={191,0,0}));
  connect(kA_realExp.y,convection. Gc)
    annotation (Line(points={{48,-63.3},{48,-58}},
                                              color={0,0,127}));
    connect(prescribedHeatFlow.port,heatCapacitor. port)
    annotation (Line(points={{54,-88},{62,-88},{62,-48},{74,-48}},
                                                         color={191,0,0},
      pattern=LinePattern.Dash));
  connect(ctrSimpleConsumer.Q_flow_vol, prescribedHeatFlow.Q_flow) annotation (
      Line(points={{-6.5,-86.5},{-2,-86.5},{-2,-88},{38,-88}},color={0,0,127}));
  connect(ctrSimpleConsumer.TFixed_vol, prescribedTemperature.T) annotation (
      Line(points={{-7,-77.5},{-7,-76},{18,-76},{18,-58},{6.8,-58},{6.8,-48}},
                                                           color={0,0,127}));
  connect(heatCapacitor.port, volume.heatPort) annotation (Line(points={{74,-48},
          {74,-28},{54,-28},{54,-10},{50,-10}},
                                       color={191,0,0}));
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
end SimpleConsumer;
