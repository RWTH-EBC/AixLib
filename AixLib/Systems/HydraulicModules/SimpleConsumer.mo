within AixLib.Systems.HydraulicModules;
model SimpleConsumer
  extends AixLib.Systems.HydraulicModules.BaseClasses.SimpleConsumer_base;

  parameter Real kA(unit="W/K")=1 "Heat transfer coefficient times area [W/K]" annotation (Dialog(enable = functionality=="T_fixed" or functionality=="T_input"));
  parameter Modelica.SIunits.Temperature T_fixed=293.15  "Ambient temperature for convection" annotation (Dialog(enable = functionality=="T_fixed"));
  parameter Modelica.SIunits.TemperatureDifference dT_maxNominalReturn = 5 "maximum undercooling/overheating based on nominal return temperature";
  parameter Modelica.SIunits.HeatCapacity capacity=1 "Capacity of the material";
  parameter Modelica.SIunits.HeatFlowRate Q_flow_fixed = 0 "Prescribed heat flow" annotation (Dialog(enable = functionality=="Q_flow_fixed"));

  parameter String functionality "Choose between different functionalities" annotation (choices(
              choice="T_fixed",
              choice="T_input",
              choice="Q_flow_fixed",
              choice="Q_flow_input"),Dialog(enable=true, group = "System"));

  Modelica.SIunits.HeatFlowRate Q_flow_max;

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(
                          T(start=T_start, fixed=true), C=capacity)
    annotation (Placement(transformation(
        origin={44,40},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection if
    functionality == "T_input" or functionality == "T_fixed"
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
  Modelica.Blocks.Sources.RealExpression kA_realExp(y=kA) if functionality == "T_input"
     or functionality == "T_fixed" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-18,70})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed) if
    functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,80})));
  Modelica.Blocks.Interfaces.RealInput T if functionality == "T_input"
                                         annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={60,120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={80,100})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow if
    functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-6,40})));
  Modelica.Blocks.Sources.RealExpression Q_realExp(y=Q_flow_fixed) if
    functionality == "Q_flow_fixed" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,76})));
  Modelica.Blocks.Interfaces.RealInput Q_flow if functionality == "Q_flow_input"
                                              annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,120}), iconTransformation(extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,100})));
  Modelica.Blocks.Math.Gain gain1(k=-demandType) if functionality == "Q_flow_input"
     or functionality == "Q_flow_fixed"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-28,56})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter if functionality == "Q_flow_input"
    annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_max(y=Q_flow_max) if functionality == "Q_flow_input"
    annotation (Placement(transformation(extent={{-98,54},{-78,74}})));
  Modelica.Blocks.Sources.RealExpression Exp_Q_flow_min(y=0) if functionality == "Q_flow_input"
    annotation (Placement(transformation(extent={{-98,38},{-78,58}})));
equation
  if demandType==1 then
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (senTFlow.T - (T_return - dT_maxNominalReturn)));
  else
    Q_flow_max = max(0, senMasFlo.m_flow * Medium.cp_const * (T_return + dT_maxNominalReturn - senTFlow.T));
  end if;

  // T functionality
  if functionality == "T_input" then
    connect(prescribedTemperature.T, T)
    annotation (Line(points={{52,80},{60,80},{60,120}}, color={0,0,127},
      pattern=LinePattern.Dash));
  elseif functionality == "T_fixed" then
    connect(realExpression1.y, prescribedTemperature.T)
    annotation (Line(points={{69,80},{52,80}},         color={0,0,127},
      pattern=LinePattern.Dash));
  end if;
  connect(convection.fluid,prescribedTemperature.port)
    annotation (Line(points={{10,80},{30,80}},   color={191,0,0},
      pattern=LinePattern.Dash));
  if functionality == "T_input" or functionality == "T_fixed" then
    connect(heatCapacitor.port,convection.solid) annotation (Line(points={{34,40},
            {10,40},{10,60}},            color={191,0,0}));
  end if;
  connect(kA_realExp.y, convection.Gc)
    annotation (Line(points={{-7,70},{0,70}}, color={0,0,127}));
  // Q functionality
  if functionality == "Q_flow_input" or functionality == "Q_flow_fixed" then
    connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{4,40},{34,40}},            color={191,0,0},
      pattern=LinePattern.Dash));
  end if;
  connect(gain1.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-21.4,56},{-22,56},{-22,40},{-16,40}},
                                                   color={0,0,127}));
  connect(Q_realExp.y, gain1.u) annotation (Line(points={{-41,76},{-40,76},{-40,
          56},{-35.2,56}}, color={0,0,127}, pattern=LinePattern.Dash));
  connect(variableLimiter.y, gain1.u) annotation (Line(points={{-43,56},{-35.2,
          56}},                                                                        color={0,0,127}, pattern=LinePattern.Dash));
  connect(Q_flow, variableLimiter.u) annotation (Line(points={{-60,120},{-60,96},
          {-70,96},{-70,56},{-66,56}},  color={0,0,127}));
  connect(Exp_Q_flow_max.y, variableLimiter.limit1)
    annotation (Line(points={{-77,64},{-66,64}}, color={0,0,127}));
  connect(Exp_Q_flow_min.y, variableLimiter.limit2)
    annotation (Line(points={{-77,48},{-66,48}}, color={0,0,127}));
  // Hydraulics

  connect(heatCapacitor.port, volume.heatPort) annotation (Line(points={{34,40},
          {28,40},{28,30},{50,30},{50,10},{42,10}}, color={191,0,0}));
end SimpleConsumer;
