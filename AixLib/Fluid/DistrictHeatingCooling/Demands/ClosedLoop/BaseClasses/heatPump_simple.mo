within AixLib.Fluid.DistrictHeatingCooling.Demands.ClosedLoop.BaseClasses;
model heatPump_simple

          replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model for water" annotation (choicesAllMatching=true);

    parameter Modelica.SIunits.MassFlowRate m_flow_nominal = 0.1;

    parameter Real eta_car = 0.5;

    parameter Modelica.SIunits.Power Capacity = 1;

    parameter Modelica.SIunits.Temperature T_max_storage;

    parameter Modelica.SIunits.Temperature TUseAct_nominal = 30 + 273.15 + 2;

    parameter Modelica.SIunits.Temperature TCon_nominal = 30 + 273.15;

    parameter Modelica.SIunits.Temperature TEva_nominal = 5 +273.15;

    parameter Modelica.SIunits.TemperatureDifference TAppCon_nominal = 2;

    parameter Modelica.SIunits.TemperatureDifference TAppEva_nominal = 2;

    Real COP_car;

    Real COP;

    Real COP_nom;

    Real COP_car_charging;

    Real COP_charging;

  Modelica.Fluid.Interfaces.FluidPort_a port_a2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{90,50},{110,70}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=-min.y/(1 + 1/(COP - 1)))
    annotation (Placement(transformation(extent={{-88,80},{-68,100}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=-Capacity/(1 + 1/(
        COP - 1)))
    annotation (Placement(transformation(extent={{-88,68},{-68,88}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{-58,76},{-42,92}})));
  Modelica.Blocks.Math.Min min
    annotation (Placement(transformation(extent={{-80,-6},{-64,10}})));
  Modelica.Blocks.Sources.Constant const(k=Capacity)
    annotation (Placement(transformation(extent={{-100,-38},{-80,-18}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=port_a2.m_flow*4180*(
        T_set_outlet - T_sink.T))
    annotation (Placement(transformation(extent={{-104,18},{-84,38}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
    annotation (Placement(transformation(extent={{-36,78},{-24,90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow2
    annotation (Placement(transformation(extent={{-52,-4},{-40,8}})));
  Delays.DelayFirstOrder del(m_flow_nominal=m_flow_nominal,
                             nPorts=2)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Delays.DelayFirstOrder del1(m_flow_nominal=m_flow_nominal,
                              nPorts=2)
    annotation (Placement(transformation(extent={{-6,-60},{14,-40}})));
  Sensors.TemperatureTwoPort T_source(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-64,50},{-44,70}})));
  Sensors.TemperatureTwoPort T_sink(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{66,-70},{46,-50}})));
  Sensors.TemperatureTwoPort T_source1(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{34,50},{54,70}})));
  Sensors.TemperatureTwoPort T_sink1(redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{-32,-70},{-52,-50}})));
  Modelica.Blocks.Interfaces.RealInput T_set_outlet
    annotation (Placement(transformation(extent={{-132,78},{-92,118}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=min.y/COP)
    annotation (Placement(transformation(extent={{36,82},{56,102}})));
  Modelica.Blocks.Math.Min min2
    annotation (Placement(transformation(extent={{66,80},{82,96}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=Capacity/COP)
    annotation (Placement(transformation(extent={{36,66},{56,86}})));
  Modelica.Blocks.Interfaces.RealOutput P_el
    annotation (Placement(transformation(extent={{98,88},{118,108}})));
equation

  COP_car = (T_set_outlet + 2)/((T_set_outlet + 2) - (T_source1.T -2));

  COP = COP_car * eta_car;

  COP_car_charging = (T_max_storage + 2)/((T_max_storage + 2) - (T_source1.T -2));

  COP_charging = COP_car_charging * eta_car;

  COP_nom = eta_car * (TUseAct_nominal/(TCon_nominal+TAppCon_nominal - (TEva_nominal-TAppEva_nominal)));

  connect(realExpression.y,max. u1) annotation (Line(points={{-67,90},{-64,90},{
          -64,88.8},{-59.6,88.8}}, color={0,0,127}));
  connect(realExpression2.y,max. u2) annotation (Line(points={{-67,78},{-64,78},
          {-64,79.2},{-59.6,79.2}}, color={0,0,127}));
  connect(const.y,min. u2) annotation (Line(points={{-79,-28},{-79,-2.8},{-81.6,
          -2.8}}, color={0,0,127}));
  connect(realExpression4.y,min. u1) annotation (Line(points={{-83,28},{-81.6,
          28},{-81.6,6.8}}, color={0,0,127}));
  connect(max.y, prescribedHeatFlow1.Q_flow)
    annotation (Line(points={{-41.2,84},{-36,84}}, color={0,0,127}));
  connect(min.y, prescribedHeatFlow2.Q_flow)
    annotation (Line(points={{-63.2,2},{-52,2}}, color={0,0,127}));
  connect(port_a1,T_source. port_a)
    annotation (Line(points={{-100,60},{-64,60}}, color={0,127,255}));
  connect(T_source.port_b, del.ports[1])
    annotation (Line(points={{-44,60},{-2,60}}, color={0,127,255}));
  connect(del.ports[2],T_source1. port_a)
    annotation (Line(points={{2,60},{34,60}}, color={0,127,255}));
  connect(T_source1.port_b, port_b1)
    annotation (Line(points={{54,60},{100,60}}, color={0,127,255}));
  connect(prescribedHeatFlow1.port, del.heatPort) annotation (Line(points={{-24,
          84},{-18,84},{-18,70},{-10,70}}, color={191,0,0}));
  connect(T_sink.port_a, port_a2)
    annotation (Line(points={{66,-60},{100,-60}}, color={0,127,255}));
  connect(T_sink.port_b, del1.ports[1])
    annotation (Line(points={{46,-60},{2,-60}}, color={0,127,255}));
  connect(port_b2,T_sink1. port_b)
    annotation (Line(points={{-100,-60},{-52,-60}}, color={0,127,255}));
  connect(T_sink1.port_a, del1.ports[2])
    annotation (Line(points={{-32,-60},{6,-60}}, color={0,127,255}));
  connect(prescribedHeatFlow2.port, del1.heatPort) annotation (Line(points={{-40,
          2},{-20,2},{-20,-50},{-6,-50}}, color={191,0,0}));
  connect(realExpression1.y,min2. u1) annotation (Line(points={{57,92},{60,92},{
          60,92.8},{64.4,92.8}}, color={0,0,127}));
  connect(min2.y,P_el)  annotation (Line(points={{82.8,88},{90,88},{90,98},{108,
          98}}, color={0,0,127}));
  connect(realExpression3.y,min2. u2) annotation (Line(points={{57,76},{60,76},{
          60,83.2},{64.4,83.2}}, color={0,0,127}));
  connect(P_el,P_el)  annotation (Line(points={{108,98},{102,98},{102,98},{108,
          98}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,40},{0,80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,40},{100,80}},
          lineColor={28,108,200},
          fillColor={15,60,112},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,-80},{100,-40}},
          lineColor={28,108,200},
          fillColor={255,85,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-80},{0,-40}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={28,108,200},
          fillColor={255,85,85},
          fillPattern=FillPattern.None)}),                       Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heatPump_simple;
