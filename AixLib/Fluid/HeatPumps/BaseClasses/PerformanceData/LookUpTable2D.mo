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
        origin={44,34})));
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
        origin={-62,36})));

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
        origin={60,0})));
  Modelica.Blocks.Math.Product proRedQEva
    "Based on the icing factor, the heat flow to the evaporator is reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-80,-80})));
  Modelica.Blocks.Math.Add calcRedQCon
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={80,-88})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(final threshold=
        Modelica.Constants.eps) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-8,78})));

protected
  Modelica.Blocks.Sources.RealExpression realCorr(final y=scalingFactor*
        sigBusHP.N)
    "Calculates correction of table output based on compressor speed and scaling factor"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-14,34})));
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
    "Calculates evaporator heat flow with total energy balance"                 annotation(Placement(transformation(extent={{-5,-5},
            {5,5}},
        rotation=270,
        origin={-83,-63})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-56,-34})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={52,-34})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-8,-8},{8,8}},
        rotation=-90,
        origin={6,32})));
protected
  parameter Real minSou = min(dataTable.tableP_ele[1,2:end]);
  parameter Real minSup = min(dataTable.tableP_ele[2:end,1]);
  parameter Real maxSou = max(dataTable.tableP_ele[1,2:end]);
  parameter Real maxSup = max(dataTable.tableP_ele[2:end,1]);

equation
  assert(minSou+273.15 < sigBusHP.T_flow_ev, "Current T_flow_ev is too low. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(maxSou+273.15 > sigBusHP.T_flow_ev, "Current T_flow_ev is too high. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(minSup+273.15 < sigBusHP.T_ret_co, "Current T_ret_co is too low. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);
  assert(maxSup+273.15 > sigBusHP.T_ret_co, "Current T_ret_co is too high. Extrapolation of data will result in unrealistic results", level = AssertionLevel.warning);

  connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{52,65.4},{52,
          60},{35.6,60},{35.6,50.8}},      color={0,0,127}));
  connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{52,65.4},{-70.4,
          65.4},{-70.4,52.8}},  color={0,0,127}));
  connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-54,69.4},{-54,
          52.8},{-53.6,52.8}},  color={0,0,127}));
  connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-54,69.4},{-54,
          60},{52,60},{52,50.8},{52.4,50.8}},
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
  connect(switchPel.y, Pel) annotation (Line(points={{-56,-45},{-56,-52},{0,-52},
          {0,-110}},                     color={0,0,127}));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{6,23.2},{6,-16},
          {44,-16},{44,-22}},     color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{6,23.2},{6,-16},{
          -64,-16},{-64,-22}},
        color={0,0,127}));
  connect(P_eleTable.y, nTimesPel.u2) annotation (Line(points={{-62,20.6},{-62,
          10},{-51.2,10},{-51.2,5.4}},
                                     color={0,0,127}));
  connect(nTimesPel.y, switchPel.u1) annotation (Line(points={{-47,-10.7},{-47,
          -20.35},{-48,-20.35},{-48,-22}}, color={0,0,127}));
  connect(Qdot_ConTable.y, nTimesQCon.u1) annotation (Line(points={{44,18.6},{
          64,18.6},{64,7.2},{63.6,7.2}},color={0,0,127}));
  connect(switchQCon.u1, nTimesQCon.y)
    annotation (Line(points={{60,-22},{60,-6.6}},  color={0,0,127}));
  connect(switchPel.y, calcRedQCon.u2) annotation (Line(points={{-56,-45},{-56,
          -52},{0,-52},{0,-80.8},{76.4,-80.8}},
                                           color={0,0,127}));
  connect(QCon, calcRedQCon.y)
    annotation (Line(points={{-80,-110},{-80,-102},{80,-102},{80,-94.6}},
                                                      color={0,0,127}));
  connect(proRedQEva.y, calcRedQCon.u1) annotation (Line(points={{-80,-86.6},{
          -80,-92},{-6,-92},{-6,-74},{83.6,-74},{83.6,-80.8}},            color=
         {0,0,127}));
  connect(sigBusHP.N, greaterThreshold.u) annotation (Line(
      points={{1.075,104.07},{-8,104.07},{-8,85.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(greaterThreshold.y, switchPel.u2) annotation (Line(points={{-8,71.4},{
          -8,48},{-20,48},{-20,-12},{-56,-12},{-56,-22}},  color={255,0,255}));
  connect(greaterThreshold.y, switchQCon.u2) annotation (Line(points={{-8,71.4},
          {-8,48},{-20,48},{-20,-12},{52,-12},{52,-22}}, color={255,0,255}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u1)
    annotation (Line(points={{52,-45},{52,-52},{-83,-52},{-83,-59}},
                                                          color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u2)
    annotation (Line(points={{-56,-45},{-56,-52},{-92,-52},{-92,-63},{-87,-63}},
                                                            color={0,0,127}));
  connect(realCorr.y, nTimesPel.u1) annotation (Line(points={{-14,23},{-14,12},{
          -42.8,12},{-42.8,5.4}}, color={0,0,127}));
  connect(realCorr.y, nTimesQCon.u2) annotation (Line(points={{-14,23},{-14,12},
          {56.4,12},{56.4,7.2}}, color={0,0,127}));
  connect(proRedQEva.y, QEva)
    annotation (Line(points={{-80,-86.6},{-80,-98},{-80,-110},{80,-110}},
                                                      color={0,0,127}));
  connect(feedbackHeatFlowEvaporator.y, proRedQEva.u2) annotation (Line(points=
          {{-83,-67.5},{-83,-69.7},{-83.6,-69.7},{-83.6,-72.8}}, color={0,0,127}));
  connect(sigBusHP.N, proRedQEva.u1) annotation (Line(
      points={{1.075,104.07},{1.075,46},{-30,46},{-30,-70},{-76.4,-70},{-76.4,
          -72.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
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
