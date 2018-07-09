within AixLib.Building.Benchmark.Test;
model TestTBA
  Components.Walls.ActiveWallPipeBased activeWall(
    outside=false,
    WallType=AixLib.DataBase.Walls.EnEV2009.OW.OW_EnEV2009_S(),
    wall_length=10,
    wall_height=3,
    connActiveLayer={3,4},
    pipe_diameter=0.02,
    pipe_thermal_resistance=0)
    annotation (Placement(transformation(extent={{-32,-34},{-18,46}})));
  AixLib.Utilities.Interfaces.Adaptors.HeatStarToComb
                                               thermStar_Demux annotation(Placement(transformation(extent = {{-10, 8}, {10, -8}}, rotation = 90, origin={48,-68})));
  AixLib.Building.Components.DryAir.Airload airload(V=10, T(start=290))            annotation(Placement(transformation(extent={{72,-38},
            {92,-18}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature tempOutside annotation(Placement(transformation(extent={{-73.5,
            -2},{-54,16}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=250)
    annotation (Placement(transformation(extent={{-118,-2},{-98,18}})));
  AixLib.Fluid.Movers.Pump pump(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    MinMaxCharacteristics=AixLib.DataBase.Pumps.Pump1(),
    m_flow_small=0.01)
    annotation (Placement(transformation(extent={{60,12},{40,32}})));

  Modelica.Fluid.Sources.Boundary_pT boundary(
    nPorts=1,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=10000) annotation (Placement(transformation(extent={{110,14},{90,34}})));

  Modelica.Blocks.Sources.RealExpression realExpression1(y=350)
    annotation (Placement(transformation(extent={{154,18},{134,38}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    nPorts=1,
    use_T_in=true,
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    p=10000,
    T=573.15) annotation (Placement(transformation(extent={{86,38},{66,58}})));

  Modelica.Fluid.Pipes.StaticPipe pipe(
    redeclare package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater,
    allowFlowReversal=true,
    length=1,
    diameter=0.5)
    annotation (Placement(transformation(extent={{28,40},{48,60}})));

  Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{14,68},{34,88}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=true)
    annotation (Placement(transformation(extent={{-44,50},{-24,70}})));
  Modelica.Fluid.Sensors.Temperature temperature1(redeclare package Medium =
        Modelica.Media.Water.ConstantPropertyLiquidWater)
    annotation (Placement(transformation(extent={{-14,-26},{6,-6}})));
equation
  connect(thermStar_Demux.thermStarComb, activeWall.thermStarComb_inside)
    annotation (Line(points={{47.9,-77.4},{21.95,-77.4},{21.95,6},{-18,6}},
        color={191,0,0}));
  connect(airload.port, thermStar_Demux.therm) annotation (Line(points={{73,-30},
          {44,-30},{44,-57.9},{42.9,-57.9}}, color={191,0,0}));
  connect(tempOutside.port, activeWall.port_outside) annotation (Line(points={{
          -54,7},{-48,7},{-48,6},{-32.35,6}}, color={191,0,0}));
  connect(realExpression.y, tempOutside.T) annotation (Line(points={{-97,8},{
          -86,8},{-86,7},{-75.45,7}}, color={0,0,127}));
  connect(pump.port_b, activeWall.port_a1) annotation (Line(points={{40,22},{26,
          22},{26,24.3333},{-18,24.3333}},  color={0,127,255}));
  connect(boundary.ports[1], pump.port_a) annotation (Line(points={{90,24},{76,
          24},{76,22},{60,22}}, color={0,127,255}));
  connect(realExpression1.y, boundary.T_in)
    annotation (Line(points={{133,28},{112,28}}, color={0,0,127}));
  connect(pipe.port_b, boundary1.ports[1]) annotation (Line(points={{48,50},{56,
          50},{56,48},{66,48}}, color={0,127,255}));
  connect(pipe.port_a, activeWall.port_b1) annotation (Line(points={{28,50},{18,
          50},{18,40.3333},{-18.35,40.3333}},
                                  color={0,127,255}));
  connect(temperature.port, activeWall.port_b1) annotation (Line(points={{24,68},
          {24,50},{18,50},{18,40.3333},{-18.35,40.3333}},
                                              color={0,127,255}));
  connect(temperature.T, boundary1.T_in) annotation (Line(points={{31,78},{68,
          78},{68,76},{88,76},{88,52}}, color={0,0,127}));
  connect(booleanExpression.y, pump.IsNight) annotation (Line(points={{-23,60},
          {14,60},{14,32.2},{50,32.2}}, color={255,0,255}));
  connect(temperature1.port, activeWall.port_a1) annotation (Line(points={{-4,-26},
          {16,-26},{16,-28},{34,-28},{34,22},{26,22},{26,24.3333},{-18,24.3333}},
                     color={0,127,255}));
  annotation ();
end TestTBA;
