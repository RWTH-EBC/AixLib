within AixLib.Fluid.DistrictHeatingCooling.Supplies.OpenLoop;
model SourceIdeal
  "Simple supply node model with ideal flow source and return port"
  extends BaseClasses.Supplies.OpenLoop.PartialSupply;

  parameter Modelica.SIunits.AbsolutePressure pReturn
    "Fixed return pressure";

  parameter Modelica.SIunits.Temperature TReturn
    "Fixed return temperature";

  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    nPorts=1,
    use_T_in=true,
    use_p_in=true)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={20,0})));

  Sources.FixedBoundary sink(redeclare package Medium = Medium, nPorts=1,
    p=pReturn)
    "Ideal sink for return from the network" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-30,0})));
equation
  connect(source.ports[1], senT_supply.port_a)
    annotation (Line(points={{30,0},{40,0}},       color={0,127,255}));
  connect(TIn, source.T_in)
    annotation (Line(points={{-106,70},{2,70},{2,4},{8,4}},
                                                       color={0,0,127}));
  connect(dpIn, source.p_in) annotation (Line(points={{-106,-70},{-2,-70},{-2,8},
          {8,8}},             color={0,0,127}));
  connect(senT_return.port_b, sink.ports[1])
    annotation (Line(points={{-60,0},{-40,0}}, color={0,127,255}));
  annotation (Icon(graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html>
<ul>
<li>
March 3, 2018, by Marcus Fuchs:<br/>
Implemented for <a href=\"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
</li>
</ul>
</html>", info="<html>
<p>
This model represents the supply node with an ideal pressure source and sink.
It provides a prescribed supply pressure and supply temperature to the network.
</p>
</html>"));
end SourceIdeal;
