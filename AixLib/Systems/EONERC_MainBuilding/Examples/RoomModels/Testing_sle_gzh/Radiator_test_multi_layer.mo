within AixLib.Systems.EONERC_MainBuilding.Examples.RoomModels.Testing_sle_gzh;
model Radiator_test_multi_layer

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
    annotation (Placement(transformation(extent={{104,0},{84,20}})));
  AixLib.Fluid.FixedResistances.PressureDrop
                                      res(
    redeclare package Medium = AixLib.Media.Water,
    m_flow_nominal=1,
    dp_nominal=100000)
    "Pipe"
    annotation (Placement(transformation(extent={{56,0},{76,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression30(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{124,82},{144,102}})));
  Modelica.Blocks.Sources.RealExpression realExpression31(y=radiator.multiLayer_HE[
        1].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{124,66},{144,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression32(y=radiator.multiLayer_HE[
        1].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{124,50},{144,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression34(y=radiator.ReturnTemperature.T)
    annotation (Placement(transformation(extent={{-268,38},{-248,58}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=radiator.multiLayer_HE[
        1].heatConv_Radiator.port_b.T)
    annotation (Placement(transformation(extent={{-268,20},{-248,40}})));
  AixLib.Utilities.Interfaces.RadPort RadiativeHeat1
                                                    "Radiative heat port to room"
    annotation (Placement(transformation(extent={{16,34},{36,54}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside1
    "Value of Real output" annotation (Placement(transformation(extent={{160,82},
            {180,102}}),     iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside1
    "Value of Real output" annotation (Placement(transformation(extent={{160,66},
            {180,86}}),        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_1 "Value of Real output"
    annotation (Placement(transformation(extent={{160,50},{180,70}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out "Value of Real output"
    annotation (Placement(transformation(extent={{-230,38},{-210,58}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_Air "Value of Real output"
    annotation (Placement(transformation(extent={{-230,20},{-210,40}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression5(y=radiator.port_a.m_flow)
    annotation (Placement(transformation(extent={{-268,74},{-248,94}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow "Value of Real output"
    annotation (Placement(transformation(extent={{-230,74},{-210,94}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{122,32},{142,52}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1 "Value of Real output"
    annotation (Placement(transformation(extent={{160,32},{180,52}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.Sine T_flow_input(
    amplitude=15,
    f=1/43200,
    offset=328.15)
    annotation (Placement(transformation(extent={{-56,-40},{-76,-20}})));
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
    N=4,
    calc_dT=AixLib.Fluid.HeatExchangers.Radiators.BaseClasses.CalcExcessTemp.exp)
    "Radiator"
    annotation (Placement(transformation(extent={{-4,-2},{16,18}})));
  Modelica.Blocks.Sources.RealExpression realExpression7(y=radiator.FlowTemperature.T)
    annotation (Placement(transformation(extent={{-268,54},{-248,74}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_sensor "Value of Real output"
    annotation (Placement(transformation(extent={{-230,54},{-210,74}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature convTemp(T=283.15)
    "Convetive heat"
    annotation (Placement(transformation(extent={{-32,24},{-12,44}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=radiator.multiLayer_HE[
        1].convective.Q_flow)
    annotation (Placement(transformation(extent={{124,16},{144,36}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv1 "Value of Real output"
    annotation (Placement(transformation(extent={{160,16},{180,36}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=radiator.multiLayer_HE[
        2].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{196,82},{216,102}})));
  Modelica.Blocks.Sources.RealExpression realExpression6(y=radiator.multiLayer_HE[
        2].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{198,66},{218,86}})));
  Modelica.Blocks.Sources.RealExpression realExpression8(y=radiator.multiLayer_HE[
        2].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{198,50},{218,70}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside2
    "Value of Real output" annotation (Placement(transformation(extent={{232,82},
            {252,102}}),     iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside2
    "Value of Real output" annotation (Placement(transformation(extent={{234,66},
            {254,86}}),        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_2 "Value of Real output"
    annotation (Placement(transformation(extent={{238,52},{258,72}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression9(y=radiator.multiLayer_HE[
        2].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{198,34},{218,54}})));
  Modelica.Blocks.Sources.RealExpression realExpression10(y=radiator.multiLayer_HE[
        2].convective.Q_flow)
    annotation (Placement(transformation(extent={{198,16},{218,36}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow2 "Value of Real output"
    annotation (Placement(transformation(extent={{234,34},{254,54}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv2 "Value of Real output"
    annotation (Placement(transformation(extent={{234,16},{254,36}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression11(y=convTemp.port.Q_flow)
    annotation (Placement(transformation(extent={{-268,4},{-248,24}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv "Value of Real output"
    annotation (Placement(transformation(extent={{-230,4},{-210,24}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression12(y=radiator.multiLayer_HE[
        3].radiator_wall.port_a.T)
    annotation (Placement(transformation(extent={{126,-38},{146,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression13(y=radiator.multiLayer_HE[
        3].radiator_wall.port_b.T)
    annotation (Placement(transformation(extent={{126,-52},{146,-32}})));
  Modelica.Blocks.Sources.RealExpression realExpression14(y=radiator.multiLayer_HE[
        3].radiator_wall.heatCapacitor.T)
    annotation (Placement(transformation(extent={{126,-68},{146,-48}})));
  Modelica.Blocks.Sources.RealExpression realExpression15(y=radiator.multiLayer_HE[
        3].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{126,-82},{146,-62}})));
  Modelica.Blocks.Sources.RealExpression realExpression16(y=radiator.multiLayer_HE[
        3].convective.Q_flow)
    annotation (Placement(transformation(extent={{126,-98},{146,-78}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_inside3
    "Value of Real output" annotation (Placement(transformation(extent={{160,-38},
            {180,-18}}),     iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radwall_outside3
    "Value of Real output" annotation (Placement(transformation(extent={{162,-52},
            {182,-32}}),       iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_radiator_m_3 "Value of Real output"
    annotation (Placement(transformation(extent={{164,-68},{184,-48}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow3 "Value of Real output"
    annotation (Placement(transformation(extent={{162,-82},{182,-62}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput Q_conv3 "Value of Real output"
    annotation (Placement(transformation(extent={{164,-98},{184,-78}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression17(y=radiator.multiLayer_HE[
        1].FlowTemperature.T)
    annotation (Placement(transformation(extent={{124,0},{144,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression18(y=radiator.multiLayer_HE[
        1].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{124,-14},{144,6}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in1 "Value of Real output"
    annotation (Placement(transformation(extent={{160,0},{180,20}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out1 "Value of Real output"
    annotation (Placement(transformation(extent={{160,-14},{180,6}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression19(y=radiator.multiLayer_HE[
        2].FlowTemperature.T)
    annotation (Placement(transformation(extent={{198,2},{218,22}})));
  Modelica.Blocks.Sources.RealExpression realExpression20(y=radiator.multiLayer_HE[
        2].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{198,-12},{218,8}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in2 "Value of Real output"
    annotation (Placement(transformation(extent={{234,2},{254,22}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out2 "Value of Real output"
    annotation (Placement(transformation(extent={{234,-12},{254,8}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Sources.RealExpression realExpression21(y=radiator.multiLayer_HE[
        3].FlowTemperature.T)
    annotation (Placement(transformation(extent={{126,-112},{146,-92}})));
  Modelica.Blocks.Sources.RealExpression realExpression22(y=radiator.multiLayer_HE[
        3].ReturnTemperature.T)
    annotation (Placement(transformation(extent={{126,-126},{146,-106}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_in3 "Value of Real output"
    annotation (Placement(transformation(extent={{162,-112},{182,-92}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Interfaces.RealOutput T_flow_out3 "Value of Real output"
    annotation (Placement(transformation(extent={{162,-126},{182,-106}}),
        iconTransformation(extent={{282,-88},{302,-68}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=5)
    annotation (Placement(transformation(extent={{-236,-22},{-224,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_sum "Value of Real output"
    annotation (Placement(transformation(extent={{-202,-32},{-182,-12}})));
  Modelica.Blocks.Sources.RealExpression realExpression23(y=radiator.multiLayer_HE[
        1].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-270,-18},{-250,2}})));
  Modelica.Blocks.Sources.RealExpression realExpression24(y=radiator.multiLayer_HE[
        2].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-272,-32},{-252,-12}})));
  Modelica.Blocks.Sources.RealExpression realExpression25(y=radiator.multiLayer_HE[
        3].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-272,-50},{-252,-30}})));
  Modelica.Blocks.Sources.Constant convection_coefficient(k=328.15)
    annotation (Placement(transformation(extent={{-82,42},{-102,62}})));
  Modelica.Blocks.Sources.RealExpression realExpression26(y=radiator.multiLayer_HE[
        4].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-272,-66},{-252,-46}})));
  Modelica.Blocks.Sources.RealExpression realExpression27(y=radiator.multiLayer_HE[
        5].radiator_wall.port_a.Q_flow)
    annotation (Placement(transformation(extent={{-274,-84},{-254,-64}})));
equation
  connect(res.port_b,sink. ports[1])
    annotation (Line(points={{76,10},{84,10}},      color={0,127,255}));
  connect(realExpression30.y,T_radwall_inside1)
    annotation (Line(points={{145,92},{170,92}}, color={0,0,127}));
  connect(realExpression31.y,T_radwall_outside1)
    annotation (Line(points={{145,76},{170,76}},     color={0,0,127}));
  connect(realExpression32.y, T_radiator_m_1)
    annotation (Line(points={{145,60},{170,60}}, color={0,0,127}));
  connect(realExpression34.y,T_flow_out)
    annotation (Line(points={{-247,48},{-220,48}},   color={0,0,127}));
  connect(realExpression4.y, T_Air)
    annotation (Line(points={{-247,30},{-220,30}},
                                                 color={0,0,127}));
  connect(realExpression5.y, m_flow)
    annotation (Line(points={{-247,84},{-220,84}}, color={0,0,127}));
  connect(realExpression1.y, Q_flow1)
    annotation (Line(points={{143,42},{170,42}}, color={0,0,127}));
  connect(radiator.port_a, source.ports[1]) annotation (Line(points={{-4,8},{
          -34,8},{-34,12},{-40,12}}, color={0,127,255}));
  connect(radiator.port_b, res.port_a) annotation (Line(points={{16,8},{18,8},{
          18,10},{56,10}}, color={0,127,255}));
  connect(RadiativeHeat1, radiator.RadiativeHeat)
    annotation (Line(points={{26,44},{26,24},{10,24},{10,10}}, color={0,0,0}));
  connect(realExpression7.y, T_flow_sensor) annotation (Line(points={{-247,64},
          {-220,64}},                     color={0,0,127}));
  connect(convTemp.port, radiator.ConvectiveHeat) annotation (Line(points={{-12,
          34},{-10,34},{-10,10},{4,10}}, color={191,0,0}));
  connect(realExpression2.y, Q_conv1)
    annotation (Line(points={{145,26},{170,26}}, color={0,0,127}));
  connect(realExpression3.y, T_radwall_inside2)
    annotation (Line(points={{217,92},{242,92}}, color={0,0,127}));
  connect(realExpression6.y, T_radwall_outside2)
    annotation (Line(points={{219,76},{244,76}}, color={0,0,127}));
  connect(realExpression8.y, T_radiator_m_2) annotation (Line(points={{219,60},
          {232,60},{232,62},{248,62}}, color={0,0,127}));
  connect(realExpression9.y, Q_flow2)
    annotation (Line(points={{219,44},{244,44}}, color={0,0,127}));
  connect(realExpression10.y, Q_conv2)
    annotation (Line(points={{219,26},{244,26}}, color={0,0,127}));
  connect(realExpression11.y, Q_conv)
    annotation (Line(points={{-247,14},{-220,14}}, color={0,0,127}));
  connect(realExpression12.y, T_radwall_inside3)
    annotation (Line(points={{147,-28},{170,-28}}, color={0,0,127}));
  connect(realExpression13.y, T_radwall_outside3)
    annotation (Line(points={{147,-42},{172,-42}}, color={0,0,127}));
  connect(realExpression14.y, T_radiator_m_3)
    annotation (Line(points={{147,-58},{174,-58}}, color={0,0,127}));
  connect(realExpression15.y, Q_flow3)
    annotation (Line(points={{147,-72},{172,-72}}, color={0,0,127}));
  connect(realExpression16.y, Q_conv3)
    annotation (Line(points={{147,-88},{174,-88}}, color={0,0,127}));
  connect(T_flow_out, T_flow_out)
    annotation (Line(points={{-220,48},{-220,48}}, color={0,0,127}));
  connect(realExpression17.y, T_flow_in1)
    annotation (Line(points={{145,10},{170,10}}, color={0,0,127}));
  connect(realExpression18.y, T_flow_out1)
    annotation (Line(points={{145,-4},{170,-4}}, color={0,0,127}));
  connect(realExpression19.y, T_flow_in2)
    annotation (Line(points={{219,12},{244,12}}, color={0,0,127}));
  connect(realExpression20.y, T_flow_out2)
    annotation (Line(points={{219,-2},{244,-2}}, color={0,0,127}));
  connect(realExpression21.y, T_flow_in3)
    annotation (Line(points={{147,-102},{172,-102}}, color={0,0,127}));
  connect(realExpression22.y, T_flow_out3)
    annotation (Line(points={{147,-116},{172,-116}}, color={0,0,127}));
  connect(multiSum.y, Q_flow_sum) annotation (Line(points={{-222.98,-16},{-208,
          -16},{-208,-22},{-192,-22}}, color={0,0,127}));
  connect(realExpression23.y, multiSum.u[1]) annotation (Line(points={{-249,-8},
          {-244,-8},{-244,-17.68},{-236,-17.68}}, color={0,0,127}));
  connect(realExpression24.y, multiSum.u[2]) annotation (Line(points={{-251,-22},
          {-242,-22},{-242,-16.84},{-236,-16.84}}, color={0,0,127}));
  connect(realExpression25.y, multiSum.u[3]) annotation (Line(points={{-251,-40},
          {-242,-40},{-242,-16},{-236,-16}}, color={0,0,127}));
  connect(convection_coefficient.y, source.T_in) annotation (Line(points={{-103,
          52},{-108,52},{-108,16},{-62,16}}, color={0,0,127}));
  connect(realExpression26.y, multiSum.u[4]) annotation (Line(points={{-251,-56},
          {-251,-15.16},{-236,-15.16}}, color={0,0,127}));
  connect(realExpression27.y, multiSum.u[5]) annotation (Line(points={{-253,-74},
          {-236,-74},{-236,-14.32}}, color={0,0,127}));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Radiator_test_multi_layer;
