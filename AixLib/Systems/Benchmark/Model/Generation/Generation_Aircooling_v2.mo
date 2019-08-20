within AixLib.Systems.Benchmark.Model.Generation;
model Generation_Aircooling_v2
    replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_big_max = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_big_min = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_small_max = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal_generation_air_small_min = 0 annotation(Dialog(tab = "General"));

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "General"), choicesAllMatching = true);
    parameter Modelica.SIunits.Pressure dpValve_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpHeatexchanger_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Area Area_Heatexchanger_Air = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Cold = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductance Thermal_Conductance_Warm = 0 annotation(Dialog(tab = "General"));

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
  Fluid.Sources.Boundary_pT bou1(
    redeclare package Medium = Medium_Water,
    p=100000,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={36,-10})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      redeclare
      Fluid.Movers.Data.Pumps.Wilo.VeroLine80slash115dash2comma2slash2 per)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={18,10})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds(smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[-1,
        m_flow_nominal_generation_air_big_min,7800; 0.0,
        m_flow_nominal_generation_air_big_min,7800; 1,
        m_flow_nominal_generation_air_big_max,12000; 1.1,
        m_flow_nominal_generation_air_big_max,12000])
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,18})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-2,-18},{18,2}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    V=0.2) annotation (Placement(transformation(extent={{-2,-26},{8,-16}})));
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
  BusSystems.Bus_Control controlBus annotation (Placement(transformation(extent=
           {{-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  BusSystems.Bus_measure measureBus annotation (Placement(transformation(extent=
           {{-124,-98},{-84,-58}}), iconTransformation(extent={{-104,-78},{-84,
            -58}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-10,-64},{-2,-56}})));
  AixLib.Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside(
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Glass(),
    A=Area_Heatexchanger_Air)                                                                                                                                                               annotation(Placement(transformation(extent={{4,-40},
            {15,-28}})));
  Modelica.Blocks.Math.Gain gain(k=1/(6.41801*1.2041))
    annotation (Placement(transformation(extent={{-16,-40},{-10,-34}})));
  Fluid.FixedResistances.PressureDrop res(
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    redeclare package Medium = Medium_Water,
    dp_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-4,-32},{-14,-22}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{-16,-20},{-36,0}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=30)
    annotation (Placement(transformation(extent={{-54,-38},{-42,-26}})));
  Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium_Water,
    dp_nominal=dpHeatexchanger_nominal,
    m_flow_nominal=m_flow_nominal_generation_coldwater)
    annotation (Placement(transformation(extent={{20,78},{32,90}})));
  Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    m_flow_nominal=m_flow_nominal_generation_coldwater,
    V=0.01)
           annotation (Placement(transformation(extent={{-6,84},{6,96}})));
  Fluid.MixingVolumes.MixingVolume vol4(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    V=0.01)
           annotation (Placement(transformation(extent={{-6,78},{6,66}})));
  Fluid.FixedResistances.PressureDrop res2(
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    redeclare package Medium = Medium_Water,
    dp_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{20,72},{32,84}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=
        Thermal_Conductance_Cold)
                             annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-29,81})));
  Fluid.MixingVolumes.MixingVolume vol5(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    V=0.01)
           annotation (Placement(transformation(extent={{-6,6},{6,-6}},
        rotation=-90,
        origin={66,20})));
  Fluid.MixingVolumes.MixingVolume vol6(
    redeclare package Medium = Medium_Water,
    nPorts=2,
    V=0.01,
    m_flow_nominal=m_flow_nominal_generation_warmwater)
           annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=90,
        origin={84,20})));
  Fluid.FixedResistances.PressureDrop res3(
    redeclare package Medium = Medium_Water,
    dp_nominal=dpHeatexchanger_nominal,
    m_flow_nominal=m_flow_nominal_generation_warmwater)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={78,0})));
  Fluid.FixedResistances.PressureDrop res4(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_generation_aircooler,
    dp_nominal=dpHeatexchanger_nominal)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={72,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=
        Thermal_Conductance_Warm)
                             annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={75,37})));
  Modelica.Blocks.Sources.RealExpression realExpression1[2](y=0)
    annotation (Placement(transformation(extent={{-114,-40},{-102,-24}})));
  Modelica.Blocks.Logical.Switch switch1[2]
    annotation (Placement(transformation(extent={{-92,-30},{-80,-18}})));
  Modelica.Blocks.Tables.CombiTable1Ds combiTable1Ds1(
                                                     smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments, table=[-1,
        m_flow_nominal_generation_air_small_min,1470; 0.0,
        m_flow_nominal_generation_air_small_min,1470; 1,
        m_flow_nominal_generation_air_small_max,2310; 1.1,
        m_flow_nominal_generation_air_small_max,2310])
    annotation (Placement(transformation(extent={{-140,-56},{-120,-36}})));
  Modelica.Blocks.Logical.Switch switch2[2]
    annotation (Placement(transformation(extent={{-92,-52},{-80,-40}})));
  Modelica.Blocks.Math.Add add[2]
    annotation (Placement(transformation(extent={{-76,-40},{-66,-30}})));
