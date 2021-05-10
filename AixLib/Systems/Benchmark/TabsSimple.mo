within AixLib.Systems.Benchmark;
model TabsSimple "Concrete core activation"
  import SI=Modelica.SIunits;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium in the system" annotation (choicesAllMatching=true);
    parameter Boolean allowFlowReversal=true
    "= false to simplify equations, assuming, but not enforcing, no flow reversal for medium 1"
    annotation (Dialog(tab="Assumptions"), Evaluate=true);
  parameter Modelica.SIunits.MassFlowRate m_flow_nominal=1
    "Nominal mass flow rate";
  parameter Modelica.SIunits.Temperature T_start=293.15
    "Initial or guess value of output (= state)";

    parameter SI.Area area "Area of activated concrete";
    parameter SI.Length thickness "Thickness of aactivated concrete";
    parameter SI.SpecificHeatCapacity cp = 0.278 "Specific heat capacity of concrete";
    parameter SI.Density rho = 2100 "Density of activated concrete";
    parameter Real alpha = 10 "Heat transfer coefficient concrete to air";

  parameter Modelica.SIunits.Length length=100 "Pipe length";
  parameter Modelica.SIunits.Length dh=0.032
    "Hydraulic diameter (assuming a round cross section area)";
  parameter Real R=0.002
    "Thermal resistance per unit length from fluid to boundary temperature";

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=rho*
        area*thickness*cp,                                                  T(
        start=T_start, fixed=true)) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=270,
        origin={26,0})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,80})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}}),
        iconTransformation(extent={{-10,120},{10,140}})));

  Modelica.Blocks.Sources.Constant const(k=area*alpha)
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowTabs annotation (Placement(
        transformation(extent={{-124,-12},{-100,12}}), iconTransformation(
          extent={{-124,-12},{-100,12}})));
equation

  connect(heatCapacitor.port, convection.solid) annotation (Line(points={{18,
          1.55431e-15},{0,1.55431e-15},{0,70},{-6.66134e-16,70}},
                                            color={191,0,0}));
  connect(convection.fluid, heatPort)
    annotation (Line(points={{0,90},{0,100}}, color={191,0,0}));
  connect(convection.Gc, const.y)
    annotation (Line(points={{-10,80},{-19,80}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, heatCapacitor.port) annotation (Line(points=
          {{-24,0},{-32,0},{-32,1.55431e-15},{18,1.55431e-15}}, color={191,0,0}));
  connect(prescribedHeatFlow.Q_flow, Q_flowTabs) annotation (Line(points={{-44,
          0},{-66,0},{-66,-2},{-112,-2},{-112,0}}, color={0,0,127}));
    annotation (Dialog(tab="Initialization"),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
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
          color={244,125,35},
          thickness=0.5),
        Line(
          points={{-40,-52},{-40,70},{40,70},{40,-90}},
          color={28,108,200},
          thickness=0.5),
        Line(
          points={{40,-60},{80,-60},{80,-88}},
          color={244,125,35},
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
end TabsSimple;
