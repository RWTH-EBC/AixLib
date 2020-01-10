within AixLib.DataBase.Chiller;
package PerformanceData
  "Different data models used for a black box chiller model"

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
          minSou + 273.15 < sigBus.T_flow_co,
          "Current T_flow_co is too low. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          maxSou + 273.15 > sigBus.T_flow_co,
          "Current T_flow_co is too high. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          minSup + 273.15 < sigBus.T_ret_ev,
          "Current T_ret_ev is too low. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          maxSup + 273.15 > sigBus.T_ret_ev,
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
    connect(sigBus.T_ret_ev,t_Ev_ou. u) annotation (Line(
        points={{1.075,104.07},{-54,104.07},{-54,83.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.T_flow_co,t_Co_in. u) annotation (Line(
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
    connect(sigBus.iceFac, proRedQEva.u1) annotation (Line(
        points={{1.075,104.07},{20,104.07},{20,-42},{72,-42},{72,-54.8},{71.6,
            -54.8}},
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
    connect(sigBus.n, nTimesSF.u1) annotation (Line(
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
</html>",   info="<html>
<p>This model uses the 2-dimensional table data given in the DIN EN 14511 (formerly EN255) to calculate <i>QEva</i> and <i>P_el</i>. To model an inverter controlled chiller, the relative <b>compressor speed <i>n</i> is scaled linearly</b> with the ouput of the tables. Furthermore, the design of a chiller is modeled via a scaling factor. As a result, the equations follow below: </p>
<p align=\"center\"><i>QEva,n = n * scalingFactor * TableQEva.y</i> </p>
<p align=\"center\"><i>P_el = n * scalingFactor * TablePel.y</i> </p>
<p align=\"justify\">To simulate possible icing of the evaporator on air-source chillers, the icing factor is used to influence the output as well. As the factor resembles the reduction of heat transfer between refrigerant and source, the factor is implemented as follows: </p>
<p align=\"center\"><i>QEva = iceFac * QEva,n</i> </p>
<p>With <i>iceFac</i> as a relative value between 0 and 1: </p>
<p align=\"center\"><i>iceFac = kA/kA_noIce</i> </p>
<p>Finally, to follow the first law of thermodynamics: </p>
<p align=\"center\"><i>QCon = P_el,n + QEva</i> </p>
<h4>Known Limitations </h4>
<p>The model <a href=\"modelica://AixLib.Utilities.Tables.CombiTable2DExtra\">CombiTable2DExtra</a> is able to disallow extrapolation by holding the last value. If one extrapolates the given perfomance data, warnings about occuring extrapolations are emitted. <b>CAUTION: Checking for possible extrapolations will trigger state events which results in higher computing time.</b> </p>
</html>"));
  end LookUpTable2D;

  model LookUpTableND "N-dimensional table with data for heat pump"
    extends
      AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;
    parameter Real nConv=100
      "Gain value multiplied with relative compressor speed n to calculate matching value based on sdf tables";
    parameter SDF.Types.InterpolationMethod interpMethod=SDF.Types.InterpolationMethod.Linear
      "Interpolation method";
    parameter SDF.Types.ExtrapolationMethod extrapMethod=SDF.Types.ExtrapolationMethod.None
      "Extrapolation method";
    parameter String filename_Pel=
        "modelica://Resources/Data/Fluid/BaseClasses/PerformanceData/LookUpTableND/VZH088AG.sdf"
                                     "File name of sdf table data"
      annotation (Dialog(group="Electrical Power",loadSelector(filter="SDF Files (*.sdf);;All Files (*.*)", caption="Select SDF file")));
    parameter String dataset_Pel="/Pel"
                                    "Dataset name"
      annotation (Dialog(group="Electrical Power"));
    parameter String dataUnit_Pel="W"
                                     "Data unit"
      annotation (Dialog(group="Electrical Power"));
    parameter String scaleUnits_Pel[3]={"K","K",""}
                                                   "Scale units"
      annotation (Dialog(group="Electrical Power"));
    parameter String filename_QCon=
        "modelica://Resources/Data/Fluid/BaseClasses/PerformanceData/LookUpTableND/VZH088AG.sdf"
                                      "File name of sdf table data"
      annotation (Dialog(group="Condenser heat flow",loadSelector(filter="SDF Files (*.sdf);;All Files (*.*)", caption="Select SDF file")));
    parameter String dataset_QCon="/QCon"
                                     "Dataset name"
      annotation (Dialog(group="Condenser heat flow"));
    parameter String dataUnit_QCon="W"
                                      "Data unit"
      annotation (Dialog(group="Condenser heat flow"));
    parameter String scaleUnits_QCon[3]={"K","K",""}
                                                    "Scale units"
      annotation (Dialog(group="Condenser heat flow"));

    Modelica.Blocks.Math.Gain nConGain(final k=nConv)
      "Convert relative speed n to an absolute value for interpolation in sdf tables"
      annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={0,68})));
   Modelica.Blocks.Math.UnitConversions.To_degC t_Co_in
      annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
              {6,6}},
          rotation=-90,
          origin={46,44})));
    Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_ou annotation (extent=[-88,38;
          -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-40,46})));
    Modelica.Blocks.Math.Add calcRedQCon
      "Calculates condenser heat flow with total energy balance" annotation (
        Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={-80,-86})));
    Utilities.Logical.SmoothSwitch switchPel
      "If HP is off, no heat will be exchanged"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={50,-60})));
    Utilities.Logical.SmoothSwitch switchQEva
      "If chiller is off, no heat will be exchanged"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-56})));
    Modelica.Blocks.Sources.Constant constZero(final k=0)
      "Power if HP is turned off"
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-4,-18})));
    SDF.NDTable nDTableQEva(
      final nin=3,
      final readFromFile=true,
      final filename=filename_QCon,
      final dataset=dataset_QCon,
      final dataUnit=dataUnit_QCon,
      final scaleUnits=scaleUnits_QCon,
      final interpMethod=interpMethod,
      final extrapMethod=extrapMethod)
      "SDF-Table data for evaporator heat flow"
      annotation (Placement(transformation(extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={-42,-10})));
    SDF.NDTable nDTablePel(
      final nin=3,
      final readFromFile=true,
      final filename=filename_Pel,
      final dataset=dataset_Pel,
      final dataUnit=dataUnit_Pel,
      final scaleUnits=scaleUnits_Pel,
      final interpMethod=interpMethod,
      final extrapMethod=extrapMethod) "SDF table data for electrical power"
                                       annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={50,-10})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3_1(
      final n1=1,
      final n2=1,
      final n3=1) "Concat all inputs into an array"
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={0,20})));

    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(final threshold=
          Modelica.Constants.eps) annotation (Placement(transformation(
          extent={{-6,-6},{6,6}},
          rotation=270,
          origin={-72,46})));
  equation
    connect(switchPel.y, Pel) annotation (Line(points={{50,-71},{50,-82},{0,-82},
            {0,-110}},
                 color={0,0,127}));

    connect(constZero.y,switchQEva. u3) annotation (Line(points={{-4,-24.6},{-4,
            -24},{-4,-24},{-4,-28},{-4,-30},{-58,-30},{-58,-42},{-58,-42},{-58,
            -44},{-58,-44}},     color={0,0,127}));
    connect(constZero.y, switchPel.u3) annotation (Line(points={{-4,-24.6},{-4,
            -30},{42,-30},{42,-48}},
                            color={0,0,127}));
    connect(nDTableQEva.y,switchQEva. u1)
      annotation (Line(points={{-42,-23.2},{-42,-44}},
                                                  color={0,0,127}));
    connect(nDTablePel.y, switchPel.u1)
      annotation (Line(points={{50,-23.2},{50,-34},{58,-34},{58,-48}},
                                                    color={0,0,127}));
    connect(multiplex3_1.y,nDTableQEva. u) annotation (Line(points={{-1.55431e-15,
            11.2},{-1.55431e-15,4.4},{-42,4.4}},
                                            color={0,0,127}));
    connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-1.77636e-15,11.2},
            {-1.77636e-15,4.4},{50,4.4}},      color={0,0,127}));
    connect(sigBus.T_flow_co,t_Co_in. u) annotation (Line(
        points={{1.075,104.07},{46,104.07},{46,51.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.T_ret_ev,t_Ev_ou. u) annotation (Line(
        points={{1.075,104.07},{-40,104.07},{-40,53.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.n, greaterThreshold.u) annotation (Line(
        points={{1.075,104.07},{-72,104.07},{-72,53.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(greaterThreshold.y,switchQEva. u2) annotation (Line(points={{-72,
            39.4},{-72,-36},{-50,-36},{-50,-44}},
                                            color={255,0,255}));
    connect(greaterThreshold.y, switchPel.u2) annotation (Line(points={{-72,39.4},
            {-72,-36},{50,-36},{50,-48}}, color={255,0,255}));
    connect(sigBus.n, nConGain.u) annotation (Line(
        points={{1.075,104.07},{1.77636e-15,104.07},{1.77636e-15,77.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(nConGain.y, multiplex3_1.u3[1]) annotation (Line(points={{
            -1.55431e-15,59.2},{-6,59.2},{-6,29.6},{-5.6,29.6}}, color={0,0,127}));
    connect(t_Ev_ou.y, multiplex3_1.u1[1]) annotation (Line(points={{-40,39.4},{
            -40,36},{5.6,36},{5.6,29.6}}, color={0,0,127}));
    connect(t_Co_in.y, multiplex3_1.u2[1]) annotation (Line(points={{46,37.4},{46,
            32},{0,32},{0,29.6}}, color={0,0,127}));
    connect(switchPel.y, calcRedQCon.u2) annotation (Line(points={{50,-71},{50,
            -76},{-76.4,-76},{-76.4,-78.8}}, color={0,0,127}));
    connect(switchQEva.y, calcRedQCon.u1) annotation (Line(points={{-50,-67},{
            -50,-72},{-83.6,-72},{-83.6,-78.8}}, color={0,0,127}));
    connect(calcRedQCon.y, QCon)
      annotation (Line(points={{-80,-92.6},{-80,-110}}, color={0,0,127}));
    connect(switchQEva.y, QEva) annotation (Line(points={{-50,-67},{-50,-88},{
            80,-88},{80,-110}}, color={0,0,127}));
    annotation (Icon(graphics={
      Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
      Line(points={{0.0,40.0},{0.0,-40.0}}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,0.0},{-30.0,20.0}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,215,136},
        fillPattern=FillPattern.Solid,
        extent={{-60.0,-40.0},{-30.0,-20.0}}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-60,-20},{-30,0}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-60,-40},{-30,-20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-30,-40},{0,-20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{0,-40},{30,-20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{30,-40},{60,-20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{30,-20},{60,0}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{0,-20},{30,0}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{0,0},{30,20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{30,0},{60,20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{0,20},{30,40}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{30,20},{60,40}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-60,20},{-30,40}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-30,20},{0,40}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-30,0},{0,20}},
            lineColor={0,0,0}),
      Rectangle(fillColor={255,255,0},
        fillPattern=FillPattern.Solid,
        extent={{-30,-20},{0,0}},
            lineColor={0,0,0})}),                Documentation(info="<html><p>
  Basic models showing the concept of using n-dimensional table data
  for the innerCycle of the heat pump model. This model assumes one
  provides data for inverter controlled heat pumps or chillers.
  However, this basis structure can be used to create own models, where
  electrical power and condenser depend on other inputs, such as
  ambient temperature.
</p>
</html>",   revisions="<html>
<ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>"));
  end LookUpTableND;

  model PolynomalApproach
    "Calculating heat pump data based on a polynomal approach"
    extends
      AixLib.DataBase.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;

    replaceable function PolyData =
        AixLib.DataBase.HeatPump.Functions.Characteristics.PartialBaseFct    "Function to calculate peformance Data" annotation(choicesAllMatching=true);
  protected
    Real Char[2];
  equation
    Char =PolyData(
        sigBus.n,
        sigBus.T_ret_ev,
        sigBus.T_flow_co,
        sigBus.m_flow_ev,
        sigBus.m_flow_co);
    if sigBus.n > Modelica.Constants.eps then
      //Get's the data from the signal Bus and calculates the power and heat flow based on the function one chooses.
      QEva = Char[2];
      Pel = Char[1];
    else //If heat pump is turned off, all values become zero.
      QCon = 0;
      Pel = 0;
    end if;
    QCon = -(QCon - Pel);
    annotation (Icon(graphics={
          Text(
            lineColor={0,0,255},
            extent={{-136,109},{164,149}},
            textString="%name"),
          Ellipse(
            lineColor = {108,88,49},
            fillColor = {255,215,136},
            fillPattern = FillPattern.Solid,
            extent={{-86,-96},{88,64}}),
          Text(
            lineColor={108,88,49},
            extent={{-90,-108},{90,72}},
            textString="f")}), Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This model is used to calculate the three values based on a
  functional approach. The user can choose between several functions or
  use their own.
</p>
<p>
  As the <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.Functions.Characteristics.PartialBaseFct\">
  base function</a> only returns the electrical power and the condenser
  heat flow, the evaporator heat flow is calculated with the following
  energy balance:
</p>
<p>
  <i>QEva = QCon - P_el</i>
</p>
</html>"));
  end PolynomalApproach;

  package BaseClasses "Package with partial classes of Performance Data"
    partial model PartialPerformanceData
      "Model with a replaceable for different methods of data aggregation"
      extends
        AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

    end PartialPerformanceData;
  annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            extent={{-100.0,-100.0},{100.0,100.0}},
            radius=25.0),
          Ellipse(
            extent={{-30.0,-30.0},{30.0,30.0}},
            lineColor={128,128,128},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}), Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This package contains base classes for the package <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData\">AixLib.Fluid.Chillers.BaseClasses.PerformanceData</a>.
</p>
</html>"));
  end BaseClasses;
annotation (Documentation(revisions="<html><ul>
  <li>
    <i>May 22, 2019&#160;</i> by Julian Matthes:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/715\">#715</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models for the grey box chiller model <a href=
  \"modelica://AixLib.Fluid.HeatPumps.HeatPump\">AixLib.Fluid.Chillers.Chiller</a>.
</p>
</html>"));
end PerformanceData;
