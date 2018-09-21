within AixLib.Systems.AirHandlingUnit.BaseClasses;
model AHU_Systemchoice

  replaceable model Systemchoice = HydraulicModules.Injection2WayValve
                                                          constrainedby
    AixLib.Systems.HydraulicModules.BaseClasses.PartialHydraulicModule annotation (choicesAllMatching=true);

  Systemchoice System annotation (Placement(transformation(extent={{-38,-38},{38,38}},
        rotation=90,
        origin={0,-34})),                                                                choicesAllMatching=true);
  Fluid.HeatExchangers.BasicHX.BasicHXnew basicHXnew
    annotation (Dialog(enable = true),Placement(transformation(extent={{-24,54},{24,100}})));
  HydraulicModules.BaseClasses.HydraulicBus hydraulicBus1
    annotation (Placement(transformation(extent={{-76,-40},{-50,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                     redeclare final package Medium = Medium1,
                     m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-44,-110},{-24,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a3(
                     redeclare final package Medium = Medium1,
                     m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{-72,74},{-52,94}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                     redeclare final package Medium = Medium1,
                     m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{74,78},{54,98}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b3(
                     redeclare final package Medium = Medium1,
                     m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default, nominal = Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{28,-110},{8,-90}})));
equation
  connect(Systemchoice.port_b1, basicHXnew.port_b2) annotation (Line(points={{-22.8,4},{-22.8,
          6},{-24,6},{-24,64.4},{-24,64.4},{-24,63.2}}, color={0,127,255}));
  connect(basicHXnew.port_a2, Systemchoice.port_a2) annotation (Line(points={{24,63.2},{24,
          4},{20,4},{22,4},{22,4},{22.8,4}}, color={0,127,255}));
  connect(System.hydraulicBus, hydraulicBus1) annotation (Line(
      points={{-38,-34},{-56,-34},{-56,-30},{-63,-30},{-63,-25}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(System.port_a1, port_a1) annotation (Line(points={{-22.8,-72},{-28,
          -72},{-28,-100},{-34,-100}}, color={0,127,255}));
  connect(port_a3, basicHXnew.port_a1) annotation (Line(points={{-62,84},{-48,
          84},{-48,90.8},{-24,90.8}}, color={0,127,255}));
  connect(basicHXnew.port_b1, port_b1) annotation (Line(points={{24,90.8},{44,
          90.8},{44,88},{64,88}}, color={0,127,255}));
  connect(port_b3, System.port_b2) annotation (Line(points={{18,-100},{22,-100},
          {22,-72},{22.8,-72}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(extent={{-60,-100},{60,100}})),Icon(
        coordinateSystem(extent={{-60,-100},{60,100}})));
end AHU_Systemchoice;
