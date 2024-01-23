within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.NoReturn;
model IdealSinks "Ideal sink models demonstrated in a simple setup"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Fluid in the pipes";

  Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    p=1000000,
    T=373.15,
    nPorts=3)                "Ideal source supplying the demand nodes"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkMin idealSinkMin(
      redeclare package Medium = Medium, prescribed_m_flow=2)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkConstFlow idealSinkConstFlow(
      redeclare package Medium = Medium, prescribed_m_flow=2)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkConstHeat idealSinkConstHeat(
    redeclare package Medium = Medium,
    dTDesign=30,
    prescribedQ(displayUnit="kW") = 200000)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(source.ports[1], idealSinkMin.port_a) annotation (Line(points={{-60,
          2.66667},{-20,2},{-20,70},{0,70}}, color={0,127,255}));
  connect(source.ports[2], idealSinkConstFlow.port_a)
    annotation (Line(points={{-60,-2.22045e-016},{0,0}}, color={0,127,255}));
  connect(source.ports[3], idealSinkConstHeat.port_a) annotation (Line(points={
          {-60,-2.66667},{-20,-2},{-20,-70},{0,-70}}, color={0,127,255}));
  annotation (Documentation(revisions="<html><ul>
  <li>June 18, 2017, by Marcus Fuchs:<br/>
    First implementation for <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/403\">issue 403</a>).
  </li>
</ul>
</html>", info="<html>
<p>
  This model demonstrates the ideal sink implementation of demand
  nodes, with a minimal example, and node models based on a common base
  class with variants prescirbing either the discharged mass flow rate
  or the extracted heat flow rate.
</p>
</html>"));
end IdealSinks;
