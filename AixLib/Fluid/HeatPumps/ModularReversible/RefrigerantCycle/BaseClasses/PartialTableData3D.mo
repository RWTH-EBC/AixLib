within AixLib.Fluid.HeatPumps.ModularReversible.RefrigerantCycle.BaseClasses;
partial model PartialTableData3D
  "Partial model with components for TableData3D approach for heat pumps and chillers"
  parameter Real scaFac "Scaling factor";
  parameter String filename "File name of sdf table data"
    annotation (Dialog(loadSelector(filter="SDF Files (*.sdf);;All Files (*.*)", caption="Select SDF file")));

  parameter Real nConv=100
    "Gain value multiplied with relative compressor speed n to calculate matching value based on sdf tables";
  parameter SDF.Types.InterpolationMethod interpMethod=SDF.Types.InterpolationMethod.Linear
    "Interpolation method";
  parameter SDF.Types.ExtrapolationMethod extrapMethod=SDF.Types.ExtrapolationMethod.None
    "Extrapolation method";
  parameter String datasetPEle="/Pel" "Dataset name"
    annotation (Dialog(group="Electrical Power"));
  parameter String dataUnitPEle="W" "Data unit"
    annotation (Dialog(group="Electrical Power"));
  parameter String scaleUnitsPEle[3]={"K","K",""} "Scale units"
    annotation (Dialog(group="Electrical Power"));

  parameter String datasetQUse_flow="/QCon" "Dataset name"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String dataUnitQUse_flow="W" "Data unit"
    annotation (Dialog(group="Condenser heat flow"));
  parameter String scaleUnitsQUse_flow[3]={"K","K",""} "Scale units"
    annotation (Dialog(group="Condenser heat flow"));

  parameter Boolean use_TEvaOutForTab=true
    "=true to use evaporator outlet temperature, false for inlet";
  parameter Boolean use_TConOutForTab=true
    "=true to use condenser outlet temperature, false for inlet";

  Modelica.Blocks.Math.Product scaFacTimPel "Scale electrical power consumption"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,2})));
  Modelica.Blocks.Math.Product scaFacTimQUse_flow "Scale useful heat flow rate"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,2})));
  Modelica.Blocks.Sources.Constant constScaFac(final k=scaFac)
    "Calculates correction of table output based on scaling factor"
    annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, rotation=0,
        origin={-90,30})));

  Modelica.Blocks.Routing.RealPassThrough reaPasThrTEvaIn if (not useInRevDev and not use_TEvaOutForTab) or (useInRevDev and not use_TConOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConIn if (not useInRevDev and not use_TConOutForTab) or (useInRevDev and not use_TEvaOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTEvaOut if (not useInRevDev and use_TEvaOutForTab) or (useInRevDev and use_TConOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,90})));
  Modelica.Blocks.Routing.RealPassThrough reaPasThrTConOut if (not useInRevDev and use_TConOutForTab) or (useInRevDev and use_TEvaOutForTab)
    "Used to enable conditional bus connection" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,90})));

  Modelica.Blocks.Math.Gain nConGain(final k=nConv)
    "Convert relative speed n to an absolute value for interpolation in sdf tables"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-80,90})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1(
    final n1=1,
    final n2=1,
    final n3=1) "Concat all inputs into an array"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,50})));
  SDF.NDTable nDTabQUse(
    final nin=3,
    final readFromFile=true,
    final filename=filename,
    final dataset=datasetQUse_flow,
    final dataUnit=dataUnitQUse_flow,
    final scaleUnits=scaleUnitsQUse_flow,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod) "SDF-Table data for condenser heat flow"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={48,40})));
  SDF.NDTable nDTabPel(
    final nin=3,
    final readFromFile=true,
    final filename=filename,
    final dataset=datasetPEle,
    final dataUnit=dataUnitPEle,
    final scaleUnits=scaleUnitsPEle,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod) "SDF table data for electrical power"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-10,40})));
protected
  parameter Boolean useInRevDev "=true to indicate usage in reversed operation";
  parameter Integer numRow=size(tabPEle.table, 1) "Number of rows in table";
  parameter Integer numCol=size(tabPEle.table, 2) "Number of columns in table";
  parameter Modelica.Units.SI.TemperatureDifference dTMin=3
    "Minimal temperature spread according to EN 14511";
  parameter Modelica.Units.SI.TemperatureDifference dTMax=10
    "Maximal temperature spread according to EN 14511";
  parameter Modelica.Units.SI.Power valTabPEle[numRow-1, numCol - 1]=
    {{tabPEle.table[j, i] for i in 2:numCol} for j in 2:numRow}
    "Table with electrical power values only";
  parameter Modelica.Units.SI.HeatFlowRate valTabQCon_flow[numRow-1, numCol - 1]
    "Table with condenser heat flow values only";
  parameter Modelica.Units.SI.HeatFlowRate valTabQEva_flow[numRow-1, numCol - 1]
    "Table with evaporator heat flow values only";
  parameter Modelica.Blocks.Types.ExternalCombiTable2D tabIdeQUse_flow=
      Modelica.Blocks.Types.ExternalCombiTable2D(
      "NoName",
      "NoName",
      tabQUse_flow.table,
      smoothness,
      extrapolation,
      false) "External table object for nominal useful side conditions";
  parameter Modelica.Blocks.Types.ExternalCombiTable2D tabIdePEle=
      Modelica.Blocks.Types.ExternalCombiTable2D(
      "NoName",
      "NoName",
      tabPEle.table,
      smoothness,
      extrapolation,
      false) "External table object for nominal electrical power consumption";

equation
  connect(multiplex3_1.y, nDTabQUse.u) annotation (Line(points={{20,39},{20,38},
          {34,38},{34,62},{48,62},{48,52}},
                            color={0,0,127}));
  connect(multiplex3_1.y, nDTabPel.u) annotation (Line(points={{20,39},{20,38},
          {6,38},{6,52},{-10,52}},
                             color={0,0,127}));
  connect(nConGain.y, multiplex3_1.u3[1]) annotation (Line(points={{-80,79},{
          -80,62},{13,62}},           color={0,0,127}));
  connect(nDTabPel.y, scaFacTimPel.u1) annotation (Line(points={{-10,29},{-10,22},
          {-34,22},{-34,14}}, color={0,0,127}));
  connect(nDTabQUse.y, scaFacTimQUse_flow.u1) annotation (Line(points={{48,29},{
          48,30},{46,30},{46,14}}, color={0,0,127}));
  connect(constScaFac.y, scaFacTimPel.u2) annotation (Line(points={{-79,30},{-54,
          30},{-54,20},{-48,20},{-48,14},{-46,14}}, color={0,0,127}));
  connect(constScaFac.y, scaFacTimQUse_flow.u2) annotation (Line(points={{-79,30},
          {-54,30},{-54,20},{26,20},{26,14},{34,14}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
            -120},{120,120}})),
    Documentation(info="<html>
<p>
  Partial model for equations and componenents used in both heat pump
  and chiller models using two-dimensional data.
</p>
</html>", revisions="<html>
<ul><li>
    <i>October 2, 2022</i> by Fabian Wuellhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/ibpsa/modelica-ibpsa/issues/1576\">#1576</a>)
  </li></ul>
</html>"),
    Icon(coordinateSystem(extent={{-120,-120},{120,120}})));
end PartialTableData3D;
