within AixLib.Building.Benchmark.Test;
model Office_Test
replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
      replaceable package Medium_Air = AixLib.Media.Air
    "Medium in the component";
  Weather weather
    annotation (Placement(transformation(extent={{50,82},{70,102}})));
  Buildings.Office office
    annotation (Placement(transformation(extent={{30,0},{92,60}})));
  InternalLoads.InternalLoads internalLoads
    annotation (Placement(transformation(extent={{-48,50},{-8,10}})));
  Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium2 = Medium_Air,
    redeclare package Medium1 = Medium_Air,
    m1_flow_nominal=100,
    m2_flow_nominal=100)
    annotation (Placement(transformation(extent={{-8,9},{8,-9}},
        rotation=90,
        origin={11,58})));
  Regelungsbenchmark.Testcontroller testcontroller
    annotation (Placement(transformation(extent={{-98,74},{-78,94}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature[5](T=293.15)
    annotation (Placement(transformation(extent={{56,-40},{76,-20}})));
  Fluid.Sources.Boundary_pT bou2(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={16,-80})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature1
                                                                         [5](T=293.15)
    annotation (Placement(transformation(extent={{-92,-34},{-72,-14}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-2,-62})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Medium_Water,
    m_flow=1,
    nPorts=1,
    T=313.15) annotation (Placement(transformation(extent={{-52,-64},{-32,-44}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = Medium_Water,
    m_flow=1,
    nPorts=1,
    T=313.15)
    annotation (Placement(transformation(extent={{-58,-106},{-38,-86}})));
  Transfer.Transfer_RLT.Full_Transfer_RLT full_Transfer_RLT(riseTime_valve=1)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
equation
  connect(weather.SolarRadiation_OrientedSurfaces1,office. SolarRadiationPort)
    annotation (Line(points={{51,99},{22,99},{22,54},{30,54}}, color={255,128,0}));
  connect(weather.Air_out,Ext_Warm. port_a2)
    annotation (Line(points={{50,90},{5.6,90},{5.6,66}},
                                                     color={0,127,255}));
  connect(weather.Air_in,Ext_Warm. port_b1)
    annotation (Line(points={{50,86},{16.4,86},{16.4,66}},
                                                       color={0,127,255}));
  connect(Ext_Warm.port_a1,office. Air_out) annotation (Line(points={{16.4,50},
          {16,50},{16,-10},{36.2,-10},{36.2,0}},
                                             color={0,127,255}));
  connect(internalLoads.AddPower,office. AddPower)
    annotation (Line(points={{-9.2,18},{30,18}}, color={191,0,0}));
  connect(internalLoads.internalBus, office.internalBus) annotation (Line(
      points={{-9.6,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(office.measureBus, weather.measureBus) annotation (Line(
      points={{30,30},{10,30},{10,76},{66,76},{66,82}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.internalBus, office.internalBus) annotation (Line(
      points={{70,92},{86,92},{86,70},{-2,70},{-2,42},{30,42}},
      color={255,204,51},
      thickness=0.5));
  connect(weather.controlBus, testcontroller.controlBus) annotation (Line(
      points={{54,82},{-78,82}},
      color={255,204,51},
      thickness=0.5));
  connect(fixedTemperature.port, office.Heatport_TBA)
    annotation (Line(points={{76,-30},{79.6,-30},{79.6,0}}, color={191,0,0}));
  connect(boundary.ports[1],full_Transfer_RLT. Fluid_in_hot) annotation (Line(
        points={{-32,-54},{0,-54},{0,-52},{30,-52}},
                                                   color={0,127,255}));
  connect(bou1.ports[1],full_Transfer_RLT. Fluid_out_hot) annotation (Line(
        points={{-2,-66},{14,-66},{14,-56},{30,-56}},
                                                color={0,127,255}));
  connect(boundary1.ports[1],full_Transfer_RLT. Fluid_in_cold) annotation (Line(
        points={{-38,-96},{-4,-96},{-4,-64},{30,-64}},
                                                   color={0,127,255}));
  connect(full_Transfer_RLT.Fluid_out_cold,bou2. ports[1]) annotation (Line(
        points={{30,-68},{24,-68},{24,-84},{16,-84}},
                                                    color={0,127,255}));
  connect(fixedTemperature1.port, full_Transfer_RLT.heatPort)
    annotation (Line(points={{-72,-24},{40,-24},{40,-50}}, color={191,0,0}));
  connect(full_Transfer_RLT.Air_out, office.Air_in) annotation (Line(points={{
          44,-50},{46,-50},{46,0},{48.6,0}}, color={0,127,255}));
  connect(Ext_Warm.port_b2, full_Transfer_RLT.Air_in) annotation (Line(points={
          {5.6,50},{4,50},{4,-36},{36,-36},{36,-50}}, color={0,127,255}));
  connect(full_Transfer_RLT.controlBus, testcontroller.controlBus) annotation (
      Line(
      points={{50.2,-57.2},{-78,-57.2},{-78,82}},
      color={255,204,51},
      thickness=0.5));
  connect(full_Transfer_RLT.measureBus, weather.measureBus) annotation (Line(
      points={{50.2,-63},{50.2,9.5},{66,9.5},{66,82}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Office_Test;
