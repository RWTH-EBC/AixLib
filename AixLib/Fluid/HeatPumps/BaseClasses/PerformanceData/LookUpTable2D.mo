within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTable2D "Performance data coming from manufacturer"
  extends BaseClasses.PartialPerformanceData;
  Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=tableQCon) if     not (capCalcType == 1)
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-40,20},
            {0,60}})));
  Modelica.Blocks.Tables.CombiTable2D P_eleTable(
    tableName="NoName",
    fileName="NoName",
    smoothness=smoothness,
    table=tablePel) if  not (capCalcType == 1) "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-40,-60},
            {0,-20}})));
  Modelica.Blocks.Math.Add sub(final k2=-1) "QEva = Pel - QCon"
    annotation (Placement(transformation(extent={{56,70},{76,90}})));
  parameter Real tableQCon[:,:] "Table data for QCon";
  parameter Real tablePel[:,:] "Data for Pel";
equation
  connect(P_eleTable.y, Pel) annotation (Line(points={{2,-40},{54,-40},{54,0},{
          110,0}}, color={0,0,127}));
  connect(Qdot_ConTable.y, QCon) annotation (Line(points={{2,40},{54,40},{54,
          -80},{110,-80}}, color={0,0,127}));
  connect(heatPumpControlBus.T_ret_co, Qdot_ConTable.u1) annotation (Line(
      points={{-106.925,0.07},{-76,0.07},{-76,52},{-44,52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_ret_co, P_eleTable.u1) annotation (Line(
      points={{-106.925,0.07},{-75.5,0.07},{-75.5,-28},{-44,-28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_flow_ev, Qdot_ConTable.u2) annotation (Line(
      points={{-106.925,0.07},{-75.5,0.07},{-75.5,28},{-44,28}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(heatPumpControlBus.T_flow_ev, P_eleTable.u2) annotation (Line(
      points={{-106.925,0.07},{-76,0.07},{-76,-52},{-44,-52}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sub.u2, Qdot_ConTable.y) annotation (Line(points={{54,74},{30,74},{30,
          40},{2,40}}, color={0,0,127}));
  connect(P_eleTable.y, sub.u1) annotation (Line(points={{2,-40},{30,-40},{30,
          84},{30,84},{30,86},{54,86},{54,86}}, color={0,0,127}));
  connect(sub.y, QEva)
    annotation (Line(points={{77,80},{110,80}}, color={0,0,127}));
end LookUpTable2D;
