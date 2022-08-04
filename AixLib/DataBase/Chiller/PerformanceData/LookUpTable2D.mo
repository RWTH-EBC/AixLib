within AixLib.DataBase.Chiller.PerformanceData;
model LookUpTable2D "Performance data coming from manufacturer"
  extends
    AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;

  parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
    "Smoothness of table interpolation";
  parameter AixLib.DataBase.Chiller.ChillerBaseDataDefinition dataTable = AixLib.DataBase.Chiller.EN14511.Vitocal200AWO201()
    "Data Table of Chiller" annotation(choicesAllMatching = true);
  parameter Boolean extrapolation=true "False to hold last value";
  parameter Boolean printAsserts=false
    "WARNING: This will lead to a lot of state-events if extrapolation occurs frequently! If extrapolation is enabled, the user will get warnings when extrapolation occurs."
    annotation (Dialog(enable=extrapolation));

  Utilities.Tables.CombiTable2DExtra  Qdot_EvaTable(
    final smoothness=smoothness,
    final u1(unit="degC"),
    final u2(unit="degC"),
    final y(unit="W", displayUnit="kW"),
    final extrapolation=extrapolation,
    final table=dataTable.tableQdot_eva)
    annotation (extent=[-60,40; -40,60], Placement(transformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={46,34})));
  Utilities.Tables.CombiTable2DExtra  P_eleTable(
    final smoothness=smoothness,
    extrapolation=extrapolation,
    final u1(unit="degC"),
    final u2(unit="degC"),
    final y(unit="W", displayUnit="kW"),
    final table=dataTable.tableP_ele)
                    "Electrical power table"
    annotation (extent=[-60,-20; -40,0], Placement(transformation(extent={{-14,-14},
            {14,14}},
        rotation=-90,
        origin={-60,36})));

  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
            {6,6}},
        rotation=270,
        origin={52,72})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-54,76})));
  Modelica.Blocks.Math.Product nTimesPel annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-41,-11})));
  Modelica.Blocks.Math.Product nTimesQEva annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={40,-10})));
  Modelica.Blocks.Math.Product proRedQEva
    "Based on the icing factor, the heat flow to the evaporator is reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={68,-62})));
  Modelica.Blocks.Math.Add calcRedQCon
    "Based on redcued heat flow to the evaporator, the heat flow to the condenser is also reduced"
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=270,
        origin={-80,-80})));

  Modelica.Blocks.Math.Product nTimesSF
    "Create the product of the scaling factor and relative compressor speed"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-9,23})));

protected
  parameter Real minSou = min(dataTable.tableP_ele[1,2:end]);
  parameter Real minSup = min(dataTable.tableP_ele[2:end,1]);
  parameter Real maxSou = max(dataTable.tableP_ele[1,2:end]);
  parameter Real maxSup = max(dataTable.tableP_ele[2:end,1]);
  Modelica.Blocks.Sources.Constant realCorr(final k=scalingFactor)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-13,43})));

