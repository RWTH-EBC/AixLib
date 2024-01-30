within AixLib.Fluid.DistrictHeatingCooling.Demands.Examples.NoReturn;
model IdealSinksDynamicDemand
  "Ideal sink models with a dynamic demand as input demonstrated in a simple setup"
  extends Modelica.Icons.Example;

  package Medium = AixLib.Media.Water "Fluid in the pipes";

  Sources.Boundary_pT source(
    redeclare package Medium = Medium,
    p=1000000,
    T=373.15,
    nPorts=3)                "Ideal source supplying the demand nodes"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkHeat idealSinkHeat(
    dTDesign=30,
    redeclare package Medium = Medium,
    Q_flow_set(tableName="Demand", fileName=
          Modelica.Utilities.Files.loadResource(
          "modelica://AixLib/Resources/Dhc_ExampleData/Building1.txt")))
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkHeatInput idealSinkHeatInput(dTDesign=
        30, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  .AixLib.Fluid.DistrictHeatingCooling.Demands.NoReturn.IdealSinkHeatInput idealSinkHeatInput1(dTDesign=
        30, redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.CombiTimeTable Q_flow_from_txt(
    tableOnFile=true,
    fileName=Modelica.Utilities.Files.loadResource(
        "modelica://AixLib/Resources/Dhc_ExampleData/Building1.txt"),
    tableName="Demand")
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Pulse pulse(
    amplitude=12000,
    width=25,
    period=3600,
    nperiod=-1) annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(idealSinkHeatInput1.port_a, source.ports[1]) annotation (Line(points={{0,50},{
          -30,50},{-30,-1.33333},{-60,-1.33333}},        color={0,127,255}));
  connect(idealSinkHeatInput.port_a, source.ports[2]) annotation (Line(points={
          {0,0},{-30,0},{-30,-2.22045e-016},{-60,-2.22045e-016}}, color={0,127,
          255}));
  connect(idealSinkHeat.port_a, source.ports[3]) annotation (Line(points={{0,-50},
          {-30,-50},{-30,1.33333},{-60,1.33333}},        color={0,127,255}));
  connect(Q_flow_from_txt.y[1], idealSinkHeatInput.Q_flow_input) annotation (
      Line(points={{81,0},{86,0},{86,26},{-12,26},{-12,8},{-0.8,8}}, color={0,0,
          127}));
  connect(idealSinkHeatInput1.Q_flow_input, pulse.y) annotation (Line(points={{
          -0.8,58},{-12,58},{-12,80},{86,80},{86,50},{81,50}}, color={0,0,127}));
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
end IdealSinksDynamicDemand;
