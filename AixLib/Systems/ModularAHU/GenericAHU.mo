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
    annotation (Placement(transformation(extent={{-210,-10},{-190,10}}),
        iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{210,-10},{190,10}}),
        iconTransformation(extent={{110,50},{90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{190,70},{210,90}}),
        iconTransformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare final package Medium =
        MediumAir,
    h_outflow(start=Medium1.h_default, nominal=Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-190,70},{-210,90}}),
        iconTransformation(extent={{110,50},{90,70}})));
  RegisterModule perheater if usePreheater
    annotation (Placement(transformation(extent={{-140,-46},{-96,14}})));
  RegisterModule cooler
    annotation (Placement(transformation(extent={{2,-46},{46,14}})));
  RegisterModule heater
    annotation (Placement(transformation(extent={{80,-46},{124,14}})));
  Fluid.HeatExchangers.DynamicHX dynamicHX
    annotation (Placement(transformation(extent={{-10,-10},{-52,42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare package Medium =
        MediumWater) if usePreheater
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-150,-110},{-130,-90}}),
        iconTransformation(extent={{-150,-110},{-130,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare package Medium =
        MediumWater) if usePreheater
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-110,-110},{-90,-90}}),
        iconTransformation(extent={{-110,-110},{-90,-90}})));
  Fluid.Actuators.Dampers.Exponential dam
    annotation (Placement(transformation(extent={{-180,-10},{-160,10}})));
  Fluid.Actuators.Dampers.Exponential dam1
    annotation (Placement(transformation(extent={{160,70},{140,90}})));
  Fluid.Actuators.Dampers.Exponential dampHX
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Fluid.Actuators.Dampers.Exponential dampByPass
    annotation (Placement(transformation(extent={{-40,-10},{-20,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-68,-54},{-60,-46}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-54,-52},{-44,-42}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a4
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-8,-110},{12,-90}}),
        iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b4
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{32,-110},{52,-90}}),
        iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a5
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{72,-110},{92,-90}}),
        iconTransformation(extent={{52,-110},{72,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b5
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{112,-110},{132,-90}}),
        iconTransformation(extent={{90,-110},{110,-90}})));
  Fluid.Movers.FlowControlled_dp fan
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Fluid.Movers.FlowControlled_dp fan1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={110,80})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=
        MediumAir.enthalpyOfCondensingGas(T=373.15)*humidifier.mWat_flow)
    annotation (Placement(transformation(extent={{140,-52},{160,-32}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{164,-52},{184,-32}})));
  Fluid.Humidifiers.Humidifier_u humidifier(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  Fluid.Humidifiers.Humidifier_u humidifier1(redeclare package Medium =
        MediumAir)
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=
        MediumAir.enthalpyOfCondensingGas(T=373.15)*humidifier.mWat_flow)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,56})));
