within AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer;
partial model SimpleConsumer

  AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    V=3)
    annotation (Placement(transformation(extent={{36,4},{56,24}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,30})));
  Modelica.Blocks.Sources.Sine sine(amplitude=0, offset=-50000)
    annotation (Placement(transformation(extent={{-84,50},{-64,70}})));
  AixLib.Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-9,-9},{9,9}},
        rotation=0,
        origin={-69,-29})));
  Modelica.Blocks.Sources.RealExpression TSpeicher(y=35 + 273.15)
    annotation (Placement(transformation(extent={{-172,-68},{-140,-48}})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2.5)
    annotation (Placement(transformation(extent={{-128,-74},{-108,-54}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{-142,-46},{-130,-26}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-140,-30},{-128,-10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{42,-24},{62,-4}})));
equation

  connect(heater.port, vol.heatPort) annotation (Line(points={{-1.77636e-15,20},
          {-1.77636e-15,14},{36,14}}, color={191,0,0}));
  connect(sine.y, heater.Q_flow)
    annotation (Line(points={{-63,60},{0,60},{0,40}}, color={0,0,127}));
  connect(TSpeicher.y, onOffController.reference)
    annotation (Line(points={{-138.4,-58},{-130,-58}}, color={0,0,127}));
  connect(onOffController.y, switch1.u2) annotation (Line(points={{-107,-64},{-100,
          -64},{-100,-29},{-79.8,-29}}, color={255,0,255}));
  connect(zero.y, switch1.u3) annotation (Line(points={{-129.4,-36},{-104,-36},{
          -104,-36.2},{-79.8,-36.2}}, color={0,0,127}));
  connect(PLR.y, switch1.u1) annotation (Line(points={{-127.4,-20},{-79.8,-20},{
          -79.8,-21.8}}, color={0,0,127}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{36,14},{36,-14},{42,-14}}, color={191,0,0}));
  connect(temperatureSensor.T, onOffController.u) annotation (Line(points={{63,-14},
          {76,-14},{76,-88},{-150,-88},{-150,-70},{-130,-70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer;
