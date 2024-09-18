within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Test_Radiator_w_roomcapa

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
  Modelica.Blocks.Sources.RealExpression realExpression4(y=roomCapacity.T)
    annotation (Placement(transformation(extent={{-212,16},{-192,36}})));
  Modelica.Blocks.Interfaces.RealOutput T_Air "Value of Real output"
    annotation (Placement(transformation(extent={{-176,16},{-156,36}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Fluid.HeatExchangers.Radiators.Radiator        radiator(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    T_start(displayUnit="K") = 293.15,
    selectable=true,
    radiatorType=AixLib.DataBase.Radiators.RadiatorBaseDataDefinition(
        NominalPower=496,
        RT_nom=Modelica.Units.Conversions.from_degC({55,45,20}),
        PressureDrop=1017878,
        Exponent=1.2776,
        VolumeWater=3.6,
        MassSteel=17.01,
        DensitySteel=7900,
        CapacitySteel=551,
        LambdaSteel=60,
        Type=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.RadiatorTypes.PanelRadiator10,
        length=2.6,
        height=0.3),
    N=6,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{-4,-2},{16,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=radiator.ConvectiveHeat.Q_flow)
    annotation (Placement(transformation(extent={{-210,-8},{-190,12}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Value of Real output"
    annotation (Placement(transformation(extent={{-174,-8},{-154,12}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=radiator.RadiativeHeat.Q_flow)
    annotation (Placement(transformation(extent={{-210,-26},{-190,-6}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad "Value of Real output"
    annotation (Placement(transformation(extent={{-174,-26},{-154,-6}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor roomCapacity(C=500000,
      T(start=293.15))
    annotation (Placement(transformation(extent={{-4,68},{16,88}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(extent={{40,44},{60,64}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
                                                         ambientTemperature
                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={88,54})));
  Modelica.Blocks.Sources.Constant convection_coefficient(k=5)
    annotation (Placement(transformation(extent={{78,74},{58,94}})));
  Modelica.Blocks.Sources.Sine ambient_Temperature(
    amplitude=15,
    f=1/86400,
    offset=273.15)
    annotation (Placement(transformation(extent={{138,44},{118,64}})));
  Modelica.Blocks.Sources.RealExpression realExpression43(y=source.ports[1].h_outflow)
    annotation (Placement(transformation(extent={{-280,-38},{-260,-18}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{-234,-52},{-214,-32}})));
  Modelica.Blocks.Math.Gain gain(k=-1)
    annotation (Placement(transformation(extent={{-270,-72},{-250,-52}})));
  Modelica.Blocks.Sources.RealExpression realExpression44(y=radiator.port_b.h_outflow)
    annotation (Placement(transformation(extent={{-312,-72},{-292,-52}})));
  Modelica.Blocks.Math.MultiProduct multiProduct(nu=2)
    annotation (Placement(transformation(extent={{-194,-54},{-182,-42}})));
  Modelica.Blocks.Sources.RealExpression realExpression45(y=source.m_flow)
    annotation (Placement(transformation(extent={{-220,-84},{-200,-64}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-146,-70},{-126,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-210,36},{-190,56}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=radiator.port_a.m_flow)
    annotation (Placement(transformation(extent={{-210,72},{-190,92}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=radiator.FlowTemperature.T)
    annotation (Placement(transformation(extent={{-210,52},{-190,72}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-172,36},{-152,56}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow "Value of Real output"
    annotation (Placement(transformation(extent={{-172,72},{-152,92}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_sensor "Value of Real output"
    annotation (Placement(transformation(extent={{-172,52},{-152,72}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{168,74},{188,94}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{168,58},{188,78}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{168,42},{188,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{166,24},{186,44}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=radiator.multiLayer_HE[
        1].convective.Q_flow)
    annotation (Placement(transformation(extent={{168,8},{188,28}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=radiator.multiLayer_HE[
        1].FlowTemperature.T)
    annotation (Placement(transformation(extent={{168,-24},{188,-4}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=radiator.multiLayer_HE[
        1].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{168,-38},{188,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=radiator.multiLayer_HE[
        1].radiative.Q_flow)
    annotation (Placement(transformation(extent={{168,-6},{188,14}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{204,74},
            {224,94}}),      iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{204,58},
            {224,78}}),        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,42},{224,62}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,24},{224,44}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,8},{224,28}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,-24},{224,-4}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,-38},{224,-18}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_rad1 "Value of Real output"
    annotation (Placement(transformation(extent={{204,-6},{224,14}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealInput T_in "Prescribed boundary temperature"
    annotation (Placement(transformation(extent={{-120,-6},{-80,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=radiator.multiLayer_HE[
        2].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{124,-68},{144,-48}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_2 "Value of Real output"
    annotation (Placement(transformation(extent={{160,-68},{180,-48}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=radiator.multiLayer_HE[
        3].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{124,-84},{144,-64}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_3 "Value of Real output"
    annotation (Placement(transformation(extent={{160,-84},{180,-64}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=radiator.multiLayer_HE[
        4].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{124,-98},{144,-78}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_4 "Value of Real output"
    annotation (Placement(transformation(extent={{160,-98},{180,-78}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=radiator.multiLayer_HE[
        5].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{122,-116},{142,-96}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_5 "Value of Real output"
    annotation (Placement(transformation(extent={{162,-116},{182,-96}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=radiator.multiLayer_HE[
        6].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{202,-66},{222,-46}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_6 "Value of Real output"
    annotation (Placement(transformation(extent={{238,-66},{258,-46}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
equation
  connect(res.port_b,sink. ports[1])
    annotation (Line(points={{76,10},{76,8},{88,8}},color={0,127,255}));
  connect(realExpression4.y, T_Air)
    annotation (Line(points={{-191,26},{-166,26}},
                                                 color={0,0,127}));
  connect(radiator.port_a, source.ports[1]) annotation (Line(points={{-4,8},{
          -34,8},{-34,12},{-40,12}}, color={0,127,255}));
  connect(radiator.port_b, res.port_a) annotation (Line(points={{16,8},{18,8},{
          18,10},{56,10}}, color={0,127,255}));
  connect(realExpression2.y, Q_conv)
    annotation (Line(points={{-189,2},{-164,2}},   color={0,0,127}));
  connect(realExpression3.y, Q_rad)
    annotation (Line(points={{-189,-16},{-164,-16}}, color={0,0,127}));
  connect(radiator.ConvectiveHeat, roomCapacity.port) annotation (Line(points={{4,10},{
          -10,10},{-10,62},{6,62},{6,68}},  color={191,0,0}));
  connect(ambientTemperature.port,convection. fluid)
    annotation (Line(points={{78,54},{60,54}}, color={191,0,0}));
  connect(convection_coefficient.y,convection. Gc)
    annotation (Line(points={{57,84},{50,84},{50,64}},color={0,0,127}));
  connect(ambientTemperature.T,ambient_Temperature. y)
    annotation (Line(points={{100,54},{117,54}},
                                             color={0,0,127}));
  connect(convection.solid, roomCapacity.port)
    annotation (Line(points={{40,54},{6,54},{6,68}},
                                              color={191,0,0}));
  connect(realExpression43.y, add.u1) annotation (Line(points={{-259,-28},{-246,
          -28},{-246,-36},{-236,-36}}, color={0,0,127}));
  connect(realExpression44.y, gain.u)
    annotation (Line(points={{-291,-62},{-272,-62}}, color={0,0,127}));
  connect(gain.y, add.u2) annotation (Line(points={{-249,-62},{-242,-62},{-242,
          -56},{-244,-56},{-244,-48},{-236,-48}}, color={0,0,127}));
  connect(add.y, multiProduct.u[1]) annotation (Line(points={{-213,-42},{-200,
          -42},{-200,-49.05},{-194,-49.05}}, color={0,0,127}));
  connect(realExpression45.y, multiProduct.u[2]) annotation (Line(points={{-199,
          -74},{-194,-74},{-194,-58},{-198,-58},{-198,-46.95},{-194,-46.95}},
        color={0,0,127}));
  connect(multiProduct.y, Q_flow_sum) annotation (Line(points={{-180.98,-48},{
          -152,-48},{-152,-60},{-136,-60}}, color={0,0,127}));
  connect(realExpression34.y,T_flow_out)
    annotation (Line(points={{-189,46},{-162,46}},   color={0,0,127}));
  connect(realExpression5.y,m_flow)
    annotation (Line(points={{-189,82},{-162,82}}, color={0,0,127}));
  connect(realExpression7.y,T_flow_sensor)  annotation (Line(points={{-189,62},
          {-162,62}},                     color={0,0,127}));
  connect(T_flow_out,T_flow_out)
    annotation (Line(points={{-162,46},{-162,46}}, color={0,0,127}));
  connect(realExpression30.y,T_radwall_inside1)
    annotation (Line(points={{189,84},{214,84}}, color={0,0,127}));
  connect(realExpression31.y,T_radwall_outside1)
    annotation (Line(points={{189,68},{214,68}},     color={0,0,127}));
  connect(realExpression32.y,T_radiator_m_1)
    annotation (Line(points={{189,52},{214,52}}, color={0,0,127}));
  connect(realExpression6.y,Q_flow1)
    annotation (Line(points={{187,34},{214,34}}, color={0,0,127}));
  connect(realExpression8.y,Q_conv1)
    annotation (Line(points={{189,18},{214,18}}, color={0,0,127}));
  connect(realExpression19.y,T_flow_in1)
    annotation (Line(points={{189,-14},{214,-14}},
                                                 color={0,0,127}));
  connect(realExpression20.y,T_flow_out1)
    annotation (Line(points={{189,-28},{214,-28}}, color={0,0,127}));
  connect(realExpression1.y,Q_rad1)
    annotation (Line(points={{189,4},{214,4}},   color={0,0,127}));
  connect(radiator.RadiativeHeat, roomCapacity.port)
    annotation (Line(points={{10,10},{18,10},{18,68},{6,68}}, color={0,0,0}));
  connect(source.T_in, T_in) annotation (Line(points={{-62,16},{-74,16},{-74,14},
          {-100,14}}, color={0,0,127}));
  connect(realExpression9.y, T_radiator_m_2)
    annotation (Line(points={{145,-58},{170,-58}}, color={0,0,127}));
  connect(realExpression10.y,T_radiator_m_3)
    annotation (Line(points={{145,-74},{170,-74}},
                                                 color={0,0,127}));
  connect(realExpression11.y,T_radiator_m_4)
    annotation (Line(points={{145,-88},{170,-88}},
                                                 color={0,0,127}));
  connect(realExpression12.y,T_radiator_m_5)
    annotation (Line(points={{143,-106},{172,-106}},
                                                 color={0,0,127}));
  connect(realExpression13.y,T_radiator_m_6)
    annotation (Line(points={{223,-56},{248,-56}},
                                                 color={0,0,127}));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Test_Radiator_w_roomcapa;
