within AixLib.Systems.ModularAHU;
model GenericAHU
  "Generic air-handling unit with heat recovery system"
  replaceable package MediumAir =
    Modelica.Media.Interfaces.PartialMedium "Medium in air canal in the component"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15,
          X_a=0.40)
          "Propylene glycol water, 40% mass fraction")));
  replaceable package MediumWater =
    Modelica.Media.Interfaces.PartialMedium "Medium in hydraulic circuits"
      annotation (choices(
        choice(redeclare package Medium = AixLib.Media.Air "Moist air"),
        choice(redeclare package Medium = AixLib.Media.Water "Water"),
        choice(redeclare package Medium =
            AixLib.Media.Antifreeze.PropyleneGlycolWater (
          property_T=293.15,
          X_a=0.40)
          "Propylene glycol water, 40% mass fraction")));

  parameter Boolean allowFlowReversal = true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for all mediums"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.Time tau=15
    "Time Constant for PT1 behavior of temperature sensors" annotation(Dialog(tab="Advanced"));
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));


  parameter  Modelica.SIunits.Temperature T_amb "Ambient temperature";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_air(min=0)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal_water(min=0)
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=303.15
    "Initialization temperature" annotation(Dialog(tab="Advanced"));

  parameter Boolean usePreheater = true "If true, a preaheater is included";

  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-230,-10},{-210,10}}),
        iconTransformation(extent={{-230,-10},{-210,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{230,-10},{210,10}}),
        iconTransformation(extent={{232,-10},{212,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{210,70},{230,90}}),
        iconTransformation(extent={{212,70},{232,90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-210,70},{-230,90}}),
        iconTransformation(extent={{-210,70},{-230,90}})));
  RegisterModule perheater if usePreheater
    annotation (Placement(transformation(extent={{-160,-46},{-116,14}})));
  RegisterModule cooler
    annotation (Placement(transformation(extent={{2,-46},{46,14}})));
  RegisterModule heater
    annotation (Placement(transformation(extent={{80,-46},{124,14}})));
  Fluid.HeatExchangers.DynamicHX dynamicHX
    annotation (Placement(transformation(extent={{-20,-10},{-62,42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        MediumWater) if usePreheater
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-170,-110},{-150,-90}}),
        iconTransformation(extent={{-170,-110},{-150,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        MediumWater) if usePreheater
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-130,-110},{-110,-90}}),
        iconTransformation(extent={{-130,-110},{-110,-90}})));
  Fluid.Actuators.Dampers.Exponential dam
    annotation (Placement(transformation(extent={{-200,-10},{-180,10}})));
  Fluid.Actuators.Dampers.Exponential dam1
    annotation (Placement(transformation(extent={{160,70},{140,90}})));
  Fluid.Actuators.Dampers.Exponential dampHX
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Fluid.Actuators.Dampers.Exponential dampByPass
    annotation (Placement(transformation(extent={{-80,-10},{-60,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-96,-54},{-88,-46}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-82,-52},{-72,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a5
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{70,-110},{90,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b5
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{110,-110},{130,-90}}),
        iconTransformation(extent={{108,-110},{128,-90}})));
  Fluid.Movers.FlowControlled_dp fan
    annotation (Placement(transformation(extent={{180,-10},{200,10}})));
  Fluid.Movers.FlowControlled_dp fan1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={110,80})));
  Fluid.Humidifiers.GenericHumidifier_u
                                 humidifier(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Fluid.Humidifiers.GenericHumidifier_u
                                 humidifier1(redeclare package Medium =
        MediumAir, steamHumidifier=false)
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
equation
  connect(perheater.port_a2, port_a3) annotation (Line(points={{-160,-27.5385},
          {-164,-27.5385},{-164,-100},{-160,-100}},color={0,127,255}));
  connect(perheater.port_b2, port_b3) annotation (Line(points={{-116,-27.5385},
          {-112,-27.5385},{-112,-100},{-120,-100}},
                                             color={0,127,255}));
  connect(const.y, add.u2)
    annotation (Line(points={{-87.6,-50},{-83,-50}}, color={0,0,127}));
  connect(add.y, dampByPass.y) annotation (Line(points={{-71.5,-47},{-71.5,
          -46.5},{-70,-46.5},{-70,-32}},
                                  color={0,0,127}));
  connect(add.u1, dampHX.y)
    annotation (Line(points={{-83,-44},{-90,-44},{-90,12}}, color={0,0,127}));
  connect(dampHX.port_b, dynamicHX.port_a2) annotation (Line(points={{-80,0},{
          -64,0},{-64,0.4},{-62,0.4}},
                                   color={0,127,255}));
  connect(perheater.port_b1, dampHX.port_a) annotation (Line(points={{-116,
          0.153846},{-112,0.153846},{-112,0},{-100,0}},
                                           color={0,127,255}));
  connect(dam.port_b, perheater.port_a1) annotation (Line(points={{-180,0},{
          -164,0},{-164,0.153846},{-160,0.153846}},
                                               color={0,127,255}));
  connect(port_a1, dam.port_a)
    annotation (Line(points={{-220,0},{-200,0}}, color={0,127,255}));
  connect(cooler.port_b1, heater.port_a1)
    annotation (Line(points={{46,0.153846},{80,0.153846}}, color={0,127,255}));
  connect(dampHX.port_a, dampByPass.port_a)
    annotation (Line(points={{-100,0},{-100,-20},{-80,-20}},
                                                           color={0,127,255}));
  connect(dampByPass.port_b, dynamicHX.port_b2) annotation (Line(points={{-60,-20},
          {-20,-20},{-20,0.4}}, color={0,127,255}));
  connect(cooler.port_a2, port_a4) annotation (Line(points={{2,-27.5385},{-4,
          -27.5385},{-4,-100},{0,-100}},
                               color={0,127,255}));
  connect(cooler.port_b2, port_b4) annotation (Line(points={{46,-27.5385},{46,
          -28},{48,-28},{48,-100},{40,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2, port_a5) annotation (Line(points={{80,-27.5385},{78,
          -27.5385},{78,-28},{74,-28},{74,-100},{80,-100}},
                                                  color={0,127,255}));
  connect(heater.port_b2, port_b5) annotation (Line(points={{124,-27.5385},{128,
          -27.5385},{128,-28},{132,-28},{132,-100},{120,-100}}, color={0,127,255}));
  connect(fan1.port_a, dam1.port_b)
    annotation (Line(points={{120,80},{140,80}},color={0,127,255}));
  connect(dynamicHX.port_b1, port_b2) annotation (Line(points={{-62,31.6},{-84,
          31.6},{-84,80},{-220,80}},
                               color={0,127,255}));
  connect(dam1.port_a, port_a2)
    annotation (Line(points={{160,80},{220,80}}, color={0,127,255}));
  connect(dynamicHX.port_b2, cooler.port_a1) annotation (Line(points={{-20,0.4},
          {-8,0.4},{-8,0.153846},{2,0.153846}}, color={0,127,255}));
  connect(heater.port_b1, humidifier.port_a) annotation (Line(points={{124,0.153846},
          {130,0.153846},{130,0},{140,0}}, color={0,127,255}));
  connect(humidifier.port_b, fan.port_a)
    annotation (Line(points={{160,0},{180,0}}, color={0,127,255}));
  if usePreheater==false then
    connect(dam.port_b, dampHX.port_a) annotation (Line(points={{-180,0},{-170,
            0},{-170,28},{-100,28},{-100,0}},
                                       color={0,127,255}));
  end if;
  connect(fan1.port_b, humidifier1.port_a)
    annotation (Line(points={{100,80},{60,80}}, color={0,127,255}));
  connect(humidifier1.port_b, dynamicHX.port_a1) annotation (Line(points={{40,80},
          {24,80},{24,31.6},{-20,31.6}},     color={0,127,255}));
  connect(fan.port_b, port_b1)
    annotation (Line(points={{200,0},{220,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
            -100},{220,100}}), graphics={
        Rectangle(extent={{-164,38},{-116,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{-4,38},{44,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{74,38},{122,-40}}, lineColor={0,0,0}),
        Rectangle(extent={{-90,100},{-30,-40}}, lineColor={0,0,0}),
        Line(points={{-164,-40},{-116,38}}, color={0,0,0}),
        Line(points={{-4,-40},{44,38}}, color={0,0,0}),
        Line(points={{74,-40},{122,38}}, color={0,0,0}),
        Line(points={{-4,36},{44,-40}}, color={0,0,0}),
        Line(points={{-90,-34},{-38,100}}, color={0,0,0}),
        Line(points={{-84,-40},{-30,94}}, color={0,0,0}),
        Line(points={{-88,98},{-30,-40}}, color={0,0,0}),
        Ellipse(extent={{202,-18},{166,18}}, lineColor={0,0,0}),
        Line(points={{176,16},{200,8}}, color={0,0,0}),
        Line(points={{200,-8},{176,-16}}, color={0,0,0}),
        Ellipse(
          extent={{18,-18},{-18,18}},
          lineColor={0,0,0},
          origin={162,78},
          rotation=180),
        Line(
          points={{-12,4},{12,-4}},
          color={0,0,0},
          origin={158,66},
          rotation=180),
        Line(
          points={{12,4},{-12,-4}},
          color={0,0,0},
          origin={158,90},
          rotation=180),
        Line(points={{212,80},{180,80}}, color={28,108,200}),
        Rectangle(extent={{138,38},{160,-40}}, lineColor={0,0,0}),
        Line(points={{146,24},{152,28}}, color={0,0,0}),
        Line(points={{152,24},{146,24}}, color={0,0,0}),
        Line(points={{152,20},{146,24}}, color={0,0,0}),
        Line(points={{146,0},{152,4}}, color={0,0,0}),
        Line(points={{152,0},{146,0}}, color={0,0,0}),
        Line(points={{152,-4},{146,0}}, color={0,0,0}),
        Line(points={{146,-20},{152,-16}}, color={0,0,0}),
        Line(points={{152,-20},{146,-20}}, color={0,0,0}),
        Line(points={{152,-24},{146,-20}}, color={0,0,0}),
        Rectangle(extent={{0,100},{20,58}}, lineColor={0,0,0}),
        Line(points={{8,90},{14,94}}, color={0,0,0}),
        Line(points={{14,90},{8,90}}, color={0,0,0}),
        Line(points={{14,86},{8,90}}, color={0,0,0}),
        Line(points={{8,70},{14,74}}, color={0,0,0}),
        Line(points={{14,70},{8,70}}, color={0,0,0}),
        Line(points={{14,66},{8,70}}, color={0,0,0}),
        Line(points={{144,80},{20,80}}, color={28,108,200}),
        Line(points={{0,78}}, color={28,108,200}),
        Line(points={{0,80},{-30,80}}, color={28,108,200}),
        Line(points={{-90,80},{-210,80}}, color={28,108,200}),
        Line(points={{-210,0},{-166,0},{-164,0}}, color={28,108,200}),
        Line(points={{-116,0},{-90,0}}, color={28,108,200}),
        Line(points={{-30,0},{-4,0}}, color={28,108,200}),
        Line(points={{44,0},{74,0}}, color={28,108,200}),
        Line(points={{122,0},{138,0}}, color={28,108,200}),
        Line(points={{202,0},{218,0}}, color={28,108,200}),
        Line(points={{160,0},{166,0}}, color={28,108,200}),
        Line(points={{-160,-40},{-160,-90}}, color={28,108,200}),
        Line(points={{-120,-40},{-120,-90}}, color={28,108,200}),
        Line(points={{0,-40},{0,-90}}, color={28,108,200}),
        Line(points={{40,-40},{40,-90}}, color={28,108,200}),
        Line(points={{80,-40},{80,-90}}, color={28,108,200}),
        Line(points={{118,-40},{118,-90}}, color={28,108,200})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{220,
            100}})));
end GenericAHU;
