within AixLib.Systems.Benchmark.Model.Transfer.Transfer_RLT;
model RLT_Central_v2
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  replaceable package Medium_Air =
    AixLib.Media.Air "Medium in the component";

    parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_diameter_hot = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_hot = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_hot = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_diameter_cold = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal_cold = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dpValve_nominal_cold = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Hot = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Area Area_Heatexchanger_AirWater_Cold = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Area Area_pipe_air = 0 annotation(Dialog(tab = "General"));

  Fluid.Humidifiers.SprayAirWasher_X hum(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=3.375,
    dp_nominal=1,
    allowFlowReversal=true)
    annotation (Placement(transformation(extent={{50,-76},{70,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{70,90},{90,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_hot(redeclare package Medium =
        Medium_Water)
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Air_in(redeclare package Medium =
        Medium_Air)
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{-110,-76},{-90,-56}})));
  Modelica.Fluid.Interfaces.FluidPort_b Air_out(redeclare package Medium =
        Medium_Air)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{90,-76},{110,-56}})));
  Modelica.Blocks.Interfaces.RealInput X_w
    "Set point for water vapor mass fraction in kg/kg total air of the fluid that leaves port_b"
    annotation (Placement(transformation(
        extent={{12,-12},{-12,12}},
        rotation=90,
        origin={0,100})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_hot,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    use_inputFilter=false,
    dpValve_nominal=dpValve_nominal_hot)
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,60})));

  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_hot,
    nPorts=4,
    V=V_mixing)
              annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-86,60})));
  Modelica.Blocks.Interfaces.RealInput pump_hot
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{112,-52},{88,-28}})));
  Fluid.Movers.SpeedControlled_y fan1(redeclare package Medium = Medium_Water,
    y_start=0,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos30slash1to8 per)
    annotation (Dialog(enable = true), Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={80,0})));
  Modelica.Blocks.Interfaces.RealInput pump_cold
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{112,-12},{88,12}})));
  Fluid.Actuators.Valves.ThreeWayLinear val2(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_cold,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    use_inputFilter=false,
    dpValve_nominal=dpValve_nominal_cold)
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
    nPorts=4,
    m_flow_nominal=m_flow_nominal_cold,
    V=V_mixing)      annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={34,80})));
  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium = Medium_Water,
    use_inputFilter=true,
    y_start=0,
    redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per)
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={-40,-20})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-82,26},{-62,46}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-20})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-60,26},{-40,46}})));
  Fluid.Sensors.Temperature senTem3(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Fluid.Sensors.Temperature senTem4(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{60,50},{80,70}})));
  Fluid.Sensors.MassFlowRate senMasFlo1(
                                       redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-14})));
  Modelica.Blocks.Interfaces.RealOutput massflow_hot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,-100})));
  Modelica.Blocks.Interfaces.RealOutput power_pump_hot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-100})));
  Modelica.Blocks.Interfaces.RealOutput power_pump_cold annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-100})));
  Modelica.Blocks.Interfaces.RealOutput massflow_cold
    "Mass flow rate from port_a to port_b" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,-100})));
  Modelica.Blocks.Interfaces.RealOutput cold_out annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,80})));
  Modelica.Blocks.Interfaces.RealOutput cold_in annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,40})));
  Modelica.Blocks.Interfaces.RealOutput hot_out annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,0})));
  Modelica.Blocks.Interfaces.RealOutput hot_in annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-100,-40})));
  Fluid.MixingVolumes.MixingVolume vol3(
    redeclare package Medium = Medium_Air,
    m_flow_nominal=3.375,
    V=2.8,
    nPorts=2) annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=0,
        origin={-20,-72})));
  Fluid.Sensors.Temperature senTem5(redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{68,-66},{88,-46}})));
  Modelica.Blocks.Interfaces.RealOutput Airtemp_out
    "Temperature in port medium"
    annotation (Placement(transformation(extent={{100,-102},{120,-82}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium_Water,
    diameter=pipe_diameter_hot,
    height_ab=pipe_height,
    length=pipe_length,
    nNodes=pipe_nodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,6})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = Medium_Water,
    diameter=pipe_diameter_hot,
    height_ab=pipe_height,
    length=pipe_length,
    nNodes=pipe_nodes) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,6})));
  Modelica.Fluid.Pipes.DynamicPipe pipe2(
    redeclare package Medium = Medium_Water,
    height_ab=pipe_height,
    length=pipe_length,
    nNodes=pipe_nodes,
    diameter=pipe_diameter_cold)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={80,26})));
  Modelica.Fluid.Pipes.DynamicPipe pipe3(
    redeclare package Medium = Medium_Water,
    height_ab=pipe_height,
    length=pipe_length,
    nNodes=pipe_nodes,
    diameter=pipe_diameter_cold)
                       annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={40,20})));
  Fluid.MixingVolumes.MixingVolume vol4(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=3.375,
    V=2.8)    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={32,-60})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_hot,
    dp_nominal(displayUnit="bar") = 20000)
    annotation (Placement(transformation(extent={{-64,-40},{-74,-30}})));
  Fluid.MixingVolumes.MixingVolume vol6(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_hot,
    V=0.01,
    nPorts=2)
           annotation (Placement(transformation(extent={{-56,-38},{-46,-48}})));
  AixLib.Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside(
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Glass(),
    A=Area_Heatexchanger_AirWater_Hot)                                                                                                                                                      annotation(Placement(transformation(extent={{-5.5,-6},
            {5.5,6}},
        rotation=90,
        origin={-66.5,-50})));
  Fluid.MixingVolumes.MixingVolume vol7(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_cold,
    V=0.01,
    nPorts=2)
           annotation (Placement(transformation(extent={{28,-38},{38,-48}})));
  AixLib.Utilities.HeatTransfer.HeatConvOutside heatTransfer_Outside1(
    surfaceType=AixLib.DataBase.Surfaces.RoughnessForHT.Glass(),
    A=Area_Heatexchanger_AirWater_Cold)                                                                                                                                                     annotation(Placement(transformation(extent={{-5.5,-6},
            {5.5,6}},
        rotation=90,
        origin={19.5,-50})));
  Fluid.FixedResistances.PressureDrop res1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal_cold,
    dp_nominal(displayUnit="bar") = 20000)
    annotation (Placement(transformation(extent={{24,-34},{34,-24}})));
  Modelica.Blocks.Math.Gain gain(k=1/(1.2041*Area_pipe_air))
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={0,-48})));
  Fluid.Sensors.MassFlowRate senMasFlo2(redeclare package Medium = Medium_Air)
    annotation (Placement(transformation(extent={{-10,-76},{10,-56}})));
  Fluid.MixingVolumes.MixingVolume vol8(
    nPorts=2,
    redeclare package Medium = Medium_Air,
    m_flow_nominal=3.375,
    V=2.8)    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=0,
        origin={-52,-60})));
