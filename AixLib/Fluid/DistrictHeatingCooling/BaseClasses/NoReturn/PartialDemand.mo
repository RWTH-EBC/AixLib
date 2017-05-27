within AixLib.Fluid.DistrictHeatingCooling.BaseClasses.NoReturn;
partial model PartialDemand
  "Base class for modeling demand nodes in DHC systems without return lines"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Inlet port of demand node"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Annex60.Fluid.Sensors.TemperatureTwoPort senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=1) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(port_a, senT_supply.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-90,40},{-90,-40},{-30,0},{-90,40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
May 27, 2017, by Marcus Fuchs:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>", info="<html>
<p>
This base class provides a common interface for demand node models that do not
represent the return flow back into the network.
</p>
</html>"));
end PartialDemand;
