within AixLib.Fluid.Examples.ERCBuilding.Control;
model HeattransferHT_Test
    replaceable package Water = AixLib.Media.Water;
  HeattransferHT heattransferHT
    annotation (Placement(transformation(extent={{-26,34},{18,-4}})));
  AixLib.Fluid.Sources.MassFlowSource_T NTflow(
    redeclare package Medium = Water,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{52,-32},{32,-12}})));
  Modelica.Blocks.Sources.CombiTimeTable Toutdoor(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    tableName="Toutdoor",
    table=[0,273.15; 31536000,273.15],
    tableOnFile=true,
    fileName="T:/fst/Modelica/Dymola/InputDataHochtemperaturtest/Toutdoor.mat")
    annotation (Placement(transformation(extent={{-98,-50},{-68,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable tflowNT(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,273.15; 31536000,273.15],
    tableOnFile=true,
    tableName="tflowNT",
    fileName="T:/fst/Modelica/Dymola/InputDataHochtemperaturtest/tflowNT.mat")
    annotation (Placement(transformation(extent={{158,-80},{128,-50}})));
  Modelica.Blocks.Sources.CombiTimeTable mflowNT(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,273.15; 31536000,273.15],
    tableOnFile=true,
    tableName="mflowNT",
    fileName="T:/fst/Modelica/Dymola/InputDataHochtemperaturtest/mflowNT.mat")
    annotation (Placement(transformation(extent={{156,-14},{126,16}})));
  AixLib.Fluid.Sources.Boundary_pT geoSink(redeclare package Medium = Water,
      nPorts=1) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={-17,-75})));
  Modelica.Blocks.Sources.CombiTimeTable WT03Requirement(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,273.15; 31536000,273.15],
    tableOnFile=true,
    tableName="WT03Requirement",
    fileName="T:/fst/Modelica/Dymola/InputDataHochtemperaturtest/WT03Requirement.mat")
    annotation (Placement(transformation(extent={{-96,40},{-66,70}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-56,46},{-36,66}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin
    annotation (Placement(transformation(extent={{108,-52},{88,-32}})));
  Modelica.Thermal.HeatTransfer.Celsius.ToKelvin toKelvin1
    annotation (Placement(transformation(extent={{-54,-14},{-34,6}})));
  Modelica.Fluid.Sensors.TemperatureTwoPort TflowWT03SIM(redeclare package
      Medium = Water) annotation (Placement(transformation(
        extent={{5,-4},{-5,4}},
        rotation=90,
        origin={-17,-26})));
  Modelica.Blocks.Sources.CombiTimeTable tflowWT03(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    columns={2},
    table=[0,273.15; 31536000,273.15],
    tableOnFile=true,
    tableName="tflowWT03",
    fileName=
        "T:/fst/Modelica/Dymola/InputDataHochtemperaturtest/tflowWT03.mat")
    annotation (Placement(transformation(extent={{82,46},{112,76}})));
equation
  connect(NTflow.ports[1], heattransferHT.port_a) annotation (Line(points={{32,-22},
          {20,-22},{20,-3.924},{15.1481,-3.924}}, color={0,127,255}));
  connect(heattransferHT.WT03Requirement, realToInteger.y) annotation (Line(
        points={{-25.3481,27.92},{-34,27.92},{-34,56},{-35,56}}, color={255,127,
          0}));
  connect(WT03Requirement.y[1], realToInteger.u) annotation (Line(points={{-64.5,
          55},{-62,55},{-62,56},{-58,56}}, color={0,0,127}));
  connect(tflowNT.y[1], toKelvin.Celsius) annotation (Line(points={{126.5,
          -65},{125.25,-65},{125.25,-42},{110,-42}}, color={0,0,127}));
  connect(toKelvin.Kelvin, NTflow.T_in) annotation (Line(points={{87,-42},{
          70,-42},{70,-18},{54,-18}}, color={0,0,127}));
  connect(mflowNT.y[1], NTflow.m_flow_in) annotation (Line(points={{124.5,1},
          {88.25,1},{88.25,-14},{52,-14}}, color={0,0,127}));
  connect(Toutdoor.y[1], toKelvin1.Celsius) annotation (Line(points={{-66.5,
          -35},{-66.5,-4},{-56,-4}}, color={0,0,127}));
  connect(toKelvin1.Kelvin, heattransferHT.TAmbient) annotation (Line(
        points={{-33,-4},{-28,-4},{-28,2.08},{-25.0222,2.08}}, color={0,0,
          127}));
  connect(heattransferHT.port_b1, TflowWT03SIM.port_a) annotation (Line(
        points={{-10.6815,-4},{-14,-4},{-14,-21},{-17,-21}}, color={0,127,
          255}));
  connect(TflowWT03SIM.port_b, geoSink.ports[1])
    annotation (Line(points={{-17,-31},{-17,-65}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{160,100}})), Icon(coordinateSystem(extent={{-100,-100},{160,100}})));
end HeattransferHT_Test;
