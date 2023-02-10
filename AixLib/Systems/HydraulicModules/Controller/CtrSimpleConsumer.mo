within AixLib.Systems.HydraulicModules.Controller;
model CtrSimpleConsumer
  extends AixLib.Systems.HydraulicModules.Controller.CtrSimpleConsumer_base(
      PIPump(yMax=0.99));

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
  parameter Modelica.Units.SI.TemperatureDifference dT_maxNominalReturn = 5 "Maximum undercooling/overheating based on nominal return temperature";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_medium "Specific heat capacity of medium";

  Modelica.Units.SI.HeatFlowRate Q_flow_max "maximum heatflow to get from consumer to not violate dT_maxNominalReturn condition";
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

  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_fixed)
 if functionality == "T_fixed"                                annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-44,0})));
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
  Modelica.Blocks.Interfaces.RealOutput TFixed_vol(unit="K")
    if functionality == "T_fixed" or functionality == "T_input"
    "Fixed temperature for volume"
    annotation (Placement(transformation(extent={{74,0},{94,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_vol(unit="W")
    if functionality == "Q_flow_input" or functionality == "Q_flow_fixed"
    "Prescribed heatflow for volume"
    annotation (Placement(transformation(extent={{76,-36},{96,-16}})));
  Modelica.Blocks.Sources.RealExpression Q_flow_max_exp(y=Q_flow_max)
    if functionality == "Q_flow_input"
                                    annotation (Placement(transformation(
        extent={{-10.5,-6.5},{10.5,6.5}},
        rotation=0,
        origin={-60.5,-33.5})));
  Modelica.Blocks.Interfaces.RealInput m_flow_Mea "Measured massflow"
    annotation (Placement(transformation(
        extent={{12,12},{-12,-12}},
        rotation=90,
        origin={50,86})));
equation
  if functionality == "T_input" then
  elseif functionality == "T_fixed" then
  end if;
  if functionality == "T_input" or functionality == "T_fixed" then
  end if;
  // Q functionality
  if functionality == "Q_flow_input" or functionality == "Q_flow_fixed" then
  end if;
  if demandType==1 then
      Q_flow_max = max(0, m_flow_Mea* cp_medium * (T_Flow_Mea - (T_Return - dT_maxNominalReturn)));
  else
      Q_flow_max = max(0, m_flow_Mea* cp_medium * (T_Return + dT_maxNominalReturn - T_Flow_Mea));
  end if;

  connect(Q_realExp.y,gain1. u) annotation (Line(points={{-33,-20},{4,-20},{4,-40},
          {7.2,-40}},      color={0,0,127}, pattern=LinePattern.Dash));
  connect(variableLimiter.y,gain1. u) annotation (Line(points={{1,-40},{7.2,-40}},     color={0,0,127}, pattern=LinePattern.Dash));
  connect(Exp_Q_flow_min.y,variableLimiter. limit2)
    annotation (Line(points={{-33,-48},{-22,-48}},
                                                 color={0,0,127}));
  connect(Q_flow, variableLimiter.u)
    annotation (Line(points={{-84,-60},{-60,-60},{-60,-40},{-22,-40}},
                                                   color={0,0,127}));
  connect(realExpression1.y, TFixed_vol) annotation (Line(points={{-33,0},{64,0},
          {64,10},{84,10}}, color={0,0,127}));
  connect(T, TFixed_vol) annotation (Line(points={{-84,-20},{-58,-20},{-58,12},
          {-50,12},{-50,14},{-8,14},{-8,10},{84,10}}, color={0,0,127}));
  connect(gain1.y, Q_flow_vol) annotation (Line(points={{16.4,-40},{70,-40},{70,
          -26},{86,-26}}, color={0,0,127}));
  connect(Q_flow_max_exp.y, variableLimiter.limit1) annotation (Line(points={{-48.95,
          -33.5},{-48.95,-32},{-22,-32}}, color={0,0,127}));
    annotation (Placement(transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-84,-40})),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
                            Text(
          extent={{-100,26},{100,-18}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CtrSimpleConsumer;
