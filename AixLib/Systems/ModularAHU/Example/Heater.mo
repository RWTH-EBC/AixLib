within AixLib.Systems.ModularAHU.Example;
model Heater "Heating register"
  extends Modelica.Icons.Example;
    package MediumWater = AixLib.Media.Water
    annotation (choicesAllMatching=true);
  package MediumAir = AixLib.Media.Air
    annotation (choicesAllMatching=true);


  RegisterModule registerModule(
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=1,
    m2_flow_nominal=0.1,
    redeclare package Medium1 = MediumAir,
    dynamicHX(
      dp1_nominal=100,
      dp2_nominal=6000,
      dT_nom=20,
      Q_nom=30000,
      redeclare AixLib.Fluid.MixingVolumes.MixingVolume vol1,
      redeclare AixLib.Fluid.MixingVolumes.MixingVolume vol2),
    T_amb=293.15,
    redeclare HydraulicModules.Admix partialHydraulicModule(
      dIns=0.01,
      kIns=0.028,
      d=0.032,
      length=1,
      Kv=6.3,
      redeclare
        AixLib.Systems.HydraulicModules.BaseClasses.PumpInterface_SpeedControlledNrpm
        PumpInterface(pump(redeclare
            AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 per))))
    annotation (Placement(transformation(extent={{-40,-44},{20,34}})));
  Fluid.Sources.Boundary_pT          boundary(
    nPorts=1,
    redeclare package Medium = MediumWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-42,-70})));
  Fluid.Sources.Boundary_pT          boundary1(
    nPorts=1,
    redeclare package Medium = MediumWater,
    T=323.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={22,-70})));
  Fluid.Sources.Boundary_pT boundaryAirSource(
    nPorts=1,
    redeclare package Medium = MediumAir,
    p=102000,
    T=288.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-82,38})));
  Fluid.Sources.Boundary_pT boundaryAirSink(nPorts=1, redeclare package Medium
      = MediumAir) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
  BaseClasses.registerBus registerBus1 annotation (Placement(transformation(
          extent={{-70,-10},{-50,10}}), iconTransformation(extent={{-72,-12},{
            -52,8}})));
  Modelica.Blocks.Sources.Ramp valveOpening(              duration=500,
      startTime=180)
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Modelica.Blocks.Sources.Constant RPM(k=2000)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
equation
  connect(boundary1.ports[1], registerModule.port_b2) annotation (Line(points={
          {22,-60},{24,-60},{24,-20},{20,-20}}, color={0,127,255}));
  connect(boundary.ports[1], registerModule.port_a2) annotation (Line(points={{
          -42,-60},{-42,-20},{-40,-20}}, color={0,127,255}));
  connect(registerModule.port_b1, boundaryAirSink.ports[1]) annotation (Line(
        points={{20,16},{44,16},{44,40},{70,40}}, color={0,127,255}));
  connect(registerModule.port_a1, boundaryAirSource.ports[1]) annotation (Line(
        points={{-40,16},{-46,16},{-46,36},{-72,36},{-72,38}}, color={0,127,255}));
  connect(registerModule.registerBus, registerBus1) annotation (Line(
      points={{-39.7,-2.3},{-60,-2.3},{-60,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(RPM.y, registerBus1.hydraulicBus.pumpBus.rpm_Input) annotation (Line(
        points={{-79,0},{-72,0},{-72,0.05},{-59.95,0.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(valveOpening.y, registerBus1.hydraulicBus.valSet) annotation (Line(
        points={{-79,-40},{-59.95,-40},{-59.95,0.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
end Heater;
