within AixLib.Fluid.HeatPumps.BaseClasses.PerformanceData;
model LookUpTableND "N-dimensional table with data for heat pump"
  extends BaseClasses.PartialPerformanceData;
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
        origin={-80,-94})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={50,-70})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-50,-68})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={0,-6})));
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
  Modelica.Blocks.Math.Product nTimesSF
    "Create the product of the scaling factor and relative compressor speed"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={-43,-41})));
  Modelica.Blocks.Math.Product nTimesSF1
    "Create the product of the scaling factor and relative compressor speed"
    annotation (Placement(transformation(
        extent={{-7,-7},{7,7}},
        rotation=-90,
        origin={59,-43})));
protected
  Modelica.Blocks.Sources.Constant       realCorr(final k=scalingFactor)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={-65,-23})));
  Modelica.Blocks.Sources.Constant       realCorr1(final k=scalingFactor)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(transformation(
        extent={{-3,-3},{3,3}},
        rotation=270,
        origin={75,-19})));
equation
  connect(feedbackHeatFlowEvaporator.y, QEva)
    annotation (Line(points={{-80,-99.4},{-80,-110},{80,-110}},
                                                color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{50,-81},{50,-82},{0,-82},
          {0,-110}},
               color={0,0,127}));
  connect(switchQCon.y, QCon) annotation (Line(points={{-50,-79},{-50,-82},{-80,
          -82},{-80,-110}},
                      color={0,0,127}));

  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-1.33227e-15,
          -12.6},{-1.33227e-15,-20},{0,-20},{0,-26},{-58,-26},{-58,-56}},
                               color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{-1.33227e-15,
          -12.6},{-1.33227e-15,-26},{42,-26},{42,-58}},
                          color={0,0,127}));
  connect(multiplex3_1.y, nDTableQCon.u) annotation (Line(points={{-1.55431e-15,
          11.2},{-1.55431e-15,4.4},{-42,4.4}},
                                          color={0,0,127}));
  connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-1.77636e-15,11.2},
          {-1.77636e-15,4.4},{50,4.4}},      color={0,0,127}));
  connect(sigBusHP.T_flow_ev, t_Ev_in.u) annotation (Line(
      points={{1.075,104.07},{46,104.07},{46,51.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.T_ret_co, t_Co_ou.u) annotation (Line(
      points={{1.075,104.07},{-40,104.07},{-40,53.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBusHP.N, greaterThreshold.u) annotation (Line(
      points={{1.075,104.07},{-72,104.07},{-72,53.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(greaterThreshold.y, switchQCon.u2) annotation (Line(points={{-72,39.4},
          {-72,-50},{-50,-50},{-50,-56}}, color={255,0,255}));
  connect(greaterThreshold.y, switchPel.u2) annotation (Line(points={{-72,39.4},
          {-72,-50},{50,-50},{50,-58}}, color={255,0,255}));
  connect(sigBusHP.N, nConGain.u) annotation (Line(
      points={{1.075,104.07},{1.77636e-15,104.07},{1.77636e-15,77.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(t_Co_ou.y, multiplex3_1.u1[1]) annotation (Line(points={{-40,39.4},{
          -40,36},{5.6,36},{5.6,29.6}}, color={0,0,127}));
  connect(t_Ev_in.y, multiplex3_1.u2[1]) annotation (Line(points={{46,37.4},{46,
          32},{0,32},{0,29.6}}, color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u2) annotation (Line(points={{50,-81},
          {50,-82},{-90,-82},{-90,-94},{-84.8,-94}},          color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{-50,-79},
          {-50,-82},{-80,-82},{-80,-89.2}},            color={0,0,127}));
  connect(nConGain.y, multiplex3_1.u3[1]) annotation (Line(points={{0,59.2},{-4,
          59.2},{-4,29.6},{-5.6,29.6}}, color={0,0,127}));
  connect(realCorr.y, nTimesSF.u2) annotation (Line(points={{-65,-26.3},{-65,
          -26.15},{-47.2,-26.15},{-47.2,-32.6}}, color={0,0,127}));
  connect(nDTableQCon.y, nTimesSF.u1) annotation (Line(points={{-42,-23.2},{-40,
          -23.2},{-40,-32.6},{-38.8,-32.6}}, color={0,0,127}));
  connect(nTimesSF.y, switchQCon.u1) annotation (Line(points={{-43,-48.7},{-43,
          -52.35},{-42,-52.35},{-42,-56}}, color={0,0,127}));
  connect(nTimesSF1.y, switchPel.u1) annotation (Line(points={{59,-50.7},{59,
          -54.35},{58,-54.35},{58,-58}}, color={0,0,127}));
  connect(realCorr1.y, nTimesSF1.u1) annotation (Line(points={{75,-22.3},{75,
          -32},{63.2,-32},{63.2,-34.6}}, color={0,0,127}));
  connect(nDTablePel.y, nTimesSF1.u2) annotation (Line(points={{50,-23.2},{52,
          -23.2},{52,-34.6},{54.8,-34.6}}, color={0,0,127}));
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
          lineColor={0,0,0})}),                Documentation(info="<html>
<p>Basic models showing the concept of using n-dimensional table data for the innerCycle of the heat pump model. This model assumes one provides data for inverter controlled heat pumps or chillers. However, this basis structure can be used to create own models, where electrical power and condenser depend on other inputs, such as ambient temperature.</p>
</html>", revisions="<html>
<ul>
<li>
<i>November 26, 2018&nbsp;</i> by Fabian Wüllhorst: <br/>
First implementation (see issue <a href=\"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
</li>
</ul>
</html>"));
end LookUpTableND;
