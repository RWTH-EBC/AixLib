within AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn;
model IdealSink "Demand node as an ideal sink without return flow"
  extends BaseClasses.NoReturn.PartialDemand;

  parameter Modelica.SIunits.MassFlowRate prescribedFlow
    "Prescribed mass flow rate, positive values are discharged from the network";

  AixLib.Fluid.Sources.MassFlowSource_T sink(
    redeclare package Medium = Medium,
    nPorts=1,
    use_m_flow_in=false,
    m_flow=-prescribedFlow)
              "Flow demand of the substation" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,30})));
equation
  connect(senT_supply.port_b, sink.ports[1])
    annotation (Line(points={{-60,0},{0,0},{0,20}}, color={0,127,255}));
  annotation (Icon(graphics={Ellipse(
          extent={{-22,40},{58,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p> This model implements a very simple demand node representation with only an
ideal flow sink discharging a prescribed mass flow rate from the DHC system's
supply network. Note that the <code>prescribedFlow</code> parameter should be
given as a positive value, specifying the mass flow rate to be extracted from
the network into the ideal sink. </p>
</html>", revisions="<html>
<ul>
<li>
May 27, 2017, by Marcus Fuchs:<br/>
First implementation for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
</li>
</ul>
</html>"));
end IdealSink;
