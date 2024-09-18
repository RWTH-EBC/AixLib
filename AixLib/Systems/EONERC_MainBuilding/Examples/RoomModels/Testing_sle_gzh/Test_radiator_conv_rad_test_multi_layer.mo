within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test_radiator_conv_rad_test_multi_layer

  AixLib.Fluid.Sources.MassFlowSource_T
                           source(
    redeclare package Medium = AixLib.Media.Water,
    use_T_in=true,
    m_flow=0.02761,
    T=328.15,
    nPorts=1) annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
  AixLib.Fluid.Sources.Boundary_pT
                        sink(redeclare package Medium = AixLib.Media.Water,
      nPorts=1)
    "Sink"
    annotation (Placement(transformation(extent={{108,-2},{88,18}})));
  AixLib.Fluid.FixedResistances.PressureDrop
                                      res(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    dp_nominal=100000)
    "Pipe"
    annotation (Placement(transformation(extent={{56,0},{76,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-178,22},{-158,42}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=convTemp.T)
    annotation (Placement(transformation(extent={{-180,6},{-160,26}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-140,22},{-120,42}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_Air "Value of Real output"
    annotation (Placement(transformation(extent={{-144,6},{-124,26}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=radiator.port_a.m_flow)
    annotation (Placement(transformation(extent={{-178,82},{-158,102}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow "Value of Real output"
    annotation (Placement(transformation(extent={{-140,82},{-120,102}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    T_start(displayUnit="K") = 293.15,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
        NominalPower=1157,
        RT_nom=Modelica.Units.Conversions.from_degC({55,45,20}),
        PressureDrop=1017878,
        Exponent=1.34,
        VolumeWater=10.2,
        MassSteel=46.1,
        DensitySteel=7900,
        CapacitySteel=551,
        LambdaSteel=60,
        Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator22,
        length=2.4,
        height=0.9),
    N=6,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{-4,2},{16,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=radiator.FlowTemperature.T)
    annotation (Placement(transformation(extent={{-178,38},{-158,58}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_sensor "Value of Real output"
    annotation (Placement(transformation(extent={{-138,38},{-118,58}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=radiator.ConvectiveHeat.Q_flow)
    annotation (Placement(transformation(extent={{-178,68},{-158,88}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Value of Real output"
    annotation (Placement(transformation(extent={{-142,68},{-122,88}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=radiator.RadiativeHeat.Q_flow)
    annotation (Placement(transformation(extent={{-178,54},{-158,74}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad "Value of Real output"
    annotation (Placement(transformation(extent={{-142,54},{-122,74}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature convTemp(T=293.15)
    "Convetive heat"
    annotation (Placement(transformation(extent={{-28,52},{-8,72}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature radTemp(T=293.15)
    "Radiative heat"
    annotation (Placement(transformation(extent={{32,52},{12,72}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{118,86},{138,106}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{118,70},{138,90}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{118,54},{138,74}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{116,36},{136,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=radiator.multiLayer_HE[
        1].convective.Q_flow)
    annotation (Placement(transformation(extent={{118,20},{138,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=radiator.multiLayer_HE[
        1].FlowTemperature.T)
    annotation (Placement(transformation(extent={{118,-12},{138,8}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=radiator.multiLayer_HE[
        1].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{118,-26},{138,-6}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{154,86},
            {174,106}}),     iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{154,70},
            {174,90}}),        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,54},{174,74}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,36},{174,56}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,20},{174,40}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,-12},{174,8}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,-26},{174,-6}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=radiator.multiLayer_HE[
        1].radiative.Q_flow)
    annotation (Placement(transformation(extent={{118,6},{138,26}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad1 "Value of Real output"
    annotation (Placement(transformation(extent={{154,6},{174,26}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-270,-56},{-250,-36}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-224,-70},{-204,-50}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-260,-90},{-240,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=radiator.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-302,-90},{-282,-70}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-184,-72},{-172,-60}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-210,-102},{-190,-82}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-136,-88},{-116,-68}})));
  Modelica.Blocks.Interfaces.RealInput T_in "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-106,-16},{-66,24}})));
equation
  connect(res.port_b,sink. ports[1])
    annotation (Line(points={{76,10},{76,8},{88,8}},color={0,127,255}));
  connect(realExpression34.y,T_flow_out)
    annotation (Line(points={{-157,32},{-130,32}},   color={0,0,127}));
  connect(realExpression4.y, T_Air)
    annotation (Line(points={{-159,16},{-134,16}},
                                                 color={0,0,127}));
  connect(realExpression5.y, m_flow)
    annotation (Line(points={{-157,92},{-130,92}}, color={0,0,127}));
  connect(radiator.port_a, source.ports[1]) annotation (Line(points={{-4,12},{
          -40,12}},                  color={0,127,255}));
  connect(radiator.port_b, res.port_a) annotation (Line(points={{16,12},{36,12},
          {36,10},{56,10}},color={0,127,255}));
  connect(realExpression7.y, T_flow_sensor) annotation (Line(points={{-157,48},
          {-128,48}},                     color={0,0,127}));
  connect(realExpression2.y, Q_conv)
    annotation (Line(points={{-157,78},{-132,78}}, color={0,0,127}));
  connect(realExpression3.y, Q_rad)
    annotation (Line(points={{-157,64},{-132,64}}, color={0,0,127}));
  connect(radTemp.port, radiator.RadiativeHeat)
    annotation (Line(points={{12,62},{10,62},{10,14}},    color={191,0,0}));
  connect(convTemp.port, radiator.ConvectiveHeat) annotation (Line(
        points={{-8,62},{-4,62},{-4,14},{4,14}}, color={191,0,0}));
  connect(realExpression30.y,T_radwall_inside1)
    annotation (Line(points={{139,96},{164,96}}, color={0,0,127}));
  connect(realExpression31.y,T_radwall_outside1)
    annotation (Line(points={{139,80},{164,80}},     color={0,0,127}));
  connect(realExpression32.y, T_radiator_m_1)
    annotation (Line(points={{139,64},{164,64}}, color={0,0,127}));
  connect(realExpression6.y, Q_flow1)
    annotation (Line(points={{137,46},{164,46}}, color={0,0,127}));
  connect(realExpression8.y, Q_conv1)
    annotation (Line(points={{139,30},{164,30}}, color={0,0,127}));
  connect(realExpression19.y, T_flow_in1)
    annotation (Line(points={{139,-2},{164,-2}}, color={0,0,127}));
  connect(realExpression20.y, T_flow_out1)
    annotation (Line(points={{139,-16},{164,-16}}, color={0,0,127}));
  connect(Q_rad, Q_rad)
    annotation (Line(points={{-132,64},{-132,64}}, color={0,0,127}));
  connect(realExpression1.y, Q_rad1)
    annotation (Line(points={{139,16},{164,16}}, color={0,0,127}));
  connect(realExpression43.y, add.u1) annotation (Line(points={{-249,-46},{-236,
          -46},{-236,-54},{-226,-54}},         color={0,0,127}));
  connect(realExpression44.y, gain.u)
    annotation (Line(points={{-281,-80},{-262,-80}},   color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(points={{-239,-80},{-232,-80},{-232,
          -74},{-234,-74},{-234,-66},{-226,-66}},          color={0,0,127}));
  connect(add.y, multiProduct.u[1]) annotation (Line(points={{-203,-60},{-190,
          -60},{-190,-67.05},{-184,-67.05}},    color={0,0,127}));
  connect(realExpression45.y, multiProduct.u[2]) annotation (Line(points={{-189,
          -92},{-184,-92},{-184,-76},{-188,-76},{-188,-64.95},{-184,-64.95}},
                     color={0,0,127}));
  connect(multiProduct.y, Q_flow_sum) annotation (Line(points={{-170.98,-66},{
          -142,-66},{-142,-78},{-126,-78}},    color={0,0,127}));
  connect(source.T_in, T_in) annotation (Line(points={{-62,16},{-74,16},{-74,4},
          {-86,4}}, color={0,0,127}));
  annotation (experiment(
      StopTime=86400,
      Interval=60,
      __Dymola_Algorithm="Dassl"));
end Test_radiator_conv_rad_test_multi_layer;
