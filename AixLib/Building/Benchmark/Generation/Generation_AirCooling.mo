within AixLib.Building.Benchmark.Generation;
model Generation_AirCooling
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    parameter Modelica.SIunits.Time riseTime_valve = 0 annotation(Dialog(tab = "General"));

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_max = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_min = 0 annotation(Dialog(tab = "General"));

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "General"), choicesAllMatching = true);
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium_Air,
    use_X_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-34,-52},{-14,-32}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=true,
    redeclare package Medium = Medium_Air,
    nPorts=1)                                                 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-42})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Air,
    m1_flow_nominal=m_flow_nominal_generation_aircooler,
    m2_flow_nominal=m_flow_nominal_generation_air_max,
    dp1_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{20,-46},{0,-26}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve8(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    riseTime=riseTime_valve,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dpValve_nominal_generation_aircooler,
    use_inputFilter=false)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-16,44})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Water,
    m1_flow_nominal=m_flow_nominal_generation_coldwater,
    m2_flow_nominal=m_flow_nominal_generation_aircooler,
    dp1_nominal=dpHeatexchanger_nominal,
    dp2_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-12,72},{8,92}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex2(
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Water,
    m1_flow_nominal=m_flow_nominal_generation_warmwater,
    m2_flow_nominal=m_flow_nominal_generation_aircooler,
    dp1_nominal=dpHeatexchanger_nominal,
    dp2_nominal=dpHeatexchanger_nominal)                  annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={76,4})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    nPorts=1,
    p=100000) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={36,-10})));

  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per,
    allowFlowReversal=false)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={18,10})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[
        0.0,0.0; 0.01,m_flow_nominal_generation_air_min; 1,
        m_flow_nominal_generation_air_max; 1.1,
        m_flow_nominal_generation_air_max])
    annotation (Placement(transformation(extent={{-72,-34},{-52,-14}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-70,-82},{-50,-102}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-94,-100},{-82,-84}})));
  BusSystem.measureBus measureBus annotation (Placement(transformation(extent={{
            -130,-90},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,-50}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water,
      allowFlowReversal=false)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,18})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-38,-18},{-18,2}})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=0.1) annotation (Placement(transformation(extent={{22,-42},{32,-32}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=0.1) annotation (Placement(transformation(extent={{-12,-42},{-2,-32}})));
  Fluid.MixingVolumes.MixingVolume vol3(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{-40,88},{-30,98}})));
  Fluid.MixingVolumes.MixingVolume vol4(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{28,88},{38,98}})));
  Fluid.MixingVolumes.MixingVolume vol5(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{-32,68},{-22,78}})));
  Fluid.MixingVolumes.MixingVolume vol6(
    nPorts=3,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{16,26},{26,36}})));
  Fluid.MixingVolumes.MixingVolume vol7(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{62,22},{72,32}})));
  Fluid.MixingVolumes.MixingVolume vol8(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{90,28},{100,38}})));
  Fluid.MixingVolumes.MixingVolume vol9(
    nPorts=2,
    m_flow_nominal=30,
    V=0.1,
    redeclare package Medium = Medium_Water)
           annotation (Placement(transformation(extent={{98,-36},{108,-26}})));
