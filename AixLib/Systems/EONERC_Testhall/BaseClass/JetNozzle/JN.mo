within AixLib.Systems.EONERC_Testhall.BaseClass.JetNozzle;
model JN "Reheater/Recooler jet nozzles"

    replaceable package MediumWater =
      AixLib.Media.Water "Medium in the heatingsystem/hydraulic" annotation (
      choicesAllMatching=true);
  replaceable package MediumAir =
      AixLib.Media.Air
    "Medium in the system" annotation(choicesAllMatching=true);

  AixLib.Fluid.Actuators.Valves.TwoWayLinear Valve_hall1(
    redeclare package Medium = MediumAir,
    m_flow_nominal=3.7,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=100,
    l=0.01)               annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={54,54})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness hx[10](
    redeclare package Medium1 = MediumAir,
    redeclare package Medium2 = MediumWater,
    m1_flow_nominal=3.7,
    m2_flow_nominal=2.1,
    eps=0.95,
    m1_flow_small=0.01,
    m2_flow_small=0.01,
    dp1_nominal=0,
    dp2_nominal=0) "Reheater"
    annotation (Placement(transformation(extent={{-2,-10},{-22,12}})));
  AixLib.Fluid.FixedResistances.GenericPipe pipe_outgoing_air(
    redeclare package Medium = MediumAir,
    parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_108x1_5(),
    length=1,
    m_flow_nominal=3.7) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-110,54})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_air_hall1(redeclare package
      Medium = MediumAir) "SUP"
    annotation (Placement(transformation(extent={{-170,44},{-150,64}}),
        iconTransformation(extent={{-86,70},{-66,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a heating_water_in(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{-168,-30},
            {-148,-10}}),    iconTransformation(extent={{-44,-50},{-24,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b heating_water_out(redeclare package
      Medium = MediumWater) annotation (Placement(transformation(extent={{164,-24},
            {184,-4}}),      iconTransformation(extent={{-74,-50},{-54,-30}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort
                                     T(redeclare package Medium = MediumAir,
      m_flow_nominal=3.7)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={82,54})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol_hot(
    nPorts=2,
    redeclare package Medium = MediumAir,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={102,42})));
  Modelica.Fluid.Interfaces.FluidPort_a air_RLT_SUP(redeclare package Medium =
        MediumAir) annotation (Placement(transformation(extent={{150,44},{170,64}}),
        iconTransformation(extent={{60,-50},{80,-30}})));
  Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus
    annotation (Placement(transformation(extent={{18,64},{42,90}}),
        iconTransformation(extent={{0,0},{0,0}})));
  Modelica.Fluid.Interfaces.FluidPort_a cool_water_in(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{-128,-58},{-110,
            -40}}),     iconTransformation(extent={{14,-50},{34,-30}})));
  Modelica.Fluid.Interfaces.FluidPort_b cool_water_out(redeclare package Medium =
        MediumWater) annotation (Placement(transformation(extent={{110,-56},{130,
            -36}}), iconTransformation(extent={{-12,-50},{8,-30}})));
  AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_in(redeclare package Medium =
        MediumWater,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=15,                  m_flow_nominal=2.3)
    annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  AixLib.Fluid.Actuators.Valves.ThreeWayLinear val_out(redeclare package Medium =
        MediumWater,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=15,                  m_flow_nominal=2.3)
    annotation (Placement(transformation(extent={{110,-24},{130,-4}})));
  AixLib.Fluid.Sources.Boundary_pT dummy_fernkaelte_ein(
    redeclare package Medium = MediumWater,
    T=281.15,
    nPorts=1,
    p=200000) "nominal mass flow 1 kg/s"
    annotation (Placement(transformation(extent={{-144,-74},{-124,-54}})));
  AixLib.Fluid.Sources.Boundary_ph dummy_fernkaelte_ais(
    redeclare package Medium = MediumWater,
    nPorts=1,
    p=100000)
    annotation (Placement(transformation(extent={{94,-76},{114,-56}})));
  AixLib.DataBase.Pumps.HydraulicModules.Throttle throttle[10](
    length=1,
    each parameterPipe=AixLib.DataBase.Pipes.Copper.Copper_40x1(),
    Kv=4,
    pipe1(length={3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5,3.5}),
    pipe2(length={8,8,8,8,8,8,6,6,6,6}),
    pipe3(length={11.5,11.5,11.5,11.5,11.5,11.5,9.5,9.5,9.5,9.5}),
    m_flow_nominal=2.3,
    redeclare package Medium = MediumWater,
    T_amb=273.15 + 10,
    T_start=323.15) "reheater jet nozzles" annotation (Placement(
        transformation(
        extent={{-26,-26},{26,26}},
        rotation=90,
        origin={-12,-46})));

  BaseClass.DistributeBus distributeBus_JN annotation (Placement(transformation(
          extent={{-88,94},{-52,132}}), iconTransformation(extent={{-112,-16},{
            -86,14}})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=11,
    redeclare package Medium = MediumAir,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-52,34})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol2(
    nPorts=11,
    redeclare package Medium = MediumAir,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={18,44})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol3(
    nPorts=11,
    redeclare package Medium = MediumWater,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-84,-58})));
  AixLib.Fluid.MixingVolumes.MixingVolume vol4(
    nPorts=11,
    redeclare package Medium = MediumWater,
    V=19,
    m_flow_nominal=4) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={54,-64})));
