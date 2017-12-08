within AixLib.Fluid.DistrictHeatingCooling.Supplies.NoReturn;
model IdealSourcePump
  replaceable package Medium = AixLib.Media.Water(T_default=273.15+70)
    "Medium model" annotation (choicesAllMatching=true);
  AixLib.Fluid.Movers.FlowControlled_dp gridPump(
    redeclare package Medium = Medium,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  AixLib.Fluid.Sources.Boundary_pT heaterSource(
    redeclare package Medium = Medium,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(
    redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Continuous.LimPID PID
    annotation (Placement(transformation(extent={{-40,50},{-20,30}})));
  Modelica.Blocks.Interfaces.RealInput T_heater
    "Flow temperature in °C (70/110)" annotation (Placement(transformation(
          extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-120,-20},
            {-80,20}})));
  Modelica.Blocks.Interfaces.RealInput p_NSP "Pressure at Netzschlechtpunkt"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}}),
        iconTransformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_gridPump "Power of grid pump "
    annotation (Placement(transformation(extent={{80,40},{120,80}}),
        iconTransformation(extent={{80,40},{120,80}})));
  Modelica.Blocks.Sources.Constant p_NSP_set(k=2.5)
    "Set value of pressure at Netzschlechtpunkt"
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  AixLib.Fluid.Sensors.TemperatureTwoPort flowTemperature(
    redeclare package Medium = Medium,
    m_flow_nominal=3)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(heaterSource.ports[1], gridPump.port_a)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,127,255}));
  connect(PID.y, gridPump.dp_in)
    annotation (Line(points={{-19,40},{0,40},{0,12}},       color={0,0,127}));
  connect(T_heater, heaterSource.T_in) annotation (Line(points={{-100,0},{-72,0},
          {-72,4},{-62,4}}, color={0,0,127}));
  connect(p_NSP, PID.u_m)
    annotation (Line(points={{-100,60},{-30,60},{-30,52}}, color={0,0,127}));
  connect(p_NSP_set.y, PID.u_s)
    annotation (Line(points={{-59,40},{-42,40}}, color={0,0,127}));
  connect(gridPump.P, P_gridPump) annotation (Line(points={{11,9},{20,9},{20,60},
          {100,60}}, color={0,0,127}));
  connect(gridPump.port_b, flowTemperature.port_a)
    annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
  connect(flowTemperature.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-34,32},{32,-34}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,26},{-20,-28},{32,0},{-20,26}},
          lineColor={28,108,200},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end IdealSourcePump;
