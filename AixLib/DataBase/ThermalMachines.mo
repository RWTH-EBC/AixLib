within AixLib.DataBase;
package ThermalMachines "Collection of Thermal Machines Database Records"
  package Chiller "Collection of Chiller Database Records"
     extends Modelica.Icons.Package;

    record ChillerBaseDataDefinition "Basic chiller data"
        extends
        AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
                                                                    tableQdot_con = tableQdot_eva);

      parameter Real tableQdot_eva[:,:] "Cooling power table; T in degC; Q_flow in W";

      annotation (Documentation(info="<html>
<p>Base data definition extending from the <a href=\"modelica://AixLib.DataBase.HeatPump.HeatPumpBaseDataDefinition\">HeatPumpBaseDataDefinition</a>, the parameters documentation is matched for a chiller. As a result, <span style=\"font-family: Courier New;\">tableQdot_eva</span> corresponds to the cooling capacity on the evaporator side of the chiller. Furthermore, the values of the tables depend on the condenser inlet temperature (defined in first row) and the evaporator outlet temperature (defined in first column) in W. </p>
<p>The nominal mass flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",   revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"),
       Icon,     preferedView="info");
    end ChillerBaseDataDefinition;

    package PerformanceData
      "Different data models used for a black box chiller model"

      model LookUpTable2D "Performance data coming from manufacturer"
        extends
          AixLib.DataBase.ThermalMachines.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;

        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
          "Smoothness of table interpolation";
        parameter
          AixLib.DataBase.ThermalMachines.Chiller.ChillerBaseDataDefinition dataTable=
            AixLib.DataBase.ThermalMachines.Chiller.EN14511.Vitocal200AWO201()
          "Data Table of Chiller" annotation (choicesAllMatching=true);
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
        connect(sigBus.N, nTimesSF.u1) annotation (Line(
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
</html>",       info="<html>
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
          AixLib.DataBase.ThermalMachines.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;
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
        connect(sigBus.N, greaterThreshold.u) annotation (Line(
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
</html>",       revisions="<html>
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
          AixLib.DataBase.ThermalMachines.Chiller.PerformanceData.BaseClasses.PartialPerformanceData;

        replaceable function PolyData =
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct
                                                                                 "Function to calculate peformance Data" annotation(choicesAllMatching=true);
      protected
        Real Char[2];
      equation
        Char =PolyData(
            sigBus.N,
            sigBus.T_ret_ev,
            sigBus.T_flow_co,
            sigBus.m_flow_ev,
            sigBus.m_flow_co);
        if sigBus.N > Modelica.Constants.eps then
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
</html>",       info="<html>
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
            AixLib.DataBase.ThermalMachines.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;

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
</html>",       info="<html>
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
</html>",     info="<html>
<p>
  This package contains models for the grey box chiller model <a href=
  \"modelica://AixLib.Fluid.HeatPumps.HeatPump\">AixLib.Fluid.Chillers.Chiller</a>.
</p>
</html>"));
    end PerformanceData;

    package EN14511

      record Vitocal200AWO201 "Vitocal200AWO201Chilling"
        extends
          AixLib.DataBase.ThermalMachines.Chiller.ChillerBaseDataDefinition(
          tableP_ele=[0,20,25,27,30,35; 7,1380.0,1590.0,1680.0,1800.0,1970.0;
              18,950.0,1060.0,1130.0,1200.0,1350.0],
          tableQdot_eva=[0,20,25,27,30,35; 7,2540.0,2440.0,2370.0,2230.0,2170.0;
              18,5270.0,5060.0,4920.0,4610.0,4500.0],
          mFlow_conNom=3960/4180/5,
          mFlow_evaNom=(2250*1.2)/3600,
          tableUppBou=[20,20; 35,20],
          tableLowBou=[20,5; 35,5]);

        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Data&nbsp;record&nbsp;for&nbsp;type&nbsp;AWO-M/AWO-M-E-AC&nbsp;201.A04, obtained from the technical guide in the UK. <a href=\"https://professionals.viessmann.co.uk/content/dam/vi-brands/UK/PDFs/Datasheets/Vitocal%20Technical%20Guide.PDF/_jcr_content/renditions/original.media_file.download_attachment.file/Vitocal%20Technical%20Guide.PDF\">Link</a> to the datasheet</p>
</html>",       revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
      end Vitocal200AWO201;
    annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
    end EN14511;
  annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
  end Chiller;

  package HeatPump "Collection of HeatPump Database Records"
     extends Modelica.Icons.Package;

    record HeatPumpBaseDataDefinition "Basic heat pump data"
        extends Modelica.Icons.Record;
      parameter Real tableQdot_con[:,:] "Heating power table; T in degC; Q_flow in W";
      parameter Real tableP_ele[:,:] "Electrical power table; T in degC; Q_flow in W";
      parameter Modelica.SIunits.MassFlowRate mFlow_conNom
        "Nominal mass flow rate in condenser";
      parameter Modelica.SIunits.MassFlowRate mFlow_evaNom
        "Nominal mass flow rate in evaporator";
      parameter Real tableUppBou[:,2] "Points to define upper boundary for sink temperature";
      parameter Real tableLowBou[:,2] "Points to define lower boundary for sink temperature";

      annotation (Documentation(info="<html>
<h4><span style=\"color: #008000\">Overview</span></h4>
<p>Base data definition used in the heat pump model. It defines the table <span style=\"font-family: Courier New;\">table_Qdot_Co</span> which gives the condenser heat flow rate and <span style=\"font-family: Courier New;\">table_Pel</span> which gives the electric power consumption of the heat pump. Both tables define the power values depending on the evaporator inlet temperature (defined in first row) and the condenser outlet temperature (defined in first column) in W. The nominal mass flow rate in the condenser and evaporator are also defined as parameters. </p>
</html>",   revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"),    Icon,     preferedView="info");
    end HeatPumpBaseDataDefinition;

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
</html>",       info="<html>
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
</html>",       info="<html>
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
</html>",       revisions="<html>
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
</html>",       info="<html>
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
</html>",       info="<html>
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
",                origin={0.5,60.5},
                  rotation=180)}),Diagram(coordinateSystem(preserveAspectRatio=false)),
            Documentation(revisions="<html><ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>",         info="<html>
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
</html>",       info="<html>
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
</html>",     info="<html>
<p>
  This package contains models for the grey box heat pump model
  <a href=\"modelica://AixLib.Fluid.HeatPumps.HeatPump\">AixLib.Fluid.HeatPumps.HeatPump</a>.
</p>
</html>"));
    end PerformanceData;

    package EN14511

      record AlphaInnotec_LW80MA "Alpha Innotec LW 80 M-A"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-7,2,7,10,15,20; 35,2625,2424,2410,2395,2347,2322; 45,
              3136,3053,3000,2970,2912,2889; 50,3486,3535,3451,3414,3365,3385],
          tableQdot_con=[0,-7,2,7,10,15,20; 35,6300,8000,9400,10300,11850,13190;
              45,6167,7733,9000,9750,11017,11730; 50,6100,7600,8800,9475,10600,
              11000],
          mFlow_conNom=9400/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-25,65; 40,65],
          tableLowBou=[-25,0; 40,0]);

          //These boundary-tables are not from the datasheet but default values.

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to manufacturer&apos;s data which was inter- and extrapolated linearly; EN14511 </p>
</html>"));
      end AlphaInnotec_LW80MA;

      record Dimplex_LA11AS "Dimplex LA 11 AS"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-7,2,7,10; 35,2444,2839,3139,3103; 45,2783,2974,3097,
              3013],
          tableQdot_con=[0,-7,2,7,10; 35,6600,8800,11300,12100; 45,6400,7898,
              9600,10145],
          mFlow_conNom=11300/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-25,58; 35,58],
          tableLowBou=[-25,18; 35,18]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to data from Dimplex data sheets; EN14511</p>
