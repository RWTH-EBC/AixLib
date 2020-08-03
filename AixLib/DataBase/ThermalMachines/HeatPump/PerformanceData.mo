within AixLib.DataBase.ThermalMachines.HeatPump;
package PerformanceData "Different models used for a black box heat pump model"
  model IcingBlock
    "Block which decreases evaporator power by an icing factor"
    AixLib.Utilities.Time.CalendarTime calTim(zerTim=zerTim, yearRef=yearRef);
    parameter Integer hourDay=16
                              "Hour of the day";
    parameter AixLib.Utilities.Time.Types.ZeroTime zerTim=AixLib.Utilities.Time.Types.ZeroTime.NY2016
      "Enumeration for choosing how reference time (time = 0) should be defined";
    parameter Integer yearRef=2016 "Year when time = 0, used if zerTim=Custom";
    replaceable function iceFunc =
        Functions.IcingFactor.BasicIcingApproach constrainedby
      AixLib.DataBase.ThermalMachines.HeatPump.Functions.IcingFactor.PartialBaseFct
                                                                                                                                                        "Replaceable function to calculate current icing factor" annotation(choicesAllMatching=true);
    Modelica.Blocks.Interfaces.RealInput T_flow_ev(unit="K", displayUnit="degC")
      "Temperature at evaporator inlet"
      annotation (Placement(transformation(extent={{-128,0},{-100,28}}),
          iconTransformation(extent={{-116,12},{-100,28}})));

    Modelica.Blocks.Interfaces.RealInput T_ret_ev(unit="K", displayUnit="degC")
      "Temperature at evaporator outlet" annotation (Placement(transformation(
            extent={{-128,-40},{-100,-12}}),iconTransformation(extent={{-116,-28},
              {-100,-12}})));
    Modelica.Blocks.Interfaces.RealInput T_oda(unit="K", displayUnit="degC") "Outdoor air temperature"
      annotation (Placement(transformation(extent={{-128,46},{-100,74}}),
          iconTransformation(extent={{-116,52},{-100,68}})));
    Modelica.Blocks.Interfaces.RealInput m_flow_ev(unit="kg/s") "Mass flow rate at evaporator"
      annotation (Placement(transformation(extent={{-128,-80},{-100,-52}}),
          iconTransformation(extent={{-116,-68},{-100,-52}})));
    Modelica.Blocks.Interfaces.RealOutput iceFac(min=0, max=1) "Output of current icing factor"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,0})));
  protected
    Real iceFac_internal "Calculated value of icing factor";
  equation
    iceFac_internal = iceFunc(T_flow_ev,T_ret_ev,T_oda,m_flow_ev);
    iceFac = iceFac_internal;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            lineColor={0,0,255},
            extent={{-150,105},{150,145}},
            textString="%name"),
          Ellipse(
            lineColor = {108,88,49},
            fillColor = {255,215,136},
            fillPattern = FillPattern.Solid,
            extent = {{-100,-100},{100,100}}),
          Text(
            lineColor={108,88,49},
            extent={{-90.0,-90.0},{90.0,90.0}},
            textString="f")}),                                     Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  Model for calculation of the icing factor. The replaceable function
  uses the inputs to calculate the resulting icing factor.
