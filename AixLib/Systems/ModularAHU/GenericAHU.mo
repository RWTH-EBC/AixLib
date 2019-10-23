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
    annotation (Placement(transformation(extent={{-154,-46},{-110,14}})));
  RegisterModule cooler
    annotation (Placement(transformation(extent={{2,-46},{46,14}})));
  RegisterModule heater
    annotation (Placement(transformation(extent={{76,-46},{120,14}})));
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
  Fluid.Actuators.Dampers.Exponential flapSup
    annotation (Placement(transformation(extent={{-190,-10},{-170,10}})));
  Fluid.Actuators.Dampers.Exponential flapRet
    annotation (Placement(transformation(extent={{200,70},{180,90}})));
  Fluid.Actuators.Dampers.Exponential dampHX
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Fluid.Actuators.Dampers.Exponential dampByPass
    annotation (Placement(transformation(extent={{-80,-10},{-60,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-100,30},{-94,36}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-88,34},{-80,42}})));
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
  Fluid.Movers.FlowControlled_dp fanSup
    annotation (Placement(transformation(extent={{156,-10},{176,10}})));
  Fluid.Movers.FlowControlled_dp fanRet annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,80})));
  Fluid.Humidifiers.GenericHumidifier_u
                                 humidifier(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{130,-10},{150,10}})));
  Fluid.Humidifiers.GenericHumidifier_u
                                 humidifier1(redeclare package Medium =
        MediumAir, steamHumidifier=false)
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
  Fluid.Sensors.TemperatureTwoPort senTRet
    annotation (Placement(transformation(extent={{160,70},{140,90}})));
  Fluid.Sensors.TemperatureTwoPort senTExh
    annotation (Placement(transformation(extent={{-140,70},{-160,90}})));
  Fluid.Sensors.TemperatureTwoPort senTSup annotation (Placement(transformation(
        extent={{-5,-6},{5,6}},
        rotation=0,
        origin={205,0})));
  Fluid.Sensors.TemperatureTwoPort senTOA annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-204,0})));
  Fluid.Sensors.VolumeFlowRate senVolFlo annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-110,80})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup
    annotation (Placement(transformation(extent={{184,-6},{196,6}})));
  Fluid.Sensors.RelativeHumidityTwoPort senRelHumSup1
    annotation (Placement(transformation(extent={{130,74},{118,86}})));