equation
  connect(hum.X_w, X_w) annotation (Line(points={{48,-60},{40,-60},{40,-40},{0,
          -40},{0,100}}, color={0,0,127}));
  connect(val1.port_3, vol.ports[1]) annotation (Line(points={{-46,60},{-64,60},
          {-64,58.2},{-80,58.2}},
                              color={0,127,255}));
  connect(Fluid_out_hot, vol.ports[2])
    annotation (Line(points={{-80,100},{-80,59.4}}, color={0,127,255}));
  connect(Fluid_in_hot, val1.port_1)
    annotation (Line(points={{-40,100},{-40,66}}, color={0,127,255}));
  connect(fan1.y, pump_cold)
    annotation (Line(points={{89.6,0},{100,0}}, color={0,0,127}));
  connect(val1.y, valve_hot) annotation (Line(points={{-32.8,60},{20,60},{20,40},
          {100,40}}, color={0,0,127}));
  connect(val2.y, valve_cold)
    annotation (Line(points={{87.2,80},{100,80}}, color={0,0,127}));
  connect(val2.port_3, vol1.ports[1]) annotation (Line(points={{74,80},{58,80},{
          58,78.2},{40,78.2}},
                           color={0,127,255}));
  connect(Fluid_out_cold, vol1.ports[2])
    annotation (Line(points={{40,100},{40,79.4},{40,79.4}},color={0,127,255}));
  connect(Fluid_in_cold, val2.port_1)
    annotation (Line(points={{80,100},{80,86},{80,86}}, color={0,127,255}));
  connect(fan2.y, pump_hot) annotation (Line(points={{-30.4,-20},{-20,-20},{-20,
          -40},{100,-40}}, color={0,0,127}));
  connect(senTem2.port, vol.ports[3]) annotation (Line(points={{-72,26},{-80,26},
          {-80,60.6}}, color={0,127,255}));
  connect(senTem3.port, vol1.ports[3])
    annotation (Line(points={{50,50},{40,50},{40,80.6}}, color={0,127,255}));
  connect(senTem4.port, val2.port_2)
    annotation (Line(points={{70,50},{80,50},{80,74}}, color={0,127,255}));
  connect(senMasFlo.m_flow, massflow_hot) annotation (Line(points={{-91,-20},{-114,
          -20},{-114,-80},{-80,-80},{-80,-100}},      color={0,0,127}));
  connect(fan2.P, power_pump_hot) annotation (Line(points={{-32.8,-28.8},{-32.8,
          -80},{-40,-80},{-40,-100}}, color={0,0,127}));
  connect(fan1.P, power_pump_cold) annotation (Line(points={{87.2,-8.8},{87.2,
          -40},{40,-40},{40,-100}}, color={0,0,127}));
  connect(senMasFlo1.m_flow, massflow_cold) annotation (Line(points={{29,-14},{
          20,-14},{20,-40},{40,-40},{40,-80},{80,-80},{80,-100}}, color={0,0,
          127}));
  connect(senTem1.T, hot_in) annotation (Line(points={{-43,36},{-20,36},{-20,
          -40},{-100,-40}}, color={0,0,127}));
  connect(senTem2.T, hot_out) annotation (Line(points={{-65,36},{-60,36},{-60,0},
          {-100,0}}, color={0,0,127}));
  connect(senTem3.T, cold_out) annotation (Line(points={{57,60},{60,60},{60,40},
          {20,40},{20,80},{-100,80}}, color={0,0,127}));
  connect(senTem4.T, cold_in) annotation (Line(points={{77,60},{78,60},{78,40},
          {-100,40}}, color={0,0,127}));
  connect(senTem5.T, Airtemp_out) annotation (Line(points={{85,-56},{92,-56},{92,
          -92},{110,-92}}, color={0,0,127}));
  connect(val1.port_2, pipe.port_a)
    annotation (Line(points={{-40,54},{-40,16}}, color={0,127,255}));
  connect(pipe.port_b, fan2.port_a)
    annotation (Line(points={{-40,-4},{-40,-12}}, color={0,127,255}));
  connect(senTem1.port, pipe.port_a)
    annotation (Line(points={{-50,26},{-40,26},{-40,16}}, color={0,127,255}));
  connect(senMasFlo.port_b, pipe1.port_a)
    annotation (Line(points={{-80,-10},{-80,-4}}, color={0,127,255}));
  connect(pipe1.port_b, vol.ports[4])
    annotation (Line(points={{-80,16},{-80,61.8}}, color={0,127,255}));
  connect(pipe2.port_a, val2.port_2)
    annotation (Line(points={{80,36},{80,74}}, color={0,127,255}));
  connect(pipe2.port_b, fan1.port_a)
    annotation (Line(points={{80,16},{80,8}}, color={0,127,255}));
  connect(senMasFlo1.port_b, pipe3.port_a)
    annotation (Line(points={{40,-4},{40,10}}, color={0,127,255}));
  connect(pipe3.port_b, vol1.ports[4])
    annotation (Line(points={{40,30},{40,81.8}}, color={0,127,255}));
  connect(vol4.ports[1], hum.port_a)
    annotation (Line(points={{30.8,-66},{50,-66}}, color={0,127,255}));
  connect(senTem5.port, Air_out)
    annotation (Line(points={{78,-66},{100,-66}}, color={0,127,255}));
  connect(senMasFlo2.m_flow, gain.u)
    annotation (Line(points={{0,-55},{0,-52.8}}, color={0,0,127}));
  connect(res.port_a, vol6.ports[1]) annotation (Line(points={{-64,-35},{-58,
          -35},{-58,-38},{-52,-38}},
                                color={0,127,255}));
  connect(res.port_b, senMasFlo.port_a) annotation (Line(points={{-74,-35},{-78,
          -35},{-80,-35},{-80,-34},{-80,-30},{-80,-30}}, color={0,127,255}));
  connect(res1.port_b, senMasFlo1.port_a) annotation (Line(points={{34,-29},{40,
          -29},{40,-28},{40,-28},{40,-24}}, color={0,127,255}));
  connect(res1.port_a, vol7.ports[1]) annotation (Line(points={{24,-29},{16,-29},
          {16,-30},{16,-30},{16,-38},{32,-38}}, color={0,127,255}));
  connect(vol7.ports[2], fan1.port_b) annotation (Line(points={{34,-38},{80,-38},
          {80,-8},{80,-8}}, color={0,127,255}));
  connect(heatTransfer_Outside1.port_b, vol7.heatPort) annotation (Line(points={
          {19.5,-44.5},{20,-44.5},{20,-43},{28,-43}}, color={191,0,0}));
  connect(heatTransfer_Outside1.port_a, vol4.heatPort) annotation (Line(points={
          {19.5,-55.5},{19.5,-60},{26,-60}}, color={191,0,0}));
  connect(gain.y, heatTransfer_Outside1.WindSpeedPort) annotation (Line(points={{0,-43.6},
          {0,-40},{14,-40},{14,-76},{23.82,-76},{23.82,-55.06}},
        color={0,0,127}));
  connect(senMasFlo2.port_b, vol4.ports[2])
    annotation (Line(points={{10,-66},{33.2,-66}}, color={0,127,255}));
  connect(senMasFlo2.port_a, vol3.ports[1])
    annotation (Line(points={{-10,-66},{-21.2,-66}}, color={0,127,255}));
  connect(vol3.ports[2], vol8.ports[1])
    annotation (Line(points={{-18.8,-66},{-53.2,-66}}, color={0,127,255}));
  connect(vol8.ports[2], Air_in)
    annotation (Line(points={{-50.8,-66},{-100,-66}}, color={0,127,255}));
  connect(hum.port_b, senTem5.port)
    annotation (Line(points={{70,-66},{78,-66}}, color={0,127,255}));
  connect(heatTransfer_Outside.port_a, vol8.heatPort) annotation (Line(points={{
          -66.5,-55.5},{-66.5,-60},{-58,-60}}, color={191,0,0}));
  connect(heatTransfer_Outside.port_b, vol6.heatPort) annotation (Line(points={{
          -66.5,-44.5},{-66.5,-43},{-56,-43}}, color={191,0,0}));
  connect(heatTransfer_Outside.WindSpeedPort, gain.y) annotation (Line(points={{-62.18,
          -55.06},{-62.18,-72},{-32,-72},{-32,-40},{0,-40},{0,-43.6}},
        color={0,0,127}));
  connect(vol6.ports[2], fan2.port_b) annotation (Line(points={{-50,-38},{-44,
          -38},{-44,-38},{-40,-38},{-40,-28}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end RLT_Central_v2;
