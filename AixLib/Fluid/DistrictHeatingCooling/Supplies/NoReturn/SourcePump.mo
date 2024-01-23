within AixLib.Fluid.DistrictHeatingCooling.Supplies.NoReturn;
model SourcePump
  "Source node with pump model and prescribed supply temperature"
  extends BaseClasses.Supplies.NoReturn.PartialSupply;
  Movers.FlowControlled_dp pump(redeclare package Medium = Medium,
      m_flow_nominal=3) "Network pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1) "Ideal fluid source with prescribed temperature"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput TIn(unit="K") "Prescribed supply temperature"
    annotation (Placement(transformation(extent={{-126,50},{-86,90}}),
        iconTransformation(extent={{-126,50},{-86,90}})));
  Modelica.Blocks.Interfaces.RealOutput P(
    quantity="Power",
    final unit="W")
    "Electrical power consumed by network pump" annotation (Placement(
        transformation(extent={{80,40},{120,80}}), iconTransformation(extent={{80,
            40},{120,80}})));
equation
  connect(source.ports[1], pump.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(pump.P, P) annotation (Line(points={{11,9},{20,9},{20,60},{100,60}},
        color={0,0,127}));
  connect(pump.port_b, senT_supply.port_a)
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(TIn, source.T_in) annotation (Line(points={{-106,70},{-72,70},{-72,4},
          {-62,4}}, color={0,0,127}));
  connect(dpIn, pump.dp_in) annotation (Line(points={{-106,-70},{-20,-70},{-20,
          30},{0,30},{0,12}}, color={0,0,127}));
  annotation (Documentation(revisions="<html><ul>
  <li>January 8, 2018, by Marcus Fuchs:<br/>
    Implemented.
  </li>
</ul>
</html>", info="<html>
This model represents the supply node with an ideal pressure source,
from which a pump discharges at a given pressure rise. It provides a
prescribed supply pressure and supply temperature to the network.
</html>"));
end SourcePump;