</html>"));
      end Dimplex_LA11AS;

      record Ochsner_GMLW_19 "Ochsner GMLW 19"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-10,2,7; 35,4300,4400,4600; 50,6300,6400,6600],
          tableQdot_con=[0,-10,2,7; 35,11600,17000,20200; 50,10200,15600,18800],
          mFlow_conNom=20200/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-15,55; 40,55],
          tableLowBou=[-15,0; 40,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to data from Ochsner data sheets; EN14511</p>
</html>"));
      end Ochsner_GMLW_19;

      record Ochsner_GMLW_19plus "Ochsner GMLW 19 plus"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-10,2,7; 35,4100,4300,4400; 50,5500,5700,5800; 60,6300,
              6500,6600],
          tableQdot_con=[0,-10,2,7; 35,12600,16800,19800; 50,11700,15900,18900;
              60,11400,15600,18600],
          mFlow_conNom=19800/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-24,52; -15,55; -10,65; 40,65],
          tableLowBou=[-24,0; 40,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to data from Ochsner data sheets; EN14511</p>
</html>"));
      end Ochsner_GMLW_19plus;

      record Ochsner_GMSW_15plus "Ochsner GMSW 15 plus"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-5,0,5; 35,3225,3300,3300; 45,4000,4000,4000; 55,4825,
              4900,4900],
          tableQdot_con=[0,-5,0,5; 35,12762,14500,16100; 45,12100,13900,15600;
              55,11513,13200,14900],
          mFlow_conNom=14500/4180/5,
          mFlow_evaNom=(14500 - 3300)/3600/3,
          tableUppBou=[-8,52; 0,65; 20,65],
          tableLowBou=[-8,10; 20,27]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to data from WPZ Buchs, Swiss; EN14511 </p>
