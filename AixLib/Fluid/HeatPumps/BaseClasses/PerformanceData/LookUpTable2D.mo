within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTable2D "Performance data coming from manufacturer"
  extends BaseClasses.PartialPerformanceData;

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";
  parameter DataBase.HeatPump.HeatPumpBaseDataDefinition dataTable = AixLib.DataBase.HeatPump.EN255.Vitocal350AWI114()
    "Data Table of HP" annotation(choicesAllMatching = true);

  Modelica.Blocks.Tables.CombiTable2D Qdot_ConTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableQdot_con,
    final tableOnFile=false,
    u1(unit="degC"),
    u2(unit="degC"),
    y(unit="W",displayUnit="kW"),
    final smoothness=smoothness)
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={46,34})));
  Modelica.Blocks.Tables.CombiTable2D P_eleTable(
    tableName="NoName",
    fileName="NoName",
    table=dataTable.tableP_ele,
    final tableOnFile=false,
    u1(unit="degC"),
    u2(unit="degC"),
    y(unit="W",displayUnit="kW"),
    final smoothness=smoothness)
                    "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={-60,36})));

  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=270,
        origin={52,72})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-54,76})));
  Modelica.Blocks.Math.Product nTimesPel annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-47,-3})));
  Modelica.Blocks.Math.Product nTimesQCon annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={40,-10})));
  Modelica.Blocks.Math.Product proRedQEva
    "Based on the icing factor, the heat flow to the evaporator is reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-78,-62})));
  Modelica.Blocks.Math.Add calcRedQCon
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={82,-70})));

  Modelica.Blocks.Math.Product nTimesSF
    "Create the product of the scaling factor and relative compressor speed"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-11,23})));
protected
  Modelica.Blocks.Sources.Constant       realCorr(final k=scalingFactor)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-15,43})));
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
    "Calculates evaporator heat flow with total energy balance"                 annotation(Placement(transformation(extent={{-5,-5},
            {5,5}},
        rotation=270,
        origin={-81,-43})));
  /*
  parameter Real minSou = min(dataTable.tableP_ele[1,2:end]);
  parameter Real minSup = min(dataTable.tableP_ele[2:end,1]);
  parameter Real maxSou = max(dataTable.tableP_ele[1,2:end]);
  parameter Real maxSup = max(dataTable.tableP_ele[2:end,1]);
*/
equation
  /*
  assert(minSou+273.15 < sigBusHP.T_flow_ev, "Current T_flow_ev is too low. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(maxSou+273.15 > sigBusHP.T_flow_ev, "Current T_flow_ev is too high. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(minSup+273.15 < sigBusHP.T_ret_co, "Current T_ret_co is too low. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(maxSup+273.15 > sigBusHP.T_ret_co, "Current T_ret_co is too high. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  */
  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{52,65.4},{52,
          60},{37.6,60},{37.6,50.8}},      color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{52,65.4},{-68.4,
          65.4},{-68.4,52.8}},  color={0,0,127}));
  connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-54,69.4},{-54,
          52.8},{-51.6,52.8}},  color={0,0,127}));
  connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-54,69.4},{-54,
          60},{52,60},{52,50.8},{54.4,50.8}},
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
  connect(P_eleTable.y, nTimesPel.u2) annotation (Line(points={{-60,20.6},{-60,
          10},{-51.2,10},{-51.2,5.4}},
                                     color={0,0,127}));
  connect(Qdot_ConTable.y, nTimesQCon.u1) annotation (Line(points={{46,18.6},{
          46,-2.8},{43.6,-2.8}},        color={0,0,127}));
  connect(QCon, calcRedQCon.y)
    annotation (Line(points={{-80,-110},{-80,-92},{82,-92},{82,-76.6}},
                                                      color={0,0,127}));
  connect(proRedQEva.y, calcRedQCon.u1) annotation (Line(points={{-78,-68.6},{
          -78,-74},{-4,-74},{-4,-56},{85.6,-56},{85.6,-62.8}},            color=
         {0,0,127}));
  connect(proRedQEva.y, QEva)
    annotation (Line(points={{-78,-68.6},{-78,-88},{80,-88},{80,-110}},
                                                      color={0,0,127}));
  connect(feedbackHeatFlowEvaporator.y, proRedQEva.u2) annotation (Line(points={{-81,
          -47.5},{-81,-54},{-81.6,-54},{-81.6,-54.8}},           color={0,0,127}));
  connect(sigBusHP.iceFac, proRedQEva.u1) annotation (Line(
      points={{1.075,104.07},{14,104.07},{14,60},{6,60},{6,-52},{-64,-52},{-64,
          -54.8},{-74.4,-54.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nTimesQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points=
          {{40,-16.6},{40,-34},{-81,-34},{-81,-39}}, color={0,0,127}));
  connect(nTimesPel.y, feedbackHeatFlowEvaporator.u2) annotation (Line(points={
          {-47,-10.7},{-47,-18},{-90,-18},{-90,-43},{-85,-43}}, color={0,0,127}));
  connect(nTimesPel.y, calcRedQCon.u2) annotation (Line(points={{-47,-10.7},{
          -48,-10.7},{-48,-48},{78.4,-48},{78.4,-62.8}}, color={0,0,127}));
  connect(nTimesPel.y, Pel) annotation (Line(points={{-47,-10.7},{-47,-78},{0,
          -78},{0,-110},{0,-110}}, color={0,0,127}));
  connect(nTimesPel.u1, nTimesSF.y) annotation (Line(points={{-42.8,5.4},{-26,
          5.4},{-26,15.3},{-11,15.3}}, color={0,0,127}));
  connect(nTimesQCon.u2, nTimesSF.y) annotation (Line(points={{36.4,-2.8},{12,
          -2.8},{12,15.3},{-11,15.3}}, color={0,0,127}));
  connect(realCorr.y, nTimesSF.u2) annotation (Line(points={{-15,39.7},{-15,
          31.4},{-15.2,31.4}}, color={0,0,127}));
  connect(sigBusHP.N, nTimesSF.u1) annotation (Line(
      points={{1.075,104.07},{-2,104.07},{-2,31.4},{-6.8,31.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
