within AixLib.DataBase.HeatPump.PerformanceData;
model LookUpTableND "N-dimensional table with data for heat pump"
  extends
    AixLib.DataBase.HeatPump.PerformanceData.BaseClasses.PartialPerformanceData;
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
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-22,68})));
 Modelica.Blocks.Math.UnitConversions.To_degC t_Ev_in
    annotation (extent=[-88,38; -76,50], Placement(transformation(extent={{-4,-4},
            {4,4}},
        rotation=-90,
        origin={-2,68})));
  Modelica.Blocks.Math.UnitConversions.To_degC t_Co_ou annotation (extent=[-88,38;
        -76,50], Placement(transformation(extent={{-3,-3},{3,3}},
        rotation=-90,
        origin={15,69})));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={46,-32})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-56,-32})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
    "Power if HP is turned off"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-6,-10})));
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
        origin={-46,16})));
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
        origin={50,14})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1(
    final n1=1,
    final n2=1,
    final n3=1) "Concat all inputs into an array"
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=-90,
        origin={-3,43})));

  Modelica.Blocks.Math.Product scalingFacTimesQCon annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-44,-8})));
  Modelica.Blocks.Math.Product scalingFacTimesPel annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={48,-10})));
protected
  Modelica.Blocks.Sources.Constant realCorr(final k=scalingFactor)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-3,15})));
equation

  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-6,-16.6},{-6,
          -20},{-60,-20},{-60,-24.8},{-60.8,-24.8}},
                               color={0,0,127}));
  connect(constZero.y, switchPel.u3) annotation (Line(points={{-6,-16.6},{-6,
          -20},{41.2,-20},{41.2,-24.8}},
                          color={0,0,127}));
  connect(multiplex3_1.y, nDTableQCon.u) annotation (Line(points={{-3,37.5},{-3,
          36},{-46,36},{-46,30.4}},       color={0,0,127}));
  connect(multiplex3_1.y, nDTablePel.u) annotation (Line(points={{-3,37.5},{-2,
          37.5},{-2,36},{50,36},{50,28.4}},  color={0,0,127}));
  connect(sigBus.TEvaInMea, t_Ev_in.u) annotation (Line(
      points={{1.075,104.07},{-2,104.07},{-2,72.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBus.TConOutMea, t_Co_ou.u) annotation (Line(
      points={{1.075,104.07},{15,104.07},{15,72.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(sigBus.nSet, nConGain.u) annotation (Line(
      points={{1.075,104.07},{-22,104.07},{-22,72.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(nConGain.y, multiplex3_1.u3[1]) annotation (Line(points={{-22,63.6},{
          -22,56},{-8,56},{-8,49},{-6.5,49}},                  color={0,0,127}));
  connect(t_Co_ou.y, multiplex3_1.u1[1]) annotation (Line(points={{15,65.7},{15,
          56},{0.5,56},{0.5,49}},       color={0,0,127}));
  connect(t_Ev_in.y, multiplex3_1.u2[1]) annotation (Line(points={{-2,63.6},{-2,
          49},{-3,49}},         color={0,0,127}));
  connect(realCorr.y, scalingFacTimesQCon.u1) annotation (Line(points={{-3,9.5},
          {-3,0},{-41.6,0},{-41.6,-3.2}},
                                    color={0,0,127}));
  connect(nDTableQCon.y, scalingFacTimesQCon.u2) annotation (Line(points={{-46,2.8},
          {-46,-3.2},{-46.4,-3.2}},       color={0,0,127}));
  connect(scalingFacTimesQCon.y, switchQCon.u1) annotation (Line(points={{-44,
          -12.4},{-44,-18},{-51.2,-18},{-51.2,-24.8}}, color={0,0,127}));
  connect(realCorr.y, scalingFacTimesPel.u2) annotation (Line(points={{-3,9.5},
          {-3,0},{45.6,0},{45.6,-5.2}},
                                  color={0,0,127}));
  connect(nDTablePel.y, scalingFacTimesPel.u1)
    annotation (Line(points={{50,0.8},{50,-5.2},{50.4,-5.2}},
                                                color={0,0,127}));
  connect(scalingFacTimesPel.y, switchPel.u1) annotation (Line(points={{48,
          -14.4},{48,-20},{50,-20},{50,-24},{50.8,-24},{50.8,-24.8}},
                                                color={0,0,127}));
  connect(switchPel.y, calcRedQCon.u2) annotation (Line(points={{46,-38.6},{46,
          -50},{76.4,-50},{76.4,-60.8}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{46,-38.6},{46,-64},{0,-64},
          {0,-110}}, color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points=
          {{-56,-38.6},{-72,-38.6},{-72,-28},{-76,-28},{-76,-33.2}}, color={0,0,
          127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u2) annotation (Line(points={
          {46,-38.6},{46,-50},{-66,-50},{-66,-26},{-90,-26},{-90,-38},{-80.8,
          -38}}, color={0,0,127}));
  connect(switchQCon.u2, sigBus.onOffMea) annotation (Line(points={{-56,-24.8},
          {-56,-18},{78,-18},{78,92},{1.075,92},{1.075,104.07}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switchPel.u2, sigBus.onOffMea) annotation (Line(points={{46,-24.8},{
          46,-16},{78,-16},{78,94},{1.075,94},{1.075,104.07}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
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
<ul>
  <li>
    <i>November 26, 2018&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/577\">#577</a>)
  </li>
</ul>
</html>"));
end LookUpTableND;