equation
  connect(perheater.port_a2, port_a3) annotation (Line(points={{-154,-27.5385},
          {-160,-27.5385},{-160,-100}},            color={0,127,255}));
  connect(perheater.port_b2, port_b3) annotation (Line(points={{-110,-27.5385},
          {-110,-100},{-120,-100}},          color={0,127,255}));
  connect(const.y, add.u2)
    annotation (Line(points={{-93.7,33},{-94,33},{-94,35.6},{-88.8,35.6}},
                                                     color={0,0,127}));
  connect(dampHX.port_b, dynamicHX.port_a2) annotation (Line(points={{-70,0},{
          -64,0},{-64,0.4},{-62,0.4}},
                                   color={0,127,255}));
  connect(perheater.port_b1, dampHX.port_a) annotation (Line(points={{-110,
          0.153846},{-112,0.153846},{-112,0},{-90,0}},
                                           color={0,127,255}));
  connect(flapSup.port_b, perheater.port_a1) annotation (Line(points={{-170,0},
          {-164,0},{-164,0.153846},{-154,0.153846}}, color={0,127,255}));
  connect(cooler.port_b1, heater.port_a1)
    annotation (Line(points={{46,0.153846},{76,0.153846}}, color={0,127,255}));
  connect(dampHX.port_a, dampByPass.port_a)
    annotation (Line(points={{-90,0},{-90,-20},{-80,-20}}, color={0,127,255}));
  connect(dampByPass.port_b, dynamicHX.port_b2) annotation (Line(points={{-60,-20},
          {-20,-20},{-20,0.4}}, color={0,127,255}));
  connect(cooler.port_a2, port_a4) annotation (Line(points={{2,-27.5385},{-4,
          -27.5385},{-4,-100},{0,-100}},
                               color={0,127,255}));
  connect(cooler.port_b2, port_b4) annotation (Line(points={{46,-27.5385},{46,
          -28},{48,-28},{48,-100},{40,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2, port_a5) annotation (Line(points={{76,-27.5385},{76,
          -100},{80,-100}},                       color={0,127,255}));
  connect(heater.port_b2, port_b5) annotation (Line(points={{120,-27.5385},{128,
          -27.5385},{128,-28},{132,-28},{132,-100},{120,-100}}, color={0,127,255}));
  connect(dynamicHX.port_b2, cooler.port_a1) annotation (Line(points={{-20,0.4},
          {-8,0.4},{-8,0.153846},{2,0.153846}}, color={0,127,255}));
  connect(heater.port_b1, humidifier.port_a) annotation (Line(points={{120,
          0.153846},{130,0.153846},{130,0}},
                                           color={0,127,255}));
  connect(humidifier.port_b, fanSup.port_a)
    annotation (Line(points={{150,0},{156,0}}, color={0,127,255}));
  if usePreheater==false then
    connect(flapSup.port_b, dampHX.port_a) annotation (Line(points={{-170,0},{
            -166,0},{-166,22},{-90,22},{-90,0}}, color={0,127,255}));
  end if;
  connect(fanRet.port_b, humidifier1.port_a)
    annotation (Line(points={{80,80},{60,80}}, color={0,127,255}));
  connect(humidifier1.port_b, dynamicHX.port_a1) annotation (Line(points={{40,80},
          {24,80},{24,31.6},{-20,31.6}},     color={0,127,255}));
  connect(senTExh.port_b, port_b2)
    annotation (Line(points={{-160,80},{-220,80}}, color={0,127,255}));
  connect(senTSup.port_b, port_b1)
    annotation (Line(points={{210,0},{220,0}}, color={0,127,255}));
  connect(port_a1, senTOA.port_a)
    annotation (Line(points={{-220,0},{-214,0}}, color={0,127,255}));
  connect(senTOA.port_b, flapSup.port_a)
    annotation (Line(points={{-194,0},{-190,0}}, color={0,127,255}));
  connect(dynamicHX.port_b1, senVolFlo.port_a) annotation (Line(points={{-62,
          31.6},{-62,80},{-100,80}}, color={0,127,255}));
  connect(senVolFlo.port_b, senTExh.port_a)
    annotation (Line(points={{-120,80},{-140,80}}, color={0,127,255}));
  connect(add.y, dampHX.y) annotation (Line(points={{-79.6,38},{-79.6,26.5},{
          -80,26.5},{-80,12}}, color={0,0,127}));
  connect(dampByPass.y, add.u1) annotation (Line(points={{-70,-32},{-104,-32},{
          -104,40.4},{-88.8,40.4}}, color={0,0,127}));
  connect(fanSup.port_b, senRelHumSup.port_a)
    annotation (Line(points={{176,0},{184,0}}, color={0,127,255}));
  connect(senRelHumSup.port_b, senTSup.port_a)
    annotation (Line(points={{196,0},{200,0}}, color={0,127,255}));
  connect(senTRet.port_b, senRelHumSup1.port_a)
    annotation (Line(points={{140,80},{130,80}}, color={0,127,255}));
  connect(port_a2, flapRet.port_a)
    annotation (Line(points={{220,80},{200,80}}, color={0,127,255}));
  connect(flapRet.port_b, senTRet.port_a)
    annotation (Line(points={{180,80},{160,80}}, color={0,127,255}));
  connect(senRelHumSup1.port_b, fanRet.port_a)
    annotation (Line(points={{118,80},{100,80}}, color={0,127,255}));
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
