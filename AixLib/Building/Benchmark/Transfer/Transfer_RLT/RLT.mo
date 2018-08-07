within AixLib.Building.Benchmark.Transfer.Transfer_RLT;
model RLT
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    replaceable package pump_model_hot = AixLib.Fluid.Movers.Data.Generic;

    parameter Modelica.SIunits.Velocity v_nominal_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Real m_flow_nominal_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Modelica.SIunits.Length pipe_length_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Modelica.SIunits.Length pipe_wall_thickness_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Modelica.SIunits.Length pipe_insulation_conductivity_hot = 0.02 annotation(Dialog(tab = "Hot"));
    parameter Modelica.SIunits.Volume V_mixing_hot = 0 annotation(Dialog(tab = "Hot"));
    parameter Real Kv_hot = 0 annotation(Dialog(tab = "Hot"));

    parameter AixLib.Fluid.Movers.Data.Generic pump_model_cold = AixLib.Fluid.Movers.Data.Pumps.Wilo.Stratos25slash1to4 annotation(Dialog(tab = "Cold"), choicesAllMatching = true);
    parameter Modelica.SIunits.Velocity v_nominal_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Real m_flow_nominal_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Modelica.SIunits.Length pipe_length_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Modelica.SIunits.Length pipe_wall_thickness_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Modelica.SIunits.Length pipe_insulation_conductivity_cold = 0.02 annotation(Dialog(tab = "Cold"));
    parameter Modelica.SIunits.Volume V_mixing_cold = 0 annotation(Dialog(tab = "Cold"));
    parameter Real Kv_cold = 0 annotation(Dialog(tab = "Cold"));
  Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
    m1_flow_nominal=1,
    m2_flow_nominal=10,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Air)
    annotation (Placement(transformation(extent={{-52,-70},{-72,-50}})));
  Fluid.HeatExchangers.ConstantEffectiveness Ext_Cold(
    m1_flow_nominal=1,
    m2_flow_nominal=10,
    dp1_nominal=10,
    dp2_nominal=10,
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Air)
    annotation (Placement(transformation(extent={{28,-70},{8,-50}})));
  Fluid.Humidifiers.SprayAirWasher_X hum(
    m_flow_nominal=20,
    dp_nominal=20,
    redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{62,-76},{82,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{70,90},{90,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-108,-76},{-88,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
  Modelica.Blocks.Interfaces.RealInput X_w1
    "Set point for water vapor mass fraction in kg/kg total air of the fluid that leaves port_b"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=90,
        origin={0,100})));
  Fluid.Movers.SpeedControlled_y fan(redeclare package Medium = Medium_Water,
      per)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-40,-20})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe(redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    v_nominal=v_nominal_hot,
    length=pipe_length_hot,
    m_flow_nominal=m_flow_nominal_hot,
    dIns=pipe_insulation_thickness_hot,
    kIns=pipe_insulation_conductivity_hot,
    thickness=pipe_wall_thickness_hot,
    nPorts=1)
    annotation (Placement(transformation(extent={{-9,8},{9,-8}},
        rotation=-90,
        origin={-40,11})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Medium_Water,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    Kv=Kv_hot,
    m_flow_nominal=m_flow_nominal_hot,
    riseTime=2)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,60})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    v_nominal=v_nominal_hot,
    length=pipe_length_hot,
    m_flow_nominal=m_flow_nominal_hot,
    dIns=pipe_insulation_thickness_hot,
    kIns=pipe_insulation_conductivity_hot,
    thickness=pipe_wall_thickness_hot,
    nPorts=1)
    annotation (Placement(transformation(extent={{-9,-8},{9,8}},
        rotation=-90,
        origin={-80,11})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_hot,
    V=V_mixing_hot,
    nPorts=3) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-86,60})));
  Modelica.Blocks.Interfaces.RealInput pump_hot
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{112,-52},{88,-28}})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={80,0})));
  Modelica.Blocks.Interfaces.RealInput pump_cold
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{112,-12},{88,12}})));
  Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = Medium_Water,
    CvData=AixLib.Fluid.Types.CvTypes.Kv,
    riseTime=2,
    Kv=Kv_cold,
    m_flow_nominal=m_flow_nominal_cold)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={80,80})));
  Modelica.Blocks.Interfaces.RealInput valve_hot
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{112,28},{88,52}})));
  Modelica.Blocks.Interfaces.RealInput valve_cold
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{112,68},{88,92}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Water,
    nPorts=3,
    m_flow_nominal=m_flow_nominal_cold,
    V=V_mixing_cold) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={34,80})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe2(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=2,
    v_nominal=v_nominal_cold,
    length=pipe_length_cold,
    m_flow_nominal=m_flow_nominal_cold,
    dIns=pipe_insulation_thickness_cold,
    kIns=pipe_insulation_conductivity_cold,
    thickness=pipe_wall_thickness_cold)
    annotation (Placement(transformation(extent={{-9,-8},{9,8}},
        rotation=-90,
        origin={40,21})));
  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe3(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    v_nominal=v_nominal_cold,
    length=pipe_length_cold,
    m_flow_nominal=m_flow_nominal_cold,
    dIns=pipe_insulation_thickness_cold,
    kIns=pipe_insulation_conductivity_cold,
    thickness=pipe_wall_thickness_cold)
    annotation (Placement(transformation(extent={{-9,8},{9,-8}},
        rotation=-90,
        origin={80,21})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_hot
    "Heat dissipation to environment"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort_cold
    "Heat dissipation to environment"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
equation
  connect(Ext_Warm.port_b2, Ext_Cold.port_a2)
    annotation (Line(points={{-52,-66},{8,-66}}, color={0,127,255}));
  connect(Ext_Cold.port_b2, hum.port_a)
    annotation (Line(points={{28,-66},{62,-66}}, color={0,127,255}));
  connect(Ext_Warm.port_a2, Air_in)
    annotation (Line(points={{-72,-66},{-98,-66}}, color={0,127,255}));
  connect(hum.port_b, Air_out)
    annotation (Line(points={{82,-66},{100,-66}}, color={0,127,255}));
  connect(hum.X_w, X_w1) annotation (Line(points={{60,-60},{40,-60},{40,-40},{0,
          -40},{0,100}}, color={0,0,127}));
  connect(plugFlowPipe1.port_a, vol.ports[1])
    annotation (Line(points={{-80,20},{-80,58.4}}, color={0,127,255}));
  connect(val1.port_3, vol.ports[2]) annotation (Line(points={{-46,60},{-64,60},
          {-64,60},{-80,60}}, color={0,127,255}));
  connect(Fluid_out_warm, vol.ports[3])
    annotation (Line(points={{-80,100},{-80,61.6}}, color={0,127,255}));
  connect(val1.port_2, plugFlowPipe.port_a)
    annotation (Line(points={{-40,54},{-40,20}}, color={0,127,255}));
  connect(Fluid_in_warm, val1.port_1)
    annotation (Line(points={{-40,100},{-40,66}}, color={0,127,255}));
  connect(fan.port_a, plugFlowPipe.ports_b[1])
    annotation (Line(points={{-40,-12},{-40,2}}, color={0,127,255}));
  connect(fan.port_b, Ext_Warm.port_a1) annotation (Line(points={{-40,-28},{-40,
          -54},{-52,-54}}, color={0,127,255}));
  connect(Ext_Warm.port_b1, plugFlowPipe1.ports_b[1])
    annotation (Line(points={{-72,-54},{-80,-54},{-80,2}}, color={0,127,255}));
  connect(fan.y, pump_hot) annotation (Line(points={{-30.4,-20},{-20,-20},{-20,-40},
          {100,-40}}, color={0,0,127}));
  connect(fan1.y, pump_cold)
    annotation (Line(points={{89.6,0},{100,0}}, color={0,0,127}));
  connect(val1.y, valve_hot) annotation (Line(points={{-32.8,60},{20,60},{20,40},
          {100,40}}, color={0,0,127}));
  connect(val2.y, valve_cold)
    annotation (Line(points={{87.2,80},{100,80}}, color={0,0,127}));
  connect(plugFlowPipe3.ports_b[1], fan1.port_a)
    annotation (Line(points={{80,12},{80,8}}, color={0,127,255}));
  connect(plugFlowPipe3.port_a, val2.port_2)
    annotation (Line(points={{80,30},{80,74}}, color={0,127,255}));
  connect(plugFlowPipe2.port_a, vol1.ports[1])
    annotation (Line(points={{40,30},{40,78.4}}, color={0,127,255}));
  connect(val2.port_3, vol1.ports[2]) annotation (Line(points={{74,80},{58,80},{
          58,80},{40,80}}, color={0,127,255}));
  connect(Fluid_out_cold, vol1.ports[3])
    annotation (Line(points={{40,100},{40,100},{40,81.6}}, color={0,127,255}));
  connect(Fluid_in_cold, val2.port_1)
    annotation (Line(points={{80,100},{80,86},{80,86}}, color={0,127,255}));
  connect(plugFlowPipe2.ports_b[1], Ext_Cold.port_b1) annotation (Line(points={{
          38.4,12},{38.4,-40},{0,-40},{0,-54},{8,-54}}, color={0,127,255}));
  connect(Ext_Cold.port_a1, fan1.port_b) annotation (Line(points={{28,-54},{60,-54},
          {60,-40},{80,-40},{80,-8}}, color={0,127,255}));
  connect(fan.heatPort, heatPort_hot) annotation (Line(points={{-45.44,-20},{-60,
          -20},{-60,-40},{-20,-40},{-20,-100}}, color={191,0,0}));
  connect(plugFlowPipe1.heatPort, heatPort_hot) annotation (Line(points={{-72,11},
          {-60,11},{-60,12},{-60,12},{-60,-40},{-20,-40},{-20,-100}}, color={191,
          0,0}));
  connect(plugFlowPipe.heatPort, heatPort_hot) annotation (Line(points={{-48,11},
          {-60,11},{-60,12},{-60,12},{-60,-40},{-20,-40},{-20,-100}}, color={191,
          0,0}));
  connect(fan1.heatPort, heatPort_cold) annotation (Line(points={{74.56,0},{0,0},
          {0,-80},{20,-80},{20,-100}}, color={191,0,0}));
  connect(plugFlowPipe2.heatPort, heatPort_cold) annotation (Line(points={{48,21},
          {60,21},{60,0},{0,0},{0,-80},{20,-80},{20,-100}}, color={191,0,0}));
  connect(plugFlowPipe3.heatPort, heatPort_cold) annotation (Line(points={{72,21},
          {60,21},{60,20},{60,20},{60,0},{0,0},{0,-80},{20,-80},{20,-100}},
        color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RLT;
