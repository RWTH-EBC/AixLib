within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTableND "n-dimensional table with data for heat pump"
  extends BaseClasses.PartialPerformanceData;
  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-96,48},
            {-84,60}})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-96,-60},{-84,-48}})));
  Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                    "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent={{74,70},
            {94,90}})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{38,-58},{58,-38}})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{38,22},{58,42}})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{0,-6},{12,6}})));
  SDF.NDTable nDTableQCon
    annotation (Placement(transformation(extent={{-12,28},{12,52}})));
  SDF.NDTable nDTablePel
    annotation (Placement(transformation(extent={{-12,-52},{12,-28}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1(
    final n1=1,
    final n2=1,
    final n3=1) "Concat all inputs into an array"
    annotation (Placement(transformation(extent={{-38,-8},{-22,8}})));
  parameter Boolean use_nConv
    "True if you need to convert the n-signal before the table data" annotation(choices(checkBox=true));
  replaceable model nConv =
      AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.BaseClasses.NConverter
      constrainedby Modelica.Blocks.Interfaces.SISO annotation(Dialog(enable=use_nConv),choicesAllMatching=true);
  nConv nConverter if use_nConv
    annotation (Placement(transformation(extent={{-76,10},{-66,20}})));
  Modelica.Blocks.Routing.RealPassThrough realPasThrNCon if not use_nConv
    "If nConverter is not used"
    annotation (Placement(transformation(extent={{-78,-22},{-62,-6}})));

equation
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{93,80},{110,80}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{59,-48},{66,-48},{66,0},{110,
          0}}, color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{
          59,-48},{66,-48},{66,80},{76,80}}, color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u2)
    annotation (Line(points={{59,32},{84,32},{84,72}}, color={0,0,127}));
  connect(switchQCon.y, QCon) annotation (Line(points={{59,32},{84,32},{84,-80},
          {110,-80}}, color={0,0,127}));

  connect(constZero.y, switchQCon.u3) annotation (Line(points={{12.6,0},{21.25,0},
          {21.25,24},{36,24}}, color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{12.6,0},{22,0},{22,
          -56},{36,-56}}, color={0,0,127}));
  connect(nDTableQCon.y, switchQCon.u1)
    annotation (Line(points={{13.2,40},{36,40}},color={0,0,127}));
  connect(nDTablePel.y, switchPel.u1)
    annotation (Line(points={{13.2,-40},{36,-40}},color={0,0,127}));
  connect(t_Ev_in.y,multiplex3_1. u1[1]) annotation (Line(points={{-83.4,54},{-44,
          54},{-44,5.6},{-39.6,5.6}}, color={0,0,127}));
  connect(t_Co_ou.y,multiplex3_1. u3[1]) annotation (Line(points={{-83.4,-54},{-44,
          -54},{-44,-5.6},{-39.6,-5.6}}, color={0,0,127}));
  connect(multiplex3_1.y, nDTableQCon.u) annotation (Line(points={{-21.2,0},{-20,
          0},{-20,40},{-14.4,40}},        color={0,0,127}));
  connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-21.2,0},{-20,
          0},{-20,-40},{-14.4,-40}},         color={0,0,127}));
  connect(nConverter.y,multiplex3_1. u2[1])
    annotation (Line(points={{-65.5,15},{-50,15},{-50,0},{-39.6,0}},
                                                   color={0,0,127}));
  connect(realPasThrNCon.y, multiplex3_1.u2[1]) annotation (Line(points={{-61.2,
          -14},{-50,-14},{-50,0},{-39.6,0}}, color={0,0,127}));
  connect(sigBusHP.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,54},{-97.2,54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.N, nConverter.u) annotation (Line(
      points={{-106.925,0.07},{-92.5,0.07},{-92.5,15},{-77,15}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.N, realPasThrNCon.u) annotation (Line(
      points={{-106.925,0.07},{-92,0.07},{-92,-14},{-79.6,-14}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.T_ret_co, t_Co_ou.u) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,-54},{-97.2,-54}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchPel.u2) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,-80},{36,-80},{36,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.onOff, switchQCon.u2) annotation (Line(
      points={{-106.925,0.07},{-106,0.07},{-106,72},{28,72},{28,32},{36,32}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
end LookUpTableND;
