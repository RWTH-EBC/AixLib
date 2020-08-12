within AixLib.Systems.EONERC_MainBuilding;
model SwitchingUnit
  "Piping system for using geothermal field and heatpump system in different modes"
  extends AixLib.Fluid.Interfaces.PartialFourPort(
    redeclare package Medium1 = Medium,
    redeclare package Medium2 = Medium,
    final allowFlowReversal1 = allowFlowReversal,
    final allowFlowReversal2 = allowFlowReversal);
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal(min=0)
    "Nominal mass flow rate";

  Fluid.Actuators.Valves.TwoWayLinear              Y3(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=160,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,-60})));


  Modelica.Fluid.Interfaces.FluidPort_a port_a3(redeclare final package Medium =
        Medium) annotation (Placement(transformation(rotation=0, extent={{30,-170},
            {50,-150}}), iconTransformation(extent={{30,-170},{50,-150}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(redeclare final package Medium =
        Medium) annotation (Placement(transformation(rotation=0, extent={{-50,-170},
            {-30,-150}}), iconTransformation(extent={{-50,-170},{-30,-150}})));

  Fluid.Actuators.Valves.TwoWayLinear              K2(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=500,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-90})));
  Fluid.Actuators.Valves.TwoWayLinear              Y2(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=160,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-90})));
  Fluid.Actuators.Valves.TwoWayLinear       K4(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=500,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-90})));
  Fluid.Actuators.Valves.TwoWayLinear       K3(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=500,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  BaseClasses.SwitchingUnitBus sWUBus annotation (Placement(transformation(
          extent={{-20,60},{20,100}}), iconTransformation(extent={{-18,64},{16,
            100}})));
  HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
    pumpInterface_SpeedControlledNrpm(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
    pump(redeclare
        AixLib.Fluid.Movers.Data.Pumps.Wilo.VeroLine50slash150dash4slash2 per,
        addPowerToMedium=false))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={50,-128})));
  Fluid.Actuators.Valves.TwoWayLinear              K1(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=500,
    order=1,
    init=Modelica.Blocks.Types.Init.SteadyState,
    dpFixed_nominal=1000)
            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,60})));
