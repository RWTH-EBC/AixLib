within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSinkMin
  "Demand node as an ideal sink without return flow, minimal implementation"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium) "Inlet port of demand node"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort senT_supply(redeclare package Medium =
        Medium, m_flow_nominal=1) "Supply flow temperature sensor"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  parameter Modelica.Units.SI.MassFlowRate prescribed_m_flow
    "Prescribed mass flow rate, positive values are discharged from the network";

  AixLib.Fluid.Sources.MassFlowSource_T sink(
    redeclare package Medium = Medium,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=-prescribed_m_flow)
              "Flow demand of the substation" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
equation
  connect(port_a, senT_supply.port_a)
    annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-60,0},{0,0},{0,20}}, color={0,127,255}));
  annotation (Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Polygon(
          points={{-86,38},{-86,-42},{-26,-2},{-86,38}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
                             Ellipse(
          extent={{-8,40},{72,-40}},
          lineColor={135,135,135},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html><p>
  This model implements a very simple demand node representation with
  only an ideal flow sink discharging a prescribed mass flow rate from
  the DHC system's supply network. Note that the
  <code>prescribed_m_flow</code> parameter should be given as a
  positive value, specifying the mass flow rate to be extracted from
  the network into the ideal sink.
</p>
<p>
  This is a minimal implementation not using the demand node base
  class.
</p>
</html>", revisions="<html>
<ul>
  <li>May 27, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>"));
end IdealSinkMin;
