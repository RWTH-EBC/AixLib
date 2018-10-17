within AixLib.Fluid.Interfaces;
model PassThroughMedium "To make medium connectors conditional"
  extends AixLib.Fluid.Interfaces.PartialTwoPortInterface;
equation
  connect(port_a, port_b)
    annotation (Line(points={{-100,0},{100,0}}, color={0,127,255}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,127,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-94,0},{92,0}},
          color={0,127,255},
          thickness=0.5)}));
end PassThroughMedium;
