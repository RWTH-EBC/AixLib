within AixLib.Fluid.DistrictHeatingCooling.Supplies.NoReturn;
model SourceIdeal
  "Simple supply node model with ideal flow source and no return port"
  extends BaseClasses.Supplies.NoReturn.PartialSupply;
  AixLib.Fluid.Sources.Boundary_pT source(          redeclare package Medium =
        Medium,
    nPorts=1,
    use_T_in=true,
    use_p_in=true)
    "Ideal fluid source with prescribed temperature and pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));

equation
  connect(source.ports[1], senT_supply.port_a)
    annotation (Line(points={{-40,0},{40,0}},      color={0,127,255}));
  connect(TIn, source.T_in)
    annotation (Line(points={{-106,70},{-88,70},{-88,70},{-70,70},{-70,4},{-62,
          4},{-62,4}},                                 color={0,0,127}));
  connect(dpIn, source.p_in) annotation (Line(points={{-106,-70},{-68,-70},{-68,
          8},{-62,8},{-62,8}},color={0,0,127}));
  annotation (Icon(graphics={Ellipse(
          extent={{-78,40},{2,-40}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>January 8, 2018, by Marcus Fuchs:<br/>
    Change parameters to inputs and rename
  </li>
  <li>May 27, 2017, by Marcus Fuchs:<br/>
    Implemented for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/402\">issue 403</a>.
  </li>
</ul>
</html>", info="<html>
<p>
  This model represents the supply node with an ideal pressure source.
  It provides a prescribed supply pressure and supply temperature to
  the network.
</p>
</html>"));
end SourceIdeal;