equation
  connect(Valve8.y,controlBus. Valve8) annotation (Line(points={{-28,44},{-64,44},
          {-64,0.1},{-99.9,0.1}},     color={0,0,127}));
  connect(fan4.y,controlBus. Pump_Aircooler_y) annotation (Line(points={{27.6,
          10},{38,10},{38,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(senMasFlo.port_b,Valve8. port_2)
    annotation (Line(points={{-16,28},{-16,34}}, color={0,127,255}));
  connect(senMasFlo.m_flow,measureBus. Aircooler_massflow) annotation (Line(
        points={{-27,18},{-40,18},{-40,-77.9},{-103.9,-77.9}}, color={0,0,127}));
  connect(senTem2.T,measureBus. Aircooler_in) annotation (Line(points={{15,-8},{
          18,-8},{18,-22},{-40,-22},{-40,-77.9},{-103.9,-77.9}}, color={0,0,127}));
  connect(vol1.ports[1], fan4.port_b)
    annotation (Line(points={{2,-26},{18,-26},{18,2}},  color={0,127,255}));
  connect(bou1.ports[1], fan4.port_b) annotation (Line(points={{36,-14},{36,-18},
          {18,-18},{18,2}}, color={0,127,255}));
  connect(prescribedTemperature.T, measureBus.AirTemp) annotation (Line(points={{-10.8,
          -60},{-18,-60},{-18,-78},{-102,-78},{-102,-77.9},{-103.9,-77.9}},
                                                                        color={0,
          0,127}));
  connect(gain.y, heatTransfer_Outside.WindSpeedPort) annotation (Line(points={{
          -9.7,-37},{-2,-37},{-2,-38.32},{4.44,-38.32}}, color={0,0,127}));
  connect(res.port_b, senMasFlo.port_a)
    annotation (Line(points={{-14,-27},{-16,-27},{-16,8}}, color={0,127,255}));
  connect(res.port_a, vol1.ports[2]) annotation (Line(points={{-4,-27},{-2,-27},
          {-2,-26},{4,-26}}, color={0,127,255}));
  connect(heatTransfer_Outside.port_a, vol1.heatPort)
    annotation (Line(points={{4,-34},{-2,-34},{-2,-21}}, color={191,0,0}));
  connect(senTem2.port, fan4.port_b)
    annotation (Line(points={{8,-18},{18,-18},{18,2}}, color={0,127,255}));
  connect(temperatureSensor.port, vol1.heatPort) annotation (Line(points={{-16,
          -10},{-12,-10},{-12,-21},{-2,-21}}, color={191,0,0}));
  connect(vol4.ports[1], res2.port_a)
    annotation (Line(points={{-1.2,78},{20,78}}, color={0,127,255}));
  connect(Valve8.port_1, vol4.ports[2])
    annotation (Line(points={{-16,54},{-16,78},{1.2,78}}, color={0,127,255}));
  connect(Fluid_in_cool_airCooler, vol3.ports[1]) annotation (Line(points={{-60,
          100},{-60,84},{-1.2,84}}, color={0,127,255}));
  connect(vol3.ports[2], res1.port_a)
    annotation (Line(points={{1.2,84},{20,84}}, color={0,127,255}));
  connect(res1.port_b, Fluid_out_cool_airCooler)
    annotation (Line(points={{32,84},{60,84},{60,100}}, color={0,127,255}));
  connect(res2.port_b, fan4.port_a) annotation (Line(points={{32,78},{40,78},{40,
          60},{18,60},{18,18}}, color={0,127,255}));
  connect(thermalConductor.port_b, vol3.heatPort)
    annotation (Line(points={{-29,86},{-29,90},{-6,90}}, color={191,0,0}));
  connect(thermalConductor.port_a, vol4.heatPort)
    annotation (Line(points={{-29,76},{-29,72},{-6,72}}, color={191,0,0}));
  connect(res4.port_a, vol5.ports[1])
    annotation (Line(points={{72,6},{72,21.2}}, color={0,127,255}));
  connect(res3.port_a, vol6.ports[1])
    annotation (Line(points={{78,6},{78,21.2}}, color={0,127,255}));
  connect(res4.port_b, fan4.port_a) annotation (Line(points={{72,-6},{72,-12},{50,
          -12},{50,28},{18,28},{18,18}}, color={0,127,255}));
  connect(vol5.ports[2], Valve8.port_3) annotation (Line(points={{72,18.8},{72,44},
          {-6,44},{-6,44}}, color={0,127,255}));
  connect(vol6.ports[2], Fluid_in_warm_airCooler)
    annotation (Line(points={{78,18.8},{78,60},{100,60}}, color={0,127,255}));
  connect(res3.port_b, Fluid_out_warm_airCooler)
    annotation (Line(points={{78,-6},{78,-60},{100,-60}}, color={0,127,255}));
  connect(vol5.heatPort, thermalConductor1.port_a)
    annotation (Line(points={{66,26},{66,37},{70,37}}, color={191,0,0}));
  connect(thermalConductor1.port_b, vol6.heatPort) annotation (Line(points={{80,
          37},{84,37},{84,36},{84,36},{84,26}}, color={191,0,0}));
  connect(combiTable1Ds.y, switch1.u1) annotation (Line(points={{-119,-20},{-104,
          -20},{-104,-19.2},{-93.2,-19.2}},      color={0,0,127}));
  connect(realExpression1.y, switch1.u3) annotation (Line(points={{-101.4,-32},{
          -100,-32},{-100,-28.8},{-93.2,-28.8}},  color={0,0,127}));
  connect(temperatureSensor.T, measureBus.Aircooler) annotation (Line(points={{-36,-10},
          {-40,-10},{-40,-77.9},{-103.9,-77.9}},          color={0,0,127}));
  connect(combiTable1Ds.u, controlBus.Fan_Aircooler_big) annotation (Line(
        points={{-142,-20},{-160,-20},{-160,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(combiTable1Ds1.y[1], switch2[1].u1) annotation (Line(points={{-119,-46},
          {-104,-46},{-104,-41.2},{-93.2,-41.2}}, color={0,0,127}));
  connect(combiTable1Ds1.y[2], switch2[2].u1) annotation (Line(points={{-119,-46},
          {-104,-46},{-104,-41.2},{-93.2,-41.2}}, color={0,0,127}));
  connect(switch2[1].u3, realExpression1[1].y) annotation (Line(points={{-93.2,-50.8},
          {-96,-50.8},{-96,-32},{-101.4,-32}}, color={0,0,127}));
  connect(switch2[2].u3, realExpression1[2].y) annotation (Line(points={{-93.2,-50.8},
          {-96,-50.8},{-96,-32},{-101.4,-32}}, color={0,0,127}));
  connect(switch1[1].y, add[1].u1) annotation (Line(points={{-79.4,-24},{-78,-24},
          {-78,-32},{-77,-32}}, color={0,0,127}));
  connect(switch2[1].y, add[1].u2) annotation (Line(points={{-79.4,-46},{-78,-46},
          {-78,-38},{-77,-38}}, color={0,0,127}));
  connect(add[1].y, firstOrder.u) annotation (Line(points={{-65.5,-35},{-65.5,
          -31.5},{-55.2,-31.5},{-55.2,-32}},
                                      color={0,0,127}));
  connect(switch1[2].y, add[2].u1) annotation (Line(points={{-79.4,-24},{-78,-24},
          {-78,-32},{-77,-32}}, color={0,0,127}));
  connect(switch2[2].y, add[2].u2) annotation (Line(points={{-79.4,-46},{-77,-46},
          {-77,-38}}, color={0,0,127}));
  connect(add[2].y, measureBus.Fan_Aircooler) annotation (Line(points={{-65.5,-35},
          {-62,-35},{-62,-77.9},{-103.9,-77.9}}, color={0,0,127}));
  connect(combiTable1Ds1.u, controlBus.Fan_Aircooler_small) annotation (Line(
        points={{-142,-46},{-160,-46},{-160,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(switch1[1].u2, controlBus.OnOff_Aircooler_big) annotation (Line(
        points={{-93.2,-24},{-99.9,-24},{-99.9,0.1}}, color={255,0,255}));
  connect(switch1[2].u2, controlBus.OnOff_Aircooler_big) annotation (Line(
        points={{-93.2,-24},{-99.9,-24},{-99.9,0.1}}, color={255,0,255}));
  connect(switch2[1].u2, controlBus.OnOff_Aircooler_small) annotation (Line(
        points={{-93.2,-46},{-99.9,-46},{-99.9,0.1}}, color={255,0,255}));
  connect(switch2[2].u2, controlBus.OnOff_Aircooler_small) annotation (Line(
        points={{-93.2,-46},{-99.9,-46},{-99.9,0.1}}, color={255,0,255}));
  connect(prescribedTemperature.port, heatTransfer_Outside.port_b) annotation (
      Line(points={{-2,-60},{20,-60},{20,-34},{15,-34}}, color={191,0,0}));
  connect(firstOrder.y, gain.u) annotation (Line(points={{-41.4,-32},{-30,-32},
          {-30,-37},{-16.6,-37}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Generation_Aircooling_v2;