equation
  if printAsserts then
    assert(
        minSou + 273.15 <sigBus.TConInMea,
        "Current T_flow_co is too low. Extrapolation of data will result in unrealistic results",
        level=AssertionLevel.warning);
    assert(
        maxSou + 273.15 >sigBus.TConInMea,
        "Current T_flow_co is too high. Extrapolation of data will result in unrealistic results",
        level=AssertionLevel.warning);
    assert(
      minSup + 273.15 < sigBus.TEvaOutMea,
      "Current T_ret_ev is too low. Extrapolation of data will result in unrealistic results",
      level=AssertionLevel.warning);
    assert(
      maxSup + 273.15 > sigBus.TEvaOutMea,
      "Current T_ret_ev is too high. Extrapolation of data will result in unrealistic results",
      level=AssertionLevel.warning);
  else
  end if;
  connect(t_Co_in.y,Qdot_EvaTable. u2) annotation (Line(points={{52,65.4},{52,
          60},{37.6,60},{37.6,50.8}},      color={0,0,127}));
  connect(t_Co_in.y, P_eleTable.u2) annotation (Line(points={{52,65.4},{-68.4,
          65.4},{-68.4,52.8}},  color={0,0,127}));
  connect(t_Ev_ou.y, P_eleTable.u1) annotation (Line(points={{-54,69.4},{-54,
          52.8},{-51.6,52.8}},  color={0,0,127}));
  connect(t_Ev_ou.y,Qdot_EvaTable. u1) annotation (Line(points={{-54,69.4},{-54,
          60},{52,60},{52,50.8},{54.4,50.8}},
                                  color={0,0,127}));
  connect(sigBus.TEvaOutMea, t_Ev_ou.u) annotation (Line(
      points={{1.075,104.07},{-54,104.07},{-54,83.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBus.TConInMea,t_Co_in. u) annotation (Line(
      points={{1.075,104.07},{2,104.07},{2,104},{52,104},{52,79.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(P_eleTable.y, nTimesPel.u2) annotation (Line(points={{-60,20.6},{
          -60,10},{-45.2,10},{-45.2,-2.6}},
                                     color={0,0,127}));
  connect(Qdot_EvaTable.y,nTimesQEva. u1) annotation (Line(points={{46,18.6},{
          46,-2.8},{43.6,-2.8}},        color={0,0,127}));
  connect(proRedQEva.y, calcRedQCon.u1) annotation (Line(points={{68,-68.6},{
          68,-70},{-76.4,-70},{-76.4,-72.8}},                             color=
         {0,0,127}));
  connect(sigBus.iceFacMea, proRedQEva.u1) annotation (Line(
      points={{1.075,104.07},{20,104.07},{20,-42},{72,-42},{72,-54.8},{71.6,-54.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(nTimesPel.y, Pel) annotation (Line(points={{-41,-18.7},{-41,-30},{0,
          -30},{0,-110}},          color={0,0,127}));
  connect(realCorr.y, nTimesSF.u2) annotation (Line(points={{-13,39.7},{-13,
          31.4},{-13.2,31.4}}, color={0,0,127}));
  connect(sigBus.nSet, nTimesSF.u1) annotation (Line(
      points={{1.075,104.07},{-4,104.07},{-4,31.4},{-4.8,31.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(nTimesQEva.y, proRedQEva.u2) annotation (Line(points={{40,-16.6},{
          40,-54.8},{64.4,-54.8}}, color={0,0,127}));
  connect(proRedQEva.y, QEva) annotation (Line(points={{68,-68.6},{68,-80},{
          80,-80},{80,-110}}, color={0,0,127}));
  connect(calcRedQCon.y, QCon)
    annotation (Line(points={{-80,-86.6},{-80,-110}}, color={0,0,127}));
  connect(nTimesPel.y, calcRedQCon.u2) annotation (Line(points={{-41,-18.7},{
          -41,-30},{-83.6,-30},{-83.6,-72.8}}, color={0,0,127}));
  connect(nTimesSF.y, nTimesPel.u1) annotation (Line(points={{-9,15.3},{-9,10},
          {-36.8,10},{-36.8,-2.6}}, color={0,0,127}));
  connect(nTimesSF.y, nTimesQEva.u2) annotation (Line(points={{-9,15.3},{-9,
          10},{36.4,10},{36.4,-2.8}}, color={0,0,127}));
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
      extent={{-60.0,-40.0},{-30.0,-20.0}})}), Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This model uses the 2-dimensional table data given in the DIN EN
  14511 (formerly EN255) to calculate <i>QEva</i> and <i>P_el</i>. To
  model an inverter controlled chiller, the relative <b>compressor
  speed <i>n</i> is scaled linearly</b> with the ouput of the tables.
  Furthermore, the design of a chiller is modeled via a scaling factor.
  As a result, the equations follow below:
</p>
<p style=\"text-align:center;\">
  <i>QEva,n = n * scalingFactor * TableQEva.y</i>
</p>
<p style=\"text-align:center;\">
  <i>P_el = n * scalingFactor * TablePel.y</i>
</p>
<p style=\"text-align:justify;\">
  To simulate possible icing of the evaporator on air-source chillers,
  the icing factor is used to influence the output as well. As the
  factor resembles the reduction of heat transfer between refrigerant
  and source, the factor is implemented as follows:
</p>
<p style=\"text-align:center;\">
  <i>QEva = iceFac * QEva,n</i>
</p>
<p>
  With <i>iceFac</i> as a relative value between 0 and 1:
</p>
<p style=\"text-align:center;\">
  <i>iceFac = kA/kA_noIce</i>
</p>
<p>
  Finally, to follow the first law of thermodynamics:
</p>
<p style=\"text-align:center;\">
  <i>QCon = P_el,n + QEva</i>
</p>
<h4>
  Known Limitations
</h4>
<p>
  The model <a href=
  \"modelica://AixLib.Utilities.Tables.CombiTable2DExtra\">CombiTable2DExtra</a>
  is able to disallow extrapolation by holding the last value. If one
  extrapolates the given perfomance data, warnings about occuring
  extrapolations are emitted. <b>CAUTION: Checking for possible
  extrapolations will trigger state events which results in higher
  computing time.</b>
</p>
</html>"));
end LookUpTable2D;
