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
  Modelica.Blocks.Math.Add sub(final k2=-1) "QEva = Pel - QCon"
    annotation (Placement(transformation(extent={{56,70},{76,90}})));

  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-80,32},
            {-68,44}})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_in annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-90,-36},{-78,-24}})));
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable= AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114()
    "data Table of HP" annotation(choicesAllMatching = true);
equation
  connect(P_eleTable.y, Pel) annotation (Line(points={{2,-40},{54,-40},{54,0},{110,
          0}}, color={0,0,127}));
  connect(Qdot_ConTable.y, QCon) annotation (Line(points={{2,40},{54,40},{54,-80},
          {110,-80}}, color={0,0,127}));
  connect(sub.u2, Qdot_ConTable.y) annotation (Line(points={{54,74},{30,74},{30,
          40},{2,40}}, color={0,0,127}));
  connect(P_eleTable.y, sub.u1) annotation (Line(points={{2,-40},{30,-40},{30,84},
          {30,84},{30,86},{54,86},{54,86}}, color={0,0,127}));
  connect(sub.y, QEva)
    annotation (Line(points={{77,80},{110,80}}, color={0,0,127}));
  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{-67.4,38},{-52,
          38},{-52,18},{-44,18},{-44,28}}, color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{-67.4,38},{-58,38},
          {-58,-52},{-44,-52}}, color={0,0,127}));
  connect(t_Co_in.y, P_eleTable.u1) annotation (Line(points={{-77.4,-30},{-62,-30},
          {-62,-28},{-44,-28}}, color={0,0,127}));
  connect(t_Co_in.y, Qdot_ConTable.u1) annotation (Line(points={{-77.4,-30},{-77.4,
          13},{-44,13},{-44,52}}, color={0,0,127}));
  connect(heatPumpControlBus.T_ret_co, t_Co_in.u) annotation (Line(
      points={{-106.925,0.07},{-91.2,0.07},{-91.2,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{-106.925,0.07},{-106.925,18},{-81.2,18},{-81.2,38}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
end LookUpTable2D;
