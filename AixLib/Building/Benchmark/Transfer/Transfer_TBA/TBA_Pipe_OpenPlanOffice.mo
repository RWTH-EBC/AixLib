within AixLib.Building.Benchmark.Transfer.Transfer_TBA;
model TBA_Pipe_OpenPlanOffice
  replaceable package Medium_Water =
    AixLib.Media.Water "Medium in the component";
  import BaseLib = AixLib.Utilities;

    parameter Modelica.SIunits.Velocity v_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Real m_flow_nominal = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_length = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_wall_thickness = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Length pipe_insulation_thickness = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.ThermalConductivity pipe_insulation_conductivity = 0  annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Volume V_mixing = 0 annotation(Dialog(tab = "General"));
    parameter Modelica.SIunits.Pressure dp_Valve_nominal = 0 annotation(Dialog(tab = "General"));

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_TBA
    annotation (Placement(transformation(extent={{-50,90},{-30,110}})));
  parameter Modelica.SIunits.Length TBA_pipe_diameter = 0.02 annotation(Dialog(tab = "General"));
  parameter Modelica.SIunits.Length TBA_wall_length = 0 annotation(Dialog(tab = "General"));
  parameter Modelica.SIunits.Length TBA_wall_height = 0 annotation(Dialog(tab = "General"));
  Modelica.Fluid.Interfaces.FluidPort_a Fluid_in(redeclare package Medium =
        Medium_Water)
    "Fluid connector a (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{-70,-110},{-50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b Fluid_out(redeclare package Medium =
        Medium_Water)
    "Fluid connector b (positive design flow direction is from port_a to port_b)"
    annotation (Placement(transformation(extent={{50,-110},{70,-90}})));
  Fluid.MixingVolumes.MixingVolume vol(
    m_flow_nominal=1,
    redeclare package Medium = Medium_Water,
    nPorts=2,
    V=TBA_wall_length*TBA_wall_height*5.8*3.14159*(TBA_pipe_diameter/2)^2)
    annotation (Placement(transformation(extent={{-8,46},{12,66}})));

  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe(redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    v_nominal=v_nominal,
    m_flow_nominal=m_flow_nominal,
    dIns=pipe_insulation_thickness,
    kIns=pipe_insulation_conductivity,
    thickness=pipe_wall_thickness,
    nPorts=1,
    length=pipe_length + 50)
    annotation (Placement(transformation(extent={{9,8},{-9,-8}},
        rotation=-90,
        origin={60,-9})));
  Fluid.Actuators.Valves.ThreeWayLinear val1(
    redeclare package Medium = Medium_Water,
    m_flow_nominal=m_flow_nominal,
    CvData=AixLib.Fluid.Types.CvTypes.OpPoint,
    dpValve_nominal=dp_Valve_nominal,
    use_inputFilter=false)
    annotation (Placement(transformation(extent={{6,6},{-6,-6}},
        rotation=-90,
        origin={-60,-40})));

  Fluid.FixedResistances.PlugFlowPipe plugFlowPipe1(
                                                   redeclare package Medium =
        Medium_Water,
    cPip=500,
    rhoPip=8000,
    nPorts=1,
    v_nominal=v_nominal,
    m_flow_nominal=m_flow_nominal,
    dIns=pipe_insulation_thickness,
    kIns=pipe_insulation_conductivity,
    thickness=pipe_wall_thickness,
    length=pipe_length + 50)
    annotation (Placement(transformation(extent={{9,-8},{-9,8}},
        rotation=-90,
        origin={-60,-9})));
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
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a HeatPort_pumpsAndPipes
    annotation (Placement(transformation(extent={{30,90},{50,110}})));
  Modelica.Blocks.Interfaces.RealInput valve
    "Actuator position (0: closed, 1: open)"
    annotation (Placement(transformation(extent={{-112,-52},{-88,-28}})));
  Modelica.Blocks.Interfaces.RealInput pump
    "Constant normalized rotational speed"
    annotation (Placement(transformation(extent={{-112,16},{-88,40}})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-42,-30},{-22,-10}})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={60,26})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Medium_Water)
    annotation (Placement(transformation(extent={{22,-30},{42,-10}})));
  Modelica.Blocks.Interfaces.RealOutput m_flow
    "Mass flow rate from port_a to port_b"
    annotation (Placement(transformation(extent={{90,10},{110,30}})));
  Modelica.Blocks.Interfaces.RealOutput Power_pump "Electrical power consumed"
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Interfaces.RealOutput Temp_out "Temperature in port medium"
    annotation (Placement(transformation(extent={{90,-30},{110,-10}})));
  Modelica.Blocks.Interfaces.RealOutput Temp_in "Temperature in port medium"
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
equation
  connect(vol.heatPort, HeatPort_TBA) annotation (Line(points={{-8,56},{-24,56},
          {-24,56},{-40,56},{-40,100},{-40,100}},
                                    color={191,0,0}));
  connect(plugFlowPipe1.heatPort, plugFlowPipe.heatPort)
    annotation (Line(points={{-52,-9},{52,-9}}, color={191,0,0}));
  connect(Fluid_in, val1.port_1)
    annotation (Line(points={{-60,-100},{-60,-46}}, color={0,127,255}));
  connect(plugFlowPipe1.ports_b[1], fan2.port_a)
    annotation (Line(points={{-60,0},{-60,20}}, color={0,127,255}));
  connect(fan2.port_b, vol.ports[1])
    annotation (Line(points={{-60,36},{-60,46},{0,46}}, color={0,127,255}));
  connect(plugFlowPipe.port_a, vol1.ports[1])
    annotation (Line(points={{60,-18},{60,-41.8}}, color={0,127,255}));
  connect(val1.port_3, vol1.ports[2]) annotation (Line(points={{-54,-40},{4,-40},
          {4,-40.6},{60,-40.6}},
                             color={0,127,255}));
  connect(vol1.ports[3], Fluid_out)
    annotation (Line(points={{60,-39.4},{60,-100}}, color={0,127,255}));
  connect(val1.port_2, plugFlowPipe1.port_a)
    annotation (Line(points={{-60,-34},{-60,-18}}, color={0,127,255}));
  connect(HeatPort_pumpsAndPipes, plugFlowPipe.heatPort) annotation (Line(
        points={{40,100},{40,28},{0,28},{0,-9},{52,-9}}, color={191,0,0}));
  connect(val1.y, valve)
    annotation (Line(points={{-67.2,-40},{-100,-40}}, color={0,0,127}));
  connect(fan2.y, pump)
    annotation (Line(points={{-69.6,28},{-100,28}}, color={0,0,127}));
  connect(senTem2.port, plugFlowPipe1.port_a) annotation (Line(points={{-32,-30},
          {-60,-30},{-60,-18}}, color={0,127,255}));
  connect(senTem1.port, vol1.ports[4]) annotation (Line(points={{32,-30},{60,-30},
          {60,-38.2}}, color={0,127,255}));
  connect(vol.ports[2], senMasFlo.port_b)
    annotation (Line(points={{4,46},{60,46},{60,36}}, color={0,127,255}));
  connect(senMasFlo.port_a, plugFlowPipe.ports_b[1])
    annotation (Line(points={{60,16},{60,0}}, color={0,127,255}));
  connect(senMasFlo.m_flow, m_flow) annotation (Line(points={{71,26},{80,26},{80,
          20},{100,20}}, color={0,0,127}));
  connect(fan2.P, Power_pump) annotation (Line(points={{-67.2,36.8},{-67.2,80},{
          80,80},{80,60},{100,60}}, color={0,0,127}));
  connect(senTem1.T, Temp_out)
    annotation (Line(points={{39,-20},{100,-20}}, color={0,0,127}));
  connect(senTem2.T, Temp_in) annotation (Line(points={{-25,-20},{0,-20},{0,-60},
          {100,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TBA_Pipe_OpenPlanOffice;
