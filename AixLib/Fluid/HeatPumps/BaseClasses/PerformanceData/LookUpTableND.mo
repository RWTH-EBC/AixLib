within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTableND "N-dimensional table with data for heat pump"
  extends BaseClasses.PartialPerformanceData;




  Modelica.Blocks.Math.Gain nConGain(final k=nConv)
    "Convert relative speed n to an absolute value for interpolation in sdf tables"
    annotation (Placement(transformation(
        extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={0,68})));
 Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=-90,
        origin={60,40})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-40,40})));
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                    "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=-90,
        origin={80,-80})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,-60})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-50,-56})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-4,-18})));
  SDF.NDTable nDTableQCon(nin=3)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={-42,-10})));
  SDF.NDTable nDTablePel(nin=3)
    annotation (Placement(transformation(extent={{-12,-12},{12,12}},
        rotation=-90,
        origin={58,-8})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1(
    final n1=1,
    final n2=1,
    final n3=1) "Concat all inputs into an array"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={0,20})));
  parameter Real nConv=1
    "Gain value multiplied with relative compressor speed n to calculate matching value based on sdf tables";
equation
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{80,-89},{80,-110}},
                                                color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{50,-71},{50,-76},{0,-76},
          {0,-110}},
               color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{50,-71},
          {66,-71},{66,-72},{80,-72}},       color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u2)
    annotation (Line(points={{-50,-67},{-50,-80},{72,-80}},
                                                       color={0,0,127}));
  connect(switchQCon.y, QCon) annotation (Line(points={{-50,-67},{-50,-67},{-50,
          -80},{-80,-80},{-80,-82},{-80,-82},{-80,-110},{-80,-110}},
                      color={0,0,127}));

  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-4,-24.6},{-4,
          -24},{-4,-24},{-4,-28},{-4,-30},{-58,-30},{-58,-42},{-58,-42},{-58,
          -44},{-58,-44}},     color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{-4,-24.6},{-4,
          -30},{42,-30},{42,-48}},
                          color={0,0,127}));
  connect(nDTableQCon.y, switchQCon.u1)
    annotation (Line(points={{-42,-23.2},{-42,-44}},
                                                color={0,0,127}));
  connect(nDTablePel.y, switchPel.u1)
    annotation (Line(points={{58,-21.2},{58,-48}},color={0,0,127}));
  connect(t_Ev_in.y,multiplex3_1. u1[1]) annotation (Line(points={{60,33.4},{8,
          33.4},{8,29.6},{5.6,29.6}}, color={0,0,127}));
  connect(t_Co_ou.y,multiplex3_1. u3[1]) annotation (Line(points={{-40,33.4},{
          -5.6,33.4},{-5.6,29.6}},       color={0,0,127}));
  connect(multiplex3_1.y, nDTableQCon.u) annotation (Line(points={{-1.55431e-15,
          11.2},{-1.55431e-15,4.4},{-42,4.4}},
                                          color={0,0,127}));
  connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-1.77636e-15,
          11.2},{-1.77636e-15,6.4},{58,6.4}},color={0,0,127}));
  connect(nConGain.y, multiplex3_1.u2[1]) annotation (Line(
      points={{-1.77636e-15,59.2},{-1.77636e-15,60},{0,60},{0,42},{1.77636e-15,
          42},{1.77636e-15,29.6}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sigBusHP.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{1.075,104.07},{60,104.07},{60,54},{60,48},{60,48},{60,47.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.N, nConGain.u) annotation (Line(
      points={{1.075,104.07},{1.77636e-15,104.07},{1.77636e-15,77.6}},
      color={255,204,51},
      thickness=0.5,
      pattern=LinePattern.Dash), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.T_ret_co, t_Co_ou.u) annotation (Line(
      points={{1.075,104.07},{-40,104.07},{-40,47.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchPel.u2) annotation (Line(
      points={{1.075,104.07},{-78,104.07},{-78,-34},{50,-34},{50,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchQCon.u2) annotation (Line(
      points={{1.075,104.07},{-78,104.07},{-78,-34},{-50,-34},{-50,-44}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Icon(graphics={
    Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
    Line(points={{0.0,40.0},{0.0,-40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,20.0},{-30.0,40.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,0.0},{-30.0,20.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-20.0},{-30.0,0.0}}),
    Rectangle(fillColor={255,215,136},
      fillPattern=FillPattern.Solid,
      extent={{-60.0,-40.0},{-30.0,-20.0}})}));
end LookUpTableND;
