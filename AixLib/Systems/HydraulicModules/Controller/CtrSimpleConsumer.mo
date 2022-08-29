within AixLib.Systems.HydraulicModules.Controller;
model CtrSimpleConsumer
  extends AixLib.Systems.HydraulicModules.Controller.CtrSimpleConsumer_base;

  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true, group = "System"));
  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter Modelica.Units.SI.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter Modelica.Units.SI.HeatCapacity capacity=1 "Capacity of the material";
  parameter Modelica.Units.SI.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));
  parameter Modelica.Units.SI.Temperature T_start=293.15  "Ambient temperature for convection";


  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-84,-20}), iconTransformation(extent={{-14,-14},{14,14}},
          origin={-84,-20})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-84,-60}), iconTransformation(extent={{-14,-14},{14,14}},
          origin={-84,-60})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(T(start=
          T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={60,-10},
        extent={{-10,10},{10,-10}},
        rotation=0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
 if functionality == "T_input" or functionality == "T_fixed"
    annotation (Placement(transformation(
        origin={34,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature if functionality == "T_input" or functionality == "T_fixed"
                          annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={0,0})));
  Modelica.Blocks.Sources.RealExpression kA_realExp(y=kA) if functionality == "T_input"
     or functionality == "T_fixed" annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=90,
        origin={34,-23})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed)
 if functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,0})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
 if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=0,
        origin={32,-40})));
  Modelica.Blocks.Sources.RealExpression Q_realExp(y=Q_flow_fixed)
 if functionality == "Q_flow_fixed" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,-20})));
  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=0,
        origin={12,-40})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter if functionality == "Q_flow_input"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_min(y=0) if functionality == "Q_flow_input"
    annotation (Placement(transformation(extent={{-54,-58},{-34,-38}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealInput Q_flow_max
                                              if functionality == "Q_flow_input"
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-84,-40})));
equation
  if functionality == "T_input" then
    connect(prescribedTemperature.T, T)
    annotation (Line(points={{-7.2,0},{-10,0},{-10,-8},{-70,-8},{-70,-20},{-84,-20}},
                                                        color={0,0,127},
      pattern=LinePattern.Dash));
  elseif functionality == "T_fixed" then
    connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{-33,0},{-7.2,0}},        color={0,0,127},
      pattern=LinePattern.Dash));
  end if;
  connect(convection.fluid,prescribedTemperature.port)
    annotation (Line(points={{24,0},{6,0}},      color={191,0,0},
      pattern=LinePattern.Dash));
  if functionality == "T_input" or functionality == "T_fixed" then
    connect(heatCapacitor.port,convection.solid) annotation (Line(points={{60,0},{
            44,0}},                      color={191,0,0}));
  end if;
  connect(kA_realExp.y, convection.Gc)
    annotation (Line(points={{34,-15.3},{34,-10}},
                                              color={0,0,127}));
  // Q functionality
  if functionality == "Q_flow_input" or functionality == "Q_flow_fixed" then
    connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{40,-40},{48,-40},{48,0},{60,0}},
                                                         color={191,0,0},
      pattern=LinePattern.Dash));
  end if;

  connect(gain1.y,prescribedHeatFlow. Q_flow)
    annotation (Line(points={{16.4,-40},{24,-40}}, color={0,0,127}));
  connect(Q_realExp.y,gain1. u) annotation (Line(points={{-33,-20},{4,-20},{4,-40},
          {7.2,-40}},      color={0,0,127}, pattern=LinePattern.Dash));
  connect(variableLimiter.y,gain1. u) annotation (Line(points={{1,-40},{7.2,-40}},     color={0,0,127}, pattern=LinePattern.Dash));
  connect(Exp_Q_flow_min.y,variableLimiter. limit2)
    annotation (Line(points={{-33,-48},{-22,-48}},
                                                 color={0,0,127}));
  connect(Q_flow, variableLimiter.u)
    annotation (Line(points={{-84,-60},{-60,-60},{-60,-40},{-22,-40}},
                                                   color={0,0,127}));
  connect(heatCapacitor.port, port_a)
    annotation (Line(points={{60,0},{80,0}}, color={191,0,0}));
  connect(Q_flow_max, variableLimiter.limit1) annotation (Line(points={{-84,-40},
          {-66,-40},{-66,-32},{-22,-32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrSimpleConsumer;
