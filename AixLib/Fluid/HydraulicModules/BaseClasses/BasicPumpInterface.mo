within AixLib.Fluid.HydraulicModules.BaseClasses;
partial model BasicPumpInterface "Pump interface for different pump types"
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    annotation (__Dymola_choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{110,-10},{90,10}}),
        iconTransformation(extent={{110,-10},{90,10}})));
  PumpBus pumpBus annotation (
      Placement(transformation(extent={{-20,80},{20,120}}), iconTransformation(
          extent={{-20,80},{20,120}})));

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Polygon(
          points={{20,-70},{60,-85},{20,-100},{20,-70}},
          lineColor={0,128,255},
          fillColor={0,128,255},
          fillPattern=FillPattern.Solid,
          visible=showDesignFlowDirection),
        Polygon(
          points={{20,-75},{50,-85},{20,-95},{20,-75}},
          lineColor={255,255,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=system.allowFlowReversal),
        Line(
          points={{55,-85},{-60,-85}},
          color={0,128,255},
          visible=showDesignFlowDirection),
        Ellipse(
          extent={{-80,90},{80,-70}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,161,107}),
        Polygon(
          points={{-28,64},{-28,-40},{54,12},{-28,64}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={220,220,220})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>May 20, 2018, by Alexander K&uuml;mpel:<br/>First implementation.</li>
</ul>
</html>", info="<html>
<p>This is a basic container model for different pump typs. A new container model for a specific pump should be extended from this class. In this way, replacing the pump model in the hydraulic modules is easy.</p>
</html>"));
end BasicPumpInterface;
