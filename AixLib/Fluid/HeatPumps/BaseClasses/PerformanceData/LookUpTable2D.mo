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
    "data Table of HP" annotation(choicesAllMatching = true);
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                    "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent={{52,70},
            {72,90}})));
equation
  connect(P_eleTable.y, Pel) annotation (Line(points={{2,-40},{30,-40},{30,0},{
          110,0}},
               color={0,0,127}));
  connect(Qdot_ConTable.y, QCon) annotation (Line(points={{2,40},{62,40},{62,
          -80},{110,-80}},
                      color={0,0,127}));
  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{-77.4,28},{-44,
          28}},                            color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{-77.4,28},{-58,28},
          {-58,-52},{-44,-52}}, color={0,0,127}));
  connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-77.4,-28},{-44,
          -28}},                color={0,0,127}));
  connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-77.4,-28},{
          -58,-28},{-58,52},{-44,52},{-44,52}},
                                  color={0,0,127}));
  connect(heatPumpControlBus.T_ret_co,t_Co_ou. u) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,-28},{-91.2,-28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{-106.925,0.07},{-106.925,28},{-106,28},{-106,28},{-91.2,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Qdot_ConTable.y, feedbackHeatFlowEvaporator.u2) annotation (Line(
        points={{2,40},{62,40},{62,70},{62,70},{62,72},{62,72}}, color={0,0,127}));
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{71,80},{110,80}}, color={0,0,127}));
  connect(feedbackHeatFlowEvaporator.u1, P_eleTable.y) annotation (Line(points=
          {{54,80},{30,80},{30,-40},{2,-40}}, color={0,0,127}));
end LookUpTable2D;
