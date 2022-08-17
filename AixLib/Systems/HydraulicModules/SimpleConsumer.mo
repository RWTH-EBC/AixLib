within AixLib.Systems.HydraulicModules;
model SimpleConsumer "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import    Modelica.Units.SI;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter Modelica.SIunits.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter Modelica.SIunits.TemperatureDifference dT_maxNominalReturn = 5 "maximum undercooling/overheating based on nominal return temperature";
  parameter Modelica.SIunits.HeatCapacity capacity=500 "Capacity of the material";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nom= 0 "Nominal heat flow";
  parameter Modelica.SIunits.TemperatureDifference dT_nom = 20 "nominal temperature difference";


  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true, group = "System"));

  Fluid.MixingVolumes.MixingVolume volume(
    final V=V,
    final T_start=T_start,
    final allowFlowReversal=allowFlowReversal,
    final m_flow_nominal=m_flow_nominal,
    redeclare package Medium = Medium,
    nPorts=2)                          annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={0,10})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={44,40},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
 if functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={10,70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,80})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=kA) if functionality == "T_input"
     or functionality == "T_fixed"                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,78})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed)
 if functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,80})));
  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-100}),
                          iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
 if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-62,58})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=Q_flow_fixed)
 if functionality == "Q_flow_fixed"                           annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,80})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-80}),iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));

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
    final T_start=T_start)
    annotation (Placement(transformation(extent={{-60,-80},{-20,-40}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_max_exp(y=Q_flow_max) if
    functionality == "Q_flow_input" annotation (Placement(transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=90,
        origin={-82.5,-81.5})));
equation
  if demandType==1 then
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (senTFlow.T - (T_Return - dT_maxNominalReturn)));
  else
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (T_Return + dT_maxNominalReturn - senTFlow.T));
  end if;

  connect(T_Flow, ctrSimpleConsumer.T_Flow) annotation (Line(points={{-106,-40},
          {-80,-40},{-80,-50},{-61.5,-50}},     color={0,0,127}));
  connect(T_Return, ctrSimpleConsumer.T_Return) annotation (Line(points={{-106,-60},
          {-80,-60},{-80,-55},{-61.5,-55}},     color={0,0,127}));
  connect(senTFlow.T, ctrSimpleConsumer.T_Flow_Mea)
    annotation (Line(points={{-52,-11},{-52,-22},{-50,-22},{-50,-38.5}},
                                                      color={0,0,127}));
  connect(ctrSimpleConsumer.y_val, val.y) annotation (Line(points={{-45,-38.5},{
          -45,-20},{-80,-20},{-80,-12}},  color={0,0,127}));
  connect(ctrSimpleConsumer.y_pump, fan.y) annotation (Line(points={{-35,-38.5},
          {-35,-20},{4,-20},{4,-12}}, color={0,0,127}));
  connect(ctrSimpleConsumer.T_Return_Mea, senTReturn.T) annotation (Line(points={{-40,
          -38.5},{-40,-28},{68,-28},{68,-11}},       color={0,0,127}));

  if functionality == "T_input" then
    connect(T, ctrSimpleConsumer.Q_flow) annotation (Line(points={{-106,-100},{-64,
            -100},{-64,-76},{-62,-76},{-62,-75},{-61,-75}},
                                        color={0,0,127}));
  elseif functionality == "Q_flow_input" then
    connect(Q_flow, ctrSimpleConsumer.T) annotation (Line(points={{-106,-80},{-92,
            -80},{-92,-65},{-61,-65}}, color={0,0,127}));
    connect(Q_flow_max_exp.y, ctrSimpleConsumer.Q_flow_max) annotation (Line(
        points={{-82.5,-69.95},{-72,-69.95},{-72,-70},{-61,-70}}, color={0,0,127}));
  end if;

  connect(ctrSimpleConsumer.port_a, volume.heatPort)
    annotation (Line(points={{-20,-60},{50,-60},{50,-10}}, color={191,0,0}));
end SimpleConsumer;
