within AixLib.PlugNHarvest.Components.Ventilation.BaseClasses;
model PartialVentFreshAir
  "Partial model for ventilation with fresh air"

   replaceable package AirModel = AixLib.Media.Air "Air model" annotation (choicesAllMatching = true);
  AixLib.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = AirModel,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-20,-42},{0,-22}})));
  AixLib.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-106,56},{-86,76}})));
  AixLib.Fluid.Sources.Outside freshAir(redeclare package Medium = AirModel,
      nPorts=1) annotation (Placement(transformation(extent={{-20,24},{0,44}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        AirModel)
    annotation (Placement(transformation(extent={{86,-24},{106,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        AirModel)
    annotation (Placement(transformation(extent={{86,16},{106,36}})));
  AixLib.Fluid.Sensors.Density senDen(redeclare package Medium = AirModel)
    annotation (Placement(transformation(extent={{-22,-72},{-2,-52}})));
equation
  connect(weaBus, freshAir.weaBus) annotation (Line(
      points={{-96,66},{-80,66},{-80,34.2},{-20,34.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(freshAir.ports[1], port_b) annotation (Line(points={{0,34},{40,34},{
          40,26},{96,26},{96,26}}, color={0,127,255}));
  connect(boundary.ports[1], port_a) annotation (Line(points={{0,-32},{40,-32},
          {40,-14},{96,-14}}, color={0,127,255}));
  connect(senDen.port, port_a) annotation (Line(points={{-12,-72},{-14,-72},{
          -14,-74},{40,-74},{40,-14},{96,-14}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PartialVentFreshAir;
