within AixLib.Systems.Benchmark.Model.Transfer.Transfer_TBA;
model TBA_Pipe_Openplanoffice_v2
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  import BaseLib = AixLib.Utilities;

    parameter Integer pipe_nodes = 2 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_diameter = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_height = 0 annotation(Dialog(tab = "General"));

    parameter Modelica.SIunits.Pressure dp_Heatexchanger_nominal = 0 annotation(Dialog(tab = "General"));

    parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));

  Fluid.MixingVolumes.MixingVolume vol(
    m_flow_nominal=1,
    redeclare package Medium = Medium_Water,
    nPorts=2,
    V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
    annotation (Placement(transformation(extent={{-8,46},{12,66}})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dp_Valve_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=-90,
        origin={-60,-40})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Medium_Water,
    nPorts=4,
    m_flow_nominal=m_flow_nominal,
    V=V_mixing)
              annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=90,
        origin={66,-40})));
  Fluid.Movers.SpeedControlled_y fan2(redeclare package Medium = Medium_Water,
      redeclare Fluid.Movers.Data.Pumps.Wilo.Stratos40slash1to12 per,
    y_start=1)
    annotation (Placement(transformation(extent={{8,8},{-8,-8}},
        rotation=-90,
        origin={-60,28})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,26})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = Medium_Water,
    height_ab=pipe_height,
    nNodes=pipe_nodes,
    diameter=pipe_diameter,
    length=pipe_length + 50)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-8})));
  Modelica.Fluid.Pipes.DynamicPipe pipe1(
    redeclare package Medium = Medium_Water,
    height_ab=pipe_height,
    nNodes=pipe_nodes,
    diameter=pipe_diameter,
    length=pipe_length + 50)
                       annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-60,-6})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_cold(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Modelica.Blocks.Interfaces.RealInput valve_temp
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-112,-12},{-88,12}})));
  Modelica.Blocks.Interfaces.RealInput pump
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{-112,48},{-88,72}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    "Mass flow rate from port_a to port_b"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Fluid.HeatExchangers.ConstantEffectiveness Ext_Warm(
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Water,
    dp1_nominal(displayUnit="bar") = dp_Heatexchanger_nominal,
    dp2_nominal=dp_Heatexchanger_nominal,
    m1_flow_nominal=m_flow_nominal,
    m2_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=0,
        origin={-5,-43})));
  Fluid.Actuators.Valves.TwoWayLinear val(
    use_inputFilter=false,
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal,
    dpValve_nominal=dp_Valve_nominal)             annotation (Placement(
        transformation(
        extent={{6,6},{-6,-6}},
        rotation=-90,
        origin={-20,-70})));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out_warm(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
  Modelica.Blocks.Interfaces.RealInput Valve_warm
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-112,-72},{-88,-48}})));
equation
  connect(vol.heatPort,HeatPort_TBA)  annotation (Line(points={{-8,56},{-24,56},
          {-24,56},{-40,56},{-40,100},{-40,100}},
                                    color={191,0,0}));
  connect(Fluid_in_cold, val1.port_1)
    annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
  connect(fan2.port_b,vol. ports[1])
    annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
  connect(val1.y, valve_temp) annotation (Line(points={{-67.2,-40},{-80,-40},{-80,
          0},{-100,0}}, color={0,0,127}));
  connect(fan2.y,pump)
    annotation (Line(points={{-69.6,28},{-80,28},{-80,60},{-100,60}},
                                                    color={0,0,127}));
  connect(senTem1.port,vol1. ports[1]) annotation (Line(points={{32,-30},{60,-30},
          {60,-41.8}}, color={0,127,255}));
  connect(vol.ports[2],senMasFlo. port_b)
    annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
  connect(senMasFlo.m_flow,m_flow)  annotation (Line(points={{71,26},{80,26},{80,
          20},{100,20}}, color={0,0,127}));
  connect(fan2.P,Power_pump)  annotation (Line(points={{-67.2,36.8},{-67.2,80},{
          80,80},{80,60},{100,60}}, color={0,0,127}));
  connect(senTem1.T,Temp_out)
    annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
  connect(senTem2.T,Temp_in)  annotation (Line(points={{-25,-20},{20,-20},{20,-60},
          {100,-60}}, color={0,0,127}));
  connect(pipe1.port_a,val1. port_2)
    annotation (Line(points={{-60,-16},{-60,-34}}, color={0,127,255}));
  connect(pipe1.port_b,fan2. port_a)
    annotation (Line(points={{-60,4},{-60,20}}, color={0,127,255}));
  connect(pipe.port_a,senMasFlo. port_a)
    annotation (Line(points={{60,2},{60,16}}, color={0,127,255}));
  connect(senTem2.port,val1. port_2) annotation (Line(points={{-32,-30},{-60,-30},
          {-60,-34}}, color={0,127,255}));
  connect(Ext_Warm.port_b1, val1.port_3)
    annotation (Line(points={{-10,-40},{-54,-40}}, color={0,127,255}));
  connect(pipe.port_b, vol1.ports[2])
    annotation (Line(points={{60,-18},{60,-40.6}}, color={0,127,255}));
  connect(Ext_Warm.port_a1, vol1.ports[3]) annotation (Line(points={{0,-40},{30,
          -40},{30,-39.4},{60,-39.4}}, color={0,127,255}));
  connect(vol1.ports[4], Fluid_out_cold)
    annotation (Line(points={{60,-38.2},{60,-100}}, color={0,127,255}));
  connect(val.port_a, Fluid_in_warm)
    annotation (Line(points={{-20,-76},{-20,-100}}, color={0,127,255}));
  connect(val.port_b, Ext_Warm.port_a2) annotation (Line(points={{-20,-64},{-20,
          -46},{-10,-46}}, color={0,127,255}));
  connect(Ext_Warm.port_b2, Fluid_out_warm)
    annotation (Line(points={{0,-46},{20,-46},{20,-100}}, color={0,127,255}));
  connect(val.y, Valve_warm) annotation (Line(points={{-27.2,-70},{-80,-70},{
          -80,-60},{-100,-60}},
                            color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TBA_Pipe_Openplanoffice_v2;
