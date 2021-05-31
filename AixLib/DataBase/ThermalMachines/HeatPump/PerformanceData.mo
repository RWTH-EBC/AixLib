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

      parameter Modelica.SIunits.Temperature THotMax=333.15 "Max. value of THot before shutdown"
      annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Modelica.SIunits.HeatFlowRate QNom=30000 "Nominal heat flow"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Real PLRMin=0.4 "Limit of PLR; less =0"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Boolean HighTemp=false "true: THot > 60°C"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));
      parameter Modelica.SIunits.TemperatureDifference DeltaTEvap=3 "Temperature difference heat source evaporator"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));

      parameter Modelica.SIunits.Temperature TSource=280 "temperature of heat source"
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));


     parameter Boolean dTConFix=false
       annotation (Dialog(tab="NotManufacturer", group="General machine information"));


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

  model LookUpTableNDNotManudacturer "4-dimensional table without manufacturer data for heat pump"
   extends
      AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;


    SDF.NDTable SDFCOP(
      final nin=4,
      final readFromFile=true,
      final filename=FilenameCOP,
      final dataset="\COP",
      final dataUnit="-",
      final scaleUnits={"degC","-","K","degC"},
      final interpMethod=SDF.Types.InterpolationMethod.Linear,
      final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
      "SDF-Table data for COP nominal"
                               annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={76,-18})));
    Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={38,16})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin1
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=0,
          origin={73,83})));
    NominalHeatPumpNotManufacturer nominalHeatPump(
      HighTemp=HighTemp,
      THotNom=THotNom,
      TSourceNom=TSourceNom,
      QNom=QNom,
      DeltaTCon=DeltaTCon,
      dTConFix=dTConFix)
      annotation (Placement(transformation(extent={{-80,-16},{-60,4}})));
    Modelica.Blocks.Logical.LessThreshold pLRMin(threshold=PLRMin)
      annotation (Placement(transformation(extent={{-124,50},{-104,70}})));
    Modelica.Blocks.Logical.Switch switch4
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-60,60})));
    Modelica.Blocks.Logical.Switch switch3
      annotation (Placement(transformation(extent={{-9,-9},{9,9}},
          rotation=270,
          origin={-35,13})));
    Modelica.Blocks.Sources.RealExpression zero
      annotation (Placement(transformation(extent={{-52,70},{-70,90}})));
    Modelica.Blocks.Math.Add add(k1=-1)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={80,-72})));
    Modelica.Blocks.Math.Product product1
      annotation (Placement(transformation(extent={{-18,-72},{-2,-56}})));
    Modelica.Blocks.Math.Product product2
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-80,-62})));

    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=PLRMin)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={74,62})));
    Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
      annotation (Placement(transformation(extent={{-7,-8},{7,8}},
          rotation=180,
          origin={51,62})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin4
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={36,126})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=180,
          origin={58,108})));
    Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom) annotation (
        Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=270,
          origin={58,2})));
    Modelica.Blocks.Routing.Multiplex4 multiplex4_2 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={76,16})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin5
      annotation (Placement(transformation(extent={{4,-4},{-4,4}},
          rotation=270,
          origin={58,16})));
    SDF.NDTable SDFCOP1(
      final nin=4,
      final readFromFile=true,
      final filename=FilenameCOP,
      final dataset="\COP",
      final dataUnit="-",
      final scaleUnits={"degC","-","K","degC"},
      final interpMethod=SDF.Types.InterpolationMethod.Linear,
      final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
      "SDF-Table data for COP" annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={38,-16})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(T=15)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-80,-90})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=15)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={80,-90})));
    Modelica.Blocks.Sources.RealExpression zero1
      annotation (Placement(transformation(extent={{0,26},{-18,46}})));
    Modelica.Blocks.Sources.RealExpression tSource(y=TSource)
      annotation (Placement(transformation(extent={{40,74},{56,92}})));
    Modelica.Blocks.Sources.RealExpression deltaTCon1(y=DeltaTCon)
      annotation (Placement(transformation(extent={{-7,-8},{7,8}},
          rotation=180,
          origin={91,104})));
    Modelica.Blocks.Math.Add add2(k2=-1)
      annotation (Placement(transformation(extent={{-8,-8},{8,8}},
          rotation=180,
          origin={122,60})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-108,-38})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=dTConFix)
      annotation (Placement(transformation(extent={{-140,-10},{-120,10}})));
  protected
    parameter String FilenameCOP= if HighTemp==false then "D:/dja-mzu/SDF/WP/COP_Scroll_R410a.sdf" else "D:/dja-mzu/SDF/WP/COP_Hubkolben_R134a.sdf";


  equation


    connect(fromKelvin1.Celsius,multiplex4_1. u1[1]) annotation (Line(points={{80.7,83},
            {90,83},{90,50},{47,50},{47,28}},                     color={0,0,127}));
    connect(switch4.y,switch3. u3) annotation (Line(points={{-49,60},{-42,60},{
            -42,50},{-42.2,50},{-42.2,23.8}},
                                          color={0,0,127}));
    connect(pLRMin.y,switch4. u2) annotation (Line(points={{-103,60},{-72,60}},
                                               color={255,0,255}));
    connect(zero.y, switch4.u1) annotation (Line(points={{-70.9,80},{-80,80},{
            -80,68},{-72,68}}, color={0,0,127}));
    connect(product1.y,product2. u1) annotation (Line(points={{-1.2,-64},{24,
            -64},{24,-48},{-75.2,-48},{-75.2,-52.4}},              color={0,0,127}));
    connect(product2.y,add. u2) annotation (Line(points={{-80,-70.8},{-80,-74},
            {42,-74},{42,-60},{76.4,-60},{76.4,-64.8}},
                                color={0,0,127}));
    connect(product1.y,add. u1)
      annotation (Line(points={{-1.2,-64},{32,-64},{32,-58},{83.6,-58},{83.6,
            -64.8}},                                        color={0,0,127}));
    connect(sigBus.PLR, switch4.u3) annotation (Line(
        points={{1.075,104.07},{1.075,92},{-90,92},{-90,52},{-72,52}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus.PLR, pLRMin.u) annotation (Line(
        points={{1.075,104.07},{1.075,98},{2,98},{2,92},{-136,92},{-136,60},{
            -126,60}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(sigBus.Shutdown, switch3.u2) annotation (Line(
        points={{1.075,104.07},{1.075,48},{-35,48},{-35,23.8}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(nominalHeatPump.QEvapNom, sigBus.QEvapNom) annotation (Line(points=
            {{-59,-4},{8,-4},{8,58},{1.075,58},{1.075,104.07}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(limiter.y, multiplex4_1.u2[1]) annotation (Line(points={{74,55.4},{
            74,46},{41,46},{41,28}},      color={0,0,127}));
    connect(sigBus.PLR, limiter.u) annotation (Line(
        points={{1.075,104.07},{6,104.07},{6,69.2},{74,69.2}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));

    connect(product1.y, Pel) annotation (Line(points={{-1.2,-64},{24,-64},{24,
            -92},{0,-92},{0,-110}},
                               color={0,0,127}));
    connect(limiter.y, multiplex4_2.u2[1]) annotation (Line(points={{74,55.4},{
            74,36},{79,36},{79,28}}, color={0,0,127}));
    connect(fromKelvin1.Celsius, multiplex4_2.u1[1]) annotation (Line(points={{80.7,83},
            {90,83},{90,40},{85,40},{85,28}},        color={0,0,127}));
    connect(nominalHeatPump.PelFullLoad, product1.u2) annotation (Line(points={
            {-59,-14},{-58,-14},{-58,-68.8},{-19.6,-68.8}}, color={0,0,127}));
    connect(tHotNom.y, fromKelvin5.Kelvin)
      annotation (Line(points={{58,8.6},{58,11.2}}, color={0,0,127}));
    connect(sigBus.T_flow_co, fromKelvin4.Kelvin) annotation (Line(
        points={{1.075,104.07},{2,104.07},{2,126},{24,126}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(product2.y, firstOrder.u) annotation (Line(points={{-80,-70.8},{-80,
            -82.8}},         color={0,0,127}));
    connect(add.y, firstOrder1.u) annotation (Line(points={{80,-78.6},{80,-82.8}},
                                         color={0,0,127}));
    connect(firstOrder1.y, QEva) annotation (Line(points={{80,-96.6},{80,-110}},
                                                      color={0,0,127}));
    connect(firstOrder.y, QCon) annotation (Line(points={{-80,-96.6},{-80,-110}},
                                                       color={0,0,127}));
    connect(add1.y, multiplex4_1.u4[1])
      annotation (Line(points={{49.2,108},{29,108},{29,28}}, color={0,0,127}));
    connect(fromKelvin5.Celsius, multiplex4_2.u4[1]) annotation (Line(points={{
            58,20.4},{58,32},{67,32},{67,28}}, color={0,0,127}));
    connect(multiplex4_1.y, SDFCOP1.u)
      annotation (Line(points={{38,5},{38,-1.6}}, color={0,0,127}));
    connect(multiplex4_2.y, SDFCOP.u)
      annotation (Line(points={{76,5},{76,-3.6}}, color={0,0,127}));
    connect(fromKelvin4.Celsius, add1.u2) annotation (Line(points={{47,126},{80,
            126},{80,112.8},{67.6,112.8}}, color={0,0,127}));
    connect(zero1.y, switch3.u1) annotation (Line(points={{-18.9,36},{-27.8,36},
            {-27.8,23.8}}, color={0,0,127}));
    connect(fromKelvin1.Kelvin, tSource.y)
      annotation (Line(points={{64.6,83},{56.8,83}}, color={0,0,127}));
    connect(deltaTCon.y, multiplex4_1.u3[1])
      annotation (Line(points={{43.3,62},{35,62},{35,28}}, color={0,0,127}));
    connect(deltaTCon1.y, add1.u1) annotation (Line(points={{83.3,104},{74,104},
            {74,103.2},{67.6,103.2}}, color={0,0,127}));
    connect(add2.y, multiplex4_2.u3[1]) annotation (Line(points={{113.2,60},{104,60},
            {104,36},{73,36},{73,28}}, color={0,0,127}));
    connect(fromKelvin4.Celsius, add2.u2) annotation (Line(points={{47,126},{
            140,126},{140,64.8},{131.6,64.8}},           color={0,0,127}));
    connect(fromKelvin5.Celsius, add2.u1) annotation (Line(points={{58,20.4},{
            58,38},{140,38},{140,54},{131.6,54},{131.6,55.2}},
                                                        color={0,0,127}));
    connect(SDFCOP1.y, switch2.u1) annotation (Line(points={{38,-29.2},{38,-42},
            {-84,-42},{-84,-16},{-112.8,-16},{-112.8,-30.8}},          color={0,0,
            127}));
    connect(switch2.y, product2.u2) annotation (Line(points={{-108,-44.6},{-108,
            -48},{-84.8,-48},{-84.8,-52.4}},
                                        color={0,0,127}));
    connect(SDFCOP.y, switch2.u3) annotation (Line(points={{76,-31.2},{76,-36},
            {-14,-36},{-14,-28},{-103.2,-28},{-103.2,-30.8}},
                                                  color={0,0,127}));
    connect(booleanExpression.y, switch2.u2) annotation (Line(points={{-119,0},
            {-108,0},{-108,-30.8}},
                              color={255,0,255}));
    connect(switch3.y, product1.u1) annotation (Line(points={{-35,3.1},{-35,
            -59.2},{-19.6,-59.2}}, color={0,0,127}));
    connect(add1.y, nominalHeatPump.u) annotation (Line(points={{49.2,108},{-94,
            108},{-94,-12},{-82,-12}}, color={0,0,127}));
    connect(switch2.y, sigBus.CoP) annotation (Line(points={{-108,-44.6},{-108,
            -48},{-174,-48},{-174,116},{1.075,116},{1.075,104.07}}, color={0,0,
            127}), Text(
        string="%second",
        index=1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>This model uses 4-dimensional table data, wich are calculated for a simplyfied refrigerant circuit with the use of isentropic compressor efficienciecs as a function of pressure gradient and frequency, superheating and calibration of minimal temperature differencees in condeser and evaporater. The table data ist a function of THot, TSource, deltaTCon and relative power, which represents compressor frequency.</p>
<p><br><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_Prel.png\"/></p>
<p><img src=\"modelica://AixLib/../../../Diagramme AixLib/WP/KennfeldScroll_DeltaT_HK.png\"/></p>
</html>"));
  end LookUpTableNDNotManudacturer;

  model NominalHeatPumpNotManufacturer

    parameter Boolean HighTemp=false;
    parameter Modelica.SIunits.Temperature THotNom=313.15 "Nominal temperature of THot"
     annotation (Dialog(tab="NotManufacturer", group="General machine information"));
    parameter Modelica.SIunits.Temperature TSourceNom=278.15 "Nominal temperature of TSource"
     annotation (Dialog(tab="NotManufacturer", group="General machine information"));
    parameter Modelica.SIunits.HeatFlowRate QNom=30000 "Nominal heat flow"
     annotation (Dialog(tab="NotManufacturer", group="General machine information"));
       parameter Modelica.SIunits.TemperatureDifference DeltaTCon=7 "Temperature difference heat sink condenser"
     annotation (Dialog(tab="NotManufacturer", group="General machine information"));

   parameter Boolean dTConFix=false "Constant delta T condenser"
     annotation (Dialog(descriptionLabel=true, group="General machine information"));

    Modelica.Blocks.Interfaces.RealOutput PelFullLoad(final unit="W", final
        displayUnit="kW")
      "maximal notwendige elektrische Leistung im Betriebspunkt" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,-80})));
    Modelica.Blocks.Math.Division division1
      annotation (Placement(transformation(extent={{0,-90},{20,-70}})));

    Modelica.Blocks.Interfaces.RealOutput QEvapNom(final unit="W", final
        displayUnit="kW")
      "maximal notwendige elektrische Leistung im Betriebspunkt" annotation (
        Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,20})));
    Modelica.Blocks.Math.Add add(k2=-1)
      annotation (Placement(transformation(extent={{64,10},{84,30}})));

    Modelica.Blocks.Sources.RealExpression tHotNom(y=THotNom)
      annotation (Placement(transformation(extent={{-100,22},{-78,46}})));
    Modelica.Blocks.Sources.RealExpression tSourceNom(y=TSourceNom)
      annotation (Placement(transformation(extent={{-100,80},{-74,104}})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin3
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-36,92})));
    Modelica.Thermal.HeatTransfer.Celsius.FromKelvin fromKelvin2
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-56,34})));
    Modelica.Blocks.Sources.RealExpression qNom(y=QNom)
      annotation (Placement(transformation(extent={{-48,-84},{-32,-64}})));
    Modelica.Blocks.Sources.RealExpression qNom1(y=QNom)
      annotation (Placement(transformation(extent={{30,16},{46,36}})));
    Modelica.Blocks.Sources.RealExpression deltaTCon(y=DeltaTCon)
      annotation (Placement(transformation(extent={{12,11},{-12,-11}},
          rotation=180,
          origin={-88,57})));
    Modelica.Blocks.Routing.Multiplex4 multiplex4_1 annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-10,12})));
    SDF.NDTable SDFCOP1(
      final nin=4,
      final readFromFile=true,
      final filename=FilenameCOP,
      final dataset="\COP",
      final dataUnit="-",
      final scaleUnits={"degC","-","K","degC"},
      final interpMethod=SDF.Types.InterpolationMethod.Linear,
      final extrapMethod=SDF.Types.ExtrapolationMethod.Linear)
      "SDF-Table data for COP" annotation (Placement(transformation(
          extent={{-12,-12},{12,12}},
          rotation=-90,
          origin={-10,-20})));
    Modelica.Blocks.Sources.RealExpression PLRNom(y=1) annotation (Placement(
          transformation(
          extent={{11,12},{-11,-12}},
          rotation=180,
          origin={-89,74})));
    Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=dTConFix)
      annotation (Placement(transformation(extent={{-126,-34},{-98,-12}})));
    Modelica.Blocks.Logical.Switch switch2
      annotation (Placement(transformation(extent={{11,-11},{-11,11}},
          rotation=180,
          origin={-55,-23})));
    Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  protected
  parameter String FilenameCOP= if HighTemp==false then "D:/dja-mzu/SDF/WP/COP_Scroll_R410a.sdf" else "D:/dja-mzu/SDF/WP/COP_Hubkolben_R134a.sdf";

  equation
    connect(division1.y, PelFullLoad) annotation (Line(points={{21,-80},{110,
            -80}},              color={0,0,127}));
    connect(add.y, QEvapNom)
      annotation (Line(points={{85,20},{110,20}}, color={0,0,127}));
    connect(division1.y, add.u2) annotation (Line(points={{21,-80},{40,-80},{40,
            14},{62,14}}, color={0,0,127}));
    connect(tHotNom.y, fromKelvin2.Kelvin)
      annotation (Line(points={{-76.9,34},{-68,34}}, color={0,0,127}));
    connect(tSourceNom.y, fromKelvin3.Kelvin)
      annotation (Line(points={{-72.7,92},{-48,92}}, color={0,0,127}));
    connect(qNom.y, division1.u1)
      annotation (Line(points={{-31.2,-74},{-2,-74}}, color={0,0,127}));
    connect(add.u1, qNom1.y)
      annotation (Line(points={{62,26},{46.8,26}}, color={0,0,127}));
    connect(SDFCOP1.y, division1.u2) annotation (Line(points={{-10,-33.2},{-10,
            -86},{-2,-86}},     color={0,0,127}));
    connect(multiplex4_1.y, SDFCOP1.u)
      annotation (Line(points={{-10,1},{-10,-5.6}}, color={0,0,127}));
    connect(fromKelvin3.Celsius, multiplex4_1.u1[1]) annotation (Line(points={{-25,92},
            {-1,92},{-1,24}},                       color={0,0,127}));
    connect(PLRNom.y, multiplex4_1.u2[1])
      annotation (Line(points={{-76.9,74},{-7,74},{-7,24}}, color={0,0,127}));
    connect(deltaTCon.y, multiplex4_1.u3[1])
      annotation (Line(points={{-74.8,57},{-13,57},{-13,24}}, color={0,0,127}));
    connect(booleanExpression.y, switch2.u2)
      annotation (Line(points={{-96.6,-23},{-68.2,-23}}, color={255,0,255}));
    connect(fromKelvin2.Celsius, switch2.u3) annotation (Line(points={{-45,34},{-40,
            34},{-40,10},{-80,10},{-80,-14.2},{-68.2,-14.2}}, color={0,0,127}));
    connect(switch2.y, multiplex4_1.u4[1]) annotation (Line(points={{-42.9,-23},{-32,
            -23},{-32,38},{-19,38},{-19,24}}, color={0,0,127}));
    connect(u, switch2.u1) annotation (Line(points={{-120,-60},{-90,-60},{-90,-31.8},
            {-68.2,-31.8}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>Auslegung des Betriebspunktes indem die maximale elektrische Leistung vorliegt</p>
</html>"));
  end NominalHeatPumpNotManufacturer;

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
