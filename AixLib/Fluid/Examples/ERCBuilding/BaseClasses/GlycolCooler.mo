within AixLib.Fluid.Examples.ERCBuilding.BaseClasses;
model GlycolCooler

  replaceable package Medium_Water = AixLib.Media.Water
    "Medium 1 in the component";
  replaceable package Medium_Air = AixLib.Media.Air
    "Medium 2 in the component";
  parameter Modelica.SIunits.Efficiency eps(max=1) = 0.8
    "Heat exchanger effectiveness";
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  AixLib.Fluid.HeatExchangers.ConstantEffectiveness GlycolCooler(
    redeclare package Medium1 = Medium_Water,
    redeclare package Medium2 = Medium_Air,
    m1_flow_nominal=15,
    m2_flow_nominal=10,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=eps,
    allowFlowReversal1=false,
    allowFlowReversal2=false,
    show_T=true)
             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,0})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Air_Out(redeclare package
      Medium = Medium_Air) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={-30,-12})));
  AixLib.Obsolete.Fluid.Sources.FixedBoundary bound_Air_Out(redeclare package
      Medium = Medium_Air, nPorts=1)
    annotation (Placement(transformation(extent={{-60,-20},{-44,-4}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Air_In(redeclare package
      Medium = Medium_Air) annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=180,
        origin={28,-12})));
  AixLib.Fluid.Sources.MassFlowSource_T pump_Air_In(
    redeclare package Medium = Medium_Air,
    use_T_in=true,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{58,-20},{42,-4}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        Medium_Water)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        Medium_Water)
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput Temp_Outdoor
    annotation (Placement(transformation(extent={{121,52},{79,94}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort Temp_Water_Out(redeclare package
      Medium = Medium_Water) annotation (Placement(transformation(
        extent={{8,8},{-8,-8}},
        rotation=180,
        origin={30,12})));
  Modelica.Blocks.Interfaces.RealInput m_flow_in
    "Prescribed mass flow rate"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,-70})));
  Modelica.Blocks.Interfaces.RealOutput temperature_out
    "Temperature of the passing fluid" annotation (Placement(transformation(
        extent={{-19,-19},{19,19}},
        rotation=270,
        origin={31,-107})));
equation

  connect(Temp_Air_Out.port_b,bound_Air_Out. ports[1]) annotation (Line(points={{-38,-12},
          {-38,-12},{-44,-12}},               color={0,127,255}));
  connect(Temp_Air_Out.port_a, GlycolCooler.port_b2) annotation (Line(points={{-22,-12},
          {-14,-12},{-14,-6},{-10,-6}},    color={0,127,255}));
  connect(GlycolCooler.port_a2, Temp_Air_In.port_b) annotation (Line(points={{10,-6},
          {14,-6},{14,-12},{20,-12}},   color={0,127,255}));
  connect(Temp_Air_In.port_a, pump_Air_In.ports[1])
    annotation (Line(points={{36,-12},{42,-12}},       color={0,127,255}));
  connect(port_a, GlycolCooler.port_a1) annotation (Line(points={{-100,0},{
          -80,0},{-80,6},{-10,6}},
                              color={0,127,255}));
  connect(Temp_Water_Out.port_a, GlycolCooler.port_b1) annotation (Line(
        points={{22,12},{14,12},{14,6},{10,6}}, color={0,127,255}));
  connect(Temp_Water_Out.port_b, port_b) annotation (Line(points={{38,12},{40,
          12},{40,6},{80,6},{80,0},{100,0}}, color={0,127,255}));
  connect(Temp_Outdoor, pump_Air_In.T_in) annotation (Line(points={{100,73},{70,
          73},{70,-8.8},{59.6,-8.8}},    color={0,0,127}));
  connect(pump_Air_In.m_flow_in, m_flow_in) annotation (Line(points={{58,-5.6},
          {76,-5.6},{76,-70},{100,-70}}, color={0,0,127}));
  connect(Temp_Water_Out.T, temperature_out) annotation (Line(points={{30,20.8},
          {30,32},{-16,32},{-16,-38},{31,-38},{31,-107}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),  Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={Bitmap(extent={{-100,-100},
              {100,100}}, fileName=
              "N:/Forschung/EBC0155_PtJ_Exergiebasierte_regelung_rsa/Students/Students-Exchange/Photos Dymola/GC.jpg"),
                                 Text(
          extent={{-141,157},{159,117}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}));
end GlycolCooler;
