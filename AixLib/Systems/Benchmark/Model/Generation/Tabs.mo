within AixLib.Systems.Benchmark.Model.Generation;
model Tabs "Concrete core activation"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Initial or guess value of output (= state)"
    annotation (Dialog(tab="Initialization"));

  Fluid.FixedResistances.PlugFlowPipe pipe(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    T_start_in=T_start,
    T_start_out=T_start,
    final v_nominal=1.5,
    final allowFlowReversal=allowFlowReversal,
    dh=dh,
    dIns=0.001,
    kIns=0.05,
    length=length,
    R=R,
    nPorts=1)
             annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,46})));

  HydraulicModules.Admix admix(
    redeclare package Medium = Medium,
    allowFlowReversal=allowFlowReversal,
    T_amb=293.15,
    m_flow_nominal=m_flow_nominal,
    T_start=T_start,
    dIns=0.01,
    kIns=0.02,
    d=0.032,
    length=1,
    Kv=10,
    pipe6(length=0.5),
    redeclare HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
      PumpInterface(pump(redeclare
          AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos32slash1to12 per)))
                               annotation (Placement(transformation(
        extent={{-40,-40},{40,40}},
        rotation=90,
        origin={0,-10})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-90,-110},{-70,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-50,-110},{-30,-90}}),
        iconTransformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{70,-110},{90,-90}}),
        iconTransformation(extent={{70,-108},{90,-88}})));
  Fluid.Actuators.Valves.ThreeWayLinear val(
    redeclare package Medium = Medium,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=63,
    m_flow_nominal=m_flow_nominal,
    dpFixed_nominal={10,10}) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-40,-70})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C, T(
        start=T_start, fixed=true)) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={20,60})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,120},{10,140}})));
  parameter Modelica.SIunits.Length length=100 "Pipe length";
  parameter Modelica.SIunits.Length dh=0.05
    "Hydraulic diameter (assuming a round cross section area)";
  parameter Real R=0.002
    "Thermal resistance per unit length from fluid to boundary temperature";
  BaseClasses.TabsBus tabsBus annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}), iconTransformation(extent={{-116,-14},{-86,16}})));
  parameter Modelica.SIunits.HeatCapacity C "Heat capacity of element (= cp*m)";
  Modelica.Blocks.Sources.Constant const(k=Gc)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  parameter Real Gc "Heat flow rate from concrete to fluid";
  Fluid.FixedResistances.HydraulicDiameter res1(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(extent={{58,-70},{78,-50}})));
  Fluid.FixedResistances.HydraulicDiameter res2(
    redeclare package Medium = Medium,
    m_flow_nominal=1,
    dh=0.05,
    length=1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={40,-76})));
equation

  connect(admix.port_b1, pipe.port_a)
    annotation (Line(points={{-24,30},{-24,46},{-10,46}}, color={0,127,255}));
  connect(pipe.ports_b[1], admix.port_a2)
    annotation (Line(points={{10,46},{24,46},{24,30}}, color={0,127,255}));
  connect(port_a2, val.port_1)
    annotation (Line(points={{-40,-100},{-40,-80}}, color={0,127,255}));
  connect(port_a1, val.port_3) annotation (Line(points={{-80,-100},{-80,-70},{-50,
          -70}}, color={0,127,255}));
  connect(val.port_2, admix.port_a1) annotation (Line(points={{-40,-60},{-24,-60},
          {-24,-50}}, color={0,127,255}));
  connect(pipe.heatPort, heatCapacitor.port)
    annotation (Line(points={{0,56},{0,60},{10,60}}, color={191,0,0}));
  connect(heatCapacitor.port, convection.solid) annotation (Line(points={{10,60},
          {0,60},{0,70},{-6.66134e-16,70}}, color={191,0,0}));
  connect(convection.fluid, heatPort)
    annotation (Line(points={{0,90},{0,100}}, color={191,0,0}));
  connect(admix.hydraulicBus, tabsBus.admixBus) annotation (Line(
      points={{-40,-10},{-40,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(val.y, tabsBus.valSet) annotation (Line(points={{-28,-70},{-14,-70},{-14,
          -110},{-99.9,-110},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(val.y_actual, tabsBus.valSetAct) annotation (Line(points={{-33,-65},{-33,
          -54},{-99.9,-54},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(convection.Gc, const.y)
    annotation (Line(points={{-10,80},{-19,80}}, color={0,0,127}));
  connect(port_b2, res1.port_b) annotation (Line(points={{80,-100},{82,-100},{
          82,-60},{78,-60}}, color={0,127,255}));
  connect(admix.port_b2, res1.port_a)
    annotation (Line(points={{24,-50},{24,-60},{58,-60}}, color={0,127,255}));
  connect(admix.port_b2, res2.port_a) annotation (Line(points={{24,-50},{26,-50},
          {26,-66},{40,-66}}, color={0,127,255}));
  connect(res2.port_b, port_b1)
    annotation (Line(points={{40,-86},{40,-100}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,120}}),                                        graphics={
        Rectangle(
          extent={{-100,120},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-68,98},{68,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,98},{68,94}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,46},{68,40}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-78,98},{-68,40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{68,98},{76,40}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-44,-68},{-36,-68},{-40,-60},{-44,-68}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={-44,-60},
          rotation=270),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          origin={-40,-56},
          rotation=180),
        Line(
          points={{-40,-90},{-40,-68}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-80,-90},{-80,-60},{-50,-60},{-48,-60}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{-40,-52},{-40,70},{40,70},{40,-90}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-60},{80,-60},{80,-88}},
          color={28,108,200},
          thickness=0.5),
        Ellipse(
          extent={{-8,8},{8,-8}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          origin={-40,12},
          rotation=180),
        Line(
          points={{4,-4},{-4,4}},
          color={0,0,0},
          thickness=0.5,
          origin={-36,16},
          rotation=180),
        Line(
          points={{4,4},{-4,-4}},
          color={0,0,0},
          thickness=0.5,
          origin={-44,16},
          rotation=180),
        Polygon(
          points={{-44,-28},{-36,-28},{-40,-20},{-44,-28}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0}),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={0,0,0},
          origin={-36,-20},
          rotation=90),
        Polygon(
          points={{-4,-4},{4,-4},{0,4},{-4,-4}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,255,255},
          origin={-40,-16},
          rotation=180),
        Line(
          points={{-32,-20},{40,-20}},
          color={28,108,200},
          thickness=0.5),
        Rectangle(
          extent={{-40,74},{40,70}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Line(
          points={{18,100}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points={{-38,108}},
          color={238,46,47},
          arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-52,114},{-52,100}}, color={238,46,47}),
        Line(points={{-56,110},{-52,114},{-48,110}}, color={238,46,47}),
        Line(points={{-4,110},{0,114},{4,110}}, color={238,46,47}),
        Line(points={{0,114},{0,100}}, color={238,46,47}),
        Line(points={{50,110},{54,114},{58,110}}, color={238,46,47}),
        Line(points={{54,114},{54,100}}, color={238,46,47})}),   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end Tabs;
