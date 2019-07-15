within AixLib.Fluid.HeatExchangers.Geothermal.Examples;
model CoaxialPipe
  extends Modelica.Icons.Example;
  replaceable package Water = AixLib.Media.Water;
  AixLib.Fluid.HeatExchangers.Geothermal.BoreHoleHeatExchanger.CoaxialPipe
    coaxialPipe(
    boreholeDepth=20,
    boreholeDiameter=0.5,
    pipeType=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
    boreholeFilling=AixLib.DataBase.Materials.FillingMaterials.basicFilling(),
    redeclare package Medium = Water,
    innerPipeType=AixLib.DataBase.Pipes.DIN_EN_10255.DIN_EN_10255_DN100(),
    T_start=285.15,
    zeta=0.01,
    m=2)
    annotation (Placement(transformation(extent={{-16,-74},{54,-4}})));
  AixLib.Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium =
        Water,
    p=130000,
    T=285.15)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,56})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        281.15)
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));
  AixLib.Fluid.Sources.FixedBoundary bou1(
    nPorts=1,
    redeclare package Medium = Water,
    p=100000,
    use_T=false,
    T=285.15)                                      annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={42,56})));
  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Water)
    annotation (Placement(transformation(extent={{72,38},{92,58}})));
equation
  connect(bou.ports[1], coaxialPipe.fluidPortIn) annotation (Line(points={{-10,46},
          {6,46},{6,-4},{6.75,-4}},
                                  color={0,127,255}));
  connect(fixedTemperature.port, coaxialPipe.thermalConnectors2Ground[1])
    annotation (Line(points={{-50,-30},{1.5,-30},{1.5,-30.25}},
                    color={191,0,0}));
  connect(bou1.ports[1], coaxialPipe.fluidPortOut)
    annotation (Line(points={{42,46},{26,46},{26,-4}}, color={0,127,255}));
  connect(temperature.port, coaxialPipe.fluidPortOut) annotation (Line(points={{
          82,38},{58,38},{58,-2},{26,-2},{26,-4}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CoaxialPipe;
