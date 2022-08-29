within AixLib.Systems.ModularEnergySystems.Modules.ModularBoiler.Control.HierarchicalControl_ModularBoiler.InternalControl_ModularBoiler.flowTemperatureController.returnAdmixture;
model Admixture
  extends BaseClasses.partialFourPort(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    final allowFlowReversal1 = allowFlowReversal,
    final allowFlowReversal2 = allowFlowReversal);
  replaceable package Medium =  AixLib.Media.Water
    "Medium in the system" annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.Temperature T_start=293.15;


  //Nominal conditions
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominalCon "Nominal mass flow rate for the individual consumers" annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.VolumeFlowRate V_flow_nominalCon=m_flow_nominalCon/Medium.d_const "Nominal Volume flow rate for the indididual consumers" annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_nominalCon
    "Pressure drop at nominal conditions for the individual consumers"
    annotation(Dialog(group="Nominal conditions"));
  parameter Modelica.Units.SI.PressureDifference dp_Valve = 0 "Pressure Difference set in regulating valve for pressure equalization in heating system" annotation (Dialog(enable = hasFeedback, group="Nominal conditions"));


  // Assumptions
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);

  // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of mass balance: dynamic (3 initialization options) or steady state" annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));


  AixLib.Fluid.Sensors.VolumeFlowRate VFSen_out(
    redeclare package Medium = Medium,
    T_start=T_start,
    final m_flow_nominal=m_flow_nominalCon,
    final allowFlowReversal=allowFlowReversal)
    "Inflow into admix module in forward line" annotation (Placement(
        transformation(
        extent={{-8,8},{8,-8}},
        rotation=270,
        origin={-88,44})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_a1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final m_flow_nominal=m_flow_nominalCon,
    final allowFlowReversal=allowFlowReversal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-84,14},{-72,26}})));

  AixLib.Fluid.Actuators.Valves.ThreeWayEqualPercentageLinear
                                              valve(
    use_inputFilter=false,
    final m_flow_nominal=m_flow_nominalCon,
    final energyDynamics=energyDynamics,
    redeclare package Medium = Medium,
    T_start=T_start,
    y_start=0,
    dpValve_nominal=dp_Valve,
    dpFixed_nominal={10,10})                             annotation (Dialog(
        enable=true, group="Actuators"), Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-40,20})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_b1(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final m_flow_nominal=m_flow_nominalCon,
    final allowFlowReversal=allowFlowReversal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final m_flow_small=0.001)
    annotation (Placement(transformation(extent={{44,14},{56,26}})));

  AixLib.Fluid.Sensors.VolumeFlowRate VFSen_in(
    redeclare package Medium = Medium,
    final m_flow_nominal=m_flow_nominalCon,
    T_start=T_start,
    final allowFlowReversal=allowFlowReversal) "Outflow out of forward line"
    annotation (Placement(transformation(
        extent={{-8,8},{8,-8}},
        rotation=90,
        origin={74,44})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_a2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final m_flow_nominal=m_flow_nominalCon,
    final allowFlowReversal=allowFlowReversal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final m_flow_small=0.001)
    annotation (Placement(transformation(extent={{46,-66},{34,-54}})));

  AixLib.Fluid.Sensors.TemperatureTwoPort senT_b2(
    T_start=T_start,
    redeclare package Medium = Medium,
    transferHeat=true,
    final m_flow_nominal=m_flow_nominalCon,
    final allowFlowReversal=allowFlowReversal,
    final initType=Modelica.Blocks.Types.Init.InitialState,
    final m_flow_small=0.001)
    annotation (Placement(transformation(extent={{-74,-66},{-86,-54}})));

  BaseClasses.AdmixtureBus admixtureBus annotation (Placement(transformation(extent={{-22,76},{22,114}}),
        iconTransformation(extent={{-22,76},{22,114}})));

  AixLib.Fluid.Movers.SpeedControlled_y fan1(
    redeclare package Medium = AixLib.Media.Water,
    allowFlowReversal=false,
    m_flow_small=0.001,
    per(pressure(V_flow={0,V_flow_nominalCon,2*V_flow_nominalCon}, dp={
            dp_nominalCon/0.8,dp_nominalCon,0})),
    addPowerToMedium=false,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{2,10},{22,30}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{6,44},{26,64}})));
  Fluid.FixedResistances.HydraulicResistance hydraulicResistance(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominalCon,
    zeta=1,
    diameter=0.5)
    annotation (Placement(transformation(extent={{-46,-70},{-66,-50}})));