equation
  connect(perheater.port_a2, port_a3) annotation (Line(points={{-140,-27.5385},
          {-144,-27.5385},{-144,-100},{-140,-100}},color={0,127,255}));
  connect(perheater.port_b2, port_b3) annotation (Line(points={{-96,-27.5385},{
          -92,-27.5385},{-92,-100},{-100,-100}},
                                             color={0,127,255}));
  connect(const.y, add.u2)
    annotation (Line(points={{-59.6,-50},{-55,-50}}, color={0,0,127}));
  connect(add.y, dampByPass.y) annotation (Line(points={{-43.5,-47},{-43.5,-46.5},
          {-30,-46.5},{-30,-32}}, color={0,0,127}));
  connect(add.u1, dampHX.y)
    annotation (Line(points={{-55,-44},{-70,-44},{-70,12}}, color={0,0,127}));
  connect(dampHX.port_b, dynamicHX.port_a2) annotation (Line(points={{-60,0},{-64,
          0},{-64,0.4},{-52,0.4}}, color={0,127,255}));
  connect(perheater.port_b1, dampHX.port_a) annotation (Line(points={{-96,0.153846},
          {-92,0.153846},{-92,0},{-80,0}}, color={0,127,255}));
  connect(dam.port_b, perheater.port_a1) annotation (Line(points={{-160,0},{-144,
          0},{-144,0.153846},{-140,0.153846}}, color={0,127,255}));
  connect(port_a1, dam.port_a)
    annotation (Line(points={{-200,0},{-180,0}}, color={0,127,255}));
  connect(cooler.port_b1, heater.port_a1)
    annotation (Line(points={{46,0.153846},{80,0.153846}}, color={0,127,255}));
  connect(dampHX.port_a, dampByPass.port_a)
    annotation (Line(points={{-80,0},{-80,-20},{-40,-20}}, color={0,127,255}));
  connect(dampByPass.port_b, dynamicHX.port_b2) annotation (Line(points={{-20,-20},
          {-10,-20},{-10,0.4}}, color={0,127,255}));
  connect(cooler.port_a2, port_a4) annotation (Line(points={{2,-27.5385},{-4,
          -27.5385},{-4,-100},{2,-100}},
                               color={0,127,255}));
  connect(cooler.port_b2, port_b4) annotation (Line(points={{46,-27.5385},{46,
          -28},{48,-28},{48,-100},{42,-100}},
                                         color={0,127,255}));
  connect(heater.port_a2, port_a5) annotation (Line(points={{80,-27.5385},{78,
          -27.5385},{78,-28},{74,-28},{74,-100},{82,-100}},
                                                  color={0,127,255}));
  connect(heater.port_b2, port_b5) annotation (Line(points={{124,-27.5385},{128,
          -27.5385},{128,-28},{132,-28},{132,-100},{122,-100}}, color={0,127,255}));
  connect(fan1.port_a, dam1.port_b)
    annotation (Line(points={{120,80},{140,80}},color={0,127,255}));
  connect(dynamicHX.port_b1, port_b2) annotation (Line(points={{-52,31.6},{-64,31.6},
          {-64,80},{-200,80}}, color={0,127,255}));
  connect(dam1.port_a, port_a2)
    annotation (Line(points={{160,80},{200,80}}, color={0,127,255}));
  connect(dynamicHX.port_b2, cooler.port_a1) annotation (Line(points={{-10,0.4},
          {-8,0.4},{-8,0.153846},{2,0.153846}}, color={0,127,255}));
  connect(realExpression.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{161,-42},{164,-42}}, color={0,0,127}));
  connect(heater.port_b1, humidifier.port_a) annotation (Line(points={{124,0.153846},
          {130,0.153846},{130,0},{140,0}}, color={0,127,255}));
  connect(humidifier.port_b, fan.port_a)
    annotation (Line(points={{160,0},{170,0}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, humidifier.heatPort) annotation (Line(points=
         {{184,-42},{184,-24},{140,-24},{140,-6}}, color={191,0,0}));
  if usePreheater==false then
    connect(dam.port_b, dampHX.port_a) annotation (Line(points={{-160,0},{-158,0},
          {-158,28},{-80,28},{-80,0}}, color={0,127,255}));
  end if;
  connect(realExpression1.y, prescribedHeatFlow1.Q_flow) annotation (Line(
        points={{81,40},{110,40},{110,56},{84,56}}, color={0,0,127}));
  connect(humidifier1.heatPort, prescribedHeatFlow1.port) annotation (Line(
        points={{60,74},{62,74},{62,56},{64,56}}, color={191,0,0}));
  connect(fan1.port_b, humidifier1.port_a)
    annotation (Line(points={{100,80},{60,80}}, color={0,127,255}));
  connect(humidifier1.port_b, dynamicHX.port_a1) annotation (Line(points={{40,
          80},{24,80},{24,31.6},{-10,31.6}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{200,100}})));
end GenericAHU;
