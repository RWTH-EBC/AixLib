within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop;
model PumpControlledwithHP_V4_jonas
  "Substation model for low-temperature networks for buildings with reversible heat pump that civers heat, cold and dhw"

      replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water"
      annotation (choicesAllMatching = true);
      replaceable package MediumBuilding = AixLib.Media.Water
      "Medium in the building heating system"
      annotation (choicesAllMatching = true);

    parameter Modelica.SIunits.SpecificHeatCapacity cp_default = 4180 "Cp-value of Water";

    parameter Modelica.SIunits.HeatFlowRate heatDemand_max "maximum heat demand for scaling of heatpump in Watt";
//    parameter Modelica.SIunits.HeatFlowRate coolingDemand_max=-5000
//                                                              "maximum cooling demand for scaling of chiller in Watt (negative values)";
    parameter Modelica.SIunits.Temperature T_supplyHeating "set temperature of supply heating";
    parameter Modelica.SIunits.Temperature T_supplyCooling "set temperature of supply heating";

 //   parameter Modelica.SIunits.Temperature deltaT_heatingSet "set temperature difference for heating on the site of building";
 //   parameter Modelica.SIunits.Temperature deltaT_coolingSet "set temperature difference for cooling on the building site";

    parameter Modelica.SIunits.Pressure dp_nominal=400000                  "nominal pressure drop";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal=(heatDemand_max)/4180
      /10
    "Nominal mass flow rate";