equation
  connect(port_a1, VFSen_out.port_a)
    annotation (Line(points={{-100,60},{-88,60},{-88,52}}, color={0,127,255}));
  connect(VFSen_out.port_b, senT_a1.port_a)
    annotation (Line(points={{-88,36},{-88,20},{-84,20}},
                                                 color={0,127,255}));
  connect(senT_a1.port_b, valve.port_1)
    annotation (Line(points={{-72,20},{-50,20}}, color={0,127,255}));
  connect(senT_b1.port_b, VFSen_in.port_a)
    annotation (Line(points={{56,20},{74,20},{74,36}}, color={0,127,255}));
  connect(VFSen_in.port_b, port_b1)
    annotation (Line(points={{74,52},{74,60},{100,60}}, color={0,127,255}));
  connect(senT_a2.port_b, valve.port_3)
    annotation (Line(points={{34,-60},{-40,-60},{-40,10}}, color={0,127,255}));
  connect(senT_a1.T, admixtureBus.Tsen_a1) annotation (Line(points={{-78,26.6},{
          -68,26.6},{-68,95.095},{0.11,95.095}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(senT_b1.T, admixtureBus.Tsen_b1) annotation (Line(points={{50,26.6},{50,
          95.095},{0.11,95.095}},
                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_b2.T, admixtureBus.Tsen_b2) annotation (Line(points={{-80,-53.4},
          {-80,0},{-114,0},{-114,95.095},{0.11,95.095}},
                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(senT_a2.T, admixtureBus.Tsen_a2) annotation (Line(points={{40,-53.4},{
          40,0},{112,0},{112,95.095},{0.11,95.095}},
                                            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(VFSen_out.V_flow, admixtureBus.VFlowInMea) annotation (Line(points={{-96.8,
          44},{-114,44},{-114,95.095},{0.11,95.095}},
                                                 color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(VFSen_in.V_flow, admixtureBus.VFlowOutMea) annotation (Line(points={{82.8,44},
          {112,44},{112,95.095},{0.11,95.095}},
                                           color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(valve.y_actual, admixtureBus.valveMea) annotation (Line(points={{-35,27},
          {0.11,27},{0.11,95.095}},
                          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(fan1.port_b, senT_b1.port_a)
    annotation (Line(points={{22,20},{44,20}}, color={0,127,255}));
  connect(realExpression.y, fan1.y) annotation (Line(points={{27,54},{36,54},{
          36,40},{12,40},{12,32}}, color={0,0,127}));
  connect(admixtureBus.valveSet, valve.y) annotation (Line(
      points={{0.11,95.095},{0.11,42},{-40,42},{-40,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(valve.port_2, fan1.port_a)
    annotation (Line(points={{-30,20},{2,20}}, color={0,127,255}));
  connect(senT_a2.port_a, port_a2)
    annotation (Line(points={{46,-60},{100,-60}}, color={0,127,255}));
  connect(senT_b2.port_b, port_b2)
    annotation (Line(points={{-86,-60},{-100,-60}}, color={0,127,255}));
  connect(senT_b2.port_a, hydraulicResistance.port_b)
    annotation (Line(points={{-74,-60},{-66,-60}}, color={0,127,255}));
  connect(senT_a2.port_b, hydraulicResistance.port_a)
    annotation (Line(points={{34,-60},{-46,-60}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(initialScale=0.1), graphics={
        Polygon(
          points={{-60,70},{-60,70}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{6,80},{46,40}},
          lineColor={135,135,135},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Line(
          points={{26,80},{46,60},{26,40}},
          color={135,135,135},
          thickness=0.5),
        Polygon(
          points={{-52,50},{-52,70},{-32,60},{-52,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-12,50},{-12,70},{-32,60},{-12,50}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{10,-10},{-10,-10},{0,10},{10,-10}},
          lineColor={95,95,95},
          lineThickness=0.5,
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          origin={-32,50},
          rotation=0),
        Line(
          points={{-32,40},{-32,-58}},
          color={0,128,255},
          thickness=0.5),
        Ellipse(
          extent={{-34,-58},{-30,-62}},
          lineColor={0,128,255},
          lineThickness=0.5,
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-94,82},{-78,64}},
          lineColor={135,135,135},
          textString="1"),
        Text(
          extent={{-40,82},{-24,64}},
          lineColor={135,135,135},
          textString="2"),
        Text(
          extent={{80,82},{96,64}},
          lineColor={135,135,135},
          textString="3"),
        Text(
          extent={{76,-52},{92,-70}},
          lineColor={135,135,135},
          textString="4"),
        Text(
          extent={{-92,-50},{-76,-68}},
          lineColor={135,135,135},
          textString="5"),
        Text(
          extent={{-32,-50},{-16,-68}},
          lineColor={135,135,135},
          textString="6")}),
    Diagram(coordinateSystem(extent={{-120,-120},{120,120}}, initialScale=0.1)));
end Admixture;
