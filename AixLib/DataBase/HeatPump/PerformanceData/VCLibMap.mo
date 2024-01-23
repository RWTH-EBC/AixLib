within AixLib.DataBase.HeatPump.PerformanceData;
model VCLibMap
  "Multi-dimensional performance map encompasing choices of fluid and flowsheet based on steady state calculations using the Vapour Compression Library"
  extends BaseClasses.PartialPerformanceData;
  // Parameters Heat pump operation
  parameter Modelica.Units.SI.Power QCon_flow_nominal=5000
    "Nominal heating power of heat pump"
    annotation (Dialog(group="Heat pump specification"));
  parameter String refrigerant="R410A" "Identifier for the refrigerant" annotation(Dialog(group=
          "Heat pump specification"));
  parameter String flowsheet="StandardFlowsheet" "Identifier for the flowsheet" annotation(Dialog(group=
          "Heat pump specification"));
  parameter SDF.Types.InterpolationMethod interpMethod=SDF.Types.InterpolationMethod.Linear
    "Interpolation method" annotation (Dialog(tab="SDF File", group="Parameters"));
  parameter SDF.Types.ExtrapolationMethod extrapMethod=SDF.Types.ExtrapolationMethod.Hold
    "Extrapolation method" annotation (Dialog(tab="SDF File", group="Parameters"));
    // Strings
  parameter String filename="modelica://AixLib/Resources/Data/Fluid/BaseClasses/PerformanceData/VCLibMap/VCLibMap.sdf"
    "Path to the sdf file"                                                                                        annotation(Dialog(tab="SDF File", group="File"));
  parameter String tableName_COP="COP" "String identifier in sdf table for COP"
    annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter String tableName_QCon="Q_con" "String identifier in sdf table for QCon" annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter String tableName_QConNominal="Q_flow_con_nominal" "String identifier in sdf table for QConNominal" annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter String tableName_mFlowEvaNominal="m_flow_eva" "String identifier in sdf table for mFlow_evaNominal" annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter String tableName_mFlowConNominal="m_flow_con" "String identifier in sdf table for mFlow_conNominal" annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter Modelica.Units.SI.Power Q_flowTableNom=
      SDF.Functions.readDatasetDouble(
      fileref,
      dataset_QflowNom,
      "W") "Nominal heat flow in map. Doesn't need to be changed."
    annotation (Dialog(tab="SDF File", group="Variable names"));
  parameter Real minCOP=0.1
    "Minimal possible COP value. Used to avoid division by zero error. Should never occur anyways if performance map is correctly created"
    annotation (Dialog(tab="Advanced"));
  Utilities.Logical.SmoothSwitch switchPel
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={44,-14})));
  Utilities.Logical.SmoothSwitch switchQCon
    "If HP is off, no heat will be exchanged"
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=-90,
        origin={-46,-14})));
  Modelica.Blocks.Sources.Constant constZero(final k=0)
                                             annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={4.44089e-16,10})));
  Modelica.Blocks.Sources.Constant       QScaling(k=scalingFactor)
    "Scaling for heat pump power " annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=90,
        origin={-15,45})));
  Modelica.Blocks.Math.Product product_scaling
    "Multiply nominal output power with scaling factor"
    annotation (Placement(transformation(extent={{-5,-5},{5,5}},
        rotation=270,
        origin={-31,27})));
  SDF.NDTable Table_QCon(
    final readFromFile=true,
    final dataUnit="W",
    final scaleUnits={"-","K","K"},
    final nin=3,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod,
    final filename=fileref,
    final dataset=dataset_QCon) "nD table with performance map of heat pump"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,50})));
  SDF.NDTable Table_COP(
    final readFromFile=true,
    final dataUnit="-",
    final scaleUnits={"-","K","K"},
    final nin=3,
    final interpMethod=interpMethod,
    final extrapMethod=extrapMethod,
    final filename=fileref,
    final dataset=dataset_COP) "nD table with performance map of heat pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={50,50})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-6,-6},{6,6}},
        rotation=270,
        origin={8.88178e-16,78})));
  Modelica.Blocks.Math.Division divisionPel "Divide QCon by COP to obtain Pel"
    annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=270,
        origin={39,9})));
  Modelica.Blocks.Math.Max max
    "Use max of lower COP value to avoid division by zero error" annotation (
      Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=270,
        origin={30,28})));
  Modelica.Blocks.Sources.Constant const_minCOP(k=minCOP)
    "Minimal possible COP. Used to avoid division by zero error. Should never occur anyways if performance map is correctly created"
    annotation (Placement(transformation(
        extent={{5,-5},{-5,5}},
        rotation=90,
        origin={5,45})));

protected
  parameter String fileref = Modelica.Utilities.Files.loadResource(filename);
  parameter Modelica.Units.SI.MassFlowRate mFlow_evaNominal=
      SDF.Functions.readDatasetDouble(
      fileref,
      dataset_mFlowEvaNominal,
      "kg/s") "Nominal mass flow rate";

  parameter Modelica.Units.SI.MassFlowRate mFlow_conNominal=
      SDF.Functions.readDatasetDouble(
      fileref,
      dataset_mFlowConNominal,
      "kg/s") "Nominal mass flow rate";
  parameter String dataset_COP="/" + flowsheet + "/" + refrigerant + "/" +
      tableName_COP "Path within sdf file to COP dataset"
    annotation (Dialog(group="Map"));
  parameter String dataset_QCon="/" + flowsheet + "/" + refrigerant + "/" +
      tableName_QCon "Path within sdf file to QCon dataset"
    annotation (Dialog(group="Map"));
  parameter String dataset_QflowNom="/" + flowsheet + "/" + refrigerant + "/" +
      tableName_QConNominal;
  parameter String dataset_mFlowConNominal="/" + flowsheet + "/" + refrigerant + "/"
       + tableName_mFlowConNominal;
  parameter String dataset_mFlowEvaNominal="/" + flowsheet + "/" + refrigerant + "/"
       + tableName_mFlowEvaNominal;