equation

  connect(pipe_outgoing_air.port_b, heating_air_hall1)
    annotation (Line(points={{-120,54},{-160,54}}, color={0,127,255}));
  connect(vol_hot.ports[1],T. port_b) annotation (Line(points={{103,52},{98,52},
          {98,54},{92,54}},     color={0,127,255}));
  connect(Valve_hall1.port_a, T.port_a) annotation (Line(points={{64,54},{72,54}},
                            color={0,127,255}));
  connect(vol_hot.ports[2], air_RLT_SUP) annotation (Line(points={{101,52},{108,
          52},{108,54},{160,54}},
                             color={0,127,255}));
  connect(Valve_hall1.y, controlBus.Hall1_Air_Valve)
    annotation (Line(points={{54,66},{54,77},{30,77}}, color={0,0,127}));
  connect(T.T, controlBus.Temperature_hot_air)
    annotation (Line(points={{82,65},{82,77},{30,77}}, color={0,0,127}));
  connect(val_in.port_1, heating_water_in)
    annotation (Line(points={{-130,-20},{-158,-20}}, color={0,127,255}));
  connect(val_in.port_3, cool_water_in) annotation (Line(points={{-120,-30},{-120,
          -49},{-119,-49}}, color={0,127,255}));
  connect(val_out.port_2, heating_water_out)
    annotation (Line(points={{130,-14},{174,-14}}, color={0,127,255}));
  connect(val_out.port_3, cool_water_out)
    annotation (Line(points={{120,-24},{120,-46}}, color={0,127,255}));
  connect(dummy_fernkaelte_ein.ports[1], cool_water_in) annotation (Line(points=
         {{-124,-64},{-119,-64},{-119,-49}}, color={0,127,255}));
  connect(dummy_fernkaelte_ais.ports[1], cool_water_out) annotation (Line(
        points={{114,-66},{118,-66},{118,-46},{120,-46}}, color={0,127,255}));
  connect(throttle.port_b1, hx.port_a2) annotation (Line(points={{-27.6,-20},{-27.6,
          -5.6},{-22,-5.6}}, color={0,127,255}));
  connect(hx.port_b2, throttle.port_a2) annotation (Line(points={{-2,-5.6},{4,-5.6},
          {4,-20},{3.6,-20}}, color={0,127,255}));
  connect(distributeBus_JN.controlBus_jn, controlBus) annotation (Line(
      points={{-70,113},{-21,113},{-21,77},{30,77}},
      color={255,204,51},
      thickness=0.5));
  connect(val_in.y, distributeBus_JN.bus_jn.val_in_set) annotation (Line(points=
         {{-120,-8},{-122,-8},{-122,113.095},{-69.91,113.095}}, color={0,0,127}));
  connect(val_out.y, distributeBus_JN.bus_jn.val_out_set) annotation (Line(
        points={{120,-2},{120,113.095},{-69.91,113.095}}, color={0,0,127}));
  connect(pipe_outgoing_air.port_a, vol1.ports[1]) annotation (Line(points={{-100,54},
          {-78,54},{-78,44},{-50.1818,44}},     color={0,127,255}));
  connect(hx.port_b1, vol1.ports[2:11]) annotation (Line(points={{-22,7.6},{-36,
          7.6},{-36,44},{-53.8182,44}}, color={0,127,255}));
  connect(hx.port_a1, vol2.ports[1:10]) annotation (Line(points={{-2,7.6},{2,
          7.6},{2,54},{16.5455,54}},
                                color={0,127,255}));
  connect(vol2.ports[11], Valve_hall1.port_b)
    annotation (Line(points={{16.1818,54},{44,54}}, color={0,127,255}));
  connect(val_in.port_2, vol3.ports[1]) annotation (Line(points={{-110,-20},{
          -96,-20},{-96,-48},{-82.1818,-48}},
                                          color={0,127,255}));
  connect(vol3.ports[2:11], throttle.port_a1) annotation (Line(points={{
          -85.8182,-48},{-70,-48},{-70,-72},{-27.6,-72}},
                                                 color={0,127,255}));
  connect(throttle.port_b2, vol4.ports[1:10]) annotation (Line(points={{3.6,-72},
          {32,-72},{32,-54},{52.5455,-54}}, color={0,127,255}));
  connect(vol4.ports[11], val_out.port_1) annotation (Line(points={{52.1818,-54},
          {66,-54},{66,-14},{110,-14}}, color={0,127,255}));
  connect(distributeBus_JN.bus_valve, throttle.hydraulicBus) annotation (Line(
      points={{-70,113},{-70,113},{-70,-46},{-38,-46}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-80},
            {160,120}}),graphics={Rectangle(
          extent={{-100,80},{100,-40}},
          lineColor={3,15,29},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid), Text(
          extent={{-58,46},{52,-2}},
          lineColor={3,15,29},
          fillColor={135,135,135},
          fillPattern=FillPattern.Solid,
          textString="JN")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-160,-80},{160,120}})));
end JN;
