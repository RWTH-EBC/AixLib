within AixLib.Fluid.HeatPumps;
model HeatPumpReal
  "Model containing the basic heat pump block and different control blocks(optional)"

  HeatPump heatPump
    annotation (Placement(transformation(extent={{84,-38},{160,38}})));
  BaseClasses.SecurityControls.SecurityControl securityControl(
    minRunTime(displayUnit="min") = 300,
    minLocTime(displayUnit="min"),
    useMinLocTim=false,
    useMinRunTim=true,
    useRunPerHour=true,
    useOpeEnv=true) if      useSecurity
    annotation (Placement(transformation(extent={{-12,-28},{52,28}})));
  BaseClasses.HeatPumpControlls.DefrostControl defrostControl if useDefrost
    annotation (Placement(transformation(extent={{-106,-26},{-46,26}})));
  BaseClasses.HeatPumpControlls.HPControl hPControls
    annotation (Placement(transformation(extent={{-182,-24},{-130,24}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a1(
                     redeclare final package Medium = Medium1,
                     m_flow(min=if allowFlowReversal1 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default))
    "Fluid connector a1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{74,90},{94,110}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b1(
                     redeclare final package Medium = Medium1,
                     m_flow(max=if allowFlowReversal1 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium1.h_default))
    "Fluid connector b1 (positive design flow direction is from port_a1 to port_b1)"
    annotation (Placement(transformation(extent={{170,90},{150,110}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a2(
                     redeclare final package Medium = Medium2,
                     m_flow(min=if allowFlowReversal2 then -Modelica.Constants.inf else 0),
                     h_outflow(start = Medium2.h_default))
    "Fluid connector a2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{148,-110},{168,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b2(
                     redeclare final package Medium = Medium2,
                     m_flow(max=if allowFlowReversal2 then +Modelica.Constants.inf else 0),
                     h_outflow(start = Medium2.h_default))
    "Fluid connector b2 (positive design flow direction is from port_a2 to port_b2)"
    annotation (Placement(transformation(extent={{94,-110},{74,-90}})));
  constant Boolean useDefrost annotation (choices(checkBox=true));
  constant Boolean useSecurity annotation (choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput T_amb "Ambient temperature"
    annotation (Placement(transformation(extent={{-240,20},{-200,60}})));
equation
  connect(securityControl.nOut, heatPump.nSet) annotation (Line(points={{54.6667,
          3.55271e-015},{68,3.55271e-015},{68,0},{79.44,0}},
                                                   color={0,0,127}));
  connect(heatPump.sigBusHP, securityControl.heatPumpControlBus) annotation (
      Line(
      points={{80.58,-10.26},{76,-10.26},{76,-48},{-26.675,-48},{-26.675,-19.32},
          {-16,-19.32}},
      color={255,204,51},
      thickness=0.5));
  connect(heatPump.sigBusHP, hPControl.heaPumControlBus) annotation (Line(
      points={{80.58,-10.26},{76,-10.26},{76,-48},{-192,-48},{-192,-14},{-192,
          -14},{-192,-13.44},{-183.04,-13.44}},
      color={255,204,51},
      thickness=0.5));
  connect(defrostControl.heaPumControlBus, heatPump.sigBusHP) annotation (Line(
      points={{-108.4,-21.32},{-108.4,-48},{76,-48},{76,-10.26},{80.58,-10.26}},
      color={255,204,51},
      thickness=0.5));
  connect(defrostControl.nOut, securityControl.nSet) annotation (Line(points={{-42.4,0},
          {-39.57,0},{-39.57,3.55271e-015},{-16.2667,3.55271e-015}},
                                                               color={0,0,127}));
  connect(heatPump.port_b2, port_b2)
    annotation (Line(points={{84,-22.8},{84,-100}}, color={0,127,255}));
  connect(heatPump.port_a1, port_a1)
    annotation (Line(points={{84,22.8},{84,100}}, color={0,127,255}));
  connect(heatPump.port_b1, port_b1) annotation (Line(points={{160,22.8},{160,
          100}},      color={0,127,255}));
  connect(heatPump.port_a2, port_a2)
    annotation (Line(points={{160,-22.8},{160,-100},{158,-100}},
                                                      color={0,127,255}));
  connect(hPControls.nOut, defrostControl.nSet) annotation (Line(points={{
          -126.36,4.44089e-016},{-121.18,4.44089e-016},{-121.18,0},{-112,0}},
        color={0,0,127}));
  connect(T_amb, hPControls.T_amb) annotation (Line(points={{-220,40},{-206,40},
          {-206,4.8},{-187.72,4.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
            {200,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics={
        Text(
          extent={{-180,42},{-132,28}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="3. Layer"),
        Text(
          extent={{-100,48},{-52,34}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="2. Layer"),
        Text(
          extent={{-4,48},{44,34}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="1. Layer"),
        Line(
          points={{-32,100},{-32,-100}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{58,96},{58,-104}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash),
        Line(
          points={{-122,100},{-122,-100}},
          color={238,46,47},
          thickness=0.5,
          pattern=LinePattern.Dash)}));
end HeatPumpReal;