</p>
</html>"));
  end IcingBlock;

  model LookUpTable2D "Performance data coming from manufacturer"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

    parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
      "Smoothness of table interpolation";
    parameter HeatPumpBaseDataDefinition dataTable=
        AixLib.DataBase.ThermalMachines.HeatPump.EN255.Vitocal350AWI114()
      "Data Table of HP" annotation (choicesAllMatching=true);
    parameter Boolean extrapolation=true "False to hold last value";
    parameter Boolean printAsserts=false
      "WARNING: This will lead to a lot of state-events if extrapolation occurs frequently! If extrapolation is enabled, the user will get warnings when extrapolation occurs."
      annotation (Dialog(enable=extrapolation));

    Utilities.Tables.CombiTable2DExtra  Qdot_ConTable(
      final smoothness=smoothness,
      final u1(unit="degC"),
      final u2(unit="degC"),
      final y(unit="W", displayUnit="kW"),
      final extrapolation=extrapolation,
      final table=dataTable.tableQdot_con)
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
    parameter Real minSou = min(dataTable.tableP_ele[1,2:end]);
    parameter Real minSup = min(dataTable.tableP_ele[2:end,1]);
    parameter Real maxSou = max(dataTable.tableP_ele[1,2:end]);
    parameter Real maxSup = max(dataTable.tableP_ele[2:end,1]);
    Modelica.Blocks.Sources.Constant realCorr(final k=scalingFactor)
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

  equation
    if printAsserts then
      assert(
          minSou + 273.15 < sigBus.T_flow_ev,
          "Current T_flow_ev is too low. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          maxSou + 273.15 > sigBus.T_flow_ev,
          "Current T_flow_ev is too high. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          minSup + 273.15 < sigBus.T_ret_co,
          "Current T_ret_co is too low. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
      assert(
          maxSup + 273.15 > sigBus.T_ret_co,
          "Current T_ret_co is too high. Extrapolation of data will result in unrealistic results",
          level=AssertionLevel.warning);
    else
    end if;
    connect(t_Ev_in.y, Qdot_ConTable.u2) annotation (Line(points={{52,65.4},{52,
            60},{37.6,60},{37.6,50.8}},      color={0,0,127}));
    connect(t_Ev_in.y, P_eleTable.u2) annotation (Line(points={{52,65.4},{-68.4,
            65.4},{-68.4,52.8}},  color={0,0,127}));
    connect(t_Co_ou.y, P_eleTable.u1) annotation (Line(points={{-54,69.4},{-54,
            52.8},{-51.6,52.8}},  color={0,0,127}));
    connect(t_Co_ou.y, Qdot_ConTable.u1) annotation (Line(points={{-54,69.4},{-54,
            60},{52,60},{52,50.8},{54.4,50.8}},
                                    color={0,0,127}));
    connect(sigBus.T_ret_co, t_Co_ou.u) annotation (Line(
        points={{1.075,104.07},{-54,104.07},{-54,83.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.T_flow_ev, t_Ev_in.u) annotation (Line(
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
    connect(proRedQEva.y, calcRedQCon.u1) annotation (Line(points={{-78,-68.6},
            {-78,-72},{-4,-72},{-4,-58},{85.6,-58},{85.6,-62.8}},           color=
           {0,0,127}));
    connect(proRedQEva.y, QEva)
      annotation (Line(points={{-78,-68.6},{-78,-86},{80,-86},{80,-110}},
                                                        color={0,0,127}));
    connect(feedbackHeatFlowEvaporator.y, proRedQEva.u2) annotation (Line(points={{-81,
            -47.5},{-81,-54},{-81.6,-54},{-81.6,-54.8}},           color={0,0,127}));
    connect(sigBus.iceFac, proRedQEva.u1) annotation (Line(
        points={{1.075,104.07},{14,104.07},{14,-52},{-74,-52},{-74,-54.8},{
            -74.4,-54.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(nTimesQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{40,
            -16.6},{40,-32},{-81,-32},{-81,-39}},      color={0,0,127}));
    connect(nTimesPel.y, feedbackHeatFlowEvaporator.u2) annotation (Line(points={{-47,
            -10.7},{-47,-22},{-90,-22},{-90,-43},{-85,-43}},      color={0,0,127}));
    connect(nTimesPel.y, Pel) annotation (Line(points={{-47,-10.7},{-47,-80},{0,
            -80},{0,-110}},          color={0,0,127}));
    connect(realCorr.y, nTimesSF.u2) annotation (Line(points={{-15,39.7},{-15,
            31.4},{-15.2,31.4}}, color={0,0,127}));
    connect(sigBus.N, nTimesSF.u1) annotation (Line(
        points={{1.075,104.07},{-2,104.07},{-2,31.4},{-6.8,31.4}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(nTimesSF.y, nTimesPel.u1) annotation (Line(points={{-11,15.3},{-11,
            8},{-42.8,8},{-42.8,5.4}}, color={0,0,127}));
    connect(nTimesSF.y, nTimesQCon.u2) annotation (Line(points={{-11,15.3},{-11,
            8},{36.4,8},{36.4,-2.8}}, color={0,0,127}));
    connect(nTimesPel.y, calcRedQCon.u2) annotation (Line(points={{-47,-10.7},{
            -47,-22},{78.4,-22},{78.4,-62.8}}, color={0,0,127}));
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
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This model uses the 2-dimensional table data given in the DIN EN
  14511 (formerly EN255) to calculate <i>QCon</i> and <i>P_el</i>. To
  model an inverter controlled heat pump, the relative <b>compressor
  speed <i>n</i> is scaled linearly</b> with the ouput of the tables.
  Furthermore, the design of a heat pump is modeled via a scaling
  factor. As a result, the equations follow below:
</p>
<p align=\"center\">
  <i>QCon,n = n * scalingFactor * TableQCon.y</i>
</p>
<p align=\"center\">
  <i>P_el = n * scalingFactor * TablePel.y</i>
</p>
<p align=\"justify\">
  To simulate possible icing of the evaporator on air-source heat
  pumps, the icing factor is used to influence the output as well. As
  the factor resembles the reduction of heat transfer between
  refrigerant and source, the factor is implemented as follows:
</p>
<p align=\"center\">
  <i>QEva = iceFac * (QCon,n-P_el,n)</i>
</p>
<p>
  With <i>iceFac</i> as a relative value between 0 and 1:
</p>
<p align=\"center\">
  <i>iceFac = kA/kA_noIce</i>
</p>
<p>
  Finally, to follow the first law of thermodynamics:
</p>
<p align=\"center\">
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

  model LookUpTableND "N-dimensional table with data for heat pump"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;
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
   Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
      annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-6,-6},
              {6,6}},
          rotation=-90,
          origin={46,44})));
    Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
          -76,50], Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-40,46})));
    Modelica.Blocks.Math.Feedback feedbackHeatFlowEvaporator
                      "Calculates evaporator heat flow with total energy balance" annotation(Placement(transformation(extent={{-6,-6},
              {6,6}},
          rotation=-90,
          origin={80,-82})));
    Utilities.Logical.SmoothSwitch switchPel
      "If HP is off, no heat will be exchanged"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={50,-60})));
    Utilities.Logical.SmoothSwitch switchQCon
      "If HP is off, no heat will be exchanged"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-50,-56})));
    Modelica.Blocks.Sources.Constant constZero(final k=0)
      "Power if HP is turned off"
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-4,-18})));
    SDF.NDTable nDTableQCon(
      final nin=3,
      final readFromFile=true,
      final filename=filename_QCon,
      final dataset=dataset_QCon,
      final dataUnit=dataUnit_QCon,
      final scaleUnits=scaleUnits_QCon,
      final interpMethod=interpMethod,
      final extrapMethod=extrapMethod) "SDF-Table data for condenser heat flow"
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
    connect(feedbackHeatFlowEvaporator.y, QEva)
      annotation (Line(points={{80,-87.4},{80,-110}},
                                                  color={0,0,127}));
    connect(switchPel.y, Pel) annotation (Line(points={{50,-71},{50,-82},{0,-82},
            {0,-110}},
                 color={0,0,127}));
    connect(switchQCon.y, QCon) annotation (Line(points={{-50,-67},{-50,-74},{
            -80,-74},{-80,-110}},
                        color={0,0,127}));

    connect(constZero.y, switchQCon.u3) annotation (Line(points={{-4,-24.6},{-4,
            -24},{-4,-24},{-4,-28},{-4,-30},{-58,-30},{-58,-42},{-58,-42},{-58,
            -44},{-58,-44}},     color={0,0,127}));
    connect(constZero.y, switchPel.u3) annotation (Line(points={{-4,-24.6},{-4,
            -30},{42,-30},{42,-48}},
                            color={0,0,127}));
    connect(nDTableQCon.y, switchQCon.u1)
      annotation (Line(points={{-42,-23.2},{-42,-44}},
                                                  color={0,0,127}));
    connect(nDTablePel.y, switchPel.u1)
      annotation (Line(points={{50,-23.2},{50,-34},{58,-34},{58,-48}},
                                                    color={0,0,127}));
    connect(multiplex3_1.y, nDTableQCon.u) annotation (Line(points={{-1.55431e-15,
            11.2},{-1.55431e-15,4.4},{-42,4.4}},
                                            color={0,0,127}));
    connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-1.77636e-15,11.2},
            {-1.77636e-15,4.4},{50,4.4}},      color={0,0,127}));
    connect(sigBus.T_flow_ev, t_Ev_in.u) annotation (Line(
        points={{1.075,104.07},{46,104.07},{46,51.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.T_ret_co, t_Co_ou.u) annotation (Line(
        points={{1.075,104.07},{-40,104.07},{-40,53.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}}));
    connect(sigBus.N, greaterThreshold.u) annotation (Line(
        points={{1.075,104.07},{-72,104.07},{-72,53.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(greaterThreshold.y, switchQCon.u2) annotation (Line(points={{-72,
            39.4},{-72,-36},{-50,-36},{-50,-44}},
                                            color={255,0,255}));
    connect(greaterThreshold.y, switchPel.u2) annotation (Line(points={{-72,39.4},
            {-72,-36},{50,-36},{50,-48}}, color={255,0,255}));
    connect(sigBus.N, nConGain.u) annotation (Line(
        points={{1.075,104.07},{1.77636e-15,104.07},{1.77636e-15,77.6}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(nConGain.y, multiplex3_1.u3[1]) annotation (Line(points={{
            -1.55431e-15,59.2},{-6,59.2},{-6,29.6},{-5.6,29.6}}, color={0,0,127}));
    connect(t_Co_ou.y, multiplex3_1.u1[1]) annotation (Line(points={{-40,39.4},{
            -40,36},{5.6,36},{5.6,29.6}}, color={0,0,127}));
    connect(t_Ev_in.y, multiplex3_1.u2[1]) annotation (Line(points={{46,37.4},{
            46,32},{0,32},{0,29.6}},
                                  color={0,0,127}));
    connect(switchPel.y, feedbackHeatFlowEvaporator.u2)
      annotation (Line(points={{50,-71},{50,-82},{75.2,-82}}, color={0,0,127}));
    connect(switchQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{-50,-67},
            {-50,-74},{80,-74},{80,-77.2}},            color={0,0,127}));
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
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
  end LookUpTableND;

  model PolynomalApproach
    "Calculating heat pump data based on a polynomal approach"
    extends
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

    replaceable function PolyData =
        AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct
                                                                             "Function to calculate peformance Data" annotation(choicesAllMatching=true);
  protected
    Real Char[2];
  equation
    Char =PolyData(
        sigBus.N,
        sigBus.T_ret_co,
        sigBus.T_flow_ev,
        sigBus.m_flow_co,
        sigBus.m_flow_ev);
    if sigBus.N > Modelica.Constants.eps then
      //Get's the data from the signal Bus and calculates the power and heat flow based on the function one chooses.
      QCon = Char[2];
      Pel = Char[1];
    else //If heat pump is turned off, all values become zero.
      QCon = 0;
      Pel = 0;
    end if;
    QEva = -(QCon - Pel);
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
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
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

  model calcCOP
    "To calculate the COP or EER of a device, this model ensures no integration failure will happen"

    parameter Modelica.SIunits.Power lowBouPel "If P_el falls below this value, COP will not be calculated";
    parameter Modelica.SIunits.Time aveTime=60 "Time span for average";

   Modelica.Blocks.Interfaces.RealInput Pel(final unit="W", final displayUnit=
          "kW")
      "Input for all electrical power consumed by the system"
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
          iconTransformation(extent={{-140,-60},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput QHeat(final unit="W", final displayUnit=
          "kW")
      "Input for all heating power delivered to the system"
      annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
          iconTransformation(extent={{-140,20},{-100,60}})));
    Modelica.Blocks.Interfaces.RealOutput y_COP "Output for calculated COP value"
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  protected
    AixLib.Utilities.Math.MovingAverage movAve(final aveTime=aveTime)
      "To calculate the moving average of the output values";
  equation
    //Check if any of the two sums are lower than the given threshold. If so, set COP to zero
    if Pel < lowBouPel or QHeat < Modelica.Constants.eps then
      movAve.u = 0;
    else
      movAve.u = QHeat/Pel;
    end if;
    connect(movAve.y, y_COP);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Line(
            points={{-82,0},{-12,0}},
            color={28,108,200},
            thickness=0.5),
          Text(
            extent={{-92,32},{-2,12}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="QHeat"),
          Text(
            extent={{-92,-8},{-2,-28}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="Pel"),
          Line(points={{-6,6},{22,6}}, color={28,108,200}),
          Line(points={{-6,-6},{22,-6}}, color={28,108,200}),
          Text(
            extent={{12,8},{102,-12}},
            lineColor={28,108,200},
            lineThickness=0.5,
            textString="COP")}),                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This model is used to calculate the COP or the EER of a device. As
  the electrical power could get negative, a lower boundary is used to
  avoid division by zero. A moving average ensure a stable calculation
  of the COP or EER.
</p>
</html>"));
  end calcCOP;

  package BaseClasses "Package with partial classes of Performance Data"
    partial model PartialPerformanceData
      "Model with a replaceable for different methods of data aggregation"

      Modelica.Blocks.Interfaces.RealOutput Pel(final unit="W", final displayUnit="kW")
                                                          "Electrical Power consumed by HP" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-110})));
      Modelica.Blocks.Interfaces.RealOutput QCon(final unit="W", final displayUnit="kW")
        "Heat flow rate through Condenser" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-80,-110})));
      AixLib.Controls.Interfaces.ThermalMachineControlBus sigBus
        "Bus-connector used in a thermal machine" annotation (Placement(
            transformation(
            extent={{-15,-14},{15,14}},
            rotation=0,
            origin={1,104})));
      Modelica.Blocks.Interfaces.RealOutput QEva(final unit="W", final displayUnit="kW")
                                                                             "Heat flow rate through Condenser"  annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={80,-110})));
    protected
      parameter Real scalingFactor=1 "Scaling factor of heat pump";
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                    Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),   Text(
              extent={{-47.5,-26.5},{47.5,26.5}},
              lineColor={0,0,127},
              pattern=LinePattern.Dash,
              textString="%name
",            origin={0.5,60.5},
              rotation=180)}),Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",     info="<html>
<p>
  Partial model for calculation of <span style=
  \"font-family: Courier New;\">P_el</span>, <span style=
  \"font-family: Courier New;\">QCon</span> and <span style=
  \"font-family: Courier New;\">QEva</span> based on the values in the
  <span style=\"font-family: Courier New;\">sigBusHP</span>.
</p>
</html>"));
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
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",   info="<html>
<p>
  This package contains base classes for the package <a href=
  \"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData\">AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData</a>.
</p>
</html>"));
  end BaseClasses;
annotation (Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>", info="<html>
<p>
  This package contains models for the grey box heat pump model
  <a href=\"modelica://AixLib.Fluid.HeatPumps.HeatPump\">AixLib.Fluid.HeatPumps.HeatPump</a>.
</p>
</html>"));
end PerformanceData;
