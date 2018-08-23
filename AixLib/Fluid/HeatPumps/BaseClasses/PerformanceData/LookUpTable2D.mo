within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTable2D "Performance data coming from manufacturer"
  extends BaseClasses.PartialPerformanceData;
  Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableQdot_con,
    final tableOnFile=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-40,20},
            {0,60}})));
  Modelica.Blocks.Tables.CombiTable2D P_eleTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableP_ele,
    final tableOnFile=false,
    final smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
                    "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-40,-60},
            {0,-20}})));

  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-90,22},
            {-78,34}})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-90,-34},{-78,-22}})));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable= AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114()
    "Data Table of HP" annotation(choicesAllMatching = true);
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                    "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent={{52,70},
            {72,90}})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{16,-58},{36,-38}})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{16,22},{36,42}})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-24,2},{-14,12}})));
equation
  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{-77.4,28},{-44,
          28}},                            color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{-77.4,28},{-58,28},
          {-58,-52},{-44,-52}}, color={0,0,127}));
  connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-77.4,-28},{-44,
          -28}},                color={0,0,127}));
  connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-77.4,-28},{
          -58,-28},{-58,52},{-44,52},{-44,52}},
                                  color={0,0,127}));
  connect(sigBusHP.T_ret_co, t_Co_ou.u) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,-28},{-91.2,-28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{-106.925,0.07},{-106.925,28},{-106,28},{-106,28},{-91.2,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{71,80},{110,80}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{37,-48},{44,-48},{44,0},{
          50,0},{50,0},{110,0},{110,0}}, color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={
          {37,-48},{38,-48},{38,-48},{44,-48},{44,80},{54,80}}, color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u2)
    annotation (Line(points={{37,32},{62,32},{62,72}}, color={0,0,127}));
  connect(switchQCon.y, QCon) annotation (Line(points={{37,32},{62,32},{62,-80},
          {110,-80}}, color={0,0,127}));
  connect(P_eleTable.y, switchPel.u1)
    annotation (Line(points={{2,-40},{14,-40}}, color={0,0,127}));
  connect(Qdot_ConTable.y, switchQCon.u1)
    annotation (Line(points={{2,40},{14,40}}, color={0,0,127}));
  connect(sigBusHP.onOff, switchQCon.u2) annotation (Line(
      points={{-106.925,0.07},{7.5,0.07},{7.5,32},{14,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchPel.u2) annotation (Line(
      points={{-106.925,0.07},{7.5,0.07},{7.5,-48},{14,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-13.5,7},{-0.75,
          7},{-0.75,24},{14,24}}, color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{-13.5,7},{-13.5,
          8},{-14,8},{8,8},{8,8},{8,-56},{10,-56},{10,-56},{14,-56},{14,-56}},
        color={0,0,127}));
end LookUpTable2D;
