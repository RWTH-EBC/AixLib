within AixLib.Building.Benchmark.Generation;
model Generation_AirCooling
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    parameter Real m_flow_nominal_generation_warmwater = 0 annotation(Dialog(tab = "General"));

    parameter Real m_flow_nominal_generation_coldwater = 0 annotation(Dialog(tab = "General"));

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_generation_aircooler annotation(Dialog(tab = "General"), choicesAllMatching = true);
    parameter Real m_flow_nominal_generation_aircooler = 0 annotation(Dialog(tab = "General"));
    parameter Real Kv_generation_aircooler = 0 annotation(Dialog(tab = "General"));

    parameter Real m_flow_nominal_generation_air_max annotation(Dialog(tab = "General"));
  Fluid.Sources.MassFlowSource_T boundary(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air)
              annotation (Placement(transformation(extent={{-46,-52},{-26,-32}})));
  Fluid.Sources.Boundary_pT bou(
    use_p_in=false,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Medium_Air)                    annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={44,-42})));
  Modelica.Blocks.Interfaces.RealInput T_in1 "Prescribed fluid temperature"
    annotation (Placement(transformation(extent={{-120,-92},{-96,-68}})));
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
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Air,
    m1_flow_nominal=m_flow_nominal_generation_aircooler,
    m2_flow_nominal=m_flow_nominal_generation_air_max)
    annotation (Placement(transformation(extent={{8,-46},{-12,-26}})));
  Fluid.MixingVolumes.MixingVolume vol(
    nPorts=2,
    V=1,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=m_flow_nominal_generation_air_max)
         annotation (Placement(transformation(extent={{16,-42},{26,-32}})));
  Fluid.Actuators.Valves.ThreeWayLinear Valve8(
    dpValve_nominal=10,
    redeclare package Medium = Medium_Water,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=Kv_generation_aircooler,
    m_flow_nominal=m_flow_nominal_generation_aircooler)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-16,30})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Water,
    m1_flow_nominal=m_flow_nominal_generation_coldwater,
    m2_flow_nominal=m_flow_nominal_generation_aircooler)
    annotation (Placement(transformation(extent={{-12,72},{8,92}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex2(
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Water,
    m1_flow_nominal=m_flow_nominal_generation_warmwater,
    m2_flow_nominal=m_flow_nominal_generation_aircooler)  annotation (Placement(
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
    p=300000,
    redeclare package Medium = Medium_Water,
    nPorts=1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-32,-8})));

  BusSystem.ControlBus controlBus annotation (Placement(transformation(extent={
            {-120,-20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,
            10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(     uMin=0, uMax=
        m_flow_nominal_generation_air_max)
    annotation (Placement(transformation(extent={{-80,-32},{-60,-12}})));
  Fluid.Movers.SpeedControlled_y fan4(redeclare package Medium = Medium_Water,
      per=pump_model_generation_aircooler)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=90,
        origin={18,10})));
equation
  connect(boundary.T_in, T_in1) annotation (Line(points={{-48,-38},{-74,-38},{
          -74,-80},{-108,-80}},
                            color={0,0,127}));
  connect(bou.T_in, T_in1) annotation (Line(points={{56,-38},{56,-80},{-108,-80}},
                      color={0,0,127}));
  connect(vol.ports[1], bou.ports[1])
    annotation (Line(points={{20,-42},{34,-42}}, color={0,127,255}));
  connect(Fluid_in_cool_airCooler, hex1.port_a1)
    annotation (Line(points={{-60,100},{-60,88},{-12,88}}, color={0,127,255}));
  connect(hex1.port_b1, Fluid_out_cool_airCooler)
    annotation (Line(points={{8,88},{60,88},{60,100}}, color={0,127,255}));
  connect(Fluid_in_warm_airCooler, hex2.port_a1)
    annotation (Line(points={{100,60},{82,60},{82,14}}, color={0,127,255}));
  connect(hex2.port_b1, Fluid_out_warm_airCooler) annotation (Line(points={{82,
          -6},{82,-6},{82,-60},{100,-60}}, color={0,127,255}));
  connect(boundary.ports[1], hex.port_a2)
    annotation (Line(points={{-26,-42},{-12,-42}}, color={0,127,255}));
  connect(hex.port_b2, vol.ports[2])
    annotation (Line(points={{8,-42},{22,-42}}, color={0,127,255}));
  connect(hex.port_b1,Valve8. port_2) annotation (Line(points={{-12,-30},{-16,
          -30},{-16,20}}, color={0,127,255}));
  connect(Valve8.port_1, hex1.port_a2) annotation (Line(points={{-16,40},{-16,
          50},{8,50},{8,76}}, color={0,127,255}));
  connect(Valve8.port_3, hex2.port_a2) annotation (Line(points={{-6,30},{52,30},
          {52,-6},{70,-6}}, color={0,127,255}));
  connect(hex2.port_b2, hex1.port_b2) annotation (Line(points={{70,14},{70,42},
          {18,42},{18,64},{-22,64},{-22,76},{-12,76}}, color={0,127,255}));
  connect(Valve8.y, controlBus.Valve8) annotation (Line(points={{-28,30},{-64,
          30},{-64,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(limiter.y, boundary.m_flow_in) annotation (Line(points={{-59,-22},{
          -54,-22},{-54,-34},{-46,-34}}, color={0,0,127}));
  connect(limiter.u, controlBus.Fan_Aircooler) annotation (Line(points={{-82,
          -22},{-86,-22},{-86,0.1},{-99.9,0.1}}, color={0,0,127}));
  connect(fan4.port_a, hex1.port_b2) annotation (Line(points={{18,18},{18,64},{-22,
          64},{-22,76},{-12,76}}, color={0,127,255}));
  connect(fan4.port_b, hex.port_a1)
    annotation (Line(points={{18,2},{18,-30},{8,-30}}, color={0,127,255}));
  connect(bou1.ports[1], hex.port_a1) annotation (Line(points={{-32,-12},{18,-12},
          {18,-30},{8,-30}}, color={0,127,255}));
  connect(fan4.y, controlBus.Pump_Aircooler_y) annotation (Line(points={{27.6,
          10},{38,10},{38,0.1},{-99.9,0.1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false), graphics={Text(
          extent={{-88,64},{-26,44}},
          lineColor={28,108,200},
          textString="Parameter Wärmetausch
müssen angepasst werden
")}));
end Generation_AirCooling;