equation
  connect(constZero.y,switchPel. u3) annotation (Line(points={{-4.44089e-16,5.6},
          {-4.44089e-16,-2},{39.2,-2},{39.2,-6.8}},
                        color={0,0,127}));
  connect(switchPel.y, calcRedQCon.u2) annotation (Line(points={{44,-20.6},{44,-46},
          {80,-46},{80,-60.8},{76.4,-60.8}}, color={0,0,127}));
  connect(switchPel.y, Pel) annotation (Line(points={{44,-20.6},{44,-46},{0,-46},
          {0,-110}}, color={0,0,127}));
  connect(switchQCon.y, feedbackHeatFlowEvaporator.u1) annotation (Line(points={{-46,
          -20.6},{-46,-22},{-76,-22},{-76,-33.2}},      color={0,0,127}));
  connect(switchPel.y, feedbackHeatFlowEvaporator.u2) annotation (Line(points={{44,
          -20.6},{44,-46},{-68,-46},{-68,-28},{-86,-28},{-86,-38},{-80.8,-38}},
        color={0,0,127}));
  connect(constZero.y, switchQCon.u3) annotation (Line(points={{-4.44089e-16,5.6},
          {-4.44089e-16,-2},{-50.8,-2},{-50.8,-6.8}},
                                    color={0,0,127}));
  connect(multiplex3_1.y, Table_QCon.u) annotation (Line(points={{-2.22045e-16,71.4},
          {-2.22045e-16,70},{-50,70},{-50,62}}, color={0,0,127}));
  connect(multiplex3_1.y, Table_COP.u) annotation (Line(points={{-2.22045e-16,71.4},
          {0,71.4},{0,70},{50,70},{50,62}}, color={0,0,127}));
  connect(QScaling.y, product_scaling.u1) annotation (Line(points={{-15,39.5},{-15,
          36},{-28,36},{-28,33}}, color={0,0,127}));
  connect(Table_QCon.y, product_scaling.u2) annotation (Line(points={{-50,39},{-50,
          36},{-34,36},{-34,33}}, color={0,0,127}));
  connect(product_scaling.y, switchQCon.u1) annotation (Line(points={{-31,21.5},
          {-31,18},{-41.2,18},{-41.2,-6.8}},
                                           color={0,0,127}));
  connect(product_scaling.y, divisionPel.u1) annotation (Line(points={{-31,21.5},
          {-31,18},{42,18},{42,15}},                       color={0,0,127}));
  connect(divisionPel.y, switchPel.u1) annotation (Line(points={{39,3.5},{39,2},
          {48.8,2},{48.8,-6.8}},  color={0,0,127}));
  connect(divisionPel.u2, max.y) annotation (Line(points={{36,15},{30,15},{30,23.6}},
                      color={0,0,127}));
  connect(max.u1, Table_COP.y) annotation (Line(points={{32.4,32.8},{32.4,36},{50,
          36},{50,39}}, color={0,0,127}));
  connect(const_minCOP.y, max.u2) annotation (Line(points={{5,39.5},{5,36},{27.6,
          36},{27.6,32.8}}, color={0,0,127}));
  connect(multiplex3_1.u1[1], sigBus.nSet) annotation (Line(points={{4.2,85.2},
          {4.2,90},{14,90},{14,104.07},{1.075,104.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiplex3_1.u2[1],sigBus.TConInMea)  annotation (Line(points={{0,85.2},
          {0,94},{0,104.07},{1.075,104.07}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(multiplex3_1.u3[1],sigBus.TEvaInMea)  annotation (Line(points={{-4.2,85.2},
          {-4.2,88},{-14,88},{-14,104.07},{1.075,104.07}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switchPel.u2, sigBus.onOffMea) annotation (Line(points={{44,-6.8},{44,
          0},{88,0},{88,94},{1.075,94},{1.075,104.07}}, color={255,0,255}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(switchQCon.u2, sigBus.onOffMea) annotation (Line(points={{-46,-6.8},{
          -46,0},{88,0},{88,94},{0,94},{0,104.07},{1.075,104.07}}, color={255,0,
          255}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(graphics={Text(
          extent={{-84,86},{88,-88}},
          lineColor={28,108,200},
          textString="VapourCompression")}), Documentation(info="<html><p>
  This model uses tables generated by the Vapour Compression Library to
  calculate the relevant outputs of the inner refrigeration cycle.
</p>
<p>
  If of interest, contact Fabian Wüllhorst or Christian Vering for more
  information on how the maps are generated.
</p>
<p>
  The publications regarding this model are currenlty in review.
</p>
</html>", revisions="<html><ul>
<ul>
  <li>
    <i>May 05, 2021&#160;</i> by Fabian Wüllhorst:<br/>
    First implementation (see issue <a href=
    \"https://github.com/RWTH-EBC/AixLib/issues/1092\">#1092</a>)
  </li>
</ul>
</html>"));
end VCLibMap;
