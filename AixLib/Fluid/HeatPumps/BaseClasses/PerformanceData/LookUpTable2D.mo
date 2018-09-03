within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTable2D "Performance data coming from manufacturer"
  extends BaseClasses.PartialPerformanceData;
  Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableQdot_con,
    final tableOnFile=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    u1(unit="degC"),
    u2(unit="degC"),
    y(unit="W",displayUnit="kW"))
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-20,-20},
            {20,20}},
        rotation=-90,
        origin={50,16})));
  Modelica.Blocks.Tables.CombiTable2D P_eleTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableP_ele,
    final tableOnFile=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    u1(unit="degC"),
    u2(unit="degC"),
    y(unit="W",displayUnit="kW"))
                    "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-20,-20},
            {20,20}},
        rotation=-90,
        origin={-56,18})));

  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=270,
        origin={52,72})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-54,76})));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable= AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114()
    "Data Table of HP" annotation(choicesAllMatching = true);

protected
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
    "Calculates evaporator heat flow with total energy balance"                 annotation(Placement(transformation(extent={{-10,-10},
            {10,10}},
        rotation=270,
        origin={80,-78})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-56,-52})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={52,-50})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={2,-10})));
public
  parameter Modelica.SIunits.Power k=0 "Constant output value";
equation
  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{52,65.4},{52,70},
          {46,70},{46,40},{38,40}},        color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{52,65.4},{-68,65.4},
          {-68,42}},            color={0,0,127}));
  connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-54,69.4},{-54,60},
          {-44,60},{-44,42}},   color={0,0,127}));
  connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-54,69.4},{-54,
          60},{70,60},{70,40},{62,40}},
                                  color={0,0,127}));
  connect(sigBusHP.T_ret_co, t_Co_ou.u) annotation (Line(
      points={{1.075,104.07},{-54,104.07},{-54,83.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{1.075,104.07},{2,104.07},{2,104},{52,104},{52,79.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{80,-87},{80,-110}},
                                                color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{-56,-63},{-56,-63},{-56,-80},
          {0,-80},{0,-110}},             color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{-56,-63},
          {-56,-64},{-56,-64},{-56,-64},{-56,-70},{80,-70}},    color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u2)
    annotation (Line(points={{52,-61},{52,-78},{72,-78}},
                                                       color={0,0,127}));
  connect(switchQCon.y, QCon) annotation (Line(points={{52,-61},{52,-84},{-80,-84},
          {-80,-108},{-80,-108},{-80,-110},{-80,-110}}, color={0,0,127}));
  connect(P_eleTable.y, switchPel.u1)
    annotation (Line(points={{-56,-4},{-56,-4},{-56,-16},{-56,-16},{-56,-16},{-48,
          -16},{-48,-40},{-48,-40}},            color={0,0,127}));
  connect(Qdot_ConTable.y, switchQCon.u1)
    annotation (Line(points={{50,-6},{60,-6},{60,-38}},
                                              color={0,0,127}));
  connect(sigBusHP.onOff, switchQCon.u2) annotation (Line(
      points={{1.075,104.07},{22,104.07},{22,-28},{52,-28},{52,-38},{52,-38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchPel.u2) annotation (Line(
      points={{1.075,104.07},{-16,104.07},{-16,-28},{-56,-28},{-56,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{2,-18.8},{2,-18.8},
          {2,-24},{44,-24},{44,-38}},
                                  color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{2,-18.8},{2,-24},
          {-64,-24},{-64,-40}},
        color={0,0,127}));
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
end LookUpTable2D;