equation
  connect(port_b2, Y3.port_a)
    annotation (Line(points={{-100,-60},{-30,-60}}, color={0,127,255}));
  connect(Y3.port_b, port_a2)
    annotation (Line(points={{-10,-60},{100,-60}}, color={0,127,255}));
  connect(K4.port_b, port_b1)
    annotation (Line(points={{60,-80},{60,60},{100,60}}, color={0,127,255}));
  connect(port_a3, Y2.port_a) annotation (Line(points={{40,-160},{40,-124},{-80,
          -124},{-80,-100}}, color={0,127,255}));
  connect(port_b3, K3.port_a) annotation (Line(points={{-40,-160},{-40,-140},{-4.44089e-16,
          -140},{-4.44089e-16,-100}}, color={0,127,255}));
  connect(K2.port_a, port_b3)
    annotation (Line(points={{-40,-100},{-40,-160}}, color={0,127,255}));
  connect(K3.port_b, port_a2)
    annotation (Line(points={{0,-80},{0,-60},{100,-60}}, color={0,127,255}));
  connect(Y2.port_b, Y3.port_a) annotation (Line(points={{-80,-80},{-80,-60},{-30,
          -60}}, color={0,127,255}));
  connect(Y2.y, sWUBus.Y2valSet) annotation (Line(points={{-92,-90},{-130,-90},
          {-130,80.1},{0.1,80.1}},      color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Y2.y_actual, sWUBus.Y2valSetAct) annotation (Line(points={{-87,-85},{
          -126,-85},{-126,80.1},{0.1,80.1}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(K2.y, sWUBus.K2valSet) annotation (Line(points={{-52,-90},{-56,-90},{
          -56,80.1},{0.1,80.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(K2.y_actual, sWUBus.K2valSetAct) annotation (Line(points={{-47,-85},{
          -47,80.1},{0.1,80.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Y3.y, sWUBus.Y3valSet) annotation (Line(points={{-20,-48},{-20,80},{
          0.1,80},{0.1,80.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Y3.y_actual, sWUBus.Y3valSetAct) annotation (Line(points={{-15,-53},{
          -15,80},{0.1,80},{0.1,80.1}},   color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(K3.y, sWUBus.K3valSet) annotation (Line(points={{-12,-90},{-10,-90},{
          -10,-76},{-8,-76},{-8,78},{0.1,78},{0.1,80.1}},   color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(K3.y_actual, sWUBus.K3valSetAct) annotation (Line(points={{-7,-85},{
          -7,78},{0.1,78},{0.1,80.1}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(K4.y, sWUBus.K4valSet) annotation (Line(points={{48,-90},{36,-90},{36,
          80},{0.1,80},{0.1,80.1}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(K4.y_actual, sWUBus.K4valSetAct) annotation (Line(points={{53,-85},{
          53,80.1},{0.1,80.1}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));

  connect(K4.port_a, pumpInterface_SpeedControlledNrpm.port_b) annotation (Line(
        points={{60,-100},{50,-100},{50,-118}}, color={0,127,255}));
  connect(pumpInterface_SpeedControlledNrpm.port_a, port_a3) annotation (Line(
        points={{50,-138},{50,-160},{40,-160}}, color={0,127,255}));
  connect(pumpInterface_SpeedControlledNrpm.pumpBus, sWUBus.pumpBus)
    annotation (Line(
      points={{60,-128},{64,-128},{64,-124},{74,-124},{74,80.1},{0.1,80.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_a1, K1.port_a)
    annotation (Line(points={{-100,60},{12,60}}, color={0,127,255}));
  connect(K1.port_b, port_b1)
    annotation (Line(points={{32,60},{100,60}}, color={0,127,255}));
  connect(K2.port_b, K1.port_a) annotation (Line(points={{-40,-80},{-38,-80},{
          -38,60},{12,60}}, color={0,127,255}));
  connect(K1.y, sWUBus.K1valSet) annotation (Line(points={{22,72},{22,80.1},{
          0.1,80.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(K1.y_actual, sWUBus.K1valSetAct) annotation (Line(points={{27,67},{27,
          80.1},{0.1,80.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(extent={{-100,-160},{100,80}},
          preserveAspectRatio=false)),           Icon(coordinateSystem(extent={{-100,
            -160},{100,80}}), graphics={
        Rectangle(
          extent={{-100,80},{100,-160}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Line(
          points={{-90,60},{92,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-90,-60},{90,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-150},{40,-140},{60,-140},{60,-62}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{60,-58},{60,60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-140},{40,-120},{-80,-120},{-80,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-150},{-40,-122}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-118},{-40,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-100},{-66,-100},{-66,-62}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-66,-58},{-66,60}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-68,62},{-64,58}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{58,62},{62,58}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-82,-58},{-78,-62}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-58},{-38,-62}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-138},{42,-142}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-42,-98},{-38,-102}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,-56},{-44,-64},{-44,-56},{-60,-64},{-60,-56}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-8,4},{8,-4},{8,4},{-8,-4},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={60,-80},
          rotation=90),
        Polygon(
          points={{-8,4},{8,-4},{8,4},{-8,-4},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-40,-80},
          rotation=90),
        Polygon(
          points={{-8,4},{8,-4},{8,4},{-8,-4},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-66,-80},
          rotation=90),
        Polygon(
          points={{-8,4},{8,-4},{8,4},{-8,-4},{-8,4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          origin={-80,-80},
          rotation=90),
        Ellipse(
          extent={{-8,8},{8,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={60,-110},
          rotation=180),
        Line(
          points={{4,4},{-4,-4}},
          color={0,0,0},
          thickness=0.5,
          origin={56,-106},
          rotation=180),
        Line(
          points={{4,-4},{-4,4}},
          color={0,0,0},
          thickness=0.5,
          origin={64,-106},
          rotation=180),
        Polygon(
          points={{-14,64},{2,56},{2,64},{-14,56},{-14,64}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p>Pump prevents flow reversal</p>
</html>"));
end SwitchingUnit;
