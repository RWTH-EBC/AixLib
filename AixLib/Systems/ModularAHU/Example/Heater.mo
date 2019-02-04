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
    annotation (Placement(transformation(extent={{-38,-40},{22,38}})));
  Fluid.Sources.Boundary_pT          boundary(
    nPorts=1,
    redeclare package Medium = MediumWater,
    T=343.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={-42,-70})));
  Fluid.Sources.Boundary_pT          boundary1(
    nPorts=1, redeclare package Medium = MediumWater)
              annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={22,-70})));
  Fluid.Sources.Boundary_pT boundaryAirSource(
    nPorts=1,
    redeclare package Medium = MediumAir,
    p=102000,
    T=283.15) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-82,38})));
  Fluid.Sources.Boundary_pT boundaryAirSink(nPorts=1, redeclare package Medium
      = MediumAir) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,40})));
  Controller.CtrBasic ctrBasic(
    k=0.04,
    Ti=100,
    Td=1) annotation (Placement(transformation(extent={{-70,-16},{-50,4}})));
  Modelica.Blocks.Sources.Constant Tset(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-100,-18},{-80,2}})));
equation
  connect(boundary1.ports[1], registerModule.port_b2) annotation (Line(points={
          {22,-60},{24,-60},{24,-16},{22,-16}}, color={0,127,255}));
  connect(boundary.ports[1], registerModule.port_a2) annotation (Line(points={{
          -42,-60},{-42,-16},{-38,-16}}, color={0,127,255}));
  connect(registerModule.port_b1, boundaryAirSink.ports[1]) annotation (Line(
        points={{22,20},{44,20},{44,40},{70,40}}, color={0,127,255}));
  connect(registerModule.port_a1, boundaryAirSource.ports[1]) annotation (Line(
        points={{-38,20},{-46,20},{-46,36},{-72,36},{-72,38}}, color={0,127,255}));
  connect(ctrBasic.registerBus, registerModule.registerBus) annotation (Line(
      points={{-51.8,-6},{-46,-6},{-46,1.7},{-37.7,1.7}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrBasic.Tset, Tset.y)
    annotation (Line(points={{-70.2,-8},{-79,-8}}, color={0,0,127}));
end Heater;
