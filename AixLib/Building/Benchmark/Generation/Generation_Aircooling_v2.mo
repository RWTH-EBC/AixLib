within AixLib.Building.Benchmark.Generation;
model Generation_Aircooling_v2
    replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_max = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_min = 0 annotation(Dialog(tab = "General"));

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "General"), choicesAllMatching = true);
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Area Area_Heatexchanger_Air = 0 annotation(Dialog(tab = "General"));

  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Medium_Air,
    use_X_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{-34,-58},{-14,-38}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=true,
    redeclare package Medium = Medium_Air,
    nPorts=1)                                                 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-42})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve8(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
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
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={36,-10})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos80slash1to12 per)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={18,10})));
  Modelica.Blocks.Tables.CombiTable1D combiTable1D(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
      table=[-1,0; 0.0,0.0; 0.0001,m_flow_nominal_generation_air_min; 1,
        m_flow_nominal_generation_air_max; 1.1,
        m_flow_nominal_generation_air_max])
    annotation (Placement(transformation(extent={{-94,-34},{-74,-14}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-70,-82},{-50,-102}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=1)
    annotation (Placement(transformation(extent={{-94,-100},{-82,-84}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,18})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    V=0.1,
    redeclare package Medium = Medium_Water,
    nPorts=2,
    m_flow_nominal=m_flow_nominal_generation_aircooler)
           annotation (Placement(transformation(extent={{-2,-26},{8,-16}})));
  Fluid.MixingVolumes.MixingVolume vol2(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=30,
    V=10)  annotation (Placement(transformation(extent={{24,-42},{34,-32}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cool_airCooler(redeclare
      package Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,90},{70,110}})));
  BusSystem.Bus_Control controlBus annotation (Placement(transformation(extent=
            {{-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  BusSystem.Bus_measure measureBus annotation (Placement(transformation(extent=
            {{-130,-90},{-90,-50}}), iconTransformation(extent={{-110,-70},{-90,
            -50}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-10,-64},{-2,-56}})));
  Utilities.HeatTransfer.HeatConv_outside heatTransfer_Outside(
    surfaceType=DataBase.Surfaces.RoughnessForHT.Glass(),
    Model=1,
    A=Area_Heatexchanger_Air)                                                                                                                                                               annotation(Placement(transformation(extent={{4,-40},
            {15,-28}})));
  Modelica.Blocks.Math.Gain gain(k=2)
    annotation (Placement(transformation(extent={{-16,-40},{-10,-34}})));
  Fluid.FixedResistances.PressureDrop res(
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    redeclare package Medium = Medium_Water,
    dp_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-4,-32},{-14,-22}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-16,-20},{-36,0}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30)
    annotation (Placement(transformation(extent={{-62,-30},{-50,-18}})));
equation
  connect(Fluid_in_cool_airCooler,hex1. port_a1)
    annotation (Line(points={{-60,100},{-60,88},{-12,88}}, color={0,127,255}));
  connect(hex1.port_b1,Fluid_out_cool_airCooler)
    annotation (Line(points={{8,88},{60,88},{60,100}}, color={0,127,255}));
  connect(Fluid_in_warm_airCooler,hex2. port_a1)
    annotation (Line(points={{100,60},{82,60},{82,14}}, color={0,127,255}));
  connect(hex2.port_b1,Fluid_out_warm_airCooler)  annotation (Line(points={{82,
          -6},{82,-6},{82,-60},{100,-60}}, color={0,127,255}));
  connect(Valve8.port_1,hex1. port_a2) annotation (Line(points={{-16,54},{-16,58},
          {8,58},{8,76}},     color={0,127,255}));
  connect(Valve8.port_3,hex2. port_a2) annotation (Line(points={{-6,44},{52,44},
          {52,-6},{70,-6}}, color={0,127,255}));
  connect(hex2.port_b2,hex1. port_b2) annotation (Line(points={{70,14},{70,42},
          {18,42},{18,64},{-22,64},{-22,76},{-12,76}}, color={0,127,255}));
  connect(Valve8.y,controlBus. Valve8) annotation (Line(points={{-28,44},{-64,44},
          {-64,0.1},{-99.9,0.1}},     color={0,0,127}));
  connect(fan4.port_a,hex1. port_b2) annotation (Line(points={{18,18},{18,64},{-22,
          64},{-22,76},{-12,76}}, color={0,127,255}));
  connect(fan4.y,controlBus. Pump_Aircooler_y) annotation (Line(points={{27.6,
          10},{38,10},{38,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(combiTable1D.u[1],controlBus. Fan_Aircooler) annotation (Line(points={{-96,-24},
          {-99.9,-24},{-99.9,0.1}},            color={0,0,127}));
  connect(realExpression.y,feedback. u1)
    annotation (Line(points={{-81.4,-92},{-68,-92}}, color={0,0,127}));
  connect(boundary.X_in[1],measureBus. WaterInAir) annotation (Line(points={{-36,-52},
          {-60,-52},{-60,-69.9},{-109.9,-69.9}},      color={0,0,127}));
  connect(feedback.u2,measureBus. WaterInAir) annotation (Line(points={{-60,-84},
          {-60,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(feedback.y,boundary. X_in[2]) annotation (Line(points={{-51,-92},{-46,
          -92},{-46,-52},{-36,-52}}, color={0,0,127}));
  connect(boundary.T_in,measureBus. AirTemp) annotation (Line(points={{-36,-44},
          {-60,-44},{-60,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(bou.T_in,measureBus. AirTemp) annotation (Line(points={{62,-38},{76,
          -38},{76,-70},{-16,-70},{-16,-69.9},{-109.9,-69.9}},
                                      color={0,0,127}));
  connect(senMasFlo.port_b,Valve8. port_2)
    annotation (Line(points={{-16,28},{-16,34}}, color={0,127,255}));
  connect(senMasFlo.m_flow,measureBus. Aircooler_massflow) annotation (Line(
        points={{-27,18},{-40,18},{-40,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(senTem2.T,measureBus. Aircooler_in) annotation (Line(points={{15,-8},{
          18,-8},{18,-22},{-40,-22},{-40,-69.9},{-109.9,-69.9}}, color={0,0,127}));
  connect(vol2.ports[1], bou.ports[1])
    annotation (Line(points={{28,-42},{40,-42}}, color={0,127,255}));
  connect(vol1.ports[1], fan4.port_b)
    annotation (Line(points={{2,-26},{18,-26},{18,2}},  color={0,127,255}));
  connect(bou1.ports[1], fan4.port_b) annotation (Line(points={{36,-14},{36,-18},
          {18,-18},{18,2}}, color={0,127,255}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-10.8,
          -60},{-18,-60},{-18,-70},{-109.9,-70},{-109.9,-69.9}},        color={0,
          0,127}));
  connect(heatTransfer_Outside.port_b, vol2.heatPort) annotation (Line(points={{15,-34},
          {18,-34},{18,-37},{24,-37}},         color={191,0,0}));
  connect(gain.y, heatTransfer_Outside.WindSpeedPort) annotation (Line(points={{
          -9.7,-37},{-2,-37},{-2,-38.32},{4.44,-38.32}}, color={0,0,127}));
  connect(res.port_b, senMasFlo.port_a)
    annotation (Line(points={{-14,-27},{-16,-27},{-16,8}}, color={0,127,255}));
  connect(res.port_a, vol1.ports[2]) annotation (Line(points={{-4,-27},{-2,-27},
          {-2,-26},{4,-26}}, color={0,127,255}));
  connect(vol2.ports[2], boundary.ports[1]) annotation (Line(points={{30,-42},{8,
          -42},{8,-48},{-14,-48}}, color={0,127,255}));
  connect(heatTransfer_Outside.port_a, vol1.heatPort)
    annotation (Line(points={{4,-34},{-2,-34},{-2,-21}}, color={191,0,0}));
  connect(prescribedTemperature.port, vol2.heatPort)
    annotation (Line(points={{-2,-60},{24,-60},{24,-37}}, color={191,0,0}));
  connect(senTem2.port, fan4.port_b)
    annotation (Line(points={{8,-18},{18,-18},{18,2}}, color={0,127,255}));
  connect(temperatureSensor.port, vol1.heatPort) annotation (Line(points={{-16,
          -10},{-12,-10},{-12,-21},{-2,-21}}, color={191,0,0}));
  connect(temperatureSensor.T, measureBus.Aircooler_out) annotation (Line(
        points={{-36,-10},{-40,-10},{-40,-70},{-109.9,-70},{-109.9,-69.9}},
        color={0,0,127}));
  connect(combiTable1D.y[1], firstOrder.u)
    annotation (Line(points={{-73,-24},{-63.2,-24}}, color={0,0,127}));
  connect(firstOrder.y, boundary.m_flow_in) annotation (Line(points={{-49.4,-24},
          {-46,-24},{-46,-40},{-34,-40}}, color={0,0,127}));
  connect(gain.u, boundary.m_flow_in) annotation (Line(points={{-16.6,-37},{-46,
          -37},{-46,-40},{-34,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_Aircooling_v2;
