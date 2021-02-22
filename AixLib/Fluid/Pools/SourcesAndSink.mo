within AixLib.Fluid.Pools;
model SourcesAndSink

  package Medium = AixLib.Media.Water;

  parameter Integer numPools;

  Modelica.Fluid.Sources.Boundary_pT freshWater(replaceable package Medium = Medium, T=283.15, nPorts=numPools)
    annotation (Placement(transformation(extent={{-66,44},{-46,64}})));
  Modelica.Fluid.Sources.Boundary_pT recycledWater(replaceable package Medium = Medium, T=298.15, nPorts=numPools)
    annotation (Placement(transformation(extent={{-68,-2},{-48,18}})));
  Modelica.Fluid.Sources.Boundary_pT sewer(replaceable package Medium = Medium, nPorts=numPools)
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
  Modelica.Fluid.Interfaces.FluidPorts_b recycledWaterPorts [numPools](
      replaceable package                                                                   Medium = Medium)
    annotation (Placement(transformation(extent={{90,-30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPorts_b freshWaterPorts [numPools](
      replaceable package                                                                Medium = Medium)
    annotation (Placement(transformation(extent={{90,20},{110,100}})));
  Modelica.Fluid.Interfaces.FluidPorts_a sewerPorts [numPools]( replaceable
      package                                                                       Medium = Medium)
    annotation (Placement(transformation(extent={{92,-92},{112,-12}})));
equation

   for i in 1:numPools loop

    connect(recycledWater.ports[i], recycledWaterPorts[i]) annotation (Line(points={{
          -48,8},{-12,8},{-12,14},{100,14},{100,10}}, color={0,127,255}));
    connect(freshWater.ports[i], freshWaterPorts[i]) annotation (Line(points={{-46,54},
          {-10,54},{-10,56},{100,56},{100,60}}, color={0,127,255}));
    connect(sewer.ports[1], sewerPorts[i]) annotation (Line(points={{-48,-40},{8,-40},
          {8,-54},{102,-54},{102,-52}}, color={0,127,255}));
   end for;
   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SourcesAndSink;
