within AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.Examples;
model SubstationHeating
  "Demonstration of the ideal substation with no effect on fluid, only direct throughflow"
  import AixLib;
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Fluid in the pipes";

  AixLib.Fluid.DistrictHeatingCooling.Demands.Substations.SubstationHeating
    substationDirectThrough(redeclare package Medium = Medium,
    m_flow_nominal=0.05,
    deltaT=10,
    maxHeatDemand=2000,
    m_flow_smal=0.00001,
    T_Supply_Set=333.15)
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
  Modelica.Blocks.Sources.Pulse Q_Demand(
    amplitude=1000,
    period=7200,
    nperiod=24,
    offset=1000,
    startTime=0) "Varying the example's mass flow rate"
    annotation (Placement(transformation(extent={{-26,48},{-6,68}})));
  AixLib.Fluid.Sources.FixedBoundary bou(
    redeclare package Medium = Medium,
    p=100300,
    T=333.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
  AixLib.Fluid.Sources.FixedBoundary bou1(
    redeclare package Medium = Medium,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{120,-10},{100,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                             T_Return(redeclare package Medium = Medium,
      m_flow_nominal=0.05)
    annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                             T_Return1(
                                      redeclare package Medium = Medium,
      m_flow_nominal=0.05)
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
equation
  connect(Q_Demand.y, substationDirectThrough.HeatDemand) annotation (Line(
        points={{-5,58},{20,58},{20,6.8},{31.8,6.8}}, color={0,0,127}));
  connect(bou.ports[1], T_Return.port_a)
    annotation (Line(points={{-34,0},{-16,0}}, color={0,127,255}));
  connect(substationDirectThrough.port_a, T_Return.port_b)
    annotation (Line(points={{32,0},{4,0}}, color={0,127,255}));
  connect(substationDirectThrough.port_b, T_Return1.port_a)
    annotation (Line(points={{52,0},{68,0}}, color={0,127,255}));
  connect(bou1.ports[1], T_Return1.port_b)
    annotation (Line(points={{100,0},{88,0}}, color={0,127,255}));
  annotation (experiment(
      StopTime=864000,
      Interval=3600,
      Tolerance=1e-005),                Documentation(revisions="<html><ul>
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
end SubstationHeating;
