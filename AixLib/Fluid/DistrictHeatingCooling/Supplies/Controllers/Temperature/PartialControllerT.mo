within AixLib.Fluid.DistrictHeatingCooling.Supplies.Controllers.Temperature;
partial model PartialControllerT "Base class for temperature controller"
  Modelica.Blocks.Interfaces.RealOutput y(unit="K") "Set temperature output"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-92,84},{94,28}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="Temperature
Controller")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><p>
  This is a base class defining the interface for different temperature
  controllers in DHC supply nodes
</p>
<ul>
  <li>July 17, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end PartialControllerT;