</html>"));
      end Ochsner_GMSW_15plus;

      record StiebelEltron_WPL18 "Stiebel Eltron WPL 18"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-7,2,7,10,20; 35,3300,3400,3500,3700,3800; 50,4500,4400,
              4600,5000,5100],
          tableQdot_con=[0,-7,2,7,10,20; 35,9700,11600,13000,14800,16300; 50,
              10000,11200,12900,16700,17500],
          mFlow_conNom=13000/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-25,65; 40,65],
          tableLowBou=[-25,0; 40,0]);
          //These boundary-tables are not from the datasheet but default values.

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",       info="<html>
<p>According to data from WPZ Buchs, Swiss; EN14511</p>
</html>"));
      end StiebelEltron_WPL18;

      record Vaillant_VWL_101 "Vaillant VWL10-1"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-15,-7,2,7; 35,2138,2177,2444,2444; 45,2558,2673,2864,
              3055; 55,2902,3131,3360,3513],
          tableQdot_con=[0,-15,-7,2,7; 35,5842,7523,9776,10807; 45,5842,7332,
              9050,10387; 55,5728,7179,9050,10043],
          mFlow_conNom=9776/4180/5,
          mFlow_evaNom=1,
          tableUppBou=[-25,65; 40,65],
          tableLowBou=[-25,0; 40,0]);
          //These boundary-tables are not from the datasheet but default values.

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>",info="<html>
<p>According to data from Vaillant data sheets; EN14511 </p>
</html>"));
      end Vaillant_VWL_101;

      record Vitocal200AWO201
        "Vitocal200AWO201"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-15,-7,2,7,10,20,30; 35,1290.0,1310.0,730.0,870.0,850.0,
              830.0,780.0; 45,1550.0,1600.0,870.0,1110.0,1090.0,1080.0,1040.0;
              55,1870.0,1940.0,1170.0,1370.0,1370.0,1370.0,1350.0],
          tableQdot_con=[0,-15,-7,2,7,10,20,30; 35,3020,3810,2610,3960,4340,
              5350,6610; 45,3020,3780,2220,3870,4120,5110,6310; 55,3120,3790,
              2430,3610,3910,4850,6000],
          mFlow_conNom=3960/4180/5,
          mFlow_evaNom=(2250*1.2)/3600,
          tableUppBou=[-20,50; -10,60; 30,60; 35,55],
          tableLowBou=[-20,25; 25,25; 35,35]);

        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p><span style=\"font-family: Courier New; color: #006400;\">Data&nbsp;record&nbsp;for&nbsp;type&nbsp;AWO-M/AWO-M-E-AC&nbsp;201.A04, obtained from the technical guide in the UK.</span></p>
