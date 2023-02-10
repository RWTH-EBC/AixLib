within AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.BaseClasses;
partial model ModularConsumer_base

  package MediumWater = AixLib.Media.Water;
  // Consumer Design
  parameter Integer n_consumers=1 "Number of consumers" annotation (Dialog(group = "Consumer Design"));
  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(group = "Consumer Design"));
  parameter Integer demandType[n_consumers]  "Array for each consumer: 1: Heating; -1: Cooling" annotation (Dialog(group = "Consumer Design"));
  parameter Modelica.Units.SI.HeatCapacity capacity[n_consumers]   "Array for each consumer: Capacity of the material" annotation(Dialog(group="Consumer Design"));

  // Nominal conditions
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_fixed[n_consumers] "Prescribed heat flow" annotation(Dialog(enable=functionality=="Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
  parameter Modelica.Units.SI.Temperature T_fixed[n_consumers] "Prescribed temperature" annotation(Dialog(enable=functionality=="T_fixed",group="Nominal conditions (Array - each consumer)"));
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom[n_consumers] "Nominal heat flow" annotation(Dialog(enable=functionality<>"Q_flow_fixed", group="Nominal conditions (Array - each consumer)"));
  parameter Modelica.Units.SI.TemperatureDifference dT_nom[n_consumers]  "nominal temperature difference" annotation(Dialog(group="Nominal conditions (Array - each consumer)"));

  // Feedback
  parameter Boolean hasFeedback[n_consumers]  "if circuit has feedback for temperature control" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TInSetSou                                                                                                                                         "Source for set value for inlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
  parameter Modelica.Units.SI.Temperature TInSet[n_consumers] "Constant set value for inlet temperature" annotation(Dialog(enable=TInSetSou == AixLib.Systems.ModularEnergySystems.Modules.
      ModularConsumer.Types.InputType.Constant, group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
  parameter Real k_ControlConsumerValve[n_consumers] "Gain of controller" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
  parameter Modelica.Units.SI.Time Ti_ControlConsumerValve[n_consumers]
    "Time constant of Integrator block" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));
  parameter Modelica.Units.SI.PressureDifference dp_Valve[n_consumers]
    "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation(Dialog(group="Flow Temperature Control (Mixture Valve) (Array - each consumer)"));

  // Pump
  parameter Boolean hasPump[n_consumers] "circuit has Pump" annotation(Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));
  parameter AixLib.Systems.ModularEnergySystems.Modules.ModularConsumer.Types.InputType TOutSetSou "Source for set value for outlet temperature" annotation (Evaluate=true, HideResult=true, Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));
  parameter Modelica.Units.SI.Temperature TOutSet[n_consumers] "Constant set value for outlet temperature" annotation(Dialog(enable=TOutSetSou == AixLib.Systems.ModularEnergySystems.Modules.
      ModularConsumer.Types.InputType.Constant, group="Return Temperature Control (Pump) (Array - each consumer)"));
  parameter Real k_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Gain of controller"
    annotation (Dialog(group = "Return Temperature Control (Pump) (Array - each consumer)"));
  parameter Modelica.Units.SI.Time Ti_ControlConsumerPump[n_consumers](min=Modelica.Constants.small) "Time constant of Integrator block"
    annotation (Dialog(group = "Return Temperature Control (Pump) (Array - each consumer)"));
  parameter Modelica.Units.SI.PressureDifference dp_nominalConPump[n_consumers]
    "Pressure increase of pump at nominal conditions for the individual consumers" annotation(Dialog(group="Return Temperature Control (Pump) (Array - each consumer)"));

  AixLib.Systems.HydraulicModules.SimpleConsumer simpleConsumer[n_consumers](
    final dp_Valve=dp_Valve,
    each final dpFixed_nominal={0,0},
    k_ControlConsumerPump=k_ControlConsumerPump,
    Ti_ControlConsumerPump=Ti_ControlConsumerPump,
    final k_ControlConsumerValve=k_ControlConsumerValve,
    final Ti_ControlConsumerValve=Ti_ControlConsumerValve,
    each TInSetSou=TInSetSou,
    TInSetValue=TInSet,
    each TOutSetSou=TOutSetSou,
    TOutSetValue=TOutSet,
    redeclare each final package Medium = MediumWater,
    each final functionality=functionality,
    final demandType=demandType,
    final hasPump=hasPump,
    final hasFeedback=hasFeedback,
    final dp_nominalPumpConsumer=dp_nominalConPump,
    final Q_flow_fixed=Q_flow_fixed,
    final T_fixed=T_fixed,
    final capacity=capacity,
    final Q_flow_nom=Q_flow_nom_inner,
    final dT_nom=dT_nom)
    annotation (Placement(transformation(extent={{-20,-88},{18,-50}})));

protected
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nom_inner[n_consumers] = if functionality=="Q_flow_fixed" then Q_flow_fixed else Q_flow_nom "inner parameter to not ask for Q_flow_nom if a fixed heatflow is used";
equation

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end ModularConsumer_base;
