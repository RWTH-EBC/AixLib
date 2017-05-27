within AixLib.Fluid.DistrictHeatingCooling.Pipes;
model FlowResistance
  "Simple adiabatic pipe model using the HydraulicDiameter flow resistance"
  extends BaseClasses.PartialPipeAdiabatic;
  FixedResistances.HydraulicDiameter res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dh=diameter,
    length=length,
    roughness=roughness) "Flow resistance"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(port_a, res.port_a)
    annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
  connect(res.port_b, port_b)
    annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
  annotation (Icon(graphics={Rectangle(
          extent={{-100,40},{100,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>
This model is meant as a very simple benchmark for other pipe implementations.
It only models the flow resistance of the pipe using the
<a href=\"modelica://AixLib.Fluid.FixedResistances.HydraulicDiameter\">AixLib.Fluid.FixedResistances.HydraulicDiameter</a>
model.
</p>
</html>", revisions="<html>
<ul>
<li>
May 27, 2017, by Marcus Fuchs:<br/>
Implemented for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>.
</li>
</ul>
</html>"));
end FlowResistance;