equation
  connect(Valve8.y, controlBus.Valve8) annotation (Line(points={{-28,44},{-64,44},
          {-64,0.1},{-99.9,0.1}},     color={0,0,127}));
  connect(fan4.port_b, hex.port_a1)
    annotation (Line(points={{18,2},{18,-30},{20,-30}},color={0,127,255}));
  connect(bou1.ports[1], hex.port_a1) annotation (Line(points={{36,-14},{18,-14},
          {18,-30},{20,-30}},color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{27.6,
          10},{38,10},{38,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(combiTable1D.u[1], controlBus.Fan_Aircooler) annotation (Line(points=
          {{-74,-24},{-99.9,-24},{-99.9,0.1}}, color={0,0,127}));
  connect(combiTable1D.y[1], boundary.m_flow_in) annotation (Line(points={{-51,-24},
          {-40,-24},{-40,-34},{-34,-34}},      color={0,0,127}));
  connect(realExpression.y, feedback.u1)
    annotation (Line(points={{-81.4,-92},{-68,-92}}, color={0,0,127}));
  connect(boundary.X_in[1], measureBus.WaterInAir) annotation (Line(points={{-36,-46},
          {-60,-46},{-60,-69.9},{-109.9,-69.9}},      color={0,0,127}));
  connect(feedback.u2, measureBus.WaterInAir) annotation (Line(points={{-60,-84},
          {-60,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(feedback.y, boundary.X_in[2]) annotation (Line(points={{-51,-92},{-46,
          -92},{-46,-46},{-36,-46}}, color={0,0,127}));
  connect(boundary.T_in, measureBus.AirTemp) annotation (Line(points={{-36,-38},
          {-60,-38},{-60,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(bou.T_in, measureBus.AirTemp) annotation (Line(points={{62,-38},{76,
          -38},{76,-70},{-16,-70},{-16,-69.9},{-109.9,-69.9}},
                                      color={0,0,127}));
  connect(senMasFlo.port_b, Valve8.port_2)
    annotation (Line(points={{-16,28},{-16,34}}, color={0,127,255}));
  connect(senMasFlo.port_a, hex.port_b1)
    annotation (Line(points={{-16,8},{-16,-30},{0,-30}},  color={0,127,255}));
  connect(senMasFlo.m_flow, measureBus.Aircooler_massflow) annotation (Line(
        points={{-27,18},{-40,18},{-40,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(senTem1.port, hex.port_b1) annotation (Line(points={{-28,-18},{-16,
          -18},{-16,-30},{0,-30}},
                               color={0,127,255}));
  connect(senTem2.port, hex.port_a1) annotation (Line(points={{8,-18},{18,-18},
          {18,-30},{20,-30}},color={0,127,255}));
  connect(senTem1.T, measureBus.Aircooler_out) annotation (Line(points={{-21,-8},
          {-16,-8},{-16,-18},{-40,-18},{-40,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(senTem2.T, measureBus.Aircooler_in) annotation (Line(points={{15,-8},{
          18,-8},{18,-18},{-40,-18},{-40,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(hex.port_b2, vol1.ports[1])
    annotation (Line(points={{20,-42},{26,-42}}, color={0,127,255}));
  connect(vol1.ports[2], bou.ports[1])
    annotation (Line(points={{28,-42},{40,-42}}, color={0,127,255}));
  connect(boundary.ports[1], vol2.ports[1])
    annotation (Line(points={{-14,-42},{-8,-42}}, color={0,127,255}));
  connect(vol2.ports[2], hex.port_a2)
    annotation (Line(points={{-6,-42},{0,-42}}, color={0,127,255}));
  connect(Fluid_in_cool_airCooler, vol3.ports[1]) annotation (Line(points={{-60,
          100},{-48,100},{-48,88},{-36,88}}, color={0,127,255}));
  connect(vol3.ports[2], hex1.port_a1)
    annotation (Line(points={{-34,88},{-12,88}}, color={0,127,255}));
  connect(hex1.port_b1, vol4.ports[1])
    annotation (Line(points={{8,88},{32,88}}, color={0,127,255}));
  connect(vol4.ports[2], Fluid_out_cool_airCooler) annotation (Line(points={{34,
          88},{46,88},{46,100},{60,100}}, color={0,127,255}));
  connect(Valve8.port_1, vol5.ports[1]) annotation (Line(points={{-16,54},{-22,
          54},{-22,68},{-28,68}}, color={0,127,255}));
  connect(vol5.ports[2], hex1.port_b2) annotation (Line(points={{-26,68},{-20,
          68},{-20,76},{-12,76}}, color={0,127,255}));
  connect(hex1.port_a2, vol6.ports[1]) annotation (Line(points={{8,76},{14,76},
          {14,26},{19.6667,26}}, color={0,127,255}));
  connect(vol6.ports[2], fan4.port_a) annotation (Line(points={{21,26},{20,26},
          {20,18},{18,18}}, color={0,127,255}));
  connect(Valve8.port_3, vol7.ports[1]) annotation (Line(points={{-6,44},{28,44},
          {28,42},{66,42},{66,22}}, color={0,127,255}));
  connect(vol7.ports[2], hex2.port_b2) annotation (Line(points={{68,22},{68,22},
          {68,14},{70,14}}, color={0,127,255}));
  connect(hex2.port_a2, vol6.ports[3]) annotation (Line(points={{70,-6},{46,-6},
          {46,26},{22.3333,26}}, color={0,127,255}));
  connect(hex2.port_a1, vol8.ports[1]) annotation (Line(points={{82,14},{90,14},
          {90,28},{94,28}}, color={0,127,255}));
  connect(vol8.ports[2], Fluid_in_warm_airCooler) annotation (Line(points={{96,
          28},{98,28},{98,60},{100,60}}, color={0,127,255}));
  connect(hex2.port_b1, vol9.ports[1]) annotation (Line(points={{82,-6},{94,-6},
          {94,-36},{102,-36}}, color={0,127,255}));
  connect(vol9.ports[2], Fluid_out_warm_airCooler) annotation (Line(points={{
          104,-36},{100,-36},{100,-60}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_AirCooling;
