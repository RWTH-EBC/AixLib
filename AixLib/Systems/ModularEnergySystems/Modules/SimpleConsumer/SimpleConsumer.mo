within AixLib.Systems.ModularEnergySystems.Modules.SimpleConsumer;
model SimpleConsumer "Simple Consumer"
  extends AixLib.Fluid.Interfaces.PartialTwoPort;
  import SI=Modelica.SIunits;

  parameter Modelica.SIunits.Temperature TControl "Flow consumer temperatures";


    AixLib.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    V=3,
    nPorts=2)
    annotation (Placement(transformation(extent={{36,6},{56,26}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heater
    "Prescribed heat flow" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,30})));
  AixLib.Fluid.Sources.Boundary_pT
                      bou(
    use_T_in=false,
    redeclare package Medium = AixLib.Media.Water,
    nPorts=1)
    annotation (Placement(transformation(extent={{62,-38},{82,-18}})));
  Modelica.Blocks.Logical.Switch switch annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-25,-31})));
  Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=2.5)
    annotation (Placement(transformation(extent={{-70,-74},{-50,-54}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0)
    annotation (Placement(transformation(extent={{-68,-46},{-58,-26}})));
  Modelica.Blocks.Sources.RealExpression PLR(y=1)
    annotation (Placement(transformation(extent={{-68,-32},{-58,-12}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{46,-78},{66,-58}})));
  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=5,
    isCircular=true,
    diameter=0.03,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow (
          dp_nominal=0, m_flow_nominal=0.4785))
  annotation (Placement(transformation(extent={{9,-6},{-9,6}},
        rotation=180,
        origin={71,8.88178e-16})));

  Modelica.Blocks.Interfaces.RealInput HeatLoad annotation (Placement(
        transformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={0,106}), iconTransformation(
        extent={{-12,-12},{12,12}},
        rotation=270,
        origin={0,106})));
  Modelica.Blocks.Sources.RealExpression TLevel(y=TControl)
    annotation (Placement(transformation(extent={{-100,-68},{-80,-48}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val
    annotation (Placement(transformation(extent={{-64,-10},{-44,10}})));
equation

  connect(heater.port, vol.heatPort) annotation (Line(points={{-1.77636e-15,20},
          {-1.77636e-15,16},{36,16}}, color={191,0,0}));
  connect(onOffController.y, switch.u2) annotation (Line(points={{-49,-64},{-42,
          -64},{-42,-31},{-33.4,-31}}, color={255,0,255}));
  connect(zero.y, switch.u3) annotation (Line(points={{-57.5,-36},{-46,-36},{
          -46,-36.6},{-33.4,-36.6}}, color={0,0,127}));
  connect(vol.heatPort, temperatureSensor.port)
    annotation (Line(points={{36,16},{36,-68},{46,-68}}, color={191,0,0}));
  connect(temperatureSensor.T, onOffController.u) annotation (Line(points={{66,-68},
          {80,-68},{80,-88},{-90,-88},{-90,-70},{-72,-70}},    color={0,0,127}));


  connect(pipe.port_a, vol.ports[1]) annotation (Line(points={{62,8.88178e-16},{
          56,8.88178e-16},{56,0},{44,0},{44,6}},  color={0,127,255}));
  connect(pipe.port_b, port_b)
    annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
  connect(bou.ports[1], port_b)
    annotation (Line(points={{82,-28},{100,-28},{100,0}}, color={0,127,255}));
  connect(HeatLoad, heater.Q_flow) annotation (Line(points={{0,106},{0,40},{
          1.9984e-15,40}}, color={0,0,127}));
  connect(PLR.y, switch.u1) annotation (Line(points={{-57.5,-22},{-34,-22},{-34,
          -25.4},{-33.4,-25.4}}, color={0,0,127}));
  connect(onOffController.reference, TLevel.y)
    annotation (Line(points={{-72,-58},{-79,-58}}, color={0,0,127}));
  connect(port_a, val.port_a)
    annotation (Line(points={{-100,0},{-64,0}}, color={0,127,255}));
  connect(val.port_b, vol.ports[2])
    annotation (Line(points={{-44,0},{48,0},{48,6}}, color={0,127,255}));
  connect(switch.y, val.y) annotation (Line(points={{-17.3,-31},{-12,-31},{-12,
          26},{-54,26},{-54,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SimpleConsumer;
