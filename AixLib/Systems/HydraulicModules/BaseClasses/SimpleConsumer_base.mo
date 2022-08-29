within AixLib.Systems.HydraulicModules.BaseClasses;
model SimpleConsumer_base
  extends AixLib.Fluid.Interfaces.PartialTwoPort(redeclare package Medium =
        MediumWater);
  extends AixLib.Fluid.Interfaces.LumpedVolumeDeclarations;

  package MediumWater = AixLib.Media.Water;
  parameter Boolean hasPump=false   "circuit has Pump" annotation (Dialog(group = "Pump"), choices(checkBox = true));
  parameter Boolean hasFeedback = false "circuit has Feedback" annotation (Dialog(group = "Feedback"), choices(checkBox = true));
  parameter Integer demandType   "Choose between heating and cooling functionality" annotation (choices(
              choice=1 "use as heating consumer",
              choice=-1 "use as cooling consumer"),Dialog(enable=true, group = "System"));
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal(min=0.001)
  "Nominal mass flow rate";
  parameter Modelica.Units.SI.Volume V=0.001 "Volume of water";
  parameter Modelica.Units.SI.PressureDifference dp_nominalPumpConsumer=500
    annotation (Dialog(enable = hasPump, group = "Pump"));
  final parameter Modelica.Units.SI.VolumeFlowRate Vflow_nom = m_flow_nominal/rho_default;
  parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Modelica.Units.SI.PressureDifference dpFixed_nominal[2] = {0,0} "Nominal additional pressure drop e.g. for distributor"
    annotation (Dialog(enable = hasFeedback, group="Feedback"));
  parameter Real k_ControlConsumerPump(min=Modelica.Constants.small)=0.5 "Gain of controller"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Modelica.Units.SI.Time Ti_ControlConsumerPump(min=Modelica.Constants.small)=10 "Time constant of Integrator block"
    annotation (Dialog(enable = hasPump, group = "Pump"));
  parameter Real k_ControlConsumerValve(min=Modelica.Constants.small)=0.5
                                                                        "Gain of controller"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));
  parameter Modelica.Units.SI.Time Ti_ControlConsumerValve=10                              "Time constant of Integrator block"
    annotation (Dialog(enable = hasFeedback, group = "Feedback"));

protected
  parameter Medium.ThermodynamicState sta_default=Medium.setState_pTX(
      T=Medium.T_default,
      p=Medium.p_default,
      X=Medium.X_default);
  parameter Modelica.Units.SI.Density rho_default=Medium.density(sta_default)
    "Density, used to compute fluid volume";

public
  Fluid.Movers.SpeedControlled_y fan(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    per(pressure(V_flow={0,Vflow_nom,Vflow_nom/0.7}, dp={dp_nominalPumpConsumer/0.7,dp_nominalPumpConsumer,0})),
    addPowerToMedium=false) if hasPump       annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={4,-1.77636e-15})));
  Fluid.MixingVolumes.MixingVolume volume(
    redeclare package Medium = Medium,
    final V=V,
    final m_flow_nominal=m_flow_nominal,
    nPorts=3)                                                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={40,-10})));
  Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear val(
    redeclare package Medium = Medium,
    from_dp=false,
    y_start=0.5,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dp_Valve,
    dpFixed_nominal=dpFixed_nominal) if hasFeedback
    annotation (Placement(transformation(extent={{-90,10},{-70,-10}})));
  Fluid.Sensors.TemperatureTwoPort senTFlow(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=0,
        origin={-52,0})));
  Fluid.Sensors.TemperatureTwoPort senTReturn(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={68,0})));
  Fluid.Sensors.MassFlowRate senMasFlo(
    redeclare package Medium = Medium,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));

  Modelica.Blocks.Interfaces.RealInput T_Flow
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-40})));
  Modelica.Blocks.Interfaces.RealInput T_Return
    annotation (Placement(
        transformation(
        extent={{-14,-14},{14,14}},
        rotation=0,
        origin={-106,-60})));
equation

  if hasPump then
    connect(fan.port_b, volume.ports[1])
      annotation (Line(points={{14,0},{41.3333,0}}, color={0,127,255}));
    connect(senMasFlo.port_b, fan.port_a)
      annotation (Line(points={{-12,0},{-6,0}}, color={0,127,255}));
  else
    connect(senMasFlo.port_b, volume.ports[1]);
  end if;

  if hasFeedback then
    connect(port_a, val.port_1)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(volume.ports[2], val.port_3) annotation (Line(points={{40,0},{40,20},
            {-80,20},{-80,10}}, color={0,127,255}));
    connect(val.port_2, senTFlow.port_a)
      annotation (Line(points={{-70,0},{-62,0}}, color={0,127,255}));
  else
    connect(port_a, senTFlow.port_a);
  end if;

  connect(volume.ports[3], senTReturn.port_a) annotation (Line(points={{38.6667,
          0},{43.6667,0},{43.6667,1.77636e-15},{58,1.77636e-15}}, color={0,127,255}));
  connect(senTReturn.port_b, port_b) annotation (Line(points={{78,-8.88178e-16},
          {89,-8.88178e-16},{89,0},{100,0}}, color={0,127,255}));
  connect(senTFlow.port_b, senMasFlo.port_a)
    annotation (Line(points={{-42,0},{-32,0}}, color={0,127,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{20,-124},{60,-139},{20,-154},{20,-124}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=not allowFlowReversal),
        Line(
          points={{55,-139},{-60,-139}},
          color={0,128,255},
          visible=not allowFlowReversal),
                   Ellipse(
          extent={{-80,80},{80,-80}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),Text(
          extent={{-56,18},{56,-18}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="CONSUMER")}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer_base;
