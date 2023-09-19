within AixLib.Fluid.Pools.Examples;
model IndoorSwimmingPoolExternalHeatingSystem
    extends Modelica.Icons.Example;
  .AixLib.Fluid.Pools.IndoorSwimmingPool indoorSwimming(poolParam=
        AixLib.DataBase.Pools.SportPool(use_ideHeaExc=false), redeclare package
      WaterMedium = WaterMedium)
    annotation (Placement(transformation(extent={{-32,-38},{16,28}})));

    replaceable package WaterMedium = AixLib.Media.Water annotation (choicesAllMatching=true);

  Modelica.Blocks.Sources.RealExpression TSoil(y=273.15 + 8)
    annotation (Placement(transformation(extent={{74,80},{58,96}})));
  Modelica.Blocks.Sources.RealExpression X_W(y=14.3/1000)
    annotation (Placement(transformation(extent={{-88,48},{-72,64}})));
  Modelica.Blocks.Sources.RealExpression T_Air(y=273.15 + 30)
    annotation (Placement(transformation(extent={{-86,72},{-70,88}})));
  Modelica.Blocks.Sources.Pulse Opening(
    amplitude=1,
    width=(13/15)*100,
    period=(24 - 7)*3600,
    offset=0,
    startTime=3600*7)
    annotation (Placement(transformation(extent={{-94,-44},{-80,-30}})));
  Modelica.Blocks.Sources.Trapezoid Person(
    amplitude=0.5,
    rising=7*3600,
    width=1*3600,
    falling=7*3600,
    period=17*3600,
    offset=0.3,
    startTime=7*3600)
    annotation (Placement(transformation(extent={{-94,-8},{-80,6}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-16,74},{-4,86}})));
  Controls.Continuous.LimPID        PI(
    k=1000,
    yMax=10000000,
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=1)                                                                                                                                                                                                         annotation(Placement(transformation(extent={{-8,-8},
            {8,8}},
        rotation=180,
        origin={82,4})));
  Modelica.Blocks.Sources.RealExpression SetTemperature(y=273.15 + 28)
    annotation (Placement(transformation(extent={{96,34},{78,50}})));
  MixingVolumes.MixingVolume vol(
    redeclare package Medium = AixLib.Media.Water,
    energyDynamics=indoorSwimming.energyDynamics,
    p_start=100000,
    m_flow_nominal=indoorSwimming.m_flow_nominal,
    V=2,
    nPorts=2) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={44,-12})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{62,-50},{42,-30}})));
equation
  connect(TSoil.y, indoorSwimming.TSoil) annotation (Line(points={{57.2,88},{36,
          88},{36,10.51},{16.72,10.51}}, color={0,0,127}));
  connect(indoorSwimming.X_w, X_W.y) annotation (Line(points={{-14.96,28.99},{
          -14.96,38},{-64,38},{-64,56},{-71.2,56}},
                                       color={0,0,127}));
  connect(indoorSwimming.TAir, T_Air.y) annotation (Line(points={{-24.08,28.99},
          {-24.08,80},{-69.2,80}}, color={0,0,127}));
  connect(Opening.y, indoorSwimming.timeOpe) annotation (Line(points={{-79.3,
          -37},{-50,-37},{-50,-24.14},{-33.44,-24.14}}, color={0,0,127}));
  connect(Person.y, indoorSwimming.uRelPer) annotation (Line(points={{-79.3,-1},
          {-50,-1},{-50,-13.91},{-33.68,-13.91}}, color={0,0,127}));
  connect(prescribedTemperature.T, T_Air.y)
    annotation (Line(points={{-17.2,80},{-69.2,80}}, color={0,0,127}));
  connect(prescribedTemperature.port, indoorSwimming.convPool) annotation (Line(
        points={{-4,80},{9.76,80},{9.76,29.32}}, color={191,0,0}));
  connect(PI.u_s, SetTemperature.y) annotation (Line(points={{91.6,4},{98,4},{
          98,30},{70,30},{70,42},{77.1,42}},
                             color={0,0,127}));
  connect(indoorSwimming.TPool, PI.u_m) annotation (Line(points={{17.92,0.28},{
          62,0.28},{62,18},{82,18},{82,13.6}}, color={0,0,127}));
  connect(vol.ports[1], indoorSwimming.port_a1) annotation (Line(points={{34,
          -13},{16,-13},{16,-14.9}}, color={0,127,255}));
  connect(vol.ports[2], indoorSwimming.port_b1) annotation (Line(points={{34,
          -11},{20,-11},{20,-22.82},{16,-22.82}}, color={0,127,255}));
  connect(prescribedHeatFlow.port, vol.heatPort)
    annotation (Line(points={{42,-40},{42,-22},{44,-22}}, color={191,0,0}));
  connect(PI.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{73.2,4},{
          66,4},{66,-20},{70,-20},{70,-40},{62,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        experiment(Tolerance=1e-6,StopTime=604800,Interval=900),
        __Dymola_Commands(file=
  "modelica://AixLib/Resources/Scripts/Dymola/Fluid/Pools/Examples/IndoorSwimmingPoolExternalHeatingSystem.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>Example model for an sport oriented indoor swimming pool with an external heat source. </p>
</html>"));
end IndoorSwimmingPoolExternalHeatingSystem;