</html>",       revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
      end Vitocal200AWO201;
    end EN14511;

    package EN255

      record AlphaInnotec_SW170I "Alpha Innotec SW 170 I"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-5.0,0.0,5.0; 35,3700,3600,3600; 50,5100,5100,5100],
          tableQdot_con=[0,-5.0,0.0,5.0; 35,14800,17200,19100; 50,14400,16400,
              18300],
          mFlow_conNom=17200/4180/10,
          mFlow_evaNom=13600/3600/3,
          tableUppBou=[-22,65; 45,65],
          tableLowBou=[-22,0; 45,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(info="<html>
<p>According to data from WPZ Buchs, Swiss; EN 255. </p>
</html>",       revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>"));
      end AlphaInnotec_SW170I;

      record NibeFighter1140_15 "Nibe Fighter 1140-15"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-5.0,0.0,2,5.0,10; 35,3360,3380,3380,3390,3400; 55,4830,
              4910,4940,4990,5050],
          tableQdot_con=[0,-5.0,0.0,2,5.0,10; 35,13260,15420,16350,17730,19930;
              55,12560,14490,15330,16590,18900],
          mFlow_conNom=15420/4180/10,
          mFlow_evaNom=(15420 - 3380)/3600/3,
          tableUppBou=[-35,65; 50,65],
          tableLowBou=[-35,0; 50,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(info="<html>
<p>According to manufacturer&apos;s data; EN 255. </p>
</html>",       revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>"));
      end NibeFighter1140_15;

      record Vitocal350AWI114 "Vitocal 350 AWI 114"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-20,-15,-10,-5,0,5,10,15,20,25,30; 35,3295.500,3522.700,
              3750,3977.300,4034.100,4090.900,4204.500,4375,4488.600,4488.600,
              4545.500; 50,4659.100,4886.400,5113.600,5227.300,5511.400,
              5568.200,5738.600,5909.100,6022.700,6250,6477.300; 65,0,6875,
              7159.100,7500,7727.300,7897.700,7954.500,7954.500,8181.800,
              8409.100,8579.500],
          tableQdot_con=[0,-20,-15,-10,-5,0,5,10,15,20,25,30; 35,9204.500,
              11136.40,11477.30,12215.90,13863.60,15056.80,16931.80,19090.90,
              21250,21477.30,21761.40; 50,10795.50,11988.60,12215.90,13068.20,
              14545.50,15681.80,17613.60,20284.10,22500,23181.80,23863.60; 65,0,
              12954.50,13465.90,14431.80,15965.90,17386.40,19204.50,21250,
              22897.70,23863.60,24886.40],
          mFlow_conNom=15400/4180/10,
          mFlow_evaNom=1,
          tableUppBou=[-20,55; -5,65; 35,65],
          tableLowBou=[-20,0; 35,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(info="<html>
<p>Data from manufacturer&apos;s data sheet (Viessmann). These exact curves are given in the data sheet for measurement procedure according to EN 255. </p>
</html>",       revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>"));
      end Vitocal350AWI114;

      record Vitocal350BWH110 "Vitocal 350 BWH 110"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,2478,2522,2609,2696,2783; 45,
              3608,3652,3696,3739,3783; 55,4217,4261,4304,4348,4391; 65,5087,
              5130,5174,5217,5261],
          tableQdot_con=[0,-5.0,0.0,5.0,10.0,15.0; 35,9522,11000,12520,14000,
              15520; 45,11610,12740,13910,15090,16220; 55,11610,12740,13910,
              15090,16220; 65,11610,12740,13910,15090,16220],
          mFlow_conNom=11000/4180/10,
          mFlow_evaNom=8400/3600/3,
          tableUppBou=[-5,55; 25,55],
          tableLowBou=[-5,0; 25,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(info="<html>
<p>Data from manufacturer&apos;s data sheet (Viessmann). These exact curves are given in the data sheet for measurement procedure according to EN 255. </p>
</html>",       revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>"));
      end Vitocal350BWH110;

      record Vitocal350BWH113 "Vitocal 350 BWH 113"
        extends
          AixLib.DataBase.ThermalMachines.HeatPump.HeatPumpBaseDataDefinition(
          tableP_ele=[0,-5.0,0.0,5.0,10.0,15.0; 35,3750,3750,3750,3750,3833; 45,
              4833,4917,4958,5042,5125; 55,5583,5667,5750,5833,5958; 65,7000,
              7125,7250,7417,7583],
          tableQdot_con=[0,-5.0,0.0,5.0,10.0,15.0; 35,14500,16292,18042,19750,
              21583; 45,15708,17167,18583,20083,21583; 55,15708,17167,18583,
              20083,21583; 65,15708,17167,18583,20083,21583],
          mFlow_conNom=16292/4180/10,
          mFlow_evaNom=12300/3600/3,
          tableUppBou=[-5,55; 25,55],
          tableLowBou=[-5,0; 25,0]);

        annotation(preferedView="text", DymolaStoredErrors,
          Icon,
          Documentation(info="<html>
<p>Data from manufacturer&apos;s data sheet (Viessmann). These exact curves are given in the data sheet for measurement procedure according to EN 255. </p>
</html>",       revisions="<html>
<ul>
 <li><i>Oct 14, 2016&nbsp;</i> by Philipp Mehrfeld:<br/>Transferred to AixLib.</li>
</ul>
</html>"));
      end Vitocal350BWH113;
    end EN255;

    package Functions "Functions for AixLib.Fluid.HeatPumps"
    extends Modelica.Icons.Package;
      package Characteristics
        extends Modelica.Icons.Package;

        function ConstantCoP "Constant CoP and constant electric power"
          extends
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct(
            N,
            T_con,
            T_eva,
            mFlow_eva,
            mFlow_con);
            parameter Modelica.SIunits.Power powerCompressor=2000
            "Constant electric power input for compressor";
            parameter Real CoP "Constant CoP";
        algorithm
          Char:= {powerCompressor,powerCompressor*CoP};

          annotation (Documentation(info="<html>
<p>Carnot CoP and constant electric power, no dependency on speed or mass flow rates!</p>
</html>",   revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
        end ConstantCoP;

        function ConstantQualityGrade
          "Carnot CoP multiplied with constant quality grade and constant electric power"
          extends
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.Characteristics.PartialBaseFct(
            N,
            T_con,
            T_eva,
            mFlow_eva,
            mFlow_con);
            parameter Real qualityGrade=0.3 "Constant quality grade";
            parameter Modelica.SIunits.Power P_com=2000
            "Constant electric power input for compressor";
        protected
            Real CoP_C "Carnot CoP";
        algorithm
          CoP_C:=T_con/(T_con - T_eva);
          Char:= {P_com,P_com*CoP_C*qualityGrade};

          annotation (Documentation(info="<html>
<p>Carnot CoP multiplied with constant quality grade and constant electric power, no dependency on speed or mass flow rates! </p>
</html>",   revisions="<html>
<ul>
<li><i>June 21, 2015&nbsp;</i> by Kristian Huchtemann:<br/>implemented</li>
</ul>
</html>
"));
        end ConstantQualityGrade;

        partial function PartialBaseFct "Base class for Cycle Characteristic"
          extends Modelica.Icons.Function;
          input Real N "Relative compressor speed";
          input Real T_con "Condenser outlet temperature";
          input Real T_eva "Evaporator inlet temperature";
          input Real mFlow_eva "Mass flow rate at evaporator";
          input Real mFlow_con "Mass flow rate at condenser";
          output Real Char[2] "Array with [Pel, QCon]";

          annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. It defines the inputs speed N (1/min), condenser outlet temperature T_co (K) and evaporator inlet temperature T_ev (K). The output is the vector Char: first value is compressor power, second value is the condenser heat flow rate. </p>
</html>",   revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>
"));
        end PartialBaseFct;

        function CarnotFunction
          "Function to emulate the polynomal approach of the Carnot_y heat pump model"
          extends PartialBaseFct;
          parameter Modelica.SIunits.Power Pel_nominal=2000
            "Constant nominal electric power";
          parameter Real etaCarnot_nominal(unit="1") = 0.5
              "Carnot effectiveness (=COP/COP_Carnot) used if use_eta_Carnot_nominal = true"
              annotation (Dialog(group="Efficiency", enable=use_eta_Carnot_nominal));

          parameter Real a[:] = {1}
            "Coefficients for efficiency curve (need p(a=a, yPL=1)=1)"
            annotation (Dialog(group="Efficiency"));
        protected
          Modelica.SIunits.Power Pel;
          Real COP;
          Real COP_carnot;
          Real etaPartLoad = AixLib.Utilities.Math.Functions.polynomial(a=a, x=N);
        algorithm
          assert(abs(T_con - T_eva)>Modelica.Constants.eps, "Temperatures have to differ to calculate the Carnot efficiency", AssertionLevel.warning);
          COP_carnot :=T_con/(T_con - T_eva);
          Pel :=Pel_nominal*N;
          COP :=etaCarnot_nominal*etaPartLoad*COP_carnot;
          Char[1] :=Pel;
          Char[2] :=COP*Pel;
          annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",         info="<html>
<p>This function emulated the the Carnot model (<a href=\"modelica://AixLib.Fluid.Chillers.BaseClasses.Carnot\">AixLib.Fluid.Chillers.BaseClasses.Carnot</a>). See this description for more info on assumptions etc.</p>
</html>"));
        end CarnotFunction;

        function PolynomalApproach
          "Function to emulate the polynomal approach of the TRNSYS Type 401 heat pump model"
          extends PartialBaseFct;
          parameter Modelica.SIunits.Power p[6] = {0,0,0,0,0,0}
            "Polynomal coefficient for the electrical power";
          parameter Modelica.SIunits.HeatFlowRate q[6] = {0,0,0,0,0,0}
            "Polynomal coefficient for the condenser heat flow";

        protected
          Real TEva_n = T_eva/273.15 + 1 "Normalized evaporator temperature";
          Real TCon_n = T_con/273.15 + 1 "Normalized condenser temperature";
        algorithm
          if N >= Modelica.Constants.eps then
            Char[1] := p[1] + p[2]*TEva_n + p[3]*TCon_n + p[4]*TCon_n*TEva_n + p[5]*TEva_n^2 + p[6]*TCon_n^2; //Pel
            Char[2] := q[1] + q[2]*TEva_n + q[3]*TCon_n + q[4]*TCon_n*TEva_n + q[5]*TEva_n^2 + q[6]*TCon_n^2; //QCon
          else //Maybe something better could be used such as smooth()
            Char[1] := 0;
            Char[2] := 0;
          end if;
          annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",         info="<html>
<p>Based on the work of Afjej and Wetter, 1997 [1] and the TRNYS Type 401 heat pump model, this function uses a six-coefficient polynom to calculate the electrical power and the heat flow to the condenser. The coefficients are calculated based on the data in DIN EN 14511 with a minimization-problem in python using the root-mean-square-error.</p>
<p>The normalized input temperatures are calculated with the formular:</p>
<p align=\"center\"><i>T_n = (T/273.15) + 1</i></p>
<p>The coefficients for the polynomal functions are stored inside the record for heat pumps in <a href=\"modelica://AixLib.DataBase.HeatPump\">AixLib.DataBase.HeatPump</a>.</p>
<p>[1]: https://www.trnsys.de/download/en/ts_type_401_en.pdf</p>
</html>"));
        end PolynomalApproach;
      end Characteristics;

      package DefrostCorrection
         extends Modelica.Icons.Package;

        function NoModel "No model"
          extends
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.DefrostCorrection.PartialBaseFct(
              T_eva);

        algorithm
        f_CoPicing:=1;

          annotation (Documentation(info="<html>
<p>No correction factor for icing/defrosting: f_cop_icing=1. </p>
</html>", revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
        end NoModel;

        partial function PartialBaseFct
          "Base class for correction model, icing and defrosting of evaporator"
          extends Modelica.Icons.Function;
          input Real T_eva;
          output Real f_CoPicing;
          annotation (Documentation(info="<html>
<p>Base funtion used in HeatPump model. Input is the evaporator inlet temperature, output is a CoP-correction factor f_cop_icing. </p>
</html>", revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
        end PartialBaseFct;

        function WetterAfjei1996
          "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
          extends
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.DefrostCorrection.PartialBaseFct(
              T_eva);

        parameter Real A=0.03;
        parameter Real B=-0.004;
        parameter Real C=0.1534;
        parameter Real D=0.8869;
        parameter Real E=26.06;
        protected
        Real factor;
        Real linear_term;
        Real gauss_curve;
        algorithm
        linear_term:=A + B*T_eva;
        gauss_curve:=C*Modelica.Math.exp(-(T_eva - D)*(T_eva - D)/E);
        if linear_term>0 then
          factor:=linear_term + gauss_curve;
        else
          factor:=gauss_curve;
        end if;
        f_CoPicing:=1-factor;
          annotation (Documentation(info="<html>
<p>Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996. </p>
</html>", revisions="<html>
<ul>
<li><i>December 10, 2013&nbsp;</i> by Ole Odendahl:<br/>Formatted documentation appropriately</li>
</ul>
</html>"));
        end WetterAfjei1996;
      end DefrostCorrection;

      package IcingFactor "Package with functions to calculate current icing factor on evaporator"
        function BasicIcingApproach
          "A function which utilizes the outdoor air temperature and current heat flow from the evaporator"
          extends PartialBaseFct;
        algorithm
          //Just a placeholder for a future icing function
          iceFac :=1;

          annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",         info="<html>
<p>This function can be used to implement a simple icing approach, e.g. based on outdoor air temperature or time based.</p>
</html>"));
        end BasicIcingApproach;

        partial function PartialBaseFct "Base function for all icing factor functions"
          extends Modelica.Icons.Function;
          input Modelica.SIunits.ThermodynamicTemperature T_flow_ev "Evaporator supply temperature";
          input Modelica.SIunits.ThermodynamicTemperature T_ret_ev "Evaporator return temperature";
          input Modelica.SIunits.ThermodynamicTemperature T_oda "Outdoor air temperature";
          input Modelica.SIunits.MassFlowRate m_flow_ev "Mass flow rate at the evaporator";
          output Real iceFac(min=0, max=1) "Icing factor, normalized value between 0 and 1";

          annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",         info="<html>
<p>Base function for calculation of the icing factor. The normalized value represents reduction of heat exchange as a result of icing of the evaporator.</p>
</html>"));
        end PartialBaseFct;

        function WetterAfjei1996
          "Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996"
          extends
            AixLib.DataBase.ThermalMachines.HeatPump.Functions.IcingFactor.PartialBaseFct;

        parameter Real A=0.03;
        parameter Real B=-0.004;
        parameter Real C=0.1534;
        parameter Real D=0.8869;
        parameter Real E=26.06;
        protected
        Real factor;
        Real linear_term;
        Real gauss_curve;
        algorithm
        linear_term:=A + B*T_flow_ev;
        gauss_curve:=C*Modelica.Math.exp(-(T_flow_ev - D)*(T_flow_ev - D)/E);
        if linear_term>0 then
          factor:=linear_term + gauss_curve;
        else
          factor:=gauss_curve;
        end if;
        iceFac:=1-factor;
          annotation (Documentation(info="<html>
<p>Correction of CoP (Icing, Defrost) according to Wetter,Afjei 1996.</p>
</html>", revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
        end WetterAfjei1996;
      annotation (Documentation(revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>",       info="<html>
<p>This package contains functions for calculation of an icing factor used in <a href=\"modelica://AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock\">AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData.IcingBlock</a>.</p>
</html>"));
      end IcingFactor;
    end Functions;
  end HeatPump;
end ThermalMachines;
