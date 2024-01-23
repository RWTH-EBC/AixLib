within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.Examples;
model SubstationDirectThrough
  "Demonstration of the ideal substation with no effect on fluid, only direct throughflow"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Fluid in the pipes";

  AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough
    substationDirectThrough(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  AixLib.Fluid.Sources.MassFlowSource_T source(
    redeclare package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)                                  "Ideal source"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  AixLib.Fluid.Sources.Boundary_pT sink(redeclare package Medium = Medium,
      nPorts=1)                         "Ideal sink" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.Sine m_flow_set(
    amplitude=2,
    freqHz=0.01,
    offset=2) "Varying the example's mass flow rate"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.Sine T_set(
    amplitude=10,
    offset=273.15 + 60,
    freqHz=0.01) "Varying the example's tempertare"
    annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
  Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium)
    "Mass flow rate sensor"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Sensors.TemperatureTwoPort senTem_stat(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    T_start=273.15 + 60,
    tau=0) "Static temperature sensor"
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));
  Sensors.TemperatureTwoPort senTem_dyn(
    redeclare package Medium = Medium,
    m_flow_nominal=2,
    T_start=273.15 + 60) "Dynamic temperature sensor"
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
equation
  connect(source.ports[1], substationDirectThrough.port_a)
    annotation (Line(points={{-40,0},{-30,0}}, color={0,127,255}));
  connect(m_flow_set.y, source.m_flow_in) annotation (Line(points={{-79,30},{
          -70,30},{-70,10},{-60,8}}, color={0,0,127}));
  connect(T_set.y, source.T_in) annotation (Line(points={{-77,-30},{-70,-30},{
          -70,2},{-62,4}}, color={0,0,127}));
  connect(substationDirectThrough.port_b, senMasFlo.port_a)
    annotation (Line(points={{-10,0},{0,0}}, color={0,127,255}));
  connect(senMasFlo.port_b, senTem_stat.port_a)
    annotation (Line(points={{20,0},{26,0}}, color={0,127,255}));
  connect(senTem_stat.port_b, senTem_dyn.port_a)
    annotation (Line(points={{46,0},{54,0}}, color={0,127,255}));
  connect(senTem_dyn.port_b, sink.ports[1])
    annotation (Line(points={{74,0},{80,0}}, color={0,127,255}));
  annotation (experiment(StopTime=100), Documentation(revisions="<html><ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This example demonstrates that the <a href=
  \"modelica://AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough\">
  AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationDirectThrough</a>
  model does not affect the fluid flow, but only serves as a
  placeholder with direct throughflow.
</p>
<p>
  The simulation results show that the mass flow sensor and the static
  temperature sensor monitor the same values as the input set-values of
  the sources. Only for a mass flow rate of 0 does the static
  temperature sensor show a deviation from the set temperature entering
  the substation model. For comparison, a dynamic temperature sensor is
  also included in this model.
</p>
</html>"));
end SubstationDirectThrough;
