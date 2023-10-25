within AixLib.Systems.EONERC_Testhall.BaseClasses.CPH.Components;
model RadiantCeilingPanelHeater

  replaceable package Medium = AixLib.Media.Water
    "Medium in the system" annotation (choicesAllMatching=true);

  parameter Integer nNodes "Number of elements";
  parameter Real Gr(unit="m2") = 1.5*18*0.9/nNodes
    "Net radiation conductance between two surfaces (see docu)";

  AixLib.Fluid.FixedResistances.GenericPipe
                                   genericPipe(
    nNodes=nNodes,
    redeclare package Medium = Medium,
    T_start=343.15)
    annotation (Dialog(enable=true), Placement(transformation(extent={{-12,-12},{12,12}})));
  Modelica.Fluid.Interfaces.FluidPort_b radiantcph_ret(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_a radiantcph_sup(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation[nNodes](Gr=Gr)
                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,36})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=
        nNodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,68})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_b1
    annotation (Placement(transformation(extent={{-10,28},{10,48}}),
        iconTransformation(extent={{-10,28},{10,48}})));
equation
  connect(genericPipe.port_b, radiantcph_ret)
    annotation (Line(points={{12,0},{100,0}}, color={0,127,255}));
  connect(genericPipe.port_a, radiantcph_sup)
    annotation (Line(points={{-12,0},{-100,0}}, color={0,127,255}));
  connect(thermalCollector.port_a, bodyRadiation.port_b)
    annotation (Line(points={{0,58},{0,46}}, color={191,0,0}));
  connect(thermalCollector.port_b, port_b1)
    annotation (Line(points={{0,78},{0,38},{0,38}},
                                             color={191,0,0}));
  connect(genericPipe.heatPort, bodyRadiation[nNodes].port_a)
    annotation (Line(points={{0,12},{0,26}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-60,10},{60,-10}},
          lineColor={0,0,0},
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-50,-12},{-50,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-30,-12},{-30,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash),
        Line(
          points={{-10,-12},{-10,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash),
        Line(
          points={{10,-12},{10,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash),
        Line(
          points={{30,-12},{30,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash),
        Line(
          points={{50,-12},{50,-32}},
          color={255,128,0},
          pattern=LinePattern.Dash)}),                           Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RadiantCeilingPanelHeater;