public
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the warm line of the network"
    annotation (Placement(transformation(extent={{-270,-10},{-250,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium)
    "Fluid connector for connecting the substation to the cold line of the network"
    annotation (Placement(transformation(extent={{168,-10},{188,10}}),
        iconTransformation(extent={{168,-10},{188,10}})));

  Delays.DelayFirstOrder del1(
    redeclare package Medium = Medium,
    tau=600,
    nPorts=2,
    m_flow_nominal=2*m_flow_nominal,
    T_start=283.15)
    annotation (Placement(transformation(extent={{72,0},{92,20}})));

  Sensors.TemperatureTwoPort senTem(redeclare package Medium = Medium,m_flow_nominal=2*m_flow_nominal, tau=0,
    T_start=283.15)
    annotation (Placement(transformation(extent={{42,-10},{62,10}})));
  Sensors.TemperatureTwoPort senTem2(redeclare package Medium =Medium,allowFlowReversal=false, tau=0,
    m_flow_nominal=2*m_flow_nominal)
    annotation (Placement(transformation(extent={{-242,10},{-222,-10}})));
  Modelica.Blocks.Sources.RealExpression T_dhw(y=273.15 + 65)
    annotation (Placement(transformation(extent={{70,-84},{42,-66}})));
  MixingVolumes.MixingVolume vol2(
  redeclare package Medium = Medium,
    nPorts=2,
    m_flow_nominal=m_flow_nominal,
    V=0.15) annotation (Placement(transformation(extent={{-76,4},{-56,24}})));
  Sensors.TemperatureTwoPort senTem4(
  redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    tau=0,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    T_start=283.15)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.RealExpression cooling(y=if no_free_cool.y == true
         then 0 else cold_input)               annotation (Placement(
        transformation(
        extent={{-57.5,-11},{57.5,11}},
        rotation=0,
        origin={-159.5,57})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,14})));
  Movers.FlowControlled_m_flow Pump(
    redeclare package Medium = Medium,
    allowFlowReversal=false,
    m_flow_small=0.0001,
    use_inputFilter=true,
    y_start=1,
    m_flow_start=2*m_flow_nominal,
    nominalValuesDefineDefaultPressureCurve=false,
    addPowerToMedium=false,
    m_flow_nominal=2,
    dp_nominal=dp_nominal)
    annotation (Placement(transformation(extent={{-152,-10},{-132,10}})));
  HeatPumps.Carnot_TCon_RE heaPum(
    redeclare package Medium2 = Medium,
    redeclare package Medium1 = MediumBuilding,
    show_T=true,
    dTEva_nominal=-10,
    dTCon_nominal=10,
    etaCarnot_nominal=0.5,
    Q_heating_nominal=heatDemand_max,
    use_eta_Carnot_nominal=true,
    dp1_nominal=30000,
    dp2_nominal=30000,
    m2_flow_nominal=1,
    m1_flow_nominal=m_flow_nominal,
    Q_cooling_nominal=-15000,
    TEva_nominal=283.15)
    annotation (Placement(transformation(extent={{16,4},{-4,-16}})));
  Sources.Boundary_pT toHouse(redeclare package Medium = MediumBuilding, nPorts
      =1) annotation (Placement(transformation(extent={{-98,-52},{-78,-32}})));
  Sources.MassFlowSource_T fromHouse(
    redeclare package Medium =MediumBuilding,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{110,-48},{90,-28}})));
  Modelica.Blocks.Sources.RealExpression m_flow_return(y=m_flow_nominal)
    annotation (Placement(transformation(extent={{176,-38},{138,-18}})));
  Modelica.Blocks.Sources.RealExpression T_room_r(y=T_room.y - heat_input/(4180
        *m_flow_nominal))
    annotation (Placement(transformation(extent={{18,-142},{110,-122}})));
  Utilities.Sensors.FuelCounter fuelCounter
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,30})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={14,-62})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={130,-64})));
  Modelica.Blocks.Sources.RealExpression T_dhw_r(y=T_dhw.y - dhw_input/(4180*
        m_flow_nominal))
    "\"Return\" Temperature of the DHW should be the Network Tempearute of the drinkingwater network, if no HeatExchangers are installed in the shower f.e."
    annotation (Placement(transformation(extent={{14,-126},{112,-106}})));
  Modelica.Blocks.Logical.GreaterThreshold dhw(threshold=10)
    annotation (Placement(transformation(extent={{-50,-116},{-30,-96}})));
  Modelica.Blocks.Sources.TimeTable T_set_free_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        50; 2.2e+07,273.15 + 50; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-220,-80},{-200,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold no_free_cool(threshold=273.15 + 18)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-194,-34})));
  Modelica.Blocks.Sources.TimeTable T_set_active_cooling(table=[0,273.15 + 35; 7.0e+06,
        273.15 + 35; 7.0e+06,273.15 + 35; 1.2e+07,273.15 + 35; 1.2e+07,273.15 +
        10; 2.2e+07,273.15 + 10; 2.2e+07,273.15 + 35; 2.7e+07,273.15 + 35; 2.7e+07,
        273.15 + 35; 3.1536e+07,273.15 + 35])
    annotation (Placement(transformation(extent={{-134,-80},{-154,-60}})));
  Modelica.Blocks.Logical.Switch T_room annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-176,-82})));
  Utilities.Sensors.FuelCounter pump
    annotation (Placement(transformation(extent={{-132,12},{-112,32}})));
  Modelica.Blocks.Sources.RealExpression WinterMassFlow(y=if cooling.y == 0
         then (-1/9*(Lim50to95.y - 273.15) + 1.25) else (1/11*(Lim105to150.y -
        273.15) - 0.76))
    annotation (Placement(transformation(extent={{-4,84},{-244,104}})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{160,82},{180,102}})));
  Modelica.Blocks.Sources.RealExpression PowerConsumption(y=pump.counter +
        fuelCounter.counter)
    annotation (Placement(transformation(extent={{88,82},{128,104}})));
  Modelica.Blocks.Sources.RealExpression SummerMassFlow(y=(-1/9*(Lim50to95.y -
        273.15) + 1.15))
    annotation (Placement(transformation(extent={{-114,64},{-222,88}})));
  Modelica.Blocks.Nonlinear.Limiter Lim50to95(uMax=273.15 + 9.5, uMin=273.15 +
        5) annotation (Placement(transformation(extent={{38,22},{10,50}})));
  Modelica.Blocks.Sources.BooleanTable SummerWinterTable(startValue=false,
      table={0,1.2e+07,2.205e+07})
    annotation (Placement(transformation(extent={{-266,26},{-240,52}})));
  Modelica.Blocks.Logical.Switch MassFlowSwitch
    "Switch between the Summer and the Winter Mass Flow" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-162,26})));
  Modelica.Blocks.Nonlinear.Limiter Lim105to150(uMax=273.15 + 15, uMin=273.15
         + 10.5)
    annotation (Placement(transformation(extent={{38,68},{10,96}})));
  Modelica.Blocks.Interfaces.RealOutput dpOut
    annotation (Placement(transformation(extent={{160,58},{180,78}})));
  Modelica.Blocks.Sources.RealExpression PressureDrop(y=port_a.p - port_b.p)
    annotation (Placement(transformation(extent={{96,56},{122,80}})));
  Modelica.Blocks.Interfaces.RealInput heat_input
    "Input for heat demand profile of substation" annotation (Placement(
        transformation(extent={{-304,-44},{-264,-4}}),    iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput cold_input
    "Input for cooling demand profile of substation"
                                                 annotation (Placement(
        transformation(extent={{-304,-82},{-264,-42}}),   iconTransformation(
          extent={{232,76},{192,116}})));
  Modelica.Blocks.Interfaces.RealInput dhw_input
    "Input for dhw demand profile of substation, as a Volumentic Flow in Liters (l/s)"
                                                 annotation (Placement(
        transformation(extent={{-304,-126},{-264,-86}}),  iconTransformation(
          extent={{232,76},{192,116}})));
equation

  //Power Consumptin Calculation
  //connect(pumpCooling.P, sum1.u[3]);
  //connect(pumpHeating.P, sum1.u[4]);

  connect(del1.ports[1], port_b) annotation (Line(points={{80,0},{178,0}},
                       color={0,127,255}));
  connect(senTem.port_b, del1.ports[2]) annotation (Line(points={{62,0},{84,0}},
                              color={0,127,255}));
  connect(senTem4.port_b, heaPum.port_a2) annotation (Line(points={{-30,0},{-4,
          0}},                       color={0,127,255}));
  connect(heaPum.port_b2, senTem.port_a) annotation (Line(points={{16,0},{42,0}},
                              color={0,127,255}));
  connect(prescribedHeatFlow1.port, vol2.heatPort) annotation (Line(points={{-82,14},
          {-76,14}},                           color={191,0,0}));
  connect(m_flow_return.y, fromHouse.m_flow_in) annotation (Line(points={{136.1,
          -28},{124,-28},{124,-30},{112,-30}}, color={0,0,127}));
  connect(heaPum.P, fuelCounter.fuel_in)
    annotation (Line(points={{-5,-6},{-18,-6},{-18,20}},    color={0,0,127}));
  connect(switch2.y,fromHouse. T_in) annotation (Line(points={{130,-53},{128,
          -53},{128,-34},{112,-34}},
                                color={0,0,127}));
  connect(switch1.y, heaPum.TSet) annotation (Line(points={{14,-51},{14,-15},{
          18,-15}},       color={0,0,127}));
  connect(T_dhw.y, switch1.u1) annotation (Line(points={{40.6,-75},{26,-75},{26,
          -74},{22,-74}},
                     color={0,0,127}));
  connect(dhw.y, switch1.u2) annotation (Line(points={{-29,-106},{14,-106},{14,
          -74}}, color={255,0,255}));
  connect(dhw.y, switch2.u2) annotation (Line(points={{-29,-106},{130,-106},{
          130,-76}},                     color={255,0,255}));
  connect(T_dhw_r.y, switch2.u1) annotation (Line(points={{116.9,-116},{116,
          -116},{116,-76},{122,-76}},
                           color={0,0,127}));
  connect(T_room_r.y, switch2.u3) annotation (Line(points={{114.6,-132},{142,
          -132},{142,-76},{138,-76}},
                               color={0,0,127}));
  connect(port_a, senTem2.port_a)
    annotation (Line(points={{-260,0},{-242,0}}, color={0,127,255}));
  connect(senTem2.port_b, Pump.port_a)
    annotation (Line(points={{-222,0},{-152,0}}, color={0,127,255}));
  connect(Pump.port_b, vol2.ports[1])
    annotation (Line(points={{-132,0},{-68,0},{-68,4}}, color={0,127,255}));
  connect(vol2.ports[2], senTem4.port_a) annotation (Line(points={{-64,4},{-64,
          0},{-50,0}},                    color={0,127,255}));
  connect(cooling.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-96.25,57},{-96.25,22},{-102,22},{-102,14}},
                                                   color={0,0,127}));
  connect(senTem2.T,no_free_cool. u) annotation (Line(points={{-232,-11},{-214,
          -11},{-214,-10},{-206,-10},{-206,-34}},
                                             color={0,0,127}));
  connect(no_free_cool.y, T_room.u2) annotation (Line(points={{-183,-34},{-184,
          -34},{-184,-44},{-176,-44},{-176,-70}}, color={255,0,255}));
  connect(T_set_active_cooling.y, T_room.u1)
    annotation (Line(points={{-155,-70},{-168,-70}}, color={0,0,127}));
  connect(T_set_free_cooling.y, T_room.u3)
    annotation (Line(points={{-199,-70},{-184,-70}}, color={0,0,127}));
  connect(T_room.y, switch1.u3) annotation (Line(points={{-176,-93},{-124,-93},
          {-124,-74},{6,-74}}, color={0,0,127}));
  connect(Pump.P, pump.fuel_in)
    annotation (Line(points={{-131,9},{-132,9},{-132,22}}, color={0,0,127}));
  connect(PowerConsumption.y, P_el) annotation (Line(points={{130,93},{156,93},
          {156,92},{170,92}}, color={0,0,127}));
  connect(senTem.T, Lim50to95.u)
    annotation (Line(points={{52,11},{52,36},{40.8,36}}, color={0,0,127}));
  connect(MassFlowSwitch.y, Pump.m_flow_in)
    annotation (Line(points={{-151,26},{-142,26},{-142,12}}, color={0,0,127}));
  connect(WinterMassFlow.y, MassFlowSwitch.u3) annotation (Line(points={{-256,
          94},{-276,94},{-276,18},{-174,18}}, color={0,0,127}));
  connect(SummerWinterTable.y, MassFlowSwitch.u2) annotation (Line(points={{
          -238.7,39},{-206,39},{-206,26},{-174,26}}, color={255,0,255}));
  connect(senTem.T, Lim105to150.u)
    annotation (Line(points={{52,11},{52,82},{40.8,82}}, color={0,0,127}));
  connect(PressureDrop.y, dpOut)
    annotation (Line(points={{123.3,68},{170,68}}, color={0,0,127}));
  connect(SummerMassFlow.y, MassFlowSwitch.u1) annotation (Line(points={{-227.4,
          76},{-227.4,46},{-194,46},{-194,34},{-174,34}}, color={0,0,127}));
  connect(dhw_input, dhw.u)
    annotation (Line(points={{-284,-106},{-52,-106}}, color={0,0,127}));
  connect(heaPum.port_b1, toHouse.ports[1]) annotation (Line(points={{-4,-12},{
          -20,-12},{-20,-42},{-78,-42}}, color={0,127,255}));
  connect(fromHouse.ports[1], heaPum.port_a1) annotation (Line(points={{90,-38},
          {34,-38},{34,-12},{16,-12}}, color={0,127,255}));
    annotation (Placement(transformation(extent={{6,-26},{-14,-46}})),
              Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,
            -140},{180,120}}),
                         graphics={
        Rectangle(
          extent={{-260,160},{220,-180}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-154,32},{118,-174}},
          lineColor={0,0,0},
          fillColor={28,108,200},
          fillPattern=FillPattern.HorizontalCylinder),
        Polygon(
          points={{-154,32},{-30,142},{118,32},{-154,32}},
          lineColor={0,0,0},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-102,4},{-56,-50}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-36,-100},{4,-174}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{10,2},{58,-54}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),                      Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-280,-140},{180,
            120}})),
    Documentation(revisions="<html>
<ul>
<li><i>August 09, 2018</i> ,by Tobias Blacha:<br/>
Implemented </li>
</ul>
</html>", info="<html>
<p>Substation model for bidirctional low-temperature networks for buildings with heat pump and chiller. In the case of simultaneous cooling and heating demands, the return flows are used as supply flows for the other application. The mass flows are controlled equation-based. The mass flows are calculated using the heating and cooling demands and the specified temperature differences between flow and return (network side).</p>
</html>"));
end PumpControlledwithHP_V4_jonas;
